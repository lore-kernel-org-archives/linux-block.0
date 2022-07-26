Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48094CCA47E
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 11:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbiGZLl0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 07:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiGZLlZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 07:41:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3737028710;
        Tue, 26 Jul 2022 04:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6uX0ZGLyrejIyanBkIZQ8Y8Qhs+sb9jbXy/SwZp+jNQ=; b=hVUtdq17/jKtV427xkunPAHRXa
        9n1scVuoZM7AMeNAy/FAjDS62hzzkksr7DNFI8GNpHgJU7x6ryrleNaIcv9eGi+xxocvj7va1Q9Cj
        3Y/5TcOn6L4WI1YnPvSuIyzDq8ZhcbpAcL+7XbS/vNNqxt8nTodUk066SzwGl09rJmVNlr8JYe++K
        9w7BJQX260OddWOVJ+9A9gEdu8fYe+IiiJXUiYQS0uUj1xmVVNKC5OuThP1GaAOfPmN7R4nc7AtgT
        xbzfHcDV0wbHgdvMR6q0cEOGGX+0rJcgzk4zd7m0AE+7qBQ9Kq0BK7OoVM9mQTtBcm+blg7ePNGHv
        84vLLIzA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGIwD-00GBhC-HQ; Tue, 26 Jul 2022 11:41:21 +0000
Date:   Tue, 26 Jul 2022 04:41:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, geert@linux-m68k.org
Subject: Re: [PATCH v8 1/2] block: fix signed int overflow in Amiga partition
 support
Message-ID: <Yt/S4QieA0/4LjLF@infradead.org>
References: <20220726045747.4779-1-schmitzmic@gmail.com>
 <20220726045747.4779-2-schmitzmic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726045747.4779-2-schmitzmic@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 26, 2022 at 04:57:46PM +1200, Michael Schmitz wrote:
> The Amiga partition parser module uses signed int for partition sector
> address and count, which will overflow for disks larger than 1 TB.
> 
> Use sector_t as type for sector address and size to allow using disks
> up to 2 TB without LBD support, and disks larger than 2 TB with LBD.
> 
> This bug was reported originally in 2012, and the fix was created by
> the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
> discussed and reviewed on linux-m68k at that time but never officially
> submitted. This patch differs from Joanne's patch only in its use of
> sector_t instead of unsigned int. No checking for overflows is done
> (see patch 2 of this series for that).
> 
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Tested-by: Martin Steigerwald <Martin@lichtvoll.de>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  block/partitions/amiga.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
> index 5c8624e26a54..f98191545d9a 100644
> --- a/block/partitions/amiga.c
> +++ b/block/partitions/amiga.c
> @@ -31,7 +31,8 @@ int amiga_partition(struct parsed_partitions *state)
>  	unsigned char *data;
>  	struct RigidDiskBlock *rdb;
>  	struct PartitionBlock *pb;
> -	int start_sect, nr_sects, blk, part, res = 0;
> +	sector_t start_sect, nr_sects;
> +	int blk, part, res = 0;
>  	int blksize = 1;	/* Multiplier for disk block size */
>  	int slot = 1;
>  
> @@ -96,14 +97,14 @@ int amiga_partition(struct parsed_partitions *state)
>  
>  		/* Tell Kernel about it */
>  
> -		nr_sects = (be32_to_cpu(pb->pb_Environment[10]) + 1 -
> -			    be32_to_cpu(pb->pb_Environment[9])) *
> +		nr_sects = ((sector_t) be32_to_cpu(pb->pb_Environment[10])
> +			   + 1 - be32_to_cpu(pb->pb_Environment[9])) *

Nit: we usually don't leave a whitespace afte a cast and the operators go
onto the previous line, i.e. this should be:

+		nr_sects = ((sector_t)be32_to_cpu(pb->pb_Environment[10]) + 1 -
+			    be32_to_cpu(pb->pb_Environment[9])) *

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
