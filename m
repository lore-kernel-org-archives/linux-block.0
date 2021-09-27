Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F226DC433FE
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 11:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5EB360F58
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 11:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbhI0L6V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 07:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbhI0L6U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 07:58:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F30C061575;
        Mon, 27 Sep 2021 04:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kp6FeOUIHhYgVPfiiOHW1sPtqbzW+ISO9kJOVy2PM64=; b=gbiv35trJWrwWe+2U11BG6Mvk5
        Ju52pIrguiyp71eh7FLH3daleYHkPxHikVvxW7WL7dlroJYXDt5nknYh4tBD9P/OFMIeWUOdbk/W4
        VumM7z9XCSuYfHJs+SAS2kB1dXkb1vWJR/5KJwfTVZjHhzEMcwznsNB9+7Ql/4rpTBbLJFNOFcEbk
        4QYvRlgEr8mDLO9P7tSFSm7obAke/Mpjm/CusSD/TZL/Ql5Uqwj+kN+vhJTm8RSIXP1AThmkXCMYp
        KHgjOOQy3whbyBIh0yLelX+hO1dojDtiZUop42x+3SMbkQ0Wt5VVfxEI0MSc2GZCPFFHNwIi/P5PT
        hxB/t+Mw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUpDd-009iNp-Lg; Mon, 27 Sep 2021 11:55:18 +0000
Date:   Mon, 27 Sep 2021 12:54:49 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     hch@infradead.org, mst@redhat.com,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        stefanha@redhat.com, israelr@nvidia.com, nitzanc@nvidia.com,
        oren@nvidia.com, linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH 1/1] virtio-blk: avoid preallocating big SGL for data
Message-ID: <YVGxCdhPxu6vct1A@infradead.org>
References: <20210830233500.51395-1-mgurtovoy@nvidia.com>
 <YVGwqlOTY9GWQfwQ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVGwqlOTY9GWQfwQ@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 27, 2021 at 12:53:14PM +0100, Christoph Hellwig wrote:
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Err, sorry.  This was supposed to go to the lastest iteration, I'll
add it there.
