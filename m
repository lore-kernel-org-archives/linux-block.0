Return-Path: <axboe@kernel.dk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.19-final
Message-ID: <0fcf8a7d-c0b5-3817-f1c4-417a384d0e03@kernel.dk>
Date: Fri, 19 Oct 2018 09:52:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Greg,

Two small fixes that should go into this release. Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20181019


----------------------------------------------------------------
Jens Axboe (1):
      Merge branch 'nvme-4.19' of git://git.infradead.org/nvme into for-linus

Keith Busch (1):
      nvme: remove ns sibling before clearing path

Ming Lei (1):
      block: don't deal with discard limit in blkdev_issue_discard()

 block/blk-lib.c          | 28 ++--------------------------
 drivers/nvme/host/core.c |  2 +-
 2 files changed, 3 insertions(+), 27 deletions(-)

-- 
Jens Axboe
