Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D9CC433FE
	for <linux-block@archiver.kernel.org>; Mon, 28 Nov 2022 15:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiK1Pcj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Nov 2022 10:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbiK1Pbo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2022 10:31:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B91425C7E
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 07:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FyuHIFv5euFr0Gjw4YqQ22tzxcFF0fJeltBDayrOrMk=; b=ecBoeJDgoYdmH5vd7tE51ceN3N
        uJ9+p5z80V7x3fMf2mrAytzYs3pX1coXfSqVAxBwD2drg71Jfvqs8t/Xbi7I3lFk62FTOPNc2t1AF
        uv4ndBLQwqCbBrd8A4tFmte8M9bUiIkkAS31tOvnCVpxhBfF6mRYLp5UYcnnDMFIdZSwtsX5Nye0Z
        +xCCEhWGkOyJgV6QVweTQEfEgNWf6KwFmQiHgYLr5TMlmD5XOSqleqAOu74sObMADRWi/q3+aVfF4
        frDcW4HNGcaSeoO1LNluUsw52DLzF7NwtZxpwV79ZEV5MItO0BrxYtYEqcZUVsiERYgazUkLzO9Ei
        28zarr3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ozg4T-002VZl-An; Mon, 28 Nov 2022 15:29:25 +0000
Date:   Mon, 28 Nov 2022 07:29:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] Minor fixes
Message-ID: <Y4TT1S4AOAm+wemn@infradead.org>
References: <20221126025550.967914-1-damien.lemoal@opensource.wdc.com>
 <166964494783.5680.1897835623013824110.b4-ty@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166964494783.5680.1897835623013824110.b4-ty@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 28, 2022 at 07:15:47AM -0700, Jens Axboe wrote:
> [2/2] block: fops: Do not set REQ_SYNC for async IOs
>       commit: 26a7bc153a19f3349fd8c2e262728b2eae6bfd6f

Urgg.  I don't think this is right.  And even if it was, block device
I/O is not out of line with the other direct I/O implementations.
