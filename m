Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38679C282CE
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 06:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CFD2084F
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 06:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C60gKQeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfDHGbj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:31:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45858 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfDHGbj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 02:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FM2H9hYluKI8BmFfcVhm5/w6M5ciV2Urhu83YANEmYw=; b=C60gKQeB2+t/9pfq2T74HPLCL
        G12+cgs2s+mwmo+/nci3RhH138EfcNBM231LXmZTMOdV+u8sA5L16DBhHkaFmthzlArM9fmENw6EX
        o9aLrQ0ioIV/iHzv9mEMvfscwJ3dHAAtYkWNZqsgVYmgHPhjCavwH2UIE1OTTW0XOYt+ZvEFPwg0h
        1IFH3i5OgCn107uZs6Og2w5vQqclHRb2IR9O9SuLITjrL1oTY5VJw2iKhas0TYdPl8AthOX4kfHSN
        1/x0J2MEVo+lifvNq+/nF1VbVvjbmQfyfx7qsdO/VdY2NpxcqopaQy21X5/Ma0IwcrJiiv2w02wCn
        u34fboOUg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDNog-0008S1-LG; Mon, 08 Apr 2019 06:31:38 +0000
Date:   Sun, 7 Apr 2019 23:31:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hisao Tanabe <xtanabe@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: remove unused variable 'def'
Message-ID: <20190408063138.GB9257@infradead.org>
References: <20190407152742.30821-1-xtanabe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407152742.30821-1-xtanabe@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 08, 2019 at 12:27:42AM +0900, Hisao Tanabe wrote:
> The 'def' local variable became unused after commit f382fb0bcef4 ("block: remove
> legacy IO schedulers"), let's remove it.
> 
> Signed-off-by: Hisao Tanabe <xtanabe@gmail.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
