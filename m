Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH 0/1] bcache fix for 4.17-rc6 
Date: Thu, 17 May 2018 23:33:25 +0800
Message-Id: <20180517153326.49271-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

Hi Jenns,

We have reports that bcache does not work when CONFIG_DEBUG_FS=n, here is
the bug report on bugzilla.kernel.org:
	https://bugzilla.kernel.org/show_bug.cgi?id=199683
This problem happens since v4.16 and I believe it still happens in v4.17.

This submission has one patch to fix this issue, the patch is tested by
one of the reporters. If it is not too late for 4.17, could you please to
pick it for 4.17-rc6 ?

Thanks in advance.

Coly Li
---

Coly Li (1):
  bcache: return 0 from bch_debug_init() if CONFIG_DEBUG_FS=n

 drivers/md/bcache/debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.16.3
