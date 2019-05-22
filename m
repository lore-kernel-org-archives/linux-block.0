Return-Path: <SRS0=6LXE=TW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D74C46470
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 12:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818AC21841
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 12:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hv+PrGcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfEVM3F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 May 2019 08:29:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60146 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbfEVM3F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 May 2019 08:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nxaaWX0j8rFdFCm/Kf6KfpdTfcr9NsWGTpWvZ3FHBhY=; b=hv+PrGcylD/RhViTAbwni3aq1
        xe+7U3VaHnwsgGlkvd6kOaP3tj0cLVstCL+jvUkotoawj7TvJkprlo8xC8sdmbgZZz/5CGp9TayKo
        +38KKYlYkz7v0fEugB/tLaHxcEA5tOnG/Jo9XASNI3pUW4nlcqjHm5tfRib9ZKMX0bHss9nMvyfyZ
        xETV4B2pzSyFYFzRc3IY7//hjt/rI0yWMhUnlFB3F4rH1rlPBgE9yai1f1GavQKEaz2jeQmOpDARB
        wr0tmLu1YVa50sjtikBE4l9nW0qFp0d6fdWq2KLZmKuSU2IGdpPtVDpygUOvJQxPlaDLHvK1iD0WC
        U1I0r1KYg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTQMg-0002qe-3G; Wed, 22 May 2019 12:29:02 +0000
Date:   Wed, 22 May 2019 05:29:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mmc: renesas_sdhi: use multiple segments if
 possible
Message-ID: <20190522122901.GA4583@infradead.org>
References: <1558520319-16452-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1558520319-16452-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558520319-16452-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 22, 2019 at 07:18:39PM +0900, Yoshihiro Shimoda wrote:
> In IOMMU environment, since it's possible to merge scatter gather
> buffers of memory requests to one iova, this patch changes the max_segs
> value when init_card of mmc_host timing to improve the transfer
> performance on renesas_sdhi_internal_dmac.

Well, you can't merge everything with an IOMMU.  For one not every
IOMMU can merge multiple scatterlist segments, second even it can merge
segements the segments need to be aligned to the IOMMU page size.  And
then of course we might have an upper limit on the total mapping.

> +	if (host->pdata->max_segs < SDHI_MAX_SEGS_IN_IOMMU &&
> +	    host->pdev->dev.iommu_group &&
> +	    (mmc_card_mmc(card) || mmc_card_sd(card)))
> +		host->mmc->max_segs = SDHI_MAX_SEGS_IN_IOMMU;

This is way to magic.  We'll need a proper DMA layer API to expose
this information, and preferably a block layer helper to increase
max_segs instead of hacking that up in the driver.
