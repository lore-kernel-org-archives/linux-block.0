Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A8DC48BDF
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 07:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9700C6102A
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 07:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhFXHEx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 03:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhFXHEw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 03:04:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533FDC061574;
        Thu, 24 Jun 2021 00:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=viVnU7GAcltDcfjhPF6DDIbci/SBwqdjKknyNfP+27I=; b=vKlR1UhwOcnjlPpk164wSBDzUs
        2zFS7XTIr2+eIhRqZRYEbT0qYrV25fT9kcief3ytTIWJRcuwMzYYDjz13mOoVtp6OMk6CmrWrNxH3
        Sw1OLDjJh8kE2G3nyEqDEhnMS/wDcM3gCtvB/vBJjvI0xkOG1PV+sp7eGOzRBmPKgfus5dS72fXy5
        +x+xQ7cJ6yGxRgKARq1Sf792du1+VcLKJIGbf7HhBfUSsKIcdgkqIIwluJH7a8YzfMgNOqdJ2XfPP
        cnlh9s0ko3kDXpk2rEC9kneaHFJbi2jk1kl3S93sCkyBzz1OM0uZvUVp+0mRYzMMyYu/tzF19QiOe
        qlK8KbHg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwJNF-00GHYM-Mj; Thu, 24 Jun 2021 07:02:09 +0000
Date:   Thu, 24 Jun 2021 08:02:05 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Edward Hsieh <edwardh@synology.com>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        neilb@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, s3t@synology.com,
        bingjingc@synology.com, cccheng@synology.com,
        Wade Liang <wadel@synology.com>
Subject: Re: [PATCH v3] block: fix trace completion for chained bio
Message-ID: <YNQt7XtxrFhLhS7E@infradead.org>
References: <20210616030810.4901-1-edwardh@synology.com>
 <YMmDxl9abff+wulm@infradead.org>
 <1204c32a-e3b3-95dd-b2b5-b9f6eef4f022@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1204c32a-e3b3-95dd-b2b5-b9f6eef4f022@synology.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 24, 2021 at 02:50:30PM +0800, Edward Hsieh wrote:
> We are suggested by Neil Brown in the last version that from the
> comment, the bio_chain_endio handling is used *only* to avoid
> deep recursion so it should be at the end of the function.
> Therefore, the position of blk_throtl_bio_endio() and bio_uninit()
> are a bit odd.

This is BS.  Placement of an else after a returning statement does
not change code generation.

> If it's not necessary then V2 patch should work to fix the
> missing completion traces. Should we resend PATCH V2?

Please send an updated version.
