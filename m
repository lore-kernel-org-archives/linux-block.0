Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1261C43334
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 07:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347813AbiFUH46 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 03:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347817AbiFUH44 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 03:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D154248E8
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 00:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655798214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A3CNJkCHn+2Ifuf6wllzWH6KabcEleGyqumFDzY2//8=;
        b=PClXCO3APyH4p/Td17js2lvLORaMjDmgvRinBc8K+jCEmHQMDvaqNcsyuNxfmsF70dZZZO
        gcVBW8mN55Hb42Tir1WNQh9j3N8O96YKqeQ6cnuZGYgvH51Et5NSQiL41d8JG/gbvGfV7W
        ZZ720p53VwM0REXGVjX8ThqjNKVYzmQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-N_h0iBWePue4H7uvH0Ficg-1; Tue, 21 Jun 2022 03:56:50 -0400
X-MC-Unique: N_h0iBWePue4H7uvH0Ficg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B841811E75;
        Tue, 21 Jun 2022 07:56:50 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 122D81121314;
        Tue, 21 Jun 2022 07:56:46 +0000 (UTC)
Date:   Tue, 21 Jun 2022 15:56:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH REPOST] blk-mq: Don't disable preemption around
 __blk_mq_run_hw_queue().
Message-ID: <YrF5uf4ZL7Oh7LVJ@T590>
References: <YrF1p2n0MxHQ3fcJ@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrF1p2n0MxHQ3fcJ@linutronix.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 21, 2022 at 09:39:19AM +0200, Sebastian Andrzej Siewior wrote:
> __blk_mq_delay_run_hw_queue() disables preemption to get a stable
> current CPU number and then invokes __blk_mq_run_hw_queue() if the CPU
> number is part the mask.
> 
> __blk_mq_run_hw_queue() acquires a spin_lock_t which is a sleeping lock
> on PREEMPT_RT and can't be acquired with disabled preemption.
> 
> If it is important that the current CPU matches the requested CPU mask
> and that the context does not migrate to another CPU while
> __blk_mq_run_hw_queue() is invoked then it possible to achieve this by
> disabling migration and keeping the context preemptible.
> 
> Disable only migration while testing the CPU mask and invoking
> __blk_mq_run_hw_queue().
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Link: https://lore.kernel.org/r/YnQHqx/5+54jd+U+@linutronix.de
> Link: https://lore.kernel.org/r/YqISXf6GAQeWqcR+@linutronix.de
> ---
>  block/blk-mq.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2083,14 +2083,14 @@ static void __blk_mq_delay_run_hw_queue(
>  		return;
>  
>  	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
> -		int cpu = get_cpu();
> -		if (cpumask_test_cpu(cpu, hctx->cpumask)) {
> +		migrate_disable();
> +		if (cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
>  			__blk_mq_run_hw_queue(hctx);
> -			put_cpu();
> +			migrate_enable();

I think you can replace it with raw_smp_processor_id() directly without
disabling migration.

Both async run queue and direct issue can run on cpu not on hctx->cpumask,
so it is fine for sync run queue too. 

Thanks,
Ming

