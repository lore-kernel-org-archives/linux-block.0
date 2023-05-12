Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA50C77B7F
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 13:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbjELNS7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240953AbjELNS5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 09:18:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFA2173C
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 06:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=i9BwSRy2OgnBjppUbjDUwJ3lki
        DhR2A/61pFFSNOezKNAhujhdeFv8mHnA4yqfArL36XyH2k8Y0jkwpL83CrYKsPgYcAlNMIdEAJIAB
        MhD0sdM/ZP0w5s6omFHiIPOIbr9Isce8QqkaNwa1pyuc/3PHRExFfb64lJC2TGocx581mfyv20SWZ
        7o/GFY88hc39JBfbBLh1yNY2pejp+DupG2z4BBEXW3WROqr8IFNfRV+UlEfHcmznDDApkfOkAwCTm
        pWwCvAPTYfy8irB6eg2QR1zCtGYaMx7sI5tEc+rWooOxkHXZ/DyhG+hlyDD+WsMjScEuJicNrgR+X
        LEq7upvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pxSfc-00C0fR-1T;
        Fri, 12 May 2023 13:18:52 +0000
Date:   Fri, 12 May 2023 06:18:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk,
        hch@infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] block/rnbd: replace REQ_OP_FLUSH with REQ_OP_WRITE
Message-ID: <ZF48vOtOHCeQxXHd@infradead.org>
References: <20230512034631.28686-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512034631.28686-1-guoqing.jiang@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
