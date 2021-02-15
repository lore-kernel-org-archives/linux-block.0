Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D55C433DB
	for <linux-block@archiver.kernel.org>; Mon, 15 Feb 2021 04:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D60F64E56
	for <linux-block@archiver.kernel.org>; Mon, 15 Feb 2021 04:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhBOEMr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Feb 2021 23:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhBOEMq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Feb 2021 23:12:46 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE11EC061574;
        Sun, 14 Feb 2021 20:12:05 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id c131so1079958ybf.7;
        Sun, 14 Feb 2021 20:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AabfSHJP7/iHWfL1yMrJ/RT4wZOdzvVxLdYPzseJ6Ls=;
        b=HWOAlRVpZpNjJQHvJBOxn998ZxkpiMnY8MesOU/u3CGwpSeo8EyLkmti1VunM0asek
         dkvWrTe2wzIC+53cEQDywGUITM0OB9RTpa0HKMyxsWgUMguJh7KiLO8kAXa6iZxnNcQw
         ZK9V2tTJ/P7Y01zMoioCCoWhS0pXR9YZ/9e5VKQxjd5eAYA6yJ1CyaFKfzewwQIRr22v
         hbk8XfeLmSMQlrWF3a30NStZcEuDY+9j81S9hJjjfFs95c+E8n+hyZYH2/kCEfEmSKRC
         exeLq2u/a2BUlsRcZI+Kiz69v4IjxjJKVQaHJcmkCVeU0nnZhDtVZmQg92dz5KGAm7xV
         C5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AabfSHJP7/iHWfL1yMrJ/RT4wZOdzvVxLdYPzseJ6Ls=;
        b=qmiKJYLeZ+8377z0Ei7T4On2xoDM784rxqd+d3x0T9fPruSGOLvjdtIOFZ5nFr2+uB
         SaREfVMQX4RzpHxG+cdbjFMcAJGDVtNuDOSAhoUL86fCxQgA28u5z2vFvqoJzSpuSD4C
         9XI2zVBBg6ZcbKabYiGQnvNhN9oJkW/OMiStw9XSXRiBYDQgOPPUrxssfEBde4JO86MM
         YbqVH6kEyFKgzmGEf2tG5NbXiJAPvXF06nGz3pipTcro6XTkEQxotMbMuskuRXjw7Bvu
         sSIIUCma232TwX68NI7SN/kCCWKEBDETmFmcb/hC6zsL3a1lXtVuNbdvgZg7MPTjFDTF
         LnZQ==
X-Gm-Message-State: AOAM531ucc9rwpGRxU4wjnKj70SFZdHuFsoitcSSikl9Bire0YRKUMSO
        kXZnDgwwPge/k1YfqsGunI+/Q4U2xbdvzWegI0w=
X-Google-Smtp-Source: ABdhPJwem+pA0CecWMmleM4bBMY+uEyoaoupft0TWBQ4rvPcPqq7B6oi4wtMGwb6mVMmQsuhfLckWcbJutphW4PHZaI=
X-Received: by 2002:a5b:2cb:: with SMTP id h11mr20941955ybp.428.1613362324929;
 Sun, 14 Feb 2021 20:12:04 -0800 (PST)
MIME-Version: 1.0
References: <20210211143807.GA115624@redhat>
In-Reply-To: <20210211143807.GA115624@redhat>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 15 Feb 2021 12:11:54 +0800
Message-ID: <CACVXFVMkeUeQav1+rcY29w9qEk6_OoDwcmHxo9KoBB3kecw8AQ@mail.gmail.com>
Subject: Re: [PATCH v2] block: recalculate segment count for multi-segment
 discards correctly
To:     David Jeffery <djeffery@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 11, 2021 at 10:48 PM David Jeffery <djeffery@redhat.com> wrote:
>
> When a stacked block device inserts a request into another block device
> using blk_insert_cloned_request, the request's nr_phys_segments field gets
> recalculated by a call to blk_recalc_rq_segments in
> blk_cloned_rq_check_limits. But blk_recalc_rq_segments does not know how to
> handle multi-segment discards. For disk types which can handle
> multi-segment discards like nvme, this results in discard requests which
> claim a single segment when it should report several, triggering a warning
> in nvme and causing nvme to fail the discard from the invalid state.
>
>  WARNING: CPU: 5 PID: 191 at drivers/nvme/host/core.c:700 nvme_setup_discard+0x170/0x1e0 [nvme_core]
>  ...
>  nvme_setup_cmd+0x217/0x270 [nvme_core]
>  nvme_loop_queue_rq+0x51/0x1b0 [nvme_loop]
>  __blk_mq_try_issue_directly+0xe7/0x1b0
>  blk_mq_request_issue_directly+0x41/0x70
>  ? blk_account_io_start+0x40/0x50
>  dm_mq_queue_rq+0x200/0x3e0
>  blk_mq_dispatch_rq_list+0x10a/0x7d0
>  ? __sbitmap_queue_get+0x25/0x90
>  ? elv_rb_del+0x1f/0x30
>  ? deadline_remove_request+0x55/0xb0
>  ? dd_dispatch_request+0x181/0x210
>  __blk_mq_do_dispatch_sched+0x144/0x290
>  ? bio_attempt_discard_merge+0x134/0x1f0
>  __blk_mq_sched_dispatch_requests+0x129/0x180
>  blk_mq_sched_dispatch_requests+0x30/0x60
>  __blk_mq_run_hw_queue+0x47/0xe0
>  __blk_mq_delay_run_hw_queue+0x15b/0x170
>  blk_mq_sched_insert_requests+0x68/0xe0
>  blk_mq_flush_plug_list+0xf0/0x170
>  blk_finish_plug+0x36/0x50
>  xlog_cil_committed+0x19f/0x290 [xfs]
>  xlog_cil_process_committed+0x57/0x80 [xfs]
>  xlog_state_do_callback+0x1e0/0x2a0 [xfs]
>  xlog_ioend_work+0x2f/0x80 [xfs]
>  process_one_work+0x1b6/0x350
>  worker_thread+0x53/0x3e0
>  ? process_one_work+0x350/0x350
>  kthread+0x11b/0x140
>  ? __kthread_bind_mask+0x60/0x60
>  ret_from_fork+0x22/0x30
>
> This patch fixes blk_recalc_rq_segments to be aware of devices which can
> have multi-segment discards. It calculates the correct discard segment
> count by counting the number of bio as each discard bio is considered its
> own segment.
>
> Fixes: 1e739730c5b9 ("block: optionally merge discontiguous discard bios into a single request")
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Laurence Oberman <loberman@redhat.com>
>
> ---
> V2 explicitly returns 1 instead of falling through in the no-multi case and
> handles REQ_OP_SECURE_ERASE like REQ_OP_DISCARD.
>
>  block/blk-merge.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 808768f6b174..756473295f19 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -383,6 +383,14 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
>         switch (bio_op(rq->bio)) {
>         case REQ_OP_DISCARD:
>         case REQ_OP_SECURE_ERASE:
> +               if (queue_max_discard_segments(rq->q) > 1) {
> +                       struct bio *bio = rq->bio;
> +
> +                       for_each_bio(bio)
> +                               nr_phys_segs++;
> +                       return nr_phys_segs;
> +               }
> +               return 1;
>         case REQ_OP_WRITE_ZEROES:
>                 return 0;
>         case REQ_OP_WRITE_SAME:
>

Hello Jens,

Any chance to merge this patch which fixes one regression caused
by commit 1e739730c5b9?

-- 
Ming Lei
