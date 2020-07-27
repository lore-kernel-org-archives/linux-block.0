Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D5AC433DF
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 21:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E42F20786
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 21:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595884901;
	bh=c6h6Mw4AEBk6WjhMZ7nsBC6+9eWffSSL9V0jMLt5GlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zW+1ByGPgVh9uA+d21wygyywumwqQMWdjEJjcYK5pF51kM4dwCF1tp1yGLkBEU8qf
	 PBLPJDK25JLKg0pbO1AjV58Z5EWomm0IerFOI5NsQnq9NLzBfPfcyvU1+pTsbwHNxP
	 FMq2lzBpwVhqhxNdtiTOnG8z8X9DGLwHkVt+1+Ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgG0VVk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgG0VVk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 17:21:40 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A42D32075D;
        Mon, 27 Jul 2020 21:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595884900;
        bh=c6h6Mw4AEBk6WjhMZ7nsBC6+9eWffSSL9V0jMLt5GlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aXCTm8loYLa6feLLuGUHcVmYwMaplG9BG51CC+Z/17Ew5qWhS8ShCcyzQtNlBZsQg
         NsBmW0wiD7gmkV4BLBN9/oAHHmQbTG7d4CfnAESKkIc+d2FIUNSQQzxMqPCloSeFw5
         eO3rBr4kY4fkHRQZSMt2FMfenBOK6NFhjRVA9RVg=
Date:   Mon, 27 Jul 2020 14:21:37 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
Message-ID: <20200727212137.GA797661@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me>
 <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <2c2ae567-6953-5b7f-2fa1-a65e287b5a9d@grimberg.me>
 <f2fc0ecf-b599-678f-7241-fcd44cde6fab@kernel.dk>
 <bcb8f89b-8477-c48b-1e0f-947cbe741818@grimberg.me>
 <23ad666a-af6a-b110-441e-43ec0f833af4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23ad666a-af6a-b110-441e-43ec0f833af4@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 27, 2020 at 03:05:40PM -0600, Jens Axboe wrote:
> +void blk_mq_quiesce_queue_wait(struct request_queue *q)
>  {
>  	struct blk_mq_hw_ctx *hctx;
>  	unsigned int i;
>  	bool rcu = false;
>  
> -	blk_mq_quiesce_queue_nowait(q);
> -
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		if (hctx->flags & BLK_MQ_F_BLOCKING)
>  			synchronize_srcu(hctx->srcu);
>  		else
>  			rcu = true;
>  	}
> +
>  	if (rcu)
>  		synchronize_rcu();
>  }

Either all the hctx's are blocking or none of them are: we don't need to
iterate the hctx's to see which sync method to use. We can add at the
very beginning (and get rid of 'bool rcu'):

	if (!(q->tag_set->flags & BLK_MQ_F_BLOCKING)) {
		synchronize_rcu();
		return;
	}


But the issue Sagi is trying to address is quiescing a lot
request queues sharing a tagset where synchronize_rcu() is too time
consuming to do repeatedly. He wants to synchrnoize once for the entire
tagset rather than per-request_queue, so I think he needs an API taking
a 'struct blk_mq_tag_set' instead of a 'struct request_queue'.
