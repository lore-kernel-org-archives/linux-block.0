Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257E5CDB482
	for <linux-block@archiver.kernel.org>; Thu, 19 Oct 2023 08:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbjJSIoF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Oct 2023 04:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbjJSInt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Oct 2023 04:43:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689061AC;
        Thu, 19 Oct 2023 01:43:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 16CA91F459;
        Thu, 19 Oct 2023 08:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697704994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hivdllsfd82vo1yNLypptwul3AXaOhBN38DCUSjUqus=;
        b=ghRDccvzVbLd0yNn455XPptLPG291EBoHoZFXsAPaPa3crt15h6HWGM5zqqsZ1OgT32PRa
        fObN7taiRd+NCxk+/01TheSPBViIAw8kPQiEBw55c0RJRIF63pJzjXWvffOeDQrPhpoK9e
        9912FGxV6ZmgCcoadosgmhBzCVFfCws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697704994;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hivdllsfd82vo1yNLypptwul3AXaOhBN38DCUSjUqus=;
        b=IOwwhfPZj4RXQ7suUqoqj0FVWtSZe3iVP+mcLObjHyO7GNItY0aqZP46/AQDteFOgGShBW
        2RvZQHbtCheJbDCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08DFE1357F;
        Thu, 19 Oct 2023 08:43:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jz4gAiLsMGUGQwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 19 Oct 2023 08:43:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8B970A06B0; Thu, 19 Oct 2023 10:43:13 +0200 (CEST)
Date:   Thu, 19 Oct 2023 10:43:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] block: assert that we're not holding open_mutex over
 blk_report_disk_dead
Message-ID: <20231019084313.36wko73lyxwq3asi@quack3>
References: <20231017184823.1383356-1-hch@lst.de>
 <20231017184823.1383356-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017184823.1383356-5-hch@lst.de>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spamd-Result: default: False [-4.12 / 50.00];
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
         BAYES_HAM(-0.52)[80.32%]
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 17-10-23 20:48:22, Christoph Hellwig wrote:
> From: Christian Brauner <brauner@kernel.org>
> 
> blk_report_disk_dead() has the following major callers:
> 
> (1) del_gendisk()
> (2) blk_mark_disk_dead()
> 
> Since del_gendisk() acquires disk->open_mutex it's clear that all
> callers are assumed to be called without disk->open_mutex held.
> In turn, blk_report_disk_dead() is called without disk->open_mutex held
> in del_gendisk().
> 
> All callers of blk_mark_disk_dead() call it without disk->open_mutex as
> well.
> 
> Ensure that it is clear that blk_report_disk_dead() is called without
> disk->open_mutex on purpose by asserting it and a comment in the code.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

BTW, checking the callers I suspect that we might eventually hit some
locking issues with NVME and its ctrl->namespace_sem which is held while
calling blk_mark_disk_dead(). But I guess we'll deal with that once we see
the problem is real.

								Honza

> ---
>  block/genhd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 4a16a424f57d4f..c9d06f72c587e8 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -559,6 +559,13 @@ static void blk_report_disk_dead(struct gendisk *disk, bool surprise)
>  	struct block_device *bdev;
>  	unsigned long idx;
>  
> +	/*
> +	 * On surprise disk removal, bdev_mark_dead() may call into file
> +	 * systems below. Make it clear that we're expecting to not hold
> +	 * disk->open_mutex.
> +	 */
> +	lockdep_assert_not_held(&disk->open_mutex);
> +
>  	rcu_read_lock();
>  	xa_for_each(&disk->part_tbl, idx, bdev) {
>  		if (!kobject_get_unless_zero(&bdev->bd_device.kobj))
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
