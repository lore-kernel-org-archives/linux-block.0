Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381C1CDB465
	for <linux-block@archiver.kernel.org>; Mon, 16 Oct 2023 15:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjJPPft (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Oct 2023 11:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjJPPfr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Oct 2023 11:35:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEEBB4;
        Mon, 16 Oct 2023 08:35:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 89E581FEBE;
        Mon, 16 Oct 2023 15:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697470543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XCrhq6NWcgUDM/zqlpSfD75/KbtlS3V+BBod9U8uBVw=;
        b=jAE2csj0S/Xd6xfR0jmmP0Aw14hqDojYN2pHsYIOLsdDe5QRY2c96sToR7UAZDfLLlQoL+
        5Te74dMfevciii9r33lePHm5cfkgUNqnSBVMvfx17NGGOizDVhjoFeEauaUFKtwaI+/hmc
        jEnwU9GCUknZatEmmESJgDSsJyH4fx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697470543;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XCrhq6NWcgUDM/zqlpSfD75/KbtlS3V+BBod9U8uBVw=;
        b=hqosW9OoDyyIfHv+VI/d0rfVsDvQKuqf47B7lS2/JVoOC8tsL6hCwlqyI/89+CWvutp8Yf
        vHxoMao09NDH1nBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7ADC1138EF;
        Mon, 16 Oct 2023 15:35:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sGT3HU9YLWWmBwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 16 Oct 2023 15:35:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EC974A0657; Mon, 16 Oct 2023 17:35:42 +0200 (CEST)
Date:   Mon, 16 Oct 2023 17:35:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: simplify bdev_del_partition()
Message-ID: <20231016153542.ptqv6mw5z4bgqhuf@quack3>
References: <20231016-fototermin-umriss-59f1ea6c1fe6@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-fototermin-umriss-59f1ea6c1fe6@brauner>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spamd-Result: default: False [0.82 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM_SHORT(0.31)[0.155];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_SPAM_LONG(3.00)[1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.89)[99.54%]
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 16-10-23 17:27:18, Christian Brauner wrote:
> BLKPG_DEL_PARTITION refuses to delete partitions that still have
> openers, i.e., that has an elevated @bdev->bd_openers count. If a device
> is claimed by setting @bdev->bd_holder and @bdev->bd_holder_ops
> @bdev->bd_openers and @bdev->bd_holders are incremented.
> @bdev->bd_openers is effectively guaranteed to be >= @bdev->bd_holders.
> So as long as @bdev->bd_openers isn't zero we know that this partition
> is still in active use and that there might still be @bdev->bd_holder
> and @bdev->bd_holder_ops set.
> 
> The only current example is @fs_holder_ops for filesystems. But that
> means bdev_mark_dead() which calls into
> bdev->bd_holder_ops->mark_dead::fs_bdev_mark_dead() is a nop. As long as
> there's an elevated @bdev->bd_openers count we can't delete the
> partition and if there isn't an elevated @bdev->bd_openers count then
> there's no @bdev->bd_holder or @bdev->bd_holder_ops.
> 
> So simply open-code what we need to do. This gets rid of one more
> instance where we acquire s_umount under @disk->open_mutex.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

BTW, now when there's only one delete_partition() caller, we could just
opencode it in its callsite...

								Honza

> ---
> Hey Jens,
> 
> This came out of an ongoing locking design discussion and is related
> to what we currently have in vfs.super. So if everyone still agrees my
> reasoning is right and you don't have big objections I'd take it through
> there.
> 
> As usual, thanks to Jan and Christoph for good discussions here.
> 
> Thanks!
> Christian
> ---
>  block/partitions/core.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index e137a87f4db0..b0585536b407 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -485,7 +485,18 @@ int bdev_del_partition(struct gendisk *disk, int partno)
>  	if (atomic_read(&part->bd_openers))
>  		goto out_unlock;
>  
> -	delete_partition(part);
> +	/*
> +	 * We verified that @part->bd_openers is zero above and so
> +	 * @part->bd_holder{_ops} can't be set. And since we hold
> +	 * @disk->open_mutex the device can't be claimed by anyone.
> +	 *
> +	 * So no need to call @part->bd_holder_ops->mark_dead() here.
> +	 * Just delete the partition and invalidate it.
> +	 */
> +
> +	remove_inode_hash(part->bd_inode);
> +	invalidate_bdev(part);
> +	drop_partition(part);
>  	ret = 0;
>  out_unlock:
>  	mutex_unlock(&disk->open_mutex);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
