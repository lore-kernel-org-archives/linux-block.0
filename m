Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:46714 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934027AbeF0VtJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jun 2018 17:49:09 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH blktests v2 0/3] Add SRP initiator driver tests
Date: Wed, 27 Jun 2018 14:49:05 -0700
Message-Id: <20180627214908.26379-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Omar,

As promised during LSF/MM, I have converted the srp-tests software to the
blktests framework. Please consider this patch series for inclusion in the
official blktests repository. Note: this patch series is also available as
a github pull request, namely https://github.com/osandov/blktests/pull/24.

Thanks,

Bart.

Changes compared to v1:
- Left out the patches from version one of this series that are already
  upstream.
- Renamed tests/srp/group into tests/srp/rc.
- The SRP tests do not start if LIO was already configured (reported by Ming).
- Documented the SRP test requirements in README.md.

Bart Van Assche (3):
  src/Makefile: Rename $(TARGETS) into $(C_TARGETS)
  Add the discontiguous-io test program
  Add tests for the SRP initiator and target drivers

 README.md                |   71 +++
 src/.gitignore           |    1 +
 src/Makefile             |   17 +-
 src/discontiguous-io.cpp |  340 ++++++++++
 tests/srp/001            |   71 +++
 tests/srp/001.out        |    8 +
 tests/srp/002            |   49 ++
 tests/srp/002.out        |    7 +
 tests/srp/003            |   50 ++
 tests/srp/003.out        |    7 +
 tests/srp/004            |   50 ++
 tests/srp/004.out        |    7 +
 tests/srp/005            |   40 ++
 tests/srp/005.out        |    7 +
 tests/srp/006            |   40 ++
 tests/srp/006.out        |    7 +
 tests/srp/007            |   40 ++
 tests/srp/007.out        |    7 +
 tests/srp/008            |   39 ++
 tests/srp/008.out        |    7 +
 tests/srp/009            |   40 ++
 tests/srp/009.out        |    7 +
 tests/srp/010            |   40 ++
 tests/srp/010.out        |    7 +
 tests/srp/011            |   44 ++
 tests/srp/011.out        |    7 +
 tests/srp/012            |   52 ++
 tests/srp/012.out        |    8 +
 tests/srp/013            |   48 ++
 tests/srp/013.out        |    8 +
 tests/srp/functions      | 1288 ++++++++++++++++++++++++++++++++++++++
 tests/srp/rc             |   54 ++
 32 files changed, 2464 insertions(+), 4 deletions(-)
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
 create mode 100755 tests/srp/rc

-- 
2.17.1
