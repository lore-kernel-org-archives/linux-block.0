Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B36C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 16:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A958160FED
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 16:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhIOQQU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:16:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46252 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhIOQQU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 12:16:20 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 86210221E0;
        Wed, 15 Sep 2021 16:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631722500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n0DDL26M7PaPvj/pZxOBBkvrzOhKzBhvyo0Y93FTP3k=;
        b=grJftI0VlFUKT72Sr8IbeP8egqYvRbT8e3246vDujNlEBtCpT4xWu1VjtaRJIG0KGMVZ2q
        ujsio3iPdBjYk9bZWknXT6jrx4gaE3U1BX7g0bTEwji1UOf0fcL1e9Lze6Z97dVZpBqcSD
        +cM+prmFyoNhFh1dpOaWRZwwuU8UedQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631722500;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n0DDL26M7PaPvj/pZxOBBkvrzOhKzBhvyo0Y93FTP3k=;
        b=iB2vRV76gVWFwDZgTklDc716aTglLj8bW3hudBILM/OeMFlr7IzhAJV6xvs8CFh1L7Z3eI
        /+/VlYzbtHZftqCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5AB7D13C37;
        Wed, 15 Sep 2021 16:15:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FxunFQQcQmEJOQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 15 Sep 2021 16:15:00 +0000
Date:   Wed, 15 Sep 2021 18:14:59 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH V7 3/3] blk-mq: don't deactivate hctx if managed irq
 isn't used
Message-ID: <20210915161459.ks3pbqceuj5x3ugu@carbon.lan>
References: <20210818144428.896216-1-ming.lei@redhat.com>
 <20210818144428.896216-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818144428.896216-4-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 18, 2021 at 10:44:28PM +0800, Ming Lei wrote:
>  struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>  	unsigned int op, blk_mq_req_flags_t flags, unsigned int hctx_idx)
>  {
> @@ -468,7 +485,10 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>  	data.hctx = q->queue_hw_ctx[hctx_idx];
>  	if (!blk_mq_hw_queue_mapped(data.hctx))
>  		goto out_queue_exit;
> -	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> +
> +	WARN_ON_ONCE(blk_mq_hctx_use_managed_irq(data.hctx));
> +
> +	cpu = blk_mq_first_mapped_cpu(data.hctx);
>  	data.ctx = __blk_mq_get_ctx(q, cpu);

I was pondering how we could address the issue that the qla2xxx driver
is using managed IRQs which makes nvme-fc depending as class on managed
IRQ.

blk_mq_alloc_request_hctx() is the only place where we really need to
distinguish between managed and !managed IRQs. As far I undertand the
situation, if all CPUs for a hctx are going offline, the driver wont use
this context. So there is only the case we end up in this code path is
when the driver tries to reconnect the queues, e.g. after
devloss. Couldn't we in this case not just return an error and go into
error recovery? Something like this:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a2db50886a26..52fc8592c72e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -486,9 +486,13 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
        if (!blk_mq_hw_queue_mapped(data.hctx))
                goto out_queue_exit;
 
-       WARN_ON_ONCE(blk_mq_hctx_use_managed_irq(data.hctx));
-
-       cpu = blk_mq_first_mapped_cpu(data.hctx);
+       if (blk_mq_hctx_use_managed_irq(data.hctx)) {
+               cpu = cpumask_first_and(hctx->cpumask, cpu_online_mask);
+               if (cpu >= nr_cpu_ids)
+                       return ERR_PTR(-EINVAL);
+       } else {
+               cpu = blk_mq_first_mapped_cpu(data.hctx);
+       }
        data.ctx = __blk_mq_get_ctx(q, cpu);

