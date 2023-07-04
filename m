Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3554EB64DD
	for <linux-block@archiver.kernel.org>; Tue,  4 Jul 2023 07:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjGDHeJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jul 2023 03:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjGDHeJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jul 2023 03:34:09 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51A611C;
        Tue,  4 Jul 2023 00:34:07 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id BB4B572DA85;
        Tue,  4 Jul 2023 09:34:04 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-block@vger.kernel.org, axboe@kernel.dk,
        Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de,
        geert@linux-m68k.org, hch@lst.de,
        Michael Schmitz <schmitzmic@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] block: bugfix for Amiga partition overflow check patch
Date:   Tue, 04 Jul 2023 09:34:04 +0200
Message-ID: <10307003.nUPlyArG6x@lichtvoll.de>
In-Reply-To: <20230704054955.16906-1-schmitzmic@gmail.com>
References: <20230704054955.16906-1-schmitzmic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Michael Schmitz - 04.07.23, 07:49:55 CEST:
> Making 'blk' sector_t (i.e. 64 bit if LBD support is active)
> fails the 'blk>0' test in the partition block loop if a
> value of (signed int) -1 is used to mark the end of the
> partition block list.
> 
> This bug was introduced in patch 3 of my prior Amiga partition
> support fixes series, and spotted by Christian Zigotzky when
> testing the latest block updates.
> 
> Explicitly cast 'blk' to signed int to allow use of -1 to
> terminate the partition block linked list.
> 
> Testing by Christian also exposed another aspect of the old
> bug fixed in commits fc3d092c6b ("block: fix signed int
> overflow in Amiga partition support") and b6f3f28f60
> ("block: add overflow checks for Amiga partition support"):
> 
> Partitions that did overflow the disk size (due to 32 bit int
> overflow) were not skipped but truncated to the end of the
> disk. Users who missed the warning message during boot would
> go on to create a filesystem with a size exceeding the
> actual partition size. Now that the 32 bit overflow has been
> corrected, such filesystems may refuse to mount with a
> 'filesystem exceeds partition size' error. Users should
> either correct the partition size, or resize the filesystem
> before attempting to boot a kernel with the RDB fixes in
> place.
> 
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Fixes: b6f3f28f60 ("block: add overflow checks for Amiga partition support")
> Message-ID: 024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
> Cc: <stable@vger.kernel.org> # 6.4
> Link: https://lore.kernel.org/r/024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> 
> --
> 
> Changes since v2:
> 
> Adrian Glaubitz:
> - fix typo in commit message
> 
> Changes since v1:
> 
> - corrected Fixes: tag
> - added Tested-by:
> - reworded commit message to describe filesystem partition
>   size mismatch problem
> ---
>  block/partitions/amiga.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
> index ed222b9c901b..506921095412 100644
> --- a/block/partitions/amiga.c
> +++ b/block/partitions/amiga.c
> @@ -90,7 +90,7 @@ int amiga_partition(struct parsed_partitions *state)
>  	}
>  	blk = be32_to_cpu(rdb->rdb_PartitionList);
>  	put_dev_sector(sect);
> -	for (part = 1; blk>0 && part<=16; part++, put_dev_sector(sect)) {
> +	for (part = 1; (s32) blk>0 && part<=16; part++, put_dev_sector(sect)) {
>  		/* Read in terms partition table understands */
>  		if (check_mul_overflow(blk, (sector_t) blksize, &blk)) {
>  			pr_err("Dev %s: overflow calculating partition block %llu! Skipping partitions %u and beyond\n",
> 

Looks good. I do not consider myself a kernel developer, but patch
description and patch itself make sense to me.

Reviewed-By: Martin Steigerwald <martin@lichtvoll.de>

Ciao,
-- 
Martin


