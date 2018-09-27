Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH 0/1] bcache fix for 4.19-rc6 
Date: Thu, 27 Sep 2018 23:41:45 +0800
Message-Id: <20180927154146.28262-1-colyli@suse.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

Guoju Fang just posts a bug fix to solve a bcache journal deadlock.
This bug probably happens when system memory is in heavy usage,
the deadlock is observed occasionally for a long while.
If it is too late to go into Linux 4.19, I will submit to you in
4.20 merge window, but it will be cool to have it in this run.

Thanks.

Coly Li

guoju (1):
  bcache: add separate workqueue for journal_write to avoid deadlock

 drivers/md/bcache/bcache.h  | 1 +
 drivers/md/bcache/journal.c | 6 +++---
 drivers/md/bcache/super.c   | 8 ++++++++
 3 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.19.0
