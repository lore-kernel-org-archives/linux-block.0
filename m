Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E51C77B61
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 00:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjDKAPs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 20:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDKAPr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 20:15:47 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCF01FF3
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 17:15:46 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id m18so6097545plx.5
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 17:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681172146; x=1683764146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5rqqrDra98sFA9rsi95BwqpnapDOX29zpoF2bPZkts=;
        b=ROgkh+YKRz3vQW6aKreELO/NGIQkQZBaKRyHfxuwiht8ajzSrPhUhd2bFPTirIVykF
         KlEao+eL1zZMwtNScftkeFD/3zsIi7sFhLQqyufQxZbG+vxelcRas3mUD5kV9AUg7Ubo
         5btD94/ergGvPHUghwzfvjZOY88VKxV6z6FlLJyWjpfuKbBkkoGP2uPzV3twZW0ynJhZ
         wTE64u8oC4x26uzzVRuAAz6s9jUGeGglQ7YZjba+E/5bH7vb0Ql8iGW/pMuuDfHyTkB1
         em9xkvNy5qIlXZRzEUiGwRfxynqqep0DVgWwMQR0lqCTNVCAXog/QVOsTuguuneVrSQE
         Ki2A==
X-Gm-Message-State: AAQBX9e0ETAvfIcEJ3lslns8UvIrE4T58DVzUxsXJI8Ysh572bXDkKgJ
        EvkYkdJ5HvHn+AVL+Ddcgf4LBAEwRQM=
X-Google-Smtp-Source: AKy350a35MdBO5v3WwDWh74Ydvd9jDWOgNhIMigSJmF7Ud/A5zBqd4JLZ0F6Ry20M6LePCO8F0xWDA==
X-Received: by 2002:a05:6a20:899e:b0:d9:4907:d8ac with SMTP id h30-20020a056a20899e00b000d94907d8acmr9341045pzg.61.1681172145892;
        Mon, 10 Apr 2023 17:15:45 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:11fd:f446:f156:c8? ([2620:15c:211:201:11fd:f446:f156:c8])
        by smtp.gmail.com with ESMTPSA id a4-20020aa780c4000000b00627e87f51a5sm8345961pfn.161.2023.04.10.17.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 17:15:45 -0700 (PDT)
Message-ID: <f81541f6-2fba-3d62-bd63-6b00b5cf5f5d@acm.org>
Date:   Mon, 10 Apr 2023 17:15:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 02/12] block: Send flush requests to the I/O scheduler
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-3-bvanassche@acm.org>
 <af4aeeea-79b2-8b0d-df8b-63f5ae6752d7@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <af4aeeea-79b2-8b0d-df8b-63f5ae6752d7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/10/23 00:46, Damien Le Moal wrote:
> Given that this change has nothing specific to zoned devices, you could rewrite
> the commit message to mention that. And are bfq and kyber OK with this change as
> well ?
> 
> Also, to be consistent with this change, shouldn't blk_mq_sched_bypass_insert()
> be updated as well ? That function is called from blk_mq_sched_insert_request().

Hi Damien,

I'm considering to replace patch 02/12 from this series by the patch below:


Subject: [PATCH] block: Send flush requests to the I/O scheduler

Send flush requests to the I/O scheduler such that I/O scheduler policies
are applied to writes with the FUA flag set. Separate the I/O scheduler
members from the flush members in struct request since with this patch
applied a request may pass through both an I/O scheduler and the flush
machinery.

This change affects the statistics of I/O schedulers that track I/O
statistics (BFQ and mq-deadline).

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  block/blk-flush.c      |  8 ++++++--
  block/blk-mq-sched.c   | 19 +++++++++++++++----
  block/blk-mq-sched.h   |  1 +
  block/blk-mq.c         | 22 +++++-----------------
  include/linux/blk-mq.h | 27 +++++++++++----------------
  5 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 53202eff545e..cf0afb75fafd 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -336,8 +336,11 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
  		 * account of this driver tag
  		 */
  		flush_rq->rq_flags |= RQF_MQ_INFLIGHT;
-	} else
+	} else {
  		flush_rq->internal_tag = first_rq->internal_tag;
+		flush_rq->rq_flags |= RQF_ELV;
+		blk_mq_sched_prepare(flush_rq);
+	}

  	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
  	flush_rq->cmd_flags |= (flags & REQ_DRV) | (flags & REQ_FAILFAST_MASK);
@@ -432,7 +435,8 @@ void blk_insert_flush(struct request *rq)
  	 */
  	if ((policy & REQ_FSEQ_DATA) &&
  	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
-		blk_mq_request_bypass_insert(rq, false, true);
+		blk_mq_sched_insert_request(rq, /*at_head=*/false,
+					    /*run_queue=*/true, /*async=*/true);
  		return;
  	}

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 62c8c1ba1321..9938c35aa7ed 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -18,6 +18,20 @@
  #include "blk-mq-tag.h"
  #include "blk-wbt.h"

+/* Prepare a request for insertion into an I/O scheduler. */
+void blk_mq_sched_prepare(struct request *rq)
+{
+	struct elevator_queue *e = rq->q->elevator;
+
+	INIT_HLIST_NODE(&rq->hash);
+	RB_CLEAR_NODE(&rq->rb_node);
+
+	if (e->type->ops.prepare_request) {
+		e->type->ops.prepare_request(rq);
+		rq->rq_flags |= RQF_ELVPRIV;
+	}
+}
+
  /*
   * Mark a hardware queue as needing a restart.
   */
@@ -397,10 +411,7 @@ static bool blk_mq_sched_bypass_insert(struct request *rq)
  	 * passthrough request is added to scheduler queue, there isn't any
  	 * chance to dispatch it given we prioritize requests in hctx->dispatch.
  	 */
-	if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq))
-		return true;
-
-	return false;
+	return req_op(rq) == REQ_OP_FLUSH || blk_rq_is_passthrough(rq);
  }

  void blk_mq_sched_insert_request(struct request *rq, bool at_head,
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 025013972453..6337c5a66af6 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -8,6 +8,7 @@

  #define MAX_SCHED_RQ (16 * BLKDEV_DEFAULT_RQ)

+void blk_mq_sched_prepare(struct request *rq);
  bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
  		unsigned int nr_segs, struct request **merged_request);
  bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index db93b1a71157..2731466b1952 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -384,18 +384,8 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
  	WRITE_ONCE(rq->deadline, 0);
  	req_ref_set(rq, 1);

-	if (rq->rq_flags & RQF_ELV) {
-		struct elevator_queue *e = data->q->elevator;
-
-		INIT_HLIST_NODE(&rq->hash);
-		RB_CLEAR_NODE(&rq->rb_node);
-
-		if (!op_is_flush(data->cmd_flags) &&
-		    e->type->ops.prepare_request) {
-			e->type->ops.prepare_request(rq);
-			rq->rq_flags |= RQF_ELVPRIV;
-		}
-	}
+	if (rq->rq_flags & RQF_ELV)
+		blk_mq_sched_prepare(rq);

  	return rq;
  }
@@ -452,13 +442,11 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
  		data->rq_flags |= RQF_ELV;

  		/*
-		 * Flush/passthrough requests are special and go directly to the
-		 * dispatch list. Don't include reserved tags in the
-		 * limiting, as it isn't useful.
+		 * Do not limit the depth for passthrough requests nor for
+		 * requests with a reserved tag.
  		 */
-		if (!op_is_flush(data->cmd_flags) &&
+		if (e->type->ops.limit_depth &&
  		    !blk_op_is_passthrough(data->cmd_flags) &&
-		    e->type->ops.limit_depth &&
  		    !(data->flags & BLK_MQ_REQ_RESERVED))
  			e->type->ops.limit_depth(data->cmd_flags, data);
  	}
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 06caacd77ed6..5e6c79ad83d2 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -169,25 +169,20 @@ struct request {
  		void *completion_data;
  	};

-
  	/*
  	 * Three pointers are available for the IO schedulers, if they need
-	 * more they have to dynamically allocate it.  Flush requests are
-	 * never put on the IO scheduler. So let the flush fields share
-	 * space with the elevator data.
+	 * more they have to dynamically allocate it.
  	 */
-	union {
-		struct {
-			struct io_cq		*icq;
-			void			*priv[2];
-		} elv;
-
-		struct {
-			unsigned int		seq;
-			struct list_head	list;
-			rq_end_io_fn		*saved_end_io;
-		} flush;
-	};
+	struct {
+		struct io_cq		*icq;
+		void			*priv[2];
+	} elv;
+
+	struct {
+		unsigned int		seq;
+		struct list_head	list;
+		rq_end_io_fn		*saved_end_io;
+	} flush;

  	union {
  		struct __call_single_data csd;

