Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC85C43334
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 06:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiGLG4D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jul 2022 02:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGLG4C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 02:56:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CC38FD7B
        for <linux-block@vger.kernel.org>; Mon, 11 Jul 2022 23:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=GhNidsFx0/8tDx9BrUYIgTLnKy
        HGOpDOCvT0VtXy5RAVf77IWuuxbnhjVPrfT8XK+CqDycpukY/ADYcx4XHH1JWzkaY2DAlxEGh/DHa
        Z3V1QHZJT2rLicpIZSC//ht+OUP+Q+bme6R85SKAH9vmwQcX4GUUgQzDEfsx6IGYQpVqRg1x20VBW
        QhvRZZ6rVIt1NE7rISxTR6yYqlUhr8vQqQstUdIRnynNgbxWc8+9xArktt/aTV6o1Rl31anY+UP7P
        RTlxyVfq+LVO45pnfMmIx/cKNTAg2KK1a8w0yVDZ6cefwQCMGnsjHmpDp22LTuAmbm4pz/IezkQlZ
        DZSu6W6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oB9oO-008APy-Lj; Tue, 12 Jul 2022 06:56:00 +0000
Date:   Mon, 11 Jul 2022 23:56:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vincent Fu <vincent.fu@samsung.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH for-next v2 2/2] null_blk: add configfs variables for 2
 options
Message-ID: <Ys0bAMk9uGQWyQ+u@infradead.org>
References: <20220708174943.87787-1-vincent.fu@samsung.com>
 <CGME20220708174952uscas1p25f5532b41eb96fe2ddc7a1a06b1a78af@uscas1p2.samsung.com>
 <20220708174943.87787-3-vincent.fu@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708174943.87787-3-vincent.fu@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
