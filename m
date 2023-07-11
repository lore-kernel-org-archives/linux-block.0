Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C33EB64DC
	for <linux-block@archiver.kernel.org>; Tue, 11 Jul 2023 06:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjGKGTz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jul 2023 02:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjGKGTy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2023 02:19:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773D0E4B
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 23:19:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3002022434;
        Tue, 11 Jul 2023 06:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689056392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zVzsxiQ98RSmHXT12YjkKKL21vDieV95nWWwG2xBdp0=;
        b=jptecx4HSEQ8XXTn/IcgONrRRw/3DEcrO4mXNQE6gs6wNGNJhIS3ZL47HpFdvWdj4SPbJj
        zdWpt9i8aAlq7MiGFpbVlHUZAxk1qovD5Nep8Y+qu9YQs3Oky1G9XD1vlPQPdIqAoyOevv
        NMcekm8+Ti7WCS15d00JC9xsESCHH7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689056392;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zVzsxiQ98RSmHXT12YjkKKL21vDieV95nWWwG2xBdp0=;
        b=yNZvpPiHzBWcsh8Rbnb7FH6VeQmZ0bQMtYy10W6dCCtaILzPqy+RMnt6DAHsxVFWAcrm4P
        NLNVyFybD3iA1xDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1F8F1390F;
        Tue, 11 Jul 2023 06:19:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XapONYf0rGQNDAAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 11 Jul 2023 06:19:51 +0000
Message-ID: <63766a54-54db-20a7-ba2f-d31fd230623d@suse.de>
Date:   Tue, 11 Jul 2023 08:19:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] f2fs: don't reopen the main block device in
 f2fs_scan_devices
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org
References: <20230707094028.107898-1-hch@lst.de> <ZKx2jVONy35B0/S1@google.com>
 <20230711050101.GA19128@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230711050101.GA19128@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/11/23 07:01, Christoph Hellwig wrote:
> I think that's because it doesn't look at sbi->s_ndevs in
> destroy_device_list.  Let's try the variant below, which also fixes
> the buildbot warning for non-zoned configfs:
> 
> ---
>  From 645d8dceaa97b6ee73be067495b111b15b187498 Mon Sep 17 00:00:00 2001
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
>   block/blk-flush.c |  2 +-
>   fs/f2fs/super.c   | 20 ++++++++------------
>   2 files changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index ca31163da00a55..30883beb750a59 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1561,7 +1561,8 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
>   	int i;
>   
>   	for (i = 0; i < sbi->s_ndevs; i++) {
> -		blkdev_put(FDEV(i).bdev, sbi->sb->s_type);
> +		if (i > 0)
> +			blkdev_put(FDEV(i).bdev, sbi->sb->s_type);
You could have started the loop at '1', and avoid the curious 'if' 
clause ...

>   #ifdef CONFIG_BLK_DEV_ZONED
>   		kvfree(FDEV(i).blkz_seq);
>   #endif
> @@ -4190,16 +4191,12 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>   	sbi->aligned_blksize = true;
>   
>   	for (i = 0; i < max_devices; i++) {
> -
> -		if (i > 0 && !RDEV(i).path[0])
> +		if (i == 0)
> +			FDEV(0).bdev = sbi->sb->s_bdev;
> +		else if (!RDEV(i).path[0])
>   			break;
>   
> -		if (max_devices == 1) {
> -			/* Single zoned block device mount */
> -			FDEV(0).bdev =
> -				blkdev_get_by_dev(sbi->sb->s_bdev->bd_dev, mode,
> -						  sbi->sb->s_type, NULL);
> -		} else {
> +		if (max_devices > 1) {
>   			/* Multi-device mount */
>   			memcpy(FDEV(i).path, RDEV(i).path, MAX_PATH_LEN);
>   			FDEV(i).total_segments =
Similar here; wouldn't it be better to unroll the loop, and have the 
check for 'max_devices' outside of the loop?
Then the loop can be coded for the 'max_device > 1' case only, and avoid 
all the special casing in the loop ...

> @@ -4215,10 +4212,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>   				FDEV(i).end_blk = FDEV(i).start_blk +
>   					(FDEV(i).total_segments <<
>   					sbi->log_blocks_per_seg) - 1;
> +				FDEV(i).bdev = blkdev_get_by_path(FDEV(i).path,
> +					mode, sbi->sb->s_type, NULL);
>   			}
> -			FDEV(i).bdev = blkdev_get_by_path(FDEV(i).path, mode,
> -							  sbi->sb->s_type,
> -							  NULL);
>   		}
>   		if (IS_ERR(FDEV(i).bdev))
>   			return PTR_ERR(FDEV(i).bdev);

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

