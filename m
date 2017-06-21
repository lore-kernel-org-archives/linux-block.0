Return-Path: <axboe@kernel.dk>
To: Omar Sandoval <osandov@osandov.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] New test and a fixup for blktests
Message-ID: <9fd24bc2-cddc-6f46-230a-dc1673242a54@kernel.dk>
Date: Wed, 21 Jun 2017 09:22:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Omar,

Two changes here:

- block/006 wants to use the iops results, but it isn't using _fio_perf.
- Add block/010 to test for shared vs non-shared tags performance.


  https://github.com/axboe/blktests.git axboe


----------------------------------------------------------------
Jens Axboe (2):
      block/006: use _fio_perf to get perf results
      block/010: add test case for shared/unshared tags

 tests/block/006     |  4 +--
 tests/block/010     | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/block/010.out |  2 ++
 3 files changed, 86 insertions(+), 2 deletions(-)
 create mode 100755 tests/block/010
 create mode 100644 tests/block/010.out

-- 
Jens Axboe
