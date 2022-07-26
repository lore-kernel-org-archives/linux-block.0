Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F431C43334
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 11:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiGZLm7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 07:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbiGZLm6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 07:42:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33CF2A438;
        Tue, 26 Jul 2022 04:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CZoNUVo1igbcpZTrqOvs2Pa5+5Pl6Ps0T7FgFnqQLac=; b=YFJv3l+Blv122NP4DU9w3ZxtKn
        QXc6wsYWgJLF7WXZNzFpuaY9vk0f3N24JZh9Z3kPZhOLEDpCNOqlnzcrq4sgTVLv6vZwxt4M5F8/F
        UNUu7+zRmjFcBAg0hLASI2dsdM5a82s0AnpoA4Wu3INxRlVV2U7+9gJPtL/nvq6rnrwvfJ96l2WhX
        RGlmqya+Y7zcYtls/B+J9oUR2yyqXjR+XPWzc5INj1N8D9KOjCnjn4bnjmuhMmmz4PQQ9I7JkiJ36
        sTuS2SvKF2mzwts2UJCHiz94o6hoTxgdBtN5YXgiJKJqTy7rofsnB9ur56x34ZS/cGNsg0daFmmok
        3gZmJPPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGIxk-00GEFF-VA; Tue, 26 Jul 2022 11:42:56 +0000
Date:   Tue, 26 Jul 2022 04:42:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, geert@linux-m68k.org
Subject: Re: [PATCH v8 2/2] block: add overflow checks for Amiga partition
 support
Message-ID: <Yt/TQOJQZEhZE+2p@infradead.org>
References: <20220726045747.4779-1-schmitzmic@gmail.com>
 <20220726045747.4779-3-schmitzmic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726045747.4779-3-schmitzmic@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 26, 2022 at 04:57:47PM +1200, Michael Schmitz wrote:
> The Amiga partition parser module uses signed int for partition sector
> address and count, which will overflow for disks larger than 1 TB.
> 
> Use u64 as type for sector address and size to allow using disks up to
> 2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
> format allows to specify disk sizes up to 2^128 bytes (though native
> OS limitations reduce this somewhat, to max 2^68 bytes), so check for
> u64 overflow carefully to protect against overflowing sector_t.
> 
> Bail out if sector addresses overflow 32 bits on kernels without LBD
> support.
> 
> This bug was reported originally in 2012, and the fix was created by
> the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
> discussed and reviewed on linux-m68k at that time but never officially
> submitted (now resubmitted as separate patch).
> This patch adds additional error checking and warning messages.
> 
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  block/partitions/amiga.c | 111 +++++++++++++++++++++++++++++++--------
>  1 file changed, 89 insertions(+), 22 deletions(-)
> 
> diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
> index f98191545d9a..7356b39cbe10 100644
> --- a/block/partitions/amiga.c
> +++ b/block/partitions/amiga.c
> @@ -11,10 +11,18 @@
>  #define pr_fmt(fmt) fmt
>  
>  #include <linux/types.h>
> +#include <linux/mm_types.h>
> +#include <linux/overflow.h>
>  #include <linux/affs_hardblocks.h>
>  
>  #include "check.h"
>  
> +/* magic offsets in partition DosEnvVec */
> +#define NR_HD	3
> +#define NR_SECT	5
> +#define LO_CYL	9
> +#define	HI_CYL	10

The last line has a tab after the #define while the previous three
don't.  Pick one style and stick to it for the others.

>  		if (!data) {
> -			pr_err("Dev %s: unable to read RDB block %d\n",
> -			       state->disk->disk_name, blk);
> +			pr_err("Dev %s: unable to read RDB block %llu\n",
> +			       state->disk->disk_name, (u64) blk);

No need for the various printk casts, a sector_t is always an
unsigned long long.
