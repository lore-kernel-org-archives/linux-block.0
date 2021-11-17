Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FABC433F5
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 06:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6487161BFA
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 06:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhKQGSb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 01:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhKQGSa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 01:18:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7612CC061570
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 22:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JP6fWNgfli7JWoW2de76zunE7n6LuUO2BZDB33kQ8mM=; b=uWDbbSR2G+P1TwJLX2dKw7mQPt
        lYMKXwD3hFwkQ+CzoYKYbdNt1HZG3nSOSiKW1HOv6HpoGBrnrWbzOpVkQgPqWUv9gdqas8/mj6iuX
        AEkLR/jU52NHHkRMtfE9Rxhcptv3PrOPA5Mu1LUxqBOVVaSk17L/8yYHSqm68+aU9W1Ptbic8gk6k
        prsT0C7ug05IfvQjyXBEgn0mOQCAwtIR933wbfFzeeMDtmMKNGYDEjUV2rvpxKg0aqkZkFGdjRfOV
        dEALJGSjTxXrpXU/yDlRjA48YlKjNFBLFhK4o4OYtsfMJL+Y7WCJboAQ9p1DCulRs/ONf3Bhb2UVf
        iMpWOl/w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnEEG-003QMv-3Z; Wed, 17 Nov 2021 06:15:32 +0000
Date:   Tue, 16 Nov 2021 22:15:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 2/4] nvme: split command copy into a helper
Message-ID: <YZSeBFhNvkYsiA2T@infradead.org>
References: <20211117033807.185715-1-axboe@kernel.dk>
 <20211117033807.185715-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117033807.185715-3-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 16, 2021 at 08:38:05PM -0700, Jens Axboe wrote:
>  /**
>   * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
>   * @nvmeq: The queue to use
> @@ -511,10 +520,7 @@ static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
>  			    bool write_sq)
>  {
>  	spin_lock(&nvmeq->sq_lock);
> -	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
> -	       cmd, sizeof(*cmd));
> -	if (++nvmeq->sq_tail == nvmeq->q_depth)
> -		nvmeq->sq_tail = 0;
> +	nvme_copy_cmd(nvmeq, cmd);
>  	nvme_write_sq_db(nvmeq, write_sq);
>  	spin_unlock(&nvmeq->sq_lock);

Given that nvme_submit_cmd only has two callers, I'd be tempted to just
open code in the callers rather than creating a deep callchain here.
