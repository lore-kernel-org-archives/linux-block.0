Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E9EC282DD
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 13:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1988F20643
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 13:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YuNoextm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgAHNby (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:31:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60746 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgAHNby (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 08:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l60ii/K6WG5lhZsXwonTOnnE34oi65D5LN0y4hhl9Ms=; b=YuNoextmvYTcLpLQeSbyrmCwE
        MibAQRDUwyU5OEajZP/gFaC72vsrnSS5E+Jmr1lSoTFdA2G9zCl93ZRiXRQBfKjPH3I90QBkMcxsK
        DYPNxfp+1UHMJcKtNKxCei2+ksp5kiwPTKo+sln1tisgcc1q8JWx2Yt4kEDywrY+TMiVFzv+WC5XJ
        WtRDrmMp/l0ZikQZ/kRbrFTSeJCZKUYj5GhUAuP4SkgDEcikHbsoANVHPRn8+de/g8vyBUI/dIgv9
        3/cBQweZHyPx4rdtdJcP72B4VnKkhmnw21Mq6c3bJWuW8abgEBAt42/piYl9JqOYRbrFLmInN0Nzw
        9F23nbw4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipBRB-0001YQ-A3; Wed, 08 Jan 2020 13:31:53 +0000
Date:   Wed, 8 Jan 2020 05:31:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        jens.axboe@oracle.com, namhyung@gmail.com, bharrosh@panasas.com,
        renxudong <renxudong1@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>, zhengbin13@huawei.com,
        Guiyao <guiyao@huawei.com>
Subject: Re: [PATCH] blk-map: add kernel address validation in
 blk_rq_map_kern func
Message-ID: <20200108133153.GA4455@infradead.org>
References: <239c8928-aea0-abe9-a75d-dc3f1b573ec5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <239c8928-aea0-abe9-a75d-dc3f1b573ec5@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 30, 2019 at 08:17:41PM +0800, Zhiqiang Liu wrote:
> +	if (!len || !virt_addr_valid(kbuf))

While this is a somewhat useful sanity check, it should never triggger
except for a grave bug in the caller.  So this needs a WARN_ON_ONCE
and a better explanation on how you triggered it, and most likely a
real fix for the caller.
