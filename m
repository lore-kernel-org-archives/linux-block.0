Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F11C433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 06:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242758AbhLCG5t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 01:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbhLCG5t (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 01:57:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC2BC06174A
        for <linux-block@vger.kernel.org>; Thu,  2 Dec 2021 22:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J8ZpJ7IEUIssWYiGn4JUZV8YSFiAwMHHgkpgEGYWdV8=; b=ckKOo2oH2akipByjX9I/TFv/1q
        XCZ4UuVBY2njzqnPMVFIwzNB1c3h3zgCt61KH5h3OnXpaDV0GQdzzbq7k2sGSD4XJvYeoVVX/mxMh
        QNV1thAoKx/NLvyH8cbKgg+Zt5HDBJMtLoOi4ENAovenjlqPrR1erq65qIIVQZ0UsXbz3JepY3xVJ
        B0oXsu8JO8XLZz6vQRWky8MndTWXQPlRowmynjaIA+RNQMgITyMhNDLfobINJ/H5bfjZEoE6TXjHe
        tvOT9AQyND/NpL3SA5Dzq+A9MR0VNjVD4ph23Eo50rAVgQ5LbDE9artbtKRlRd51E8aKtURanqWPG
        r0tCLysA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mt2Sf-00EdOZ-Mi; Fri, 03 Dec 2021 06:54:25 +0000
Date:   Thu, 2 Dec 2021 22:54:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 2/2] block: fix double bio queue when merging in cached
 request path
Message-ID: <Yam/Id1Sasa+iKol@infradead.org>
References: <20211202194741.810957-1-axboe@kernel.dk>
 <20211202194741.810957-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202194741.810957-3-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
