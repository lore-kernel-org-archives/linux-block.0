Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D01C433EF
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 07:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiERHXw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 03:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiERHXw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 03:23:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA5D50E2C
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 00:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cYLErFCxpD1I/acDYOobQC9MKgloOF+X7iH9mUZf2Co=; b=IuaDcPMbQz2KPXxyklqoW5Bp9G
        EmDpIP+wzRCmnQ3q/qQS3PA4Y6t54lZ0zxINrgg/gPkX6vaJV823JthgbZ/dCpgfhkBm+VJok5kai
        RYkinbygHVhh6IS+SCLj+oMj/v7RlaqaqmEQhP+EMfAPppchEfhz2RkSUofYXD6Q5VqdIrXtndT2H
        rdHAVtnw0bU/33zNlgMqHzuaKq9AZgtdZnufJ2gKr9OI3xsbntFBcz/mqI8h1BRqAI1nQ/QH54Fdu
        lyACzfn6jOw5MMxIB/7sn2DQpO7RStnVxjOrHOQkeYpqPRQFrYJKyBF7eld9WjqHTauQNoixxYJ1m
        nuRd0wqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrE28-0003dM-Nq; Wed, 18 May 2022 07:23:48 +0000
Date:   Wed, 18 May 2022 00:23:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@fb.com>,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH 1/3] block: export dma_alignment attribute
Message-ID: <YoSfBA6cKV1WsZah@infradead.org>
References: <20220513161339.1580042-1-kbusch@fb.com>
 <YoH0vuUA4KdcpEAz@infradead.org>
 <YoJgdrMpIiobiDy3@kbusch-mbp.dhcp.thefacebook.com>
 <YoQn2KkI/nwnUmIG@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoQn2KkI/nwnUmIG@kbusch-mbp.dhcp.thefacebook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 17, 2022 at 04:55:20PM -0600, Keith Busch wrote:
> A little less easy than I thought... This is what I'm coming up with, and it's
> bad enough that I'm sure there has to be a better way. Specifically concerning
> is the new "do_dma()" function below, and was the only way I managed to get the
> correct 'struct block_device' whether we're stat'ing a filesystem file or raw
> block device file.

I don't think doing this in common code makes much sense.  The core
VFS code should not have to know if something is on a block device or
not.

Instead add a new getattr method to block/bdev.c for the block devices,
and just have a helper to set the alinments(s) based on that by it,
and any file systems that is made ready to accept lower alignment.
And I'd prefer to do them individully and tested as there might be all
kinds of assumptions.  For all other instances keep the value as 0
for unknown.

> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -106,7 +106,7 @@ struct statx {
>  	__u32	stx_uid;	/* User ID of owner */
>  	__u32	stx_gid;	/* Group ID of owner */
>  	__u16	stx_mode;	/* File mode */
> -	__u16	__spare0[1];
> +	__u16	stx_dma;	/* DMA alignment */

I'd name this dio_mem_alignment, because it is is:

 a) specific to direct I/O
 b) DMA is just the implementation detail, but not the user semantics

while we're at it, please also add a dio_file_alignment for the
alignment in the file, which can be sector or fs block size.  I'm
perfectly fine if you only do it for the block layer first, I'll
take up the wok to update the most common file systems after that.
