Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7005C433DF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 01:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB142083E
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 01:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5GJW9YO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgG1Bkz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 21:40:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26743 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726265AbgG1Bkz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 21:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595900453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RCjKpXJyN62/c5yVHzk8RTcp4fhzn/0rYLcwRzNEGIA=;
        b=A5GJW9YOE8uXZnMoN3yVIr29h6EBm1iJiaPMjdRqwSDUIy8ZR4YODVsSXpez+C8/PPisaF
        WvIscXrl5kEuyRp601n/8ZGWgKtWma8lYmRl1zjV8pR7HVUTAMTVGeBAzycmBBhRPkpIr0
        UqryNKBRlrsA4EmLL6iuxRcAR1Ed27c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-IQ4Zp378Nv6c-sGQCI9_0w-1; Mon, 27 Jul 2020 21:40:51 -0400
X-MC-Unique: IQ4Zp378Nv6c-sGQCI9_0w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 311DC80183C;
        Tue, 28 Jul 2020 01:40:50 +0000 (UTC)
Received: from T590 (ovpn-12-109.pek2.redhat.com [10.72.12.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D1CF69323;
        Tue, 28 Jul 2020 01:40:42 +0000 (UTC)
Date:   Tue, 28 Jul 2020 09:40:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200728014038.GA1305646@T590>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727231022.307602-2-sagi@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 27, 2020 at 04:10:21PM -0700, Sagi Grimberg wrote:
> drivers that have shared tagsets may need to quiesce potentially a lot
> of request queues that all share a single tagset (e.g. nvme). Add an interface
> to quiesce all the queues on a given tagset. This interface is useful because
> it can speedup the quiesce by doing it in parallel.
> 
> For tagsets that have BLK_MQ_F_BLOCKING set, we use call_srcu to all hctxs
> in parallel such that all of them wait for the same rcu elapsed period with
> a per-hctx heap allocated rcu_synchronize. for tagsets that don't have
> BLK_MQ_F_BLOCKING set, we simply call a single synchronize_rcu as this is
> sufficient.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  block/blk-mq.c         | 66 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/blk-mq.h |  4 +++
>  2 files changed, 70 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index abcf590f6238..c37e37354330 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -209,6 +209,42 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>  
> +static void blk_mq_quiesce_blocking_queue_async(struct request_queue *q)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned int i;
> +
> +	blk_mq_quiesce_queue_nowait(q);
> +
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
> +		hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), GFP_KERNEL);
> +		if (!hctx->rcu_sync)
> +			continue;

This approach of quiesce/unquiesce tagset is good abstraction.

Just one more thing, please allocate a rcu_sync array because hctx is supposed
to not store scratch stuff.


thanks, 
Ming

