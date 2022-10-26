Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C0BC38A2D
	for <linux-block@archiver.kernel.org>; Wed, 26 Oct 2022 03:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiJZDLs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 23:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiJZDLq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 23:11:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F3A733E2
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 20:11:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACDCCB81FC3
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 03:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C69C433D7;
        Wed, 26 Oct 2022 03:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666753900;
        bh=fxmwVHbsA/+pqnCckJV2/2NXsabbJFCdvegpqpw7dQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ln5qqxsE4auLzowtiTlVW1wxUGH4Ug8GQyHRYKuBcfR45KqxnCsQM7H625mIpKqVc
         zWWpOqT2T2pvoPolK6HDOjFfzkQgx9QGVTAUrttRMH1/22j/PuRiD6+9G0ZFnDtgUh
         LyCM0CNVZtIa+WWRBCgg7S/vQdK+4ezcBqTPpn3L4T0PtxMXpNQlGxMWRBXKjZw6xy
         H/Rf4VidNXukO3pZR8/tK2ceSzi154Z85W+z7t06vtdL0wTTKp8+J+t+VBgguqnmiB
         G7YKWJRda2tuc4OOIDGm0R3zY+vuNMn6MhYi4nXbM2QObT3cagn13HbFe03zQ5DmWT
         7f953DmfPiquQ==
Date:   Tue, 25 Oct 2022 21:11:37 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        David Jeffery <djeffery@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2 1/1] blk-mq: avoid double ->queue_rq() because of
 early timeout
Message-ID: <Y1ilaQV3hz6kudH3@kbusch-mbp.dhcp.thefacebook.com>
References: <20221026015521.347973-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026015521.347973-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 26, 2022 at 09:55:21AM +0800, Ming Lei wrote:
> @@ -1564,8 +1571,13 @@ static bool blk_mq_check_expired(struct request *rq, void *priv)
>  	 * it was completed and reallocated as a new request after returning
>  	 * from blk_mq_check_expired().
>  	 */
> -	if (blk_mq_req_expired(rq, next))
> +	if (blk_mq_req_expired(rq, expired)) {
> +		if (expired->check_only) {
> +			expired->has_timedout_rq = true;
> +			return false;
> +		}
>  		blk_mq_rq_timed_out(rq);
> +	}
>  	return true;
>  }
>  
> @@ -1573,7 +1585,10 @@ static void blk_mq_timeout_work(struct work_struct *work)
>  {
>  	struct request_queue *q =
>  		container_of(work, struct request_queue, timeout_work);
> -	unsigned long next = 0;
> +	struct blk_expired_data expired = {
> +		.check_only = true,
> +		.timeout_start = jiffies,
> +	};
>  	struct blk_mq_hw_ctx *hctx;
>  	unsigned long i;
>  
> @@ -1593,10 +1608,24 @@ static void blk_mq_timeout_work(struct work_struct *work)
>  	if (!percpu_ref_tryget(&q->q_usage_counter))
>  		return;
>  
> -	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
> +	/* check if there is any timed-out request */
> +	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &expired);
> +	if (expired.has_timedout_rq) {
> +		/*
> +		 * Before walking tags, we must ensure any submit started
> +		 * before the current time has finished. Since the submit
> +		 * uses srcu or rcu, wait for a synchronization point to
> +		 * ensure all running submits have finished
> +		 */
> +		blk_mq_wait_quiesce_done(q);
> +
> +		expired.check_only = false;
> +		expired.next = 0;
> +		blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &expired);

I think it would be easier to follow with separate callbacks instead of
special casing for 'check_only'. One callback for checking timeouts, and
a different one for handling them?
