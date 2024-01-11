Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A0750264
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B0C568CFE; Thu, 11 Jan 2024 18:10:03 +0100 (CET)
Date: Thu, 11 Jan 2024 18:10:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-mq: ensure a q_usage_counter reference is held
 when splitting bios
Message-ID: <20240111171002.GA20150@lst.de>
References: <20240111135705.2155518-1-hch@lst.de> <20240111135705.2155518-3-hch@lst.de> <d713fe1b-3eaa-4de4-99a6-5910247ffad5@kernel.dk> <20240111161440.GA16626@lst.de> <d91cb6ee-50bd-4397-b82f-d34dfc135b4a@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d91cb6ee-50bd-4397-b82f-d34dfc135b4a@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 11, 2024 at 09:17:41AM -0700, Jens Axboe wrote:
> On 1/11/24 9:14 AM, Christoph Hellwig wrote:
> > On Thu, Jan 11, 2024 at 09:12:23AM -0700, Jens Axboe wrote:
> >> On 1/11/24 6:57 AM, Christoph Hellwig wrote:
> >>> q_usage_counter is the only thing preventing us from the limits changing
> >>> under us in __bio_split_to_limits, but blk_mq_submit_bio doesn't hold it.
> >>>
> >>> Change __submit_bio to always acquire the q_usage_counter counter before
> >>> branching out into bio vs request based helper, and let blk_mq_submit_bio
> >>> tell it if it consumed the reference by handing it off to the request.
> >>
> >> This causes hangs for me on shutdown/reset:
> > 
> >> which seems to indicate that a reference is being leaked. Haven't poked
> >> any further at it, I'll drop these two for now.
> > 
> > Can you send me your .config?
> 
> Don't think it's .config related, hit it on my test box and then in my
> vm as well. It's likely due to batched allocations, would be my guess.
> I can start/halt the vm fine with just a boot, but if I do:

Yupp, cached rqs it was.  The incremental patch below fixes it.
Can you add some cached request testing to blktests so that this gets
covered by default?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 421db29535ba50..39eb4b99320c11 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2967,8 +2967,14 @@ bool blk_mq_submit_bio(struct bio *bio)
 		if (rq && rq->q == q) {
 			if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
 				return false;
-			if (blk_mq_use_cached_rq(rq, plug, bio))
+			if (blk_mq_use_cached_rq(rq, plug, bio)) {
+				/*
+				 * We're using the reference already owned by
+				 * rq from here on.
+				 */
+				blk_queue_exit(q);
 				goto has_rq;
+			}
 		}
 	}
 
