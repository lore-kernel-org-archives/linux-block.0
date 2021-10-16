Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AB4C433FE
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 04:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9ADF610E5
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 04:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbhJPEdf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 00:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239469AbhJPEde (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 00:33:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CA8C061570;
        Fri, 15 Oct 2021 21:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=p+p6uTIkzBB8tDKO/mqyeWKSA3
        /pq2YOfPUko4iT6IlWoXJWlT9oX8zlieaQEMAJfjgjy3OFVGoYxRlLqXiXPPMZJB9fdTIdnz8LJ+N
        VCNA5LZu0JDnLPg1LFMdF4XD7wJkh5cddsLWhn5Ib9QZFKNCvdjLtTlg243CBJkLKRsaati0WnFD1
        QpSKrQN7LY8PenbHTD7+yN6t4NFJDNnk5UuLDDm/8RnZvMK0z/3Vl5/mIksmiXsxPeXoW+ZxnZBOq
        +QIghsV9yfh01+YV6XRc1F4glFtfU/ZZORmTbvRjv4Wu9Z9xFWOf2aiM21tH/PFBfEBzCUyyfW56X
        GxYdMVcA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbbLo-009jEH-Go; Sat, 16 Oct 2021 04:31:16 +0000
Date:   Fri, 15 Oct 2021 21:31:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     axboe@kernel.dk, liushixin2@huawei.com, bhelgaas@google.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mtip32xx: Remove redundant 'flush_workqueue()' calls
Message-ID: <YWpVlNmPgdRRurcw@infradead.org>
References: <0fea349c808c6cfbf549b0e33701320c7860c8b7.1634234221.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fea349c808c6cfbf549b0e33701320c7860c8b7.1634234221.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
