Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6772CC433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31AC16115A
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhJTGK0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 02:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhJTGKZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 02:10:25 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F3EC06161C;
        Tue, 19 Oct 2021 23:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nVCF7K3gy8t++oilgt6Lq+1KU5MchEW73Byv1/RLJqY=; b=4n0xkWPlHbg/VzNBLPkn8vCxp7
        QG3TRqWD/fHXTHYyn8/ho/KT/q296fZPgLIRLug7NiB1mnUiTy8Vwbix7cYU6wvVI8A020mOjHWNy
        EMlNrLVtXLSCN5yjMR+/QOpeJ/4C62pQmMkiT7sf92SXvbMl2MmwsuutwKVrJQNMORLnwvAFKuwJL
        RQjQf1/5C6dH0SBCUr1WnXoIbdm8oAicgpEQT7PkIQyHZ8vhS8PZvJCDGJMplAg2ZQYgiNPLeMVp0
        FQLScE6aLaF86LhPT7dnN5gTo5WiilVAxq1MEM+ly5jJWtNx+lh7igAbCe/XZkU0JaArmaz8cXbgM
        vQW/mCCQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md4lm-003SQk-N2; Wed, 20 Oct 2021 06:08:10 +0000
Date:   Tue, 19 Oct 2021 23:08:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: schedule queue restart after BLK_STS_ZONE_RESOURCE
Message-ID: <YW+ySp6Fqgxr8alD@infradead.org>
References: <20211020040404.132984-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020040404.132984-1-naohiro.aota@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 20, 2021 at 01:04:04PM +0900, Naohiro Aota wrote:
>  		needs_restart = blk_mq_sched_needs_restart(hctx);
> +		need_resource |= (prep == PREP_DISPATCH_NO_BUDGET);

Nit: I think this would be a little more readable as:

		if (prep == PREP_DISPATCH_NO_BUDGET)
			need_resource = true;

But otherwise the patch looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
