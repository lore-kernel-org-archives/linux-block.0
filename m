Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E49C54EE9
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 07:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiITHlN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 03:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiITHks (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 03:40:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1287B61109;
        Tue, 20 Sep 2022 00:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ZxP83v0vaJ+vNwnb1326N/eZ16
        cSLBe6bAkpb+d3lg6Af4u91/ZzsrVW/TkC8u6PQXR0re+uFeCq6sl5WiBRz2NzQRTXaWNKAs4GAF7
        bH+winZ+u/1nqaOqbyEADoNKfdvcXtkW2nJfBN0+DDnriLmL4L67rnldvrh4BogjE3PuCfhNxPy/c
        luq4l16K6sJiqoRa2hZfA+LisEgbAqWM9nD+Q6pkAW9VasYSo8tLkFzLw4b3BpBkViq0RwnSUDlX5
        MrlA1QZwr80AVP5cev+zamm1C6gXO3aC9Qi9ZYd+fTdeI58XnfEw7qFiSfXVVGE349Ux4pvXi30Ss
        HhhS9WqQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaXrD-001R2t-2K; Tue, 20 Sep 2022 07:39:51 +0000
Date:   Tue, 20 Sep 2022 00:39:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ping-Xiang Chen <p.x.chen.1005@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ping-Xiang Chen <p.x.chen@uci.edu>
Subject: Re: [PATCH] block: fix comment typo in submit_bio of block-core.c.
Message-ID: <YyluR+ZyPrnsjaBC@infradead.org>
References: <20220914074237.31621-1-p.x.chen@uci.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914074237.31621-1-p.x.chen@uci.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
