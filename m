Return-Path: <SRS0=uYlv=UC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE869C04AB5
	for <linux-block@archiver.kernel.org>; Mon,  3 Jun 2019 10:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F0D21655
	for <linux-block@archiver.kernel.org>; Mon,  3 Jun 2019 10:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bjV2Mxd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfFCKA3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jun 2019 06:00:29 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34838 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfFCKA2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jun 2019 06:00:28 -0400
Received: by mail-it1-f195.google.com with SMTP id n189so7191525itd.0
        for <linux-block@vger.kernel.org>; Mon, 03 Jun 2019 03:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=P2KnBgX9CnHdHSf1j96Toqk+RnvI6gNFOXj0X9tLMFc=;
        b=bjV2Mxd9+++Raj+M/38vYL/Zn5Nnh+CzakW0Zb2yWNtn8KM+XGfafdGk9UIO3LVD29
         z/4GWsdME5VOrgHEHLllsGvRJZBNC+KTMx2Hbacbk9xNVt2VziwONSecHj5d6dROriL7
         P9WzC11diEGUJUD+lqsP/YzXyDXF4GByY2Zik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=P2KnBgX9CnHdHSf1j96Toqk+RnvI6gNFOXj0X9tLMFc=;
        b=r8K01F+RwnO+lD/ZZurrB/jocVmdGw3SKoydSGzjRLwnXQKeLv7Mm7wuHywiTUP11u
         dZ+ART69ap1yIq64azeSe+z6G2dmprbCS/pbAEv38DgZNiun8UC/D/cCW1R1Sk7DsaHJ
         XC2PcRoWyH6C3W1IBcUwpNiwfTHCDrnhzjMBy3tfqbKzhRExfvPnHU8n8g8SZHlD+q+2
         S7sTWhHQRg0jrUtcPV6m5tPH06csNvrE+7Np/qLmVsAk/yLhPzBxnxhhkXqvfplT+p0r
         FCL6d0kok4mfMNsNuWmaBXEHJYer3In287gBNoviebx9qwrJoxWbuBsd6j/Muhp3x+Dj
         FTGQ==
X-Gm-Message-State: APjAAAUnhqUH+nm9WpxNHt/j/6TmC9U3xEisqKBVJyTOqSiYqSPOJuOq
        xpH3h1lJecB0BHW7l83IoD+b7GZI1Br8CyNAjU8ILA==
X-Google-Smtp-Source: APXvYqzmQzURBMdghbXWyL1R/IqDIac+MGcHtIGToda52dSUka14PJVDMMjv5HxZwxuZLdo87QK19QVcELvlCxw/jvw=
X-Received: by 2002:a02:4049:: with SMTP id n70mr16505096jaa.42.1559556026781;
 Mon, 03 Jun 2019 03:00:26 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20190531022801.10003-1-ming.lei@redhat.com> <20190531022801.10003-9-ming.lei@redhat.com>
 <7819e1a523b9e8227e3a9d188ee1e083@mail.gmail.com> <20190602064202.GA2731@ming.t460p>
 <20190602074757.GA31572@ming.t460p> <020a7707a31803d65dd94cc0928a425a@mail.gmail.com>
 <20190603035605.GB13684@ming.t460p>
In-Reply-To: <20190603035605.GB13684@ming.t460p>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQISV99IJucrELCJ7/TtkhttwnBgjgOGFSeuAhzMczwA7yMTbgJjyv4mAu5i69MBzxVPCaWhc+pg
Date:   Mon, 3 Jun 2019 15:30:24 +0530
Message-ID: <f24109eb867deae8cb262466ecc70b09@mail.gmail.com>
Subject: RE: [PATCH 8/9] scsi: megaraid: convert private reply queue to blk-mq
 hw queue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>
> Please drop the patch in my last email, and apply the following patch
and see
> if we can make a difference:

Ming,

I dropped early patch and applied the below patched.  Now, I am getting
expected performance (3.0M IOPS).
Below patch fix the performance issue.  See perf report after applying the
same -

     8.52%  [kernel]        [k] sbitmap_any_bit_set
     4.19%  [kernel]        [k] blk_mq_run_hw_queue
     3.76%  [megaraid_sas]  [k] complete_cmd_fusion
     3.24%  [kernel]        [k] scsi_queue_rq
     2.53%  [megaraid_sas]  [k] megasas_build_ldio_fusion
     2.34%  [megaraid_sas]  [k] megasas_build_and_issue_cmd_fusion
     2.18%  [kernel]        [k] entry_SYSCALL_64
     1.85%  [kernel]        [k] syscall_return_via_sysret
     1.78%  [kernel]        [k] blk_mq_run_hw_queues
     1.59%  [kernel]        [k] gup_pmd_range
     1.49%  [kernel]        [k] _raw_spin_lock_irqsave
     1.24%  [kernel]        [k] scsi_dec_host_busy
     1.23%  [kernel]        [k] blk_mq_free_request
     1.23%  [kernel]        [k] blk_mq_get_request
     0.96%  [kernel]        [k] __slab_free
     0.91%  [kernel]        [k] aio_complete
     0.90%  [kernel]        [k] __sched_text_start
     0.89%  [megaraid_sas]  [k] megasas_queue_command
     0.85%  [kernel]        [k] __fget
     0.84%  [kernel]        [k] scsi_mq_get_budget

I will do some more testing and update the results.

Kashyap

>
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c index
> 3d6780504dcb..69d6bffcc8ff 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -627,6 +627,9 @@ static int hctx_active_show(void *data, struct
seq_file
> *m)  {
>  	struct blk_mq_hw_ctx *hctx = data;
>
> +	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
> +		hctx = blk_mq_master_hctx(hctx);
> +
>  	seq_printf(m, "%d\n", atomic_read(&hctx->nr_active));
>  	return 0;
>  }
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c index
> 309ec5079f3f..58ef83a34fda 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -30,6 +30,9 @@ bool blk_mq_has_free_tags(struct blk_mq_tags *tags)
>   */
>  bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)  {
> +	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
> +		hctx = blk_mq_master_hctx(hctx);
> +
>  	if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) &&
>  	    !test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
>  		atomic_inc(&hctx->tags->active_queues);
> @@ -55,6 +58,9 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)  {
>  	struct blk_mq_tags *tags = hctx->tags;
>
> +	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
> +		hctx = blk_mq_master_hctx(hctx);
> +
>  	if (!test_and_clear_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
>  		return;
>
> @@ -74,6 +80,10 @@ static inline bool hctx_may_queue(struct
> blk_mq_hw_ctx *hctx,
>
>  	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_SHARED))
>  		return true;
> +
> +	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
> +		hctx = blk_mq_master_hctx(hctx);
> +
>  	if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
>  		return true;
>
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h index
> 61deab0b5a5a..84e9b46ffc78 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -36,11 +36,22 @@ extern void blk_mq_tag_wakeup_all(struct
> blk_mq_tags *tags, bool);  void blk_mq_queue_tag_busy_iter(struct
> request_queue *q, busy_iter_fn *fn,
>  		void *priv);
>
> +static inline struct blk_mq_hw_ctx *blk_mq_master_hctx(
> +		struct blk_mq_hw_ctx *hctx)
> +{
> +	return hctx->queue->queue_hw_ctx[0];
> +}
> +
> +
>  static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue
*bt,
>  						 struct blk_mq_hw_ctx
*hctx)
>  {
>  	if (!hctx)
>  		return &bt->ws[0];
> +
> +	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
> +		hctx = blk_mq_master_hctx(hctx);
> +
>  	return sbq_wait_ptr(bt, &hctx->wait_index);  }
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c index
> 49d73d979cb3..4196ed3b0085 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -303,7 +303,7 @@ static struct request *blk_mq_rq_ctx_init(struct
> blk_mq_alloc_data *data,
>  	} else {
>  		if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
>  			rq_flags = RQF_MQ_INFLIGHT;
> -			atomic_inc(&data->hctx->nr_active);
> +			blk_mq_inc_nr_active(data->hctx);
>  		}
>  		rq->tag = tag;
>  		rq->internal_tag = -1;
> @@ -517,7 +517,7 @@ void blk_mq_free_request(struct request *rq)
>
>  	ctx->rq_completed[rq_is_sync(rq)]++;
>  	if (rq->rq_flags & RQF_MQ_INFLIGHT)
> -		atomic_dec(&hctx->nr_active);
> +		blk_mq_dec_nr_active(hctx);
>
>  	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
>  		laptop_io_completion(q->backing_dev_info);
> @@ -1064,7 +1064,7 @@ bool blk_mq_get_driver_tag(struct request *rq)
>  	if (rq->tag >= 0) {
>  		if (shared) {
>  			rq->rq_flags |= RQF_MQ_INFLIGHT;
> -			atomic_inc(&data.hctx->nr_active);
> +			blk_mq_inc_nr_active(data.hctx);
>  		}
>  		data.hctx->tags->rqs[rq->tag] = rq;
>  	}
> diff --git a/block/blk-mq.h b/block/blk-mq.h index
> 633a5a77ee8b..f1279b8c2289 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -193,6 +193,20 @@ unsigned int blk_mq_in_flight(struct request_queue
> *q, struct hd_struct *part);  void blk_mq_in_flight_rw(struct
request_queue
> *q, struct hd_struct *part,
>  			 unsigned int inflight[2]);
>
> +static inline void blk_mq_inc_nr_active(struct blk_mq_hw_ctx *hctx) {
> +	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
> +		hctx = blk_mq_master_hctx(hctx);
> +	atomic_inc(&hctx->nr_active);
> +}
> +
> +static inline void blk_mq_dec_nr_active(struct blk_mq_hw_ctx *hctx) {
> +	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
> +		hctx = blk_mq_master_hctx(hctx);
> +	atomic_dec(&hctx->nr_active);
> +}
> +
>  static inline void blk_mq_put_dispatch_budget(struct blk_mq_hw_ctx
*hctx)
> {
>  	struct request_queue *q = hctx->queue; @@ -218,7 +232,7 @@ static
> inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
>
>  	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
>  		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
> -		atomic_dec(&hctx->nr_active);
> +		blk_mq_dec_nr_active(hctx);
>  	}
>  }
>
> Thanks,
> Ming
