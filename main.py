from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import sys
import os

from absl import app
from absl import flags
from absl import logging

FLAGS = flags.FLAGS

flags.DEFINE_string('input_dir', None, 'location of the input files.')
flags.DEFINE_string('output_dir', None, 'path for outpur files.')
flags.DEFINE_boolean('gpu_enabled', False,
                     'parameters to enable GPU computations.')

def main(argv):
    del argv  # Unused.
    if FLAGS.input_dir is None:
        print("No input directory provided. Please use --help for usage.")
        sys.exit(0)

    print('Running under Python {0[0]}.{0[1]}.{0[2]}'.format(sys.version_info),
          file=sys.stderr)
    logging.info('Input directory is %s.', FLAGS.input_dir)
    if FLAGS.output_dir is not None:
        logging.info('Output directory is %s.', FLAGS.input_dir)
    else:
        logging.info('Output directory is %s.', os.getcwd())
    logging.info("GPU enabled %s.", FLAGS.gpu_enabled)


if __name__ == '__main__':
    app.run(main)
