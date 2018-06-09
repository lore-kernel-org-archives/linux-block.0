Return-Path: <axboe@kernel.dk>
Subject: Re: mainline boot is broken: KASAN: use-after-free in
 blk_flush_complete_seq
To: Dmitry Vyukov <dvyukov@google.com>, linux-block@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <CACT4Y+ZmRj61ia-WQBC=M72o=OZWk5LSnzf2qOEuOLHAa4do_A@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1d8de494-0a52-33f5-4c8d-0ec08cfb101c@kernel.dk>
Date: Sat, 9 Jun 2018 06:33:06 -0600
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZmRj61ia-WQBC=M72o=OZWk5LSnzf2qOEuOLHAa4do_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/9/18 3:34 AM, Dmitry Vyukov wrote:
> Hi,
> 
> Boot of mainline kernel is currently broken.
> On commit 7d3bf613e99abbd96ac7b90ee3694a246c975021.
> Config:
> https://gist.githubusercontent.com/dvyukov/9f7f1fd9e477efd85b221b3a21036c20/raw/7c56ede0840494b26045976960866f2b265c6f64/gistfile1.txt
> Should have been introduced very recently.

Can you try the below?

> You may need to also patch "umh: fix race condition", because that's
> another boot crasher currently present in tree.

Not sure that that refers to.


diff --git a/block/blk-flush.c b/block/blk-flush.c
index 058abdb50f31..ce41f666de3e 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -169,9 +169,11 @@ static bool blk_flush_complete_seq(struct request *rq,
 	struct request_queue *q = rq->q;
 	struct list_head *pending = &fq->flush_queue[fq->flush_pending_idx];
 	bool queued = false, kicked;
+	unsigned int cmd_flags;
 
 	BUG_ON(rq->flush.seq & seq);
 	rq->flush.seq |= seq;
+	cmd_flags = rq->cmd_flags;
 
 	if (likely(!error))
 		seq = blk_flush_cur_seq(rq);
@@ -212,7 +214,7 @@ static bool blk_flush_complete_seq(struct request *rq,
 		BUG();
 	}
 
-	kicked = blk_kick_flush(q, fq, rq->cmd_flags);
+	kicked = blk_kick_flush(q, fq, cmd_flags);
 	return kicked | queued;
 }
 

-- 
Jens Axboe
