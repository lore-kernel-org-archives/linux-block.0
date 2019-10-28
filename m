Return-Path: <SRS0=tc1V=YV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB21CA9EC0
	for <linux-block@archiver.kernel.org>; Mon, 28 Oct 2019 17:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE1E21721
	for <linux-block@archiver.kernel.org>; Mon, 28 Oct 2019 17:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SR7U7z7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfJ1RKM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Oct 2019 13:10:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36142 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730243AbfJ1RKM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Oct 2019 13:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ph8TTZ5SyE2A9xYh+ngDKVy870Gkb+SsTY9zHnpWZiU=; b=SR7U7z7GpWn7kz+sdY6LrWteq
        LeL/AgRpPbouQJsOsmdjTE7e3ddQLNkuUEODnwAbTliEdfPcd8LY257e7U0q6Tf+ZpTSx02UlsLHy
        6MWg2hjQhKMRBR/SRVmFwMBbyUUVgXtA58ShEbCdJR5jYo9XOA6ObZfbwp8U5AFJd/veBZd/H3wQA
        suw3Z8ABzWWTRRtDXjq314QD9pZmUcV1h1OVQtepl99Mp4r0R02NvbO0ygQpfNecciaNYKrje6boA
        x5OR4car9tpKwYuiIxuDkmrmwajN85JRklJ8j3NtQfTbREOvqMODdn+wlbxKsVl2biWIiOvvDSKez
        IjryPD+9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP8Wx-0006Mu-Rq; Mon, 28 Oct 2019 17:10:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CDE9F300EBF;
        Mon, 28 Oct 2019 18:09:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 32A8720D7FEEF; Mon, 28 Oct 2019 18:10:10 +0100 (CET)
Date:   Mon, 28 Oct 2019 18:10:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, mingo@kernel.org
Subject: Re: [PATCH 1/2] io-wq: small threadpool implementation for io_uring
Message-ID: <20191028171010.GH4114@hirez.programming.kicks-ass.net>
References: <20191025172251.12830-1-axboe@kernel.dk>
 <20191025172251.12830-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025172251.12830-2-axboe@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 25, 2019 at 11:22:50AM -0600, Jens Axboe wrote:

>  include/linux/sched.h |   1 +
>  kernel/sched/core.c   |  16 +-

This all seems pretty harmless, it makes the wq paths wee bit slower,
but everything else should be unaffected.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 67a1d86981a9..6666e25606b7 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1468,6 +1468,7 @@ extern struct pid *cad_pid;
>  #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
>  #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
>  #define PF_MEMALLOC_NOCMA	0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
> +#define PF_IO_WORKER		0x20000000	/* Task is an IO worker */
>  #define PF_FREEZER_SKIP		0x40000000	/* Freezer should not count it as freezable */
>  #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
>  
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index dd05a378631a..a95a2f05f3b5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -16,6 +16,7 @@
>  #include <asm/tlb.h>
>  
>  #include "../workqueue_internal.h"
> +#include "../../fs/io-wq.h"
>  #include "../smpboot.h"
>  
>  #include "pelt.h"
> @@ -4103,9 +4104,12 @@ static inline void sched_submit_work(struct task_struct *tsk)
>  	 * we disable preemption to avoid it calling schedule() again
>  	 * in the possible wakeup of a kworker.
>  	 */
> -	if (tsk->flags & PF_WQ_WORKER) {
> +	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
>  		preempt_disable();
> -		wq_worker_sleeping(tsk);
> +		if (tsk->flags & PF_WQ_WORKER)
> +			wq_worker_sleeping(tsk);
> +		else
> +			io_wq_worker_sleeping(tsk);
>  		preempt_enable_no_resched();
>  	}
>  
> @@ -4122,8 +4126,12 @@ static inline void sched_submit_work(struct task_struct *tsk)
>  
>  static void sched_update_worker(struct task_struct *tsk)
>  {
> -	if (tsk->flags & PF_WQ_WORKER)
> -		wq_worker_running(tsk);
> +	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
> +		if (tsk->flags & PF_WQ_WORKER)
> +			wq_worker_running(tsk);
> +		else
> +			io_wq_worker_running(tsk);
> +	}
>  }
>  
>  asmlinkage __visible void __sched schedule(void)
> -- 
> 2.17.1
> 
