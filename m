Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2095C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 14:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C10320882
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 14:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fnuuhfj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfDCOoo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:44:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34960 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfDCOoo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 10:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=Fnuuhfj/41IGvtjz6soYLKHgw
        NOw8g8oh/E6SeR8R3iTgGFEKncZwXfm+R/EuyPktbWmZ3b8tkP0sqFAC+Y/59EIis7UrkihkEZ26n
        /IWXEKqCQt4nqqnov2IynYheKL4o06J7Sck50a1k/1pXF77//zMNtX2CT3wsYhtd0iuwCcaoSglv0
        Rnl06xBWG3T4M5zoYTDtASB4imXhArduZVZOnO5H4dBVfYen1hDyeK/OjHGYQcneGzJdyes3xcmzK
        lZTPc2gBZp6Gwz9SpubdYELuIuclmkruE2OAqJozV2Apw2dNgDnHqAzWgNRWUtKOuJoOx2tG9+EF8
        XlOYgRECw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBh87-0002Kf-5r; Wed, 03 Apr 2019 14:44:43 +0000
Date:   Wed, 3 Apr 2019 07:44:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] block: clarify that bio_add_page() and related helpers
 can add multi pages
Message-ID: <20190403144443.GA8397@infradead.org>
References: <20190402023632.8485-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402023632.8485-1-ming.lei@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
