Return-Path: <btv1==730b852cac1==tonyb@cybernetics.com>
Subject: [PATCH v2] bsg: fix bogus EINVAL on non-data commands
To: Christoph Hellwig <hch@lst.de>,
 FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Jens Axboe
 <axboe@kernel.dk>, linux-scsi <linux-scsi@vger.kernel.org>,
 linux-block@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.com>, Johannes Thumshirn <jthumshirn@suse.de>
References: <7730dcb2-7e69-3fc5-7eeb-4bbcf5091f14@cybernetics.com>
 <20180711063716.GA7934@lst.de>
From: Tony Battersby <tonyb@cybernetics.com>
Message-ID: <21524c51-7b58-19c2-dd13-eca592824185@cybernetics.com>
Date: Wed, 11 Jul 2018 10:46:03 -0400
MIME-Version: 1.0
In-Reply-To: <20180711063716.GA7934@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Fix a regression introduced in Linux kernel 4.17 where sending a SCSI
command that does not transfer data (such as TEST UNIT READY) via
/dev/bsg/* results in EINVAL.

Fixes: 17cb960f29c2 ("bsg: split handling of SCSI CDBs vs transport requeues")
Cc: <stable@vger.kernel.org> # 4.17+
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
diff --git a/block/bsg.c b/block/bsg.c
index 66602c4..3da540f 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -267,8 +267,6 @@ bsg_map_hdr(struct request_queue *q, str
 	} else if (hdr->din_xfer_len) {
 		ret = blk_rq_map_user(q, rq, NULL, uptr64(hdr->din_xferp),
 				hdr->din_xfer_len, GFP_KERNEL);
-	} else {
-		ret = blk_rq_map_user(q, rq, NULL, NULL, 0, GFP_KERNEL);
 	}
 
 	if (ret)
