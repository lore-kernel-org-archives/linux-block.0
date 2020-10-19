Return-Path: <SRS0=eZc3=D2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C71C433E7
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 00:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB64522275
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 00:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bo/phCBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgJSAuw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Oct 2020 20:50:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42467 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727173AbgJSAuv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Oct 2020 20:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603068650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fE/Y48CjGF5exAFdQXpq91w93L8qvd2SuneNHFuHjak=;
        b=bo/phCBIESLMZBMepOPbKeq2goTJFFcQ2ZeZ2GD8tBfbWEtHMl5V2fzNZJ1ygRem/diu53
        UBpmu/o8QduXeRAUJtiz9I9ulVBOoyL6y4j9pl3eHB/abWbxfM+VXxPbSmj9fvIZdjO40v
        Ev/wnMnkawOZmVVCl9K050EVCQWSfQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-euvLwKOSMQCm2r3_YSjqSA-1; Sun, 18 Oct 2020 20:50:46 -0400
X-MC-Unique: euvLwKOSMQCm2r3_YSjqSA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B877C1868403;
        Mon, 19 Oct 2020 00:50:43 +0000 (UTC)
Received: from T590 (ovpn-12-185.pek2.redhat.com [10.72.12.185])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D6F8D5D9F3;
        Mon, 19 Oct 2020 00:50:33 +0000 (UTC)
Date:   Mon, 19 Oct 2020 08:50:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Chao Leng <lengchao@huawei.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/4] blk-mq: check rq->state explicitly in
 blk_mq_tagset_count_completed_rqs
Message-ID: <20201019005029.GB1301072@T590>
References: <20201016142811.1262214-1-ming.lei@redhat.com>
 <20201016142811.1262214-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016142811.1262214-2-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 16, 2020 at 10:28:08PM +0800, Ming Lei wrote:
> blk_mq_tagset_count_completed_rqs() is called from
> blk_mq_tagset_wait_completed_request() for draining requests to be
> completed remotely. What we need to do is to see request->state to
> switch to non-MQ_RQ_COMPLETE.
> 
> So check MQ_RQ_COMPLETE explicitly in blk_mq_tagset_count_completed_rqs().
> 
> Meantime mark flush request as IDLE in its .end_io() for aligning to
> end normal request because flush request may stay in inflight tags in case
> of !elevator, so we need to change its state into IDLE.
> 
> Cc: Chao Leng <lengchao@huawei.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-flush.c  | 2 ++
>  block/blk-mq-tag.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 53abb5c73d99..31a2ae04d3f0 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -231,6 +231,8 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
>  		return;
>  	}
>  
> +	WRITE_ONCE(rq->state, MQ_RQ_IDLE);

oops, the above line should have been:

	WRITE_ONCE(flush_rq->state, MQ_RQ_IDLE);

Thanks,
Ming

