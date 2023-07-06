Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80896EB64D9
	for <linux-block@archiver.kernel.org>; Thu,  6 Jul 2023 14:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjGFOjx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jul 2023 10:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbjGFOjw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jul 2023 10:39:52 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B96010F5;
        Thu,  6 Jul 2023 07:39:50 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B43B667373; Thu,  6 Jul 2023 16:39:46 +0200 (CEST)
Date:   Thu, 6 Jul 2023 16:39:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chengming Zhou <chengming.zhou@linux.dev>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        ming.lei@redhat.com, tj@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v2 1/4] blk-mq: use percpu csd to remote complete
 instead of per-rq csd
Message-ID: <20230706143946.GA15131@lst.de>
References: <20230629110359.1111832-1-chengming.zhou@linux.dev> <20230629110359.1111832-2-chengming.zhou@linux.dev> <20230706130735.GA13089@lst.de> <f6f52b55-a991-1179-75cb-bf8fce8f6783@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6f52b55-a991-1179-75cb-bf8fce8f6783@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 06, 2023 at 10:23:49PM +0800, Chengming Zhou wrote:
> Yes, should I change like below? Looks like much long code. :-)
> 
> if (llist_add(&rq->ipi_list, &per_cpu(blk_cpu_done, cpu)))
> 	smp_call_function_single_async(cpu, &per_cpu(blk_cpu_csd, cpu));

Doesn't look bad too me.

>
> 
> > 
> > But I think this code has a rpboem when it is preemptd between
> > the llist_add and smp_call_function_single_async.  We either need a
> > get_cpu/put_cpu around them, or instroduce a structure with the list
> > and csd, and then you can use one pointer from per_cpu and still ensure
> > the list and csd are for the same CPU.
> > 
> 
> cpu = rq->mq_ctx->cpu; So it's certainly the same CPU, right?

You're right of couse - cpu is the submitting cpu and not the current
one and thus not affected by preemption.  Sorry for the noise.

