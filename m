Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449DEC433FE
	for <linux-block@archiver.kernel.org>; Tue, 15 Nov 2022 09:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbiKOJNL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Nov 2022 04:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237701AbiKOJNK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Nov 2022 04:13:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AA321E2A;
        Tue, 15 Nov 2022 01:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nNmdNr72F7JnqSK5T7GGDKWQNE+gfCD7Nu7AVN1iiIo=; b=SW8L4WsNy8yyQUdTdG5ZYEXJZ+
        9mXaKQ3S1/iWWsMdDncHfptCDhfA0bnRGlVXe5BC6AXR5nSUFNpsrlk1OOd3L6aey3Q+7FQ+2hQZm
        h2yfySIVHCksLL59ter4Ezk8nHA6oI8GFSSiKQHFkNBO+dDY0Opt7pH5j4C35THvR+4TJJnk/RDqe
        WjR7ny+havRvsFAf2sx+75vIA1Fa55hUJo4KtKixDyRpsp/GFje0HgVyLP5vvMB1u/qLi9Isx5qa4
        yA7R1iZLMDVaV46sc1wGzKkV0FJ/G3a8QOYUnDZEAjTSliXEgROLwH5e+F9+CuCtvRA4uPkAWoA7W
        whSwXFtg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ous0B-009EFP-TN; Tue, 15 Nov 2022 09:13:08 +0000
Date:   Tue, 15 Nov 2022 01:13:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] blkdev: make struct block_device_operations.devnode()
 take a const *
Message-ID: <Y3NYI04dFGgtQke9@infradead.org>
References: <20221109144843.679668-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109144843.679668-1-gregkh@linuxfoundation.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 09, 2022 at 03:48:43PM +0100, Greg Kroah-Hartman wrote:
> The devnode() callback in struct block_device_operations should not be
> modifying the device that is passed into it, so mark it as a const * and
> propagate the function signature changes out into the one subsystem that
> actually uses this callback.

Yes.  In fact it really shouldn't exist at all.  I wonder if we can
do another attempt at dropping pktcdvd?

