Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C105C34047
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 16:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4C52067D
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 16:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A5zup0/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgBSQaQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:30:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgBSQaQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 11:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+YTqgPxKXHQcHMkW6GXNHumjMuoizIUcyDnmsogSMbg=; b=A5zup0/mbprngaaymaRX+EGvT8
        XCu7zrWUVVcfv8q01WuUKuot9fF5yMSEoL1H++vNxMgXJZYlNP7Oke/VlP96OtFLUC4sp4wsdc2aO
        uv2lSfFan/Jl4xnBkPxxFFRhcVNWP/p4uwJDmeXS9rhKFTcFaZTetPwoEPngShZo2la6tPb4+fLOp
        ZqWllxBO4h/FINTyA7GHPYThGfLfjAAT5rRC4gdvxmrNFEI82fZDAdwYvN9EQKtdxw0jU/TdX/gvl
        4QaLfV8Kmsimh7DAw0sfUU+AQKwjsOBu2A0V1PbKFQlpw8WAdcXx+q2CD+BVsu7ju4LaQ07Qenim4
        /gFWg9mw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4SEp-0004Xf-JC; Wed, 19 Feb 2020 16:30:15 +0000
Date:   Wed, 19 Feb 2020 08:30:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] bcache: make bch_btree_check() to be multiple threads
Message-ID: <20200219163015.GE10644@infradead.org>
References: <20200215082858.128025-1-colyli@suse.de>
 <20200215082858.128025-3-colyli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215082858.128025-3-colyli@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

maybe s/be multiple threads/multithreaded/ in the subject?

