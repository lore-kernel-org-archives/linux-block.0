Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59818 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933738AbeFVWTr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jun 2018 18:19:47 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH blktests 00/15] Add SRP initiator driver tests
Date: Fri, 22 Jun 2018 15:19:31 -0700
Message-Id: <20180622221946.10987-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Omar,

As promised during LSF/MM, I have converted the srp-tests software to the
blktests framework. This patch series included all blktests patches I postd
a few days ago. Please consider this patch series for inclusion in the
official blktests repository. Note: this patch series is also available as
a github pull request, namely https://github.com/osandov/blktests/pull/24.

Thanks,

Bart.

Bart Van Assche (15):
  common/rc: Fix _have_tracepoint()
  Annotate include statements in shell scripts where the source file is
    a variable
  check, tests/meta/012: Use array["index"] instead of array[index]
  Suppress shellcheck complaints about global variables
  check: Avoid that shellcheck complains that $FULL appears unused
  Multiple tests: remove unused and undefined variables
  Avoid passing tests/block/002 arguments to _init_scsi_debug
  check: Suppress a shellcheck warning about the DMESG_FILTER
    initialization
  Makefile: Do not suppress useful shellcheck warnings
  tests/meta/group: Fix shellcheck complaints
  make check: Also check tests/*/group files
  check: Make TMPDIR absolute
  src/Makefile: Fix pattern rule
  Add the discontiguous-io test program
  Add tests for the SRP initiator and target drivers

 Makefile                 |   16 +-
 check                    |   53 +-
 common/cpuhotplug        |    2 +
 common/fio               |    2 +
 common/iopoll            |    2 +
 common/loop              |    1 +
 common/nbd               |    2 +
 common/nvme              |    2 +
 common/rc                |    2 +
 common/scsi              |    2 +
 common/scsi_debug        |    3 +
 common/shellcheck        |    4 +
 new                      |    2 +
 src/.gitignore           |    1 +
 src/Makefile             |    6 +-
 src/discontiguous-io.cpp |  340 ++++++++++
 tests/block/001          |    1 +
 tests/block/002          |    3 +-
 tests/block/003          |    2 +
 tests/block/004          |    2 +
 tests/block/005          |    2 +
 tests/block/006          |    2 +
 tests/block/007          |    1 +
 tests/block/009          |    1 +
 tests/block/010          |    2 +
 tests/block/011          |    2 +
 tests/block/012          |    2 +
 tests/block/013          |    2 +
 tests/block/014          |    2 +
 tests/block/015          |    2 +
 tests/block/016          |    2 +
 tests/block/017          |    2 +
 tests/block/018          |    2 +
 tests/block/019          |    2 +
 tests/block/020          |    2 +
 tests/block/021          |    2 +
 tests/loop/001           |    2 +
 tests/loop/003           |    5 +-
 tests/loop/005           |    2 +
 tests/meta/001           |    2 +
 tests/meta/002           |    2 +
 tests/meta/003           |    2 +
 tests/meta/004           |    2 +
 tests/meta/005           |    2 +
 tests/meta/006           |    2 +
 tests/meta/007           |    2 +
 tests/meta/008           |    2 +
 tests/meta/009           |    2 +
 tests/meta/010           |    2 +
 tests/meta/011           |    2 +
 tests/meta/012           |    6 +-
 tests/meta/group         |    6 +-
 tests/nbd/001            |    2 +
 tests/nbd/002            |    2 +
 tests/nvme/001           |    2 +
 tests/nvme/002           |    2 +
 tests/nvme/003           |    2 +
 tests/nvme/004           |    2 +
 tests/nvme/005           |    2 +
 tests/nvme/006           |    2 +
 tests/nvme/007           |    2 +
 tests/nvme/008           |    2 +
 tests/nvme/009           |    2 +
 tests/nvme/010           |    5 +-
 tests/nvme/011           |    5 +-
 tests/nvme/012           |    3 +-
 tests/nvme/013           |    3 +-
 tests/scsi/001           |    2 +
 tests/scsi/002           |    2 +
 tests/scsi/003           |    2 +
 tests/scsi/004           |    1 +
 tests/srp/001            |   72 +++
 tests/srp/001.out        |    8 +
 tests/srp/002            |   50 ++
 tests/srp/002.out        |    7 +
 tests/srp/003            |   51 ++
 tests/srp/003.out        |    7 +
 tests/srp/004            |   51 ++
 tests/srp/004.out        |    7 +
 tests/srp/005            |   41 ++
 tests/srp/005.out        |    7 +
 tests/srp/006            |   41 ++
 tests/srp/006.out        |    7 +
 tests/srp/007            |   41 ++
 tests/srp/007.out        |    7 +
 tests/srp/008            |   40 ++
 tests/srp/008.out        |    7 +
 tests/srp/009            |   41 ++
 tests/srp/009.out        |    7 +
 tests/srp/010            |   41 ++
 tests/srp/010.out        |    7 +
 tests/srp/011            |   45 ++
 tests/srp/011.out        |    7 +
 tests/srp/012            |   53 ++
 tests/srp/012.out        |    8 +
 tests/srp/013            |   49 ++
 tests/srp/013.out        |    8 +
 tests/srp/functions      | 1288 ++++++++++++++++++++++++++++++++++++++
 tests/srp/group          |   37 ++
 99 files changed, 2548 insertions(+), 53 deletions(-)
 create mode 100644 common/shellcheck
 create mode 100644 src/discontiguous-io.cpp
 create mode 100755 tests/srp/001
 create mode 100644 tests/srp/001.out
 create mode 100755 tests/srp/002
 create mode 100644 tests/srp/002.out
 create mode 100755 tests/srp/003
 create mode 100644 tests/srp/003.out
 create mode 100755 tests/srp/004
 create mode 100644 tests/srp/004.out
 create mode 100755 tests/srp/005
 create mode 100644 tests/srp/005.out
 create mode 100755 tests/srp/006
 create mode 100644 tests/srp/006.out
 create mode 100755 tests/srp/007
 create mode 100644 tests/srp/007.out
 create mode 100755 tests/srp/008
 create mode 100644 tests/srp/008.out
 create mode 100755 tests/srp/009
 create mode 100644 tests/srp/009.out
 create mode 100755 tests/srp/010
 create mode 100644 tests/srp/010.out
 create mode 100755 tests/srp/011
 create mode 100644 tests/srp/011.out
 create mode 100755 tests/srp/012
 create mode 100644 tests/srp/012.out
 create mode 100755 tests/srp/013
 create mode 100644 tests/srp/013.out
 create mode 100755 tests/srp/functions
 create mode 100755 tests/srp/group

-- 
2.17.1
