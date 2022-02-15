Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BC0C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 09:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbiBOJY3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 04:24:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbiBOJYZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 04:24:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D0F16CA40
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 01:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644917055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cm/ISAFiAk/VNWvvlXYPM5JrNqPrXyiLbVHmj92D8Cs=;
        b=BSWpL/tWoXomu9stEDfDckskPcmE4kjRZuuaugkaCso5ZlHNJnVnNSCxHRQ+N5N8K9yqO5
        95QVtPX2YmoTYNUn0pebMsz0kod0wvZLAp83vmkOKbzN03XPULKuI2q1mBf4KqEJ7EVBPJ
        cyMEr31iKA698biy1AsCwcCS2mZ+zfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-ZbLGAnaLMDiaCKAAGTOAQQ-1; Tue, 15 Feb 2022 04:24:10 -0500
X-MC-Unique: ZbLGAnaLMDiaCKAAGTOAQQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB930184608F;
        Tue, 15 Feb 2022 09:24:08 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CE261059A7C;
        Tue, 15 Feb 2022 09:23:50 +0000 (UTC)
Date:   Tue, 15 Feb 2022 17:23:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] blk-mq: Remove get_cpu() in
 __blk_mq_delay_run_hw_queue().
Message-ID: <YgtxIZdDXie01OJJ@T590>
References: <YgtuX9dDpXe8Xbs+@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgtuX9dDpXe8Xbs+@linutronix.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 15, 2022 at 10:11:59AM +0100, Sebastian Andrzej Siewior wrote:
> The callchain:
>   __blk_mq_delay_run_hw_queue(x, false, x)
>     cpu = get_cpu();
>     cpumask_test_cpu(cpu, hctx->cpumask);
>       __blk_mq_run_hw_queue(hctx);
>         blk_mq_run_dispatch_ops();
> 	  __blk_mq_run_dispatch_ops(x, true, x);
> 	    might_sleep_if(true);
> 
> will trigger the might_sleep warning since get_cpu() disables
> preemption. Based on my understanding, __blk_mq_run_hw_queue() should
> run on the requested CPU for the benefit of cache locality. The system
> won't crash if it runs on another CPU but the performance will be
> probably less than optimal.
> 
> If the current CPU matches the requested cpumask then it may remain and
> fulfill the requirement. If the scheduler moves the task to another CPU
> then it will run on the wrong CPU but no harm is done in terms of
> correctness.
> 
> Remove get_cpu() from __blk_mq_delay_run_hw_queue().
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> I have nothing to trigger that path, this is based on review. I see the
> callchain but with blk_queue_has_srcu == 0.
> The calls I see are from per-CPU threads and from unbound CPU threads.
> 
> If the correct CPU is important then migrate_disable() could be used
> (slightly higher overhead than preempt_disable() but preemptible) or
> unconditionally pass to kblockd_mod_delayed_work_on() (higher overhead
> than migrate_disable() but will be done anyway if the current CPU is
> wrong).
> 
>  block/blk-mq.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1adfe4824ef5e..90217f1b09add 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2040,14 +2040,10 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
>  		return;
>  
>  	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
> -		int cpu = get_cpu();

Did you observe the warning triggered?  might_sleep_if(true) in
__blk_mq_run_dispatch_ops() is only supposed to be run in case of
(hctx->flags & BLK_MQ_F_BLOCKING).

Thanks, 
Ming

