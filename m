Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:52596 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754018AbeGIW4o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jul 2018 18:56:44 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH blktests v3 0/6] Add SRP initiator driver tests
Date: Mon,  9 Jul 2018 15:56:37 -0700
Message-Id: <20180709225643.10537-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Omar,

As promised during LSF/MM, I have converted the srp-tests software to the
blktests framework. Please consider this patch series for inclusion in the
official blktests repository. This patch series is also available as a
github pull request, namely https://github.com/osandov/blktests/pull/24.

Thanks,

Bart.

Changes compared to v2:
- Instead of documenting which kernel configuration options are required in
  README.md, skip the SRP tests if not all required kernel configuration
  options have been set.
- Renamed tests/srp/functions into tests/srp/rc.
- Made sure that the SRP test cleanup code is run if a test is interrupted
  with Ctrl-C.
- Fixed the syntax of the fio command line: changed -rw=... into --rw=...
- Suppressed the "Unloaded the ... kernel module" messages.
- Moved the multipath configuration data from README.md into
  tests/srp/multipath.conf. With this change /etc/multipath.conf can be a
  soft link and copy/pasting multipath configuration data is no longer required.
- multipathd is now started and stopped during each test instead of requiring
  that it is started before running any tests.
- Added "find_multipaths no" to multipath.conf for Arch Linux.
- The null_blk driver is now used instead of brd.
- If a PCI RDMA adapter is present in the test system, the SRP initiator not
  only connects over the rdma_rxe driver but also uses the loopback
  functionality of the PCI RDMA adapter.
- A list of which SRP connections have been created is written into the $FULL
  file.
- It is no longer attempted to associate the rdma_rxe driver with IPoIB network
  interfaces.

Changes compared to v1:
- Left out the patches from version one of this series that are already
  upstream.
- Renamed tests/srp/group into tests/srp/rc.
- The SRP tests do not start if LIO was already configured (reported by Ming).
- Documented the SRP test requirements in README.md.

Bart Van Assche (6):
  dir-locals.el: Add c-mode settings
  check: Make $FULL an absolute path
  src/Makefile: Introduce the C_TARGETS variable
  src/Makefile: Move -Wall from the C compilation rule to the $(CFLAGS)
    variable
  Add the discontiguous-io test program
  Add tests for the SRP initiator and target drivers

 .dir-locals.el           |    6 +-
 README.md                |   13 +
 check                    |    2 +-
 common/rc                |   17 +
 src/.gitignore           |    1 +
 src/Makefile             |   17 +-
 src/discontiguous-io.cpp |  340 +++++++++
 tests/srp/001            |   73 ++
 tests/srp/001.out        |    3 +
 tests/srp/002            |   50 ++
 tests/srp/002.out        |    2 +
 tests/srp/003            |   50 ++
 tests/srp/003.out        |    2 +
 tests/srp/004            |   50 ++
 tests/srp/004.out        |    2 +
 tests/srp/005            |   41 ++
 tests/srp/005.out        |    2 +
 tests/srp/006            |   41 ++
 tests/srp/006.out        |    2 +
 tests/srp/007            |   41 ++
 tests/srp/007.out        |    2 +
 tests/srp/008            |   40 ++
 tests/srp/008.out        |    2 +
 tests/srp/009            |   41 ++
 tests/srp/009.out        |    2 +
 tests/srp/010            |   41 ++
 tests/srp/010.out        |    2 +
 tests/srp/011            |   46 ++
 tests/srp/011.out        |    2 +
 tests/srp/012            |   53 ++
 tests/srp/012.out        |    2 +
 tests/srp/013            |   49 ++
 tests/srp/013.out        |    3 +
 tests/srp/multipath.conf |   27 +
 tests/srp/rc             | 1433 ++++++++++++++++++++++++++++++++++++++
 35 files changed, 2493 insertions(+), 7 deletions(-)
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
 create mode 100644 tests/srp/multipath.conf
 create mode 100755 tests/srp/rc

-- 
2.18.0
