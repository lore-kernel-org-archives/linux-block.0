Return-Path: <SRS0=ZSeo=EM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC13CC2D0A3
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 14:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 107C1208B3
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 14:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ck/ClVa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgKFOT2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Nov 2020 09:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKFOT2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Nov 2020 09:19:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E431DC0613CF
        for <linux-block@vger.kernel.org>; Fri,  6 Nov 2020 06:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q0iIzCch8dECVtr4ccwvqxYQ8ASSx68Fsd69Q1tG5cU=; b=ck/ClVa5041I5uApej8MpGj65M
        QNfZifbbJORiIcNzFi26DBs+Zxz6ZsXhw2luEXQhDC0XyMdVgcO379VQsUaNOxZ4BbspZTE+GavBq
        ARWf1dVibTu2ls3z99AAYC4Rf2ZGu7nEw9cgZvWrhUI3Lgt1c2HvVyihLi5EfX7K4OEsYNtRyzBUH
        W/QJ4BFGF6jz07PHyOkajfCFkziDQvm4jKKNahZXObD4rhhrJyK88dP/MBoKMsdmBogyDjAbkeIQJ
        EJ+iexEEqCRH7vxtw4Zl+WwDEP/Vu81d/MOzHj1UXWetMZ3kyIwXByVbLxe5XVSShtiLSgZChMLoN
        s52ifIkA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb2aM-0006Ka-Bo; Fri, 06 Nov 2020 14:19:26 +0000
Date:   Fri, 6 Nov 2020 14:19:26 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] null_blk: Fix scheduling in atomic with zoned mode
Message-ID: <20201106141926.GA24218@infradead.org>
References: <20201106110141.5887-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106110141.5887-1-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good for now:

Reviewed-by: Christoph Hellwig <hch@lst.de>

although I think we should address the global lock for the
!memory_backed case rather sooner than later.
