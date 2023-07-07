Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8E4EB64D9
	for <linux-block@archiver.kernel.org>; Fri,  7 Jul 2023 00:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjGGAjj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jul 2023 20:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGGAjj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jul 2023 20:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136DA1FDF
        for <linux-block@vger.kernel.org>; Thu,  6 Jul 2023 17:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688690323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ro1nJzcln/eYZkAzkMTbLXXcZ5XsFny+Ub1a6wQm7lU=;
        b=FnSn0oc7IT6lma3yvzuCspN1Du3oQKf7+0rB6esbGSZuaR/Mp7ZiRpamDZinH1ZsA8rE2K
        77/yXzE44biD9zsQBtxYyQ37MZJpQgrPyRfzlFs8PSX9a9yfGe5n9g4ntMixBOg7otKvCq
        Pv9V01trtoiTk3lkW9/+IBK0pUbNRGc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-11BLZukdNsO-N-IHAkYZtQ-1; Thu, 06 Jul 2023 20:38:40 -0400
X-MC-Unique: 11BLZukdNsO-N-IHAkYZtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D79B3C0F675;
        Fri,  7 Jul 2023 00:38:39 +0000 (UTC)
Received: from ovpn-8-34.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CEC86F6435;
        Fri,  7 Jul 2023 00:38:11 +0000 (UTC)
Date:   Fri, 7 Jul 2023 08:38:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] block: Do not merge if merging is disabled
Message-ID: <ZKdebT5VRdr0qxxv@ovpn-8-34.pek2.redhat.com>
References: <20230706201433.3987617-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706201433.3987617-1-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 06, 2023 at 01:14:33PM -0700, Bart Van Assche wrote:
> While testing the performance impact of zoned write pipelining, I
> noticed that merging happens even if merging has been disabled via
> sysfs. Fix this.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq-sched.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 67c95f31b15b..8883721f419a 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -375,7 +375,8 @@ bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
>  bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
>  				   struct list_head *free)
>  {
> -	return rq_mergeable(rq) && elv_attempt_insert_merge(q, rq, free);
> +	return !blk_queue_nomerges(q) && rq_mergeable(rq) &&
> +		elv_attempt_insert_merge(q, rq, free);
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);

elv_attempt_insert_merge() does check blk_queue_nomerges() at its entry,
so this patch fix nothing.

Given blk_mq_sched_try_insert_merge is only called from bfq and
deadline, it may not matter to apply this optimization.

Thanks,
Ming

