Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C0BCDB465
	for <linux-block@archiver.kernel.org>; Thu, 19 Oct 2023 08:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344918AbjJSIbP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Oct 2023 04:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344937AbjJSIbN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Oct 2023 04:31:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021FE129;
        Thu, 19 Oct 2023 01:31:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 885461F88B;
        Thu, 19 Oct 2023 08:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697704268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Trgk7bVrAE5DykQszLb8Bbjyoi8PuBc0fr4BNkiXBlw=;
        b=sHe7kQU8H8Yq8Hf8X7fxpvzTwt8TTBYMcdqJriU5HNf9miJha+lm+VlkHRTiqB0x4Avs+S
        kM05EmpnBlT/Z6fbcXXxoBhHms06sj/Jh7A5mZ/c47DbIAZa0Xbs5EUi5kk9S7v3YxeZ1c
        p8AFUGIfIb0pCZ+DphReQPQSrl1yTzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697704268;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Trgk7bVrAE5DykQszLb8Bbjyoi8PuBc0fr4BNkiXBlw=;
        b=4KNnnkMBCdcz50ff/i9Y8iOMHdn7uvNkKwmJEhllJEDQX+3hbPf0aWUU5LaL67d36uRTnS
        lO9IxoKqwCKdQ4DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 730811357F;
        Thu, 19 Oct 2023 08:31:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PU77G0zpMGVMPAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 19 Oct 2023 08:31:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0198AA06B0; Thu, 19 Oct 2023 10:31:07 +0200 (CEST)
Date:   Thu, 19 Oct 2023 10:31:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] block: WARN_ON_ONCE() when we remove active
 partitions
Message-ID: <20231019083107.mm7tcgv6of6pszac@quack3>
References: <20231017184823.1383356-1-hch@lst.de>
 <20231017184823.1383356-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017184823.1383356-3-hch@lst.de>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spamd-Result: default: False [-6.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[8];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 17-10-23 20:48:20, Christoph Hellwig wrote:
> From: Christian Brauner <brauner@kernel.org>
> 
> The logic for disk->open_partitions is:
> 
> blkdev_get_by_*()
> -> bdev_is_partition()
>    -> blkdev_get_part()
>       -> blkdev_get_whole() // bdev_whole->bd_openers++
>       -> if (part->bd_openers == 0)
>                  disk->open_partitions++
>          part->bd_openers
> 
> In other words, when we first claim/open a partition we increment
> disk->open_partitions and only when all part->bd_openers are closed will
> disk->open_partitions be zero. That should mean that
> disk->open_partitions is always > 0 as long as there's anyone that
> has an open partition.
> 
> So the check for disk->open_partitions should meand that we can never
> remove an active partition that has a holder and holder ops set. Assert
> that in the code. The main disk isn't removed so that check doesn't work
> for disk->part0 which is what we want. After all we only care about
> partition not about the main disk.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/partitions/core.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index b0585536b407a5..f47ffcfdfcec22 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -274,17 +274,6 @@ void drop_partition(struct block_device *part)
>  	put_device(&part->bd_device);
>  }
>  
> -static void delete_partition(struct block_device *part)
> -{
> -	/*
> -	 * Remove the block device from the inode hash, so that it cannot be
> -	 * looked up any more even when openers still hold references.
> -	 */
> -	remove_inode_hash(part->bd_inode);
> -	bdev_mark_dead(part, false);
> -	drop_partition(part);
> -}
> -
>  static ssize_t whole_disk_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
> @@ -674,8 +663,23 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
>  	sync_blockdev(disk->part0);
>  	invalidate_bdev(disk->part0);
>  
> -	xa_for_each_start(&disk->part_tbl, idx, part, 1)
> -		delete_partition(part);
> +	xa_for_each_start(&disk->part_tbl, idx, part, 1) {
> +		/*
> +		 * Remove the block device from the inode hash, so that
> +		 * it cannot be looked up any more even when openers
> +		 * still hold references.
> +		 */
> +		remove_inode_hash(part->bd_inode);
> +
> +		/*
> +		 * If @disk->open_partitions isn't elevated but there's
> +		 * still an active holder of that block device things
> +		 * are broken.
> +		 */
> +		WARN_ON_ONCE(atomic_read(&part->bd_openers));
> +		invalidate_bdev(part);
> +		drop_partition(part);
> +	}
>  	clear_bit(GD_NEED_PART_SCAN, &disk->state);
>  
>  	/*
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
