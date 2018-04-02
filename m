Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 2 Apr 2018 13:29:51 -0700
From: Tejun Heo <tj@kernel.org>
To: Sitsofe Wheeler <sitsofe@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
	Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [BISECTED][REGRESSION] Hang while booting EeePC 900
Message-ID: <20180402202951.GE388343@devbig577.frc2.facebook.com>
References: <CALjAwxh-PVYFnYFCJpGOja+m5SzZ8Sa4J7ohxdK=r8NyOF-EMA@mail.gmail.com>
 <de102067-b589-af05-ae71-496e948000f0@kernel.dk>
 <CALjAwxgtuEv=d1TfvH3EdXqZs=_6F7TinyVhbPdUmTsdK_5ghw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALjAwxgtuEv=d1TfvH3EdXqZs=_6F7TinyVhbPdUmTsdK_5ghw@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Sitsofe.

Can you see whether the following patch makes any difference?

Thanks.

diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index a05e367..f0e6e41 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -165,7 +165,7 @@ void blk_abort_request(struct request *req)
 		 * No need for fancy synchronizations.
 		 */
 		blk_rq_set_deadline(req, jiffies);
-		mod_timer(&req->q->timeout, 0);
+		kblockd_schedule_work(&req->q->timeout_work);
 	} else {
 		if (blk_mark_rq_complete(req))
 			return;
