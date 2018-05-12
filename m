Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.18-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <d1fade60-9275-486d-fb47-ee871e467b62@kernel.dk>
Date: Sat, 12 May 2018 09:57:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Just a few NVMe fixes this round - one fixing a use-after-free, one
fixes the return value after controller reset, and the last one fixes an
issue where some drives will spuriously EIO. We should get these into
4.17.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180511


----------------------------------------------------------------
Charles Machalow (1):
      nvme: Fix sync controller reset return

Jens Axboe (1):
      nvme: add quirk to force medium priority for SQ creation

Jianchao Wang (1):
      nvme: fix use-after-free in nvme_free_ns_head

 drivers/nvme/host/core.c |  8 +++++++-
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  | 12 +++++++++++-
 3 files changed, 23 insertions(+), 2 deletions(-)

-- 
Jens Axboe
