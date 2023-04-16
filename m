Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E8FC77B61
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 05:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDPFx6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 01:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDPFx5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 01:53:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2371A2D52
        for <linux-block@vger.kernel.org>; Sat, 15 Apr 2023 22:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bSwuvOu1GCLIkQmHMuQysnhR2LFzOSj1yd6mu/sn+gY=; b=uWE7J2zS+h2C0S1VgNprhnQMb/
        Q9ZnlxbE6jMw9yckULxH1Cg7U4qskel1zi3ozslAKIragxfiLiV3oW38ZaSEBxBsbg0p2xtmKqo3a
        +2k/nSbeNVVOK7IxEWPs/m2fks9qFt8CLesm6COTXSgVJXOZSAhn3yqsOlTdLh/8v7RZdv6MKg/ca
        QC8YU9/XlOZhnAPP40VU5ukHfM4IrhQ5lE4+M8o9qB4S3W/eTNH2b2eRHvLi56Qx5kvNzHX3qqiOj
        yY1HIhWv4CBxeCpwCarXUjkjnsaqwHX5Wye+rHLSLa9A2lvLbGAJNzOcmlhOAK8tj+gqVBNPHNRPW
        +LYOLhEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnvKn-00DBtN-05;
        Sun, 16 Apr 2023 05:53:57 +0000
Date:   Sat, 15 Apr 2023 22:53:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: store bdev->bd_disk->fops->submit_bio state
 in bdev
Message-ID: <ZDuNdUjnrfQF2D7E@infradead.org>
References: <20230414134848.91563-1-axboe@kernel.dk>
 <20230414134848.91563-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414134848.91563-3-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 14, 2023 at 07:48:48AM -0600, Jens Axboe wrote:
> We have a long chain of memory dereferencing just to whether or not
> this disk has a special submit_bio helper. As that's not necessarily
> the common case, add a bd_submit_bio state in the bdev to avoid
> traversing this memory dependency chain if we don't need to.

Do you have any numbers on how this helps?

> +	bdev->bd_submit_bio = 0;

bd_submit_bio sounds like a function call, so I'd name this
bd_has_submit_io.

But maybe it might make more sense to just add a bit that this is
a blk-mq backed device into bd_state as that might be handy in other
places as well?
