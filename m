Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244B7C433EF
	for <linux-block@archiver.kernel.org>; Wed, 24 Nov 2021 07:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhKXHqg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Nov 2021 02:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhKXHqf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Nov 2021 02:46:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79B9C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 23:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=MQSeJPkepU7G2+pEbvo0KT/htF
        A4ORGiwfvQI2TXZBjanCsr8Y5qRCP241YVyUPA0YH4t3VLCH7ic60mOt76zZO0zePmau7Gk3SpbmM
        +Bcm1dAnpRNTpyUcuEkp0kSMwcvXJ/Arx4J/c/JIltrpZuLDF2hea4QbmoB4A7h4pxOfkBaCc1VHp
        CVPzK7SOFcBMdUfcLNLPEHUD7D0HLwZkYKsZnaP6uLnbq76ov4u0+hW1IdXNkbtUiWcvO2jxrQcRg
        abN5BWjpMIxTp0alxfHO4q9zKqrS7s/L/7pkwe2/cMANs9iTZ5lvIs1cMJTqR0/D9Km2UdRLPoJ4M
        MXr7+m3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpmwA-0049Zc-Ha; Wed, 24 Nov 2021 07:43:26 +0000
Date:   Tue, 23 Nov 2021 23:43:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-crypto: remove blk_crypto_unregister()
Message-ID: <YZ3tHrHbrjcYou0+@infradead.org>
References: <20211124013733.347612-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124013733.347612-1-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
