Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B547C63697
	for <linux-block@archiver.kernel.org>; Fri, 27 Nov 2020 02:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D418208CA
	for <linux-block@archiver.kernel.org>; Fri, 27 Nov 2020 02:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJ07LBPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392238AbgK0ClJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 21:41:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392216AbgK0ClJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 21:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606444867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CGuxrkK2iZdB4UEGYj2iQ4NnbaMBbMY85hcPMYR8MBQ=;
        b=hJ07LBPK6aOMffsSjpk9yNfN2rJ5yqivomKTC6wLsq0yGTDqAXtvAk34j3ics8Rl6SJrR9
        sPQ5R/aTXogA5wylVerANw4aFt9YHMmIgpWdOcMsO5ZNrPJvatQLqIwz8nXGsWC+hwiFzw
        4lONryBFrIs6mxBj1n+eXBOyzrw+tos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-kITHRiolM6uqfv8pokK3Vw-1; Thu, 26 Nov 2020 21:41:04 -0500
X-MC-Unique: kITHRiolM6uqfv8pokK3Vw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE3738049C3;
        Fri, 27 Nov 2020 02:41:03 +0000 (UTC)
Received: from T590 (ovpn-12-114.pek2.redhat.com [10.72.12.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B52B1001281;
        Fri, 27 Nov 2020 02:40:56 +0000 (UTC)
Date:   Fri, 27 Nov 2020 10:40:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: Make running from the wrong CPU less scary
Message-ID: <20201127024052.GB126383@T590>
References: <20201126095152.19151-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126095152.19151-1-dwagner@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 26, 2020 at 10:51:52AM +0100, Daniel Wagner wrote:
> The current warning looks aweful like a proper crash. This is
> confusing. There is not much information to gained from the stack
> trace anyway, let's drop it.
> 
> While at it print the cpumask as there might be additial helpful
> information when debugging the sitation.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> Hi,
> 
> We got a report from a customer because he was concerned about the log
> entries. As it turns out, it fooled me too to be honest. What do you
> think about making it a bit less look-a-like a kernel oops?
> 
> 
>  smpboot: Booting Node 0 Processor 12 APIC 0x26                                                
> WARNING, didn't collect load info for all cpus, balancing is broken                            
>  run queue from wrong CPU 0, hctx active                                                       
>  CPU: 0 PID: 42300 Comm: kworker/13:2H Kdump: loaded Tainted: G           OE  X    5.3.18-109.$
>  Hardware name: IBM System x3650 M5 -[5462AC1]-/00KG915, BIOS -[TCE144J-3.11]- 12/03/2019      
>  Workqueue: kblockd blk_mq_run_work_fn                                                         
>  Call Trace:                                                                                   
>   dump_stack+0x66/0x8b                                                                         
>   __blk_mq_run_hw_queue+0xee/0x100                                                             
>   process_one_work+0x1f4/0x3e0                                                                 
>   worker_thread+0x2d/0x3e0                                                                     
>   ? process_one_work+0x3e0/0x3e0                                                               
>   kthread+0x10d/0x130                                                                          
>   ? kthread_park+0xa0/0xa0                                                                     
>   ret_from_fork+0x35/0x40                                                                      
>  run queue from wrong CPU 0, hctx active                                                       
>  CPU: 0 PID: 42300 Comm: kworker/13:2H Kdump: loaded Tainted: G           OE  X    5.3.18-109.$
>  Hardware name: IBM System x3650 M5 -[5462AC1]-/00KG915, BIOS -[TCE144J-3.11]- 12/03/2019      
>  Workqueue: kblockd blk_mq_run_work_fn    
> 
> 
> Thanks,
> Daniel
> 
>  block/blk-mq.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 55bcee5dc032..0427b719d9c4 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1514,10 +1514,8 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
>  	 */
>  	if (!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
>  		cpu_online(hctx->next_cpu)) {
> -		printk(KERN_WARNING "run queue from wrong CPU %d, hctx %s\n",
> -			raw_smp_processor_id(),
> -			cpumask_empty(hctx->cpumask) ? "inactive": "active");
> -		dump_stack();
> +		printk(KERN_WARNING "run queue from wrong CPU %d, hctx %*pbl\n",
> +			raw_smp_processor_id(), cpumask_pr_args(hctx->cpumask));
>  	}

Now we have guaranteed that no any requests originated from one hctx exists
when this hctx is going to offline, which is strong enough for killing the check.

The reason why such warning is triggered is that wq's cpu hot unplug is
handled before blk-mq's handling.

I'd suggest to kill the whole branch in the fast path.

Thanks,
Ming

