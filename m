Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50409C04FDF
	for <linux-block@archiver.kernel.org>; Tue, 11 Jul 2023 16:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjGKQS0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jul 2023 12:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjGKQSB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2023 12:18:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED944B8
        for <linux-block@vger.kernel.org>; Tue, 11 Jul 2023 09:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79E1F61564
        for <linux-block@vger.kernel.org>; Tue, 11 Jul 2023 16:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E1FC43397;
        Tue, 11 Jul 2023 16:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689092279;
        bh=9L6KVSpQ52iJPE/W9jY3lrnhEPrff+Z1LTyLQcv3sdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GjMT73AgXcyF+/wnM61zc+wcm/8+eqcyrwD4iVIc+yIvuT+1V7qmm2MdRA0lKY/WD
         xdJ9bIgeszZQ6thQC1dB813TOS+iQrY0gKWqpajt4w0UqMTyhIgJcCUXMiuNqoFvgr
         wnTKYlRQKa4jrojQp05SGNSzG7uNhVVs+BgMkx/U6TNOu8WX1gyvrEsiYs0NfLPOiG
         N3frObkHFygc1ageTo9HcPRYpB6WWShpwoY0d1lOAkJJ2Et+mbfB3cECwz1PVy80tN
         9hx8J+DBW/XxqyR1TilaseDsC9Ig0lMUv3olAUi58RZ19k/PcdKY/mt034voSdWvPO
         xq2nYnt433w4g==
Date:   Tue, 11 Jul 2023 09:17:57 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] f2fs: don't reopen the main block device in
 f2fs_scan_devices
Message-ID: <ZK2AtW9hLjqpbaPW@google.com>
References: <20230707094028.107898-1-hch@lst.de>
 <ZKx2jVONy35B0/S1@google.com>
 <20230711050101.GA19128@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711050101.GA19128@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 07/11, Christoph Hellwig wrote:
> I think that's because it doesn't look at sbi->s_ndevs in
> destroy_device_list.  Let's try the variant below, which also fixes
> the buildbot warning for non-zoned configfs:

Thanks. At a glance, this looks better. Let me give it a try.

> 
> ---
> >From 645d8dceaa97b6ee73be067495b111b15b187498 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 7 Jul 2023 10:31:49 +0200
> Subject: f2fs: don't reopen the main block device in f2fs_scan_devices
> 
> f2fs_scan_devices reopens the main device since the very beginning, which
> has always been useless, and also means that we don't pass the right
> holder for the reopen, which now leads to a warning as the core super.c
> holder ops aren't passed in for the reopen.
> 
> Fixes: 3c62be17d4f5 ("f2fs: support multiple devices")
> Fixes: 0718afd47f70 ("block: introduce holder ops")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-flush.c |  2 +-
>  fs/f2fs/super.c   | 20 ++++++++------------
>  2 files changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index ca31163da00a55..30883beb750a59 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1561,7 +1561,8 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
>  	int i;
>  
>  	for (i = 0; i < sbi->s_ndevs; i++) {
> -		blkdev_put(FDEV(i).bdev, sbi->sb->s_type);
> +		if (i > 0)
> +			blkdev_put(FDEV(i).bdev, sbi->sb->s_type);
>  #ifdef CONFIG_BLK_DEV_ZONED
>  		kvfree(FDEV(i).blkz_seq);
>  #endif
> @@ -4190,16 +4191,12 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>  	sbi->aligned_blksize = true;
>  
>  	for (i = 0; i < max_devices; i++) {
> -
> -		if (i > 0 && !RDEV(i).path[0])
> +		if (i == 0)
> +			FDEV(0).bdev = sbi->sb->s_bdev;
> +		else if (!RDEV(i).path[0])
>  			break;
>  
> -		if (max_devices == 1) {
> -			/* Single zoned block device mount */
> -			FDEV(0).bdev =
> -				blkdev_get_by_dev(sbi->sb->s_bdev->bd_dev, mode,
> -						  sbi->sb->s_type, NULL);
> -		} else {
> +		if (max_devices > 1) {
>  			/* Multi-device mount */
>  			memcpy(FDEV(i).path, RDEV(i).path, MAX_PATH_LEN);
>  			FDEV(i).total_segments =
> @@ -4215,10 +4212,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>  				FDEV(i).end_blk = FDEV(i).start_blk +
>  					(FDEV(i).total_segments <<
>  					sbi->log_blocks_per_seg) - 1;
> +				FDEV(i).bdev = blkdev_get_by_path(FDEV(i).path,
> +					mode, sbi->sb->s_type, NULL);
>  			}
> -			FDEV(i).bdev = blkdev_get_by_path(FDEV(i).path, mode,
> -							  sbi->sb->s_type,
> -							  NULL);
>  		}
>  		if (IS_ERR(FDEV(i).bdev))
>  			return PTR_ERR(FDEV(i).bdev);
> -- 
> 2.39.2
