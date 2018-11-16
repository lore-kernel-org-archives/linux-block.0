Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177D7C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74FF2089D
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bD/JMotO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74FF2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeKPSuA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:50:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbeKPSuA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zM/LPODREadS3lwtmjN5C1UC/ThPCCho3r4i6ndulIE=; b=bD/JMotO10lrA7ZXw0pHuU9u9
        LWH5Cd05A0uHVIiPo2B0UQcLEMEMXr36q/7JB5nJ61diiOCBTjlbBMXBTtRYGZneLEg5vLXqrPmdH
        ldwrvETKEZtoTyrqMFM6xpQOmM/Z1v7Ae1CCJUtx91rtyKmUdfWsSYDY2YDoLwk9Gy/jceq8vM02V
        DTfhshce/9Lwx+KI206xdVFMVitriKPYitqmmdbt8cZA3cGyMhpmkZWEy05NVlUqUwtdXApDqD0eb
        boefeAHYqqphBzQRiyvgsU0Z9Aq68wBnE8QVjSqC/QOd/772MY84lK7n7hcDd3LYrZp4Ol944Bd7P
        JmmNVYY3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNZeB-00041y-9S; Fri, 16 Nov 2018 08:38:39 +0000
Date:   Fri, 16 Nov 2018 00:38:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 03/11] blk-rq-qos: inline check for q->rq_qos functions
Message-ID: <20181116083839.GE9023@infradead.org>
References: <20181115195135.22812-1-axboe@kernel.dk>
 <20181115195135.22812-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115195135.22812-4-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 15, 2018 at 12:51:27PM -0700, Jens Axboe wrote:
> Put the short code in the fast path, where we don't have any
> functions attached to the queue. This minimizes the impact on
> the hot path in the core code.

This looks mechanically fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But since I seem to have missed the introduction of it - why do we need
multiple struct rq_qos per request to start with?  This sort of stacking
seems rather odd and counter-productive, and the commit introducing
this code doesn't explain the rationale at all.
