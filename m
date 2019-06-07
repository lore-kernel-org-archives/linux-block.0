Return-Path: <SRS0=19b2=UG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E92C28CC3
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 09:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B259D208C3
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 09:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cZ+tnvrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfFGJpI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jun 2019 05:45:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37191 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfFGJpH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jun 2019 05:45:07 -0400
Received: by mail-io1-f68.google.com with SMTP id e5so927858iok.4
        for <linux-block@vger.kernel.org>; Fri, 07 Jun 2019 02:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=g83v8094D4mWODrUsadU7i1rBHO1zAwqVkxt10+UJWs=;
        b=cZ+tnvrCCvhDViv8MaNtI6RhwVKZNuUz1P0VxPFHCv5cI/djeQtkfdwtTYPZ9y3cb0
         glnMJ5xglNqEPXlop71+7g4rq1TGhCdz77XUd1K6oaCz191YzGIbC++RKfmyBN4laDub
         sGi32iK6TL0LYTmWb/x83mZwO7sNvGYjElVe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=g83v8094D4mWODrUsadU7i1rBHO1zAwqVkxt10+UJWs=;
        b=cX5Rvd4NJt1hVBZiY17xuMf/ojoovyox39XEVLkjOZqVhkev/0mJf5Zwgab5woA6qq
         ldWZngyKxd7f+W6xjoKbfo1wWMzsrvVIlGBrB2a49XvLdV3HrmJpFHBWyU5B0pdI1ej9
         nRFDrDJKA1dKwY+VhK8QOhvHAyJo8SYarX1LBYQtwKlsOgSiKbtVJlk5k1uah+dJWhYr
         NFRAfjjv8ILrY+v56yzHz9HiiXhpHUltxizKShg1fLkyYd6LU/3e00ZtDVu1Ev/O6ZNz
         SoUhTJWpWDHeD7oEmyR8HPzvAjij6JhhI0NDp7QmHf05c8SrZuyFlnhR00WB4M+WFt7M
         w4hQ==
X-Gm-Message-State: APjAAAUE9Kotg9r8HLN9o1sztaLIrmEyZIPZ1KkSXUj3CIb6whSAGV4a
        gF+JjVAcQMAJTQk4+W2grBE89GA00s/vDXRhAxF3lA==
X-Google-Smtp-Source: APXvYqy/ZoC4j2RDDElcc5eVOlGiF41xNchXI0MTqIyaBC1DnAhTbnpN2o4x0Gy7CWr4zx2wpbseZbVJ8yuU960Fbms=
X-Received: by 2002:a6b:691d:: with SMTP id e29mr29149534ioc.96.1559900706576;
 Fri, 07 Jun 2019 02:45:06 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20190531022801.10003-1-ming.lei@redhat.com> <20190531022801.10003-9-ming.lei@redhat.com>
 <7819e1a523b9e8227e3a9d188ee1e083@mail.gmail.com> <20190602064202.GA2731@ming.t460p>
 <20190602074757.GA31572@ming.t460p> <020a7707a31803d65dd94cc0928a425a@mail.gmail.com>
 <20190603035605.GB13684@ming.t460p> f24109eb867deae8cb262466ecc70b09@mail.gmail.com
In-Reply-To: f24109eb867deae8cb262466ecc70b09@mail.gmail.com
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQISV99IJucrELCJ7/TtkhttwnBgjgOGFSeuAhzMczwA7yMTbgJjyv4mAu5i69MBzxVPCaWhc+pggAZsHKA=
Date:   Fri, 7 Jun 2019 15:15:04 +0530
Message-ID: <287b092778c749c8b101641f9d48ab44@mail.gmail.com>
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
> >
> > Please drop the patch in my last email, and apply the following patch
> > and see if we can make a difference:
>
> Ming,
>
> I dropped early patch and applied the below patched.  Now, I am getting
> expected performance (3.0M IOPS).
> Below patch fix the performance issue.  See perf report after applying
the
> same -
>
>      8.52%  [kernel]        [k] sbitmap_any_bit_set
>      4.19%  [kernel]        [k] blk_mq_run_hw_queue
>      3.76%  [megaraid_sas]  [k] complete_cmd_fusion
>      3.24%  [kernel]        [k] scsi_queue_rq
>      2.53%  [megaraid_sas]  [k] megasas_build_ldio_fusion
>      2.34%  [megaraid_sas]  [k] megasas_build_and_issue_cmd_fusion
>      2.18%  [kernel]        [k] entry_SYSCALL_64
>      1.85%  [kernel]        [k] syscall_return_via_sysret
>      1.78%  [kernel]        [k] blk_mq_run_hw_queues
>      1.59%  [kernel]        [k] gup_pmd_range
>      1.49%  [kernel]        [k] _raw_spin_lock_irqsave
>      1.24%  [kernel]        [k] scsi_dec_host_busy
>      1.23%  [kernel]        [k] blk_mq_free_request
>      1.23%  [kernel]        [k] blk_mq_get_request
>      0.96%  [kernel]        [k] __slab_free
>      0.91%  [kernel]        [k] aio_complete
>      0.90%  [kernel]        [k] __sched_text_start
>      0.89%  [megaraid_sas]  [k] megasas_queue_command
>      0.85%  [kernel]        [k] __fget
>      0.84%  [kernel]        [k] scsi_mq_get_budget
>
> I will do some more testing and update the results.

Ming, I did testing on AMD Dual Socket server (AMD EPYC 7601 32-Core
Processor). System has total 128 logical cores.

Without patch, performance can go upto 2.8M IOPS. See below perf top
output.

   7.37%  [megaraid_sas]      [k] complete_cmd_fusion
   2.51%  [kernel]            [k] copy_user_generic_string
   2.48%  [kernel]            [k] read_tsc
   2.10%  fio                 [.] thread_main
   2.06%  [kernel]            [k] gup_pgd_range
   1.98%  [kernel]            [k] __get_user_4
   1.92%  [kernel]            [k] entry_SYSCALL_64
   1.58%  [kernel]            [k] scsi_queue_rq
   1.55%  [megaraid_sas]      [k] megasas_queue_command
   1.52%  [kernel]            [k] irq_entries_start
   1.43%  fio                 [.] get_io_u
   1.39%  [kernel]            [k] blkdev_direct_IO
   1.34%  [kernel]            [k] __audit_syscall_exit
   1.31%  [megaraid_sas]      [k] megasas_build_and_issue_cmd_fusion
   1.27%  [kernel]            [k] syscall_slow_exit_work
   1.23%  [kernel]            [k] io_submit_one
   1.20%  [kernel]            [k] do_syscall_64
   1.17%  fio                 [.] td_io_queue
   1.16%  [kernel]            [k] lookup_ioctx
   1.14%  [kernel]            [k] kmem_cache_alloc
   1.10%  [megaraid_sas]      [k] megasas_build_ldio_fusion
   1.07%  [kernel]            [k] __memset
   1.06%  [kernel]            [k] __virt_addr_valid
   0.98%  [kernel]            [k] blk_mq_get_request
   0.94%  [kernel]            [k] note_interrupt
   0.91%  [kernel]            [k] __get_user_8
   0.91%  [kernel]            [k] aio_read_events
   0.85%  [kernel]            [k] __put_user_4
   0.78%  fio                 [.] fio_libaio_commit
   0.74%  [megaraid_sas]      [k] MR_BuildRaidContext
   0.70%  [kernel]            [k] __x64_sys_io_submit
   0.69%  fio                 [.] utime_since_now


With your patch - Performance can go upto 1.7M IOPS. See below perf top
output.

 23.01%  [kernel]              [k] sbitmap_any_bit_set
   6.42%  [kernel]              [k] blk_mq_run_hw_queue
   4.44%  [megaraid_sas]        [k] complete_cmd_fusion
   4.23%  [kernel]              [k] blk_mq_run_hw_queues
   1.80%  [kernel]              [k] read_tsc
   1.60%  [kernel]              [k] copy_user_generic_string
   1.33%  fio                   [.] thread_main
   1.27%  [kernel]              [k] irq_entries_start
   1.22%  [kernel]              [k] gup_pgd_range
   1.20%  [kernel]              [k] __get_user_4
   1.20%  [kernel]              [k] entry_SYSCALL_64
   1.07%  [kernel]              [k] scsi_queue_rq
   0.88%  fio                   [.] get_io_u
   0.87%  [megaraid_sas]        [k] megasas_queue_command
   0.86%  [kernel]              [k] blkdev_direct_IO
   0.85%  fio                   [.] td_io_queue
   0.80%  [kernel]              [k] note_interrupt
   0.76%  [kernel]              [k] lookup_ioctx
   0.76%  [kernel]              [k] do_syscall_64
   0.75%  [megaraid_sas]        [k] megasas_build_and_issue_cmd_fusion
   0.74%  [megaraid_sas]        [k] megasas_build_ldio_fusion
   0.72%  [kernel]              [k] kmem_cache_alloc
   0.71%  [kernel]              [k] __audit_syscall_exit
   0.67%  [kernel]              [k] __virt_addr_valid
   0.65%  [kernel]              [k] blk_mq_get_request
   0.64%  [kernel]              [k] __memset
   0.62%  [kernel]              [k] syscall_slow_exit_work
   0.60%  [kernel]              [k] io_submit_one
   0.59%  [kernel]              [k] ktime_get
   0.58%  fio                   [.] fio_libaio_commit
   0.57%  [kernel]              [k] aio_read_events
   0.54%  [kernel]              [k] __get_user_8
   0.53%  [kernel]              [k] aio_complete_rw
   0.51%  [kernel]              [k] kmem_cache_free

With your patch + reducing logical cpu core to 64 (CPU hotplugged),
performance can go upto 2.2M IOPS. See below perf top output.

   9.56%  [kernel]            [k] sbitmap_any_bit_set
   4.62%  [megaraid_sas]      [k] complete_cmd_fusion
   3.02%  [kernel]            [k] blk_mq_run_hw_queue
   2.15%  [kernel]            [k] copy_user_generic_string
   2.13%  [kernel]            [k] blk_mq_run_hw_queues
   2.09%  [kernel]            [k] read_tsc
   1.66%  [kernel]            [k] __get_user_4
   1.59%  [kernel]            [k] entry_SYSCALL_64
   1.57%  [kernel]            [k] gup_pgd_range
   1.55%  fio                 [.] thread_main
   1.51%  [kernel]            [k] scsi_queue_rq
   1.31%  [kernel]            [k] __memset
   1.21%  [megaraid_sas]      [k] megasas_build_and_issue_cmd_fusion
   1.16%  [megaraid_sas]      [k] megasas_queue_command
   1.13%  fio                 [.] get_io_u
   1.12%  [kernel]            [k] blk_mq_get_request
   1.07%  [kernel]            [k] blkdev_direct_IO
   1.06%  [kernel]            [k] __put_user_4
   1.05%  fio                 [.] td_io_queue
   1.02%  [kernel]            [k] syscall_slow_exit_work
   1.00%  [megaraid_sas]      [k] megasas_build_ldio_fusion


In summary, Part of the performance drop may be correlated with number of
hctx created in block layer. I can provide more details and can test
follow up patch.

Kashyap


>
> Kashyap
>
> >
> > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c index
> > 3d6780504dcb..69d6bffcc8ff 100644
> > --- a/block/blk-mq-debugfs.c
> > +++ b/block/blk-mq-debugfs.c
> > @@ -627,6 +627,9 @@ static int hctx_active_show(void *data, struct
> > seq_file
> > *m)  {
> >  	struct blk_mq_hw_ctx *hctx = data;
> >
> > +	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
> > +		hctx = blk_mq_master_hctx(hctx);
> > +
> >  	seq_printf(m, "%d\n", atomic_read(&hctx->nr_active));
> >  	return 0;
> >  }
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c index
> > 309ec5079f3f..58ef83a34fda 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -30,6 +30,9 @@ bool blk_mq_has_free_tags(struct blk_mq_tags *tags)
> >   */
> >  bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)  {
> > +	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
> > +		hctx = blk_mq_master_hctx(hctx);
> > +
> >  	if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) &&
> >  	    !test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
> >  		atomic_inc(&hctx->tags->active_queues);
> > @@ -55,6 +58,9 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
> {
> >  	struct blk_mq_tags *tags = hctx->tags;
> >
> > +	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
> > +		hctx = blk_mq_master_hctx(hctx);
> > +
> >  	if (!test_and_clear_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
> >  		return;
> >
> > @@ -74,6 +80,10 @@ static inline bool hctx_may_queue(struct
> > blk_mq_hw_ctx *hctx,
> >
> >  	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_SHARED))
> >  		return true;
> > +
> > +	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
> > +		hctx = blk_mq_master_hctx(hctx);
> > +
> >  	if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
> >  		return true;
> >
> > diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h index
> > 61deab0b5a5a..84e9b46ffc78 100644
> > --- a/block/blk-mq-tag.h
> > +++ b/block/blk-mq-tag.h
> > @@ -36,11 +36,22 @@ extern void blk_mq_tag_wakeup_all(struct
> > blk_mq_tags *tags, bool);  void blk_mq_queue_tag_busy_iter(struct
> > request_queue *q, busy_iter_fn *fn,
> >  		void *priv);
> >
> > +static inline struct blk_mq_hw_ctx *blk_mq_master_hctx(
> > +		struct blk_mq_hw_ctx *hctx)
> > +{
> > +	return hctx->queue->queue_hw_ctx[0]; }
> > +
> > +
> >  static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue
*bt,
> >  						 struct blk_mq_hw_ctx
*hctx)
> >  {
> >  	if (!hctx)
> >  		return &bt->ws[0];
> > +
> > +	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
> > +		hctx = blk_mq_master_hctx(hctx);
> > +
> >  	return sbq_wait_ptr(bt, &hctx->wait_index);  }
> >
> > diff --git a/block/blk-mq.c b/block/blk-mq.c index
> > 49d73d979cb3..4196ed3b0085 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -303,7 +303,7 @@ static struct request *blk_mq_rq_ctx_init(struct
> > blk_mq_alloc_data *data,
> >  	} else {
> >  		if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
> >  			rq_flags = RQF_MQ_INFLIGHT;
> > -			atomic_inc(&data->hctx->nr_active);
> > +			blk_mq_inc_nr_active(data->hctx);
> >  		}
> >  		rq->tag = tag;
> >  		rq->internal_tag = -1;
> > @@ -517,7 +517,7 @@ void blk_mq_free_request(struct request *rq)
> >
> >  	ctx->rq_completed[rq_is_sync(rq)]++;
> >  	if (rq->rq_flags & RQF_MQ_INFLIGHT)
> > -		atomic_dec(&hctx->nr_active);
> > +		blk_mq_dec_nr_active(hctx);
> >
> >  	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
> >  		laptop_io_completion(q->backing_dev_info);
> > @@ -1064,7 +1064,7 @@ bool blk_mq_get_driver_tag(struct request *rq)
> >  	if (rq->tag >= 0) {
> >  		if (shared) {
> >  			rq->rq_flags |= RQF_MQ_INFLIGHT;
> > -			atomic_inc(&data.hctx->nr_active);
> > +			blk_mq_inc_nr_active(data.hctx);
> >  		}
> >  		data.hctx->tags->rqs[rq->tag] = rq;
> >  	}
> > diff --git a/block/blk-mq.h b/block/blk-mq.h index
> > 633a5a77ee8b..f1279b8c2289 100644
> > --- a/block/blk-mq.h
> > +++ b/block/blk-mq.h
> > @@ -193,6 +193,20 @@ unsigned int blk_mq_in_flight(struct
> > request_queue *q, struct hd_struct *part);  void
> > blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
> >  			 unsigned int inflight[2]);
> >
> > +static inline void blk_mq_inc_nr_active(struct blk_mq_hw_ctx *hctx) {
> > +	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
> > +		hctx = blk_mq_master_hctx(hctx);
> > +	atomic_inc(&hctx->nr_active);
> > +}
> > +
> > +static inline void blk_mq_dec_nr_active(struct blk_mq_hw_ctx *hctx) {
> > +	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
> > +		hctx = blk_mq_master_hctx(hctx);
> > +	atomic_dec(&hctx->nr_active);
> > +}
> > +
> >  static inline void blk_mq_put_dispatch_budget(struct blk_mq_hw_ctx
> > *hctx) {
> >  	struct request_queue *q = hctx->queue; @@ -218,7 +232,7 @@ static
> > inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
> >
> >  	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
> >  		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
> > -		atomic_dec(&hctx->nr_active);
> > +		blk_mq_dec_nr_active(hctx);
> >  	}
> >  }
> >
> > Thanks,
> > Ming
