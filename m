Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C39C77B7F
	for <linux-block@archiver.kernel.org>; Sun, 14 May 2023 14:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjENOQr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 May 2023 10:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjENOQq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 May 2023 10:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E27F4496
        for <linux-block@vger.kernel.org>; Sun, 14 May 2023 07:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684073728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aCpGmkfp6j4JflPPgPCjygFBgL0pwwWBwF9dOYMEzYs=;
        b=fmIf/eEv3mLjog8D46Aot4B8NmiZ05M6kNjCqE6J0v9fYt/6NsUXoTfzB4ncOjoWNT2JzT
        kB0C63eTdWP8dtlO4l9hQt+UNuq2zNHb4f2gkb/n76c6l0OWx0N7rA9+kAOwlpdPKQoQHA
        Hd4nMaSeANwAzNlDw1U+zxocSJD/ngg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-XOXYlBMUNxm_x_tYSZWyXw-1; Sun, 14 May 2023 10:15:24 -0400
X-MC-Unique: XOXYlBMUNxm_x_tYSZWyXw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A45F1C06ECB;
        Sun, 14 May 2023 14:15:23 +0000 (UTC)
Received: from ovpn-8-17.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F3FE1121314;
        Sun, 14 May 2023 14:15:18 +0000 (UTC)
Date:   Sun, 14 May 2023 22:15:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tian Lan <tilan7663@gmail.com>
Cc:     lkp@intel.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        tian.lan@twosigma.com, ming.lei@redhat.com
Subject: Re: [PATCH 1/1] blk-mq: fix blk_mq_hw_ctx active request accounting
Message-ID: <ZGDs8U6naf46s+bx@ovpn-8-17.pek2.redhat.com>
References: <202305140021.WvuGBjaZ-lkp@intel.com>
 <20230513190534.331274-1-tilan7663@gmail.com>
 <ZGDPLEtUiDeIrCyl@ovpn-8-17.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGDPLEtUiDeIrCyl@ovpn-8-17.pek2.redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 14, 2023 at 08:08:12PM +0800, Ming Lei wrote:
> Hello Tian,
> 
> On Sat, May 13, 2023 at 03:05:34PM -0400, Tian Lan wrote:
> > From: Tian Lan <tian.lan@twosigma.com>
> > 
> > The nr_active counter continues to increase over time which causes the
> > blk_mq_get_tag to hang until the thread is rescheduled to a different
> > core despite there are still tags available.
> > 
> > kernel-stack
> > 
> >   INFO: task inboundIOReacto:3014879 blocked for more than 2 seconds
> >   Not tainted 6.1.15-amd64 #1 Debian 6.1.15~debian11
> >   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >   task:inboundIOReacto state:D stack:0  pid:3014879 ppid:4557 flags:0x00000000
> >     Call Trace:
> >     <TASK>
> >     __schedule+0x351/0xa20
> >     scheduler+0x5d/0xe0
> >     io_schedule+0x42/0x70
> >     blk_mq_get_tag+0x11a/0x2a0
> >     ? dequeue_task_stop+0x70/0x70
> >     __blk_mq_alloc_requests+0x191/0x2e0
> > 
> > kprobe output showing RQF_MQ_INFLIGHT bit is not cleared before
> > __blk_mq_free_request being called.
> 
> RQF_MQ_INFLIGHT won't be cleared when the request is freed normally
> from blk_mq_free_request().
> 
> > 
> >   320    320  kworker/29:1H __blk_mq_free_request rq_flags 0x220c0 in-flight 1
> 
> RQF_MQ_INFLIGHT/RQF_DONTPREP/RQF_IO_STAT/RQF_STATS is set, and it isn't
> a FLUSH request.
> 
> >          b'__blk_mq_free_request+0x1 [kernel]'
> >          b'bt_iter+0x50 [kernel]'
> >          b'blk_mq_queue_tag_busy_iter+0x318 [kernel]'
> >          b'blk_mq_timeout_work+0x7c [kernel]'
> >          b'process_one_work+0x1c4 [kernel]'
> >          b'worker_thread+0x4d [kernel]'
> >          b'kthread+0xe6 [kernel]'
> >          b'ret_from_fork+0x1f [kernel]'
> 
> If __blk_mq_free_request() is called from timeout, that means this
> request has been freed by blk_mq_free_request() already, so __blk_mq_dec_active_requests
> should have been run.
> 
> However, one case is that __blk_mq_dec_active_requests isn't called in
> blk_mq_end_request_batch, so maybe your driver is nvme with multiple
> NSs, so can you try the following patch?
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f6dad0886a2f..9c5dd5aa289c 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1062,6 +1062,9 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
>  		if (iob->need_ts)
>  			__blk_mq_end_request_acct(rq, now);
>  
> +		if (rq->rq_flags & RQF_MQ_INFLIGHT)
> +			__blk_mq_dec_active_requests(rq->mq_hctx);
> +
>  		rq_qos_done(rq->q, rq);

The above is actually not correct, given __blk_mq_sub_active_requests()
is done as batch in blk_mq_flush_tag_batch().

So the problem is in the difference between blk_mq_free_request() and
blk_mq_end_request_batch(), wrt. when to call
__blk_mq_dec_active_requests().

So your V2 looks correct, given now both two paths decrease active
requests after req_ref_put_and_test() is done.

And the issue should start from f794f3351f26 ("block: add support for
blk_mq_end_request_batch()").


Thanks,
Ming

