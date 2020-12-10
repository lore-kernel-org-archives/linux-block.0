Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB0DC4361B
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 06:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BC723770
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 06:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgLJGI0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 01:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgLJGI0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 01:08:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14B8C0613CF;
        Wed,  9 Dec 2020 22:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=krvzMijr2DTK95r8aDcraPpF2Bvw+tpaABfRE8afbIU=; b=MMFnxyirDBVqe6Ds/gV6tyVUqA
        J/rYehWZL0xV3H9CVJqdT/0u7cs0VjK8ub+idBB13EAMY+9I8WxHYGYyclz7/KqdQ3GMu705JojFv
        moX4BtOK5GSpGon7E+2KtFcAOS6/QHDqfEkj4dSUJGibBt+6BUf7ivlQD3MWw22JGJbpyLh0YqOXI
        2davK57u0P+EA+1SQlSk/RGm79+0j3dB672I3Ov6bpdTS/8p9HNWT687GGwQHgkHw1pkh38U0E2Et
        XKcjMV4siHMuMYA8HPpTNEOt2EhwY8qDvz5VSMhyq2XLE5U1vqu1lGqh2jj03q4WedqJdG8iPYPYO
        cXlp7lxA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knF78-00052W-O9; Thu, 10 Dec 2020 06:07:42 +0000
Date:   Thu, 10 Dec 2020 06:07:42 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org
Subject: Re: [PATCH] block: blk-iocost: fix build for ARCH with missing
 local64.h files
Message-ID: <20201210060742.GA19263@infradead.org>
References: <20201209204657.6676-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209204657.6676-1-rdunlap@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 09, 2020 at 12:46:57PM -0800, Randy Dunlap wrote:
> When building block/blk-iocost.c on arch/x6x/ or arch/nios2/, the
> build fails due to missing the <asm/local64.h> file.

Please mark it mandatory-y if the asm-generic version is suitable
for everyone and random pieces of kernel code are supposed to include
it.
