Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F372AC433EF
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 05:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF2B6115B
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 05:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348026AbhIIFtc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 01:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhIIFta (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Sep 2021 01:49:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A21C061575;
        Wed,  8 Sep 2021 22:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oLeEme0/UtsgtWi3oPoIvHkyGoWeV/STJK5ybt+fzqc=; b=TO+GiZKlesWHaNqYSWzxX0/WuJ
        4g8n1US24PHkLZrfDiS0NsKcDCH8WPbyPe+TvbuXdymrm9s8efmDY6F7bLyTZgq/3Sh98HIg6IrFC
        DBTW1jIIZy3YoSguXDJXd8tGKqg2r+1qGlPb2V/JkbuamzeXNmhX0pfzUjYkQ2+CsHQPu1HWBCDic
        pfN7L1q+s3ZPmBn0MxzQAAdq/7hX29gp/r6IvCEtaJZg80U/H3DJp/mDimvZVNTJxzHXAfu/PiBq4
        trsTc8hj+S1D3+eLAtEgMz+XZpPRza856pvmBRsDSwaugtcdPL/rNMHVy3TIN232lDkWHCN0CS6v9
        cnnKwgqQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOCum-009WCl-2b; Thu, 09 Sep 2021 05:48:03 +0000
Date:   Thu, 9 Sep 2021 06:48:00 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk
Subject: Re: [PATCH] blk-mq: export blk_mq_submit_bio symbol
Message-ID: <YTmgEAEx69PR/RMy@infradead.org>
References: <20210909053653.144360-1-kumarpraveen@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909053653.144360-1-kumarpraveen@linux.microsoft.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 09, 2021 at 11:06:53AM +0530, Praveen Kumar wrote:
> There are use-cases like replication where need to hook the blk I/O
> operations for devices and perform specific operation and fallback to
> its original I/O operations.
> Prior to v5.9 there was make_request_fn and then blk_mq_submit_bio
> exported apis, which provided infrastructure to drivers to develop these
> features. However in v5.10-rc1 with below commit the API was removed
> from the export list.
> 
> Previous commit: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.10-rc1&id=681cc5e8667e8579a2da8fa4090c48a2d73fc3bb
> 
> This patch exports the blk_mq_submit_bio symbol to provide flexibility
> to the drivers.

Please send your users of this "feature" to this list for inclusion
and we'll help you to massage them into a non-broken version.

And yes, you should have gotten the memo by now that we don't export
anything for out of tree modules.
