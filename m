Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FFDC43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3E4206BB
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CO1CUG40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3E4206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeKSS2f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:28:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35396 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeKSS2f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 13:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V8JcxpYInnwJnr5INtyM4KXnIyL1spe3oCtqtO1/u2Q=; b=CO1CUG407whqFlVWn0vz8celb
        69qcR270fp25HCrY2UO2lxZo2f5rxvNo8iLfPigf4u+qgBcH9VPObdOdiwMsa81FP4BCVhkqEaGof
        q2uHI+YVC16ZmczBJ0/p0lJhhlB9GwUB3ce1Vo/646OqVCXtNOW+wqFe+CcWKLKLX7GSRLJkJ29Fa
        V4UiTgdcpv6q4ult1McJB2CXz+4saeFc3snolXgFOnTqiNUQJB4t4jvqS2v58++NPuzZD+I4qWSzS
        /LxJilW+zcb9VjkfvDGtRjXHBiZc60N2VPWwusZvIKXWeDhOg+OvS/J+seFQBenAHw8e8ANn/Aveq
        f03KtSgKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOeYy-0006hQ-7P; Mon, 19 Nov 2018 08:05:44 +0000
Date:   Mon, 19 Nov 2018 00:05:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/7] block: make blk_poll() take a parameter on whether
 to spin or not
Message-ID: <20181119080544.GF9622@infradead.org>
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-7-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117214354.822-7-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -bool blk_poll(struct request_queue *q, blk_qc_t cookie)
> +bool blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)

I find the paramter name a little confusing.  Maybe wait_for_request,
although I don't particularly like that one either.  But we really need
to document the parameter well here, no matter what we end up naming
it.  And we should use a consistent name through the whole stack.

> index c1ec3475a140..f6971b45bc54 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -116,7 +116,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>  
>  	cookie = submit_bio(bio);
>  
> -	blk_poll(bdev_get_queue(req->ns->bdev), cookie);
> +	blk_poll(bdev_get_queue(req->ns->bdev), cookie, true);

This opportunistic poll is pretty bogus now as we never set the HIPRI
flag and it should probably be removed in a prep patch.  We should then
later try to use a scheme similar to your aio polling for the nvme
target as well.
