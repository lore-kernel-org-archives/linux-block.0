Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB7CC678D4
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 13:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCGNPj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 08:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCGNOu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 08:14:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A0C3BDA8;
        Tue,  7 Mar 2023 05:13:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 15A8B21A12;
        Tue,  7 Mar 2023 13:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678194751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Ox8W2bMVJMfVIfzcRaMQ49l6YJW5Si9u8QMjb81tfM=;
        b=OgOwA5L2YJkUt/23w3k0WCQiImWZek6v1Zz5pBhEGJndnqwbDNrHC9ZM9rappBdTSzSSlq
        PoKXiFC8WiDDgy2d2sPjmMApkNqStBEowoWw0URfFvo7XLp60vF0xoruQwPF9TZleZrJME
        EfI40CnWlEPG6u36oEyRJ5w7RMGs7Jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678194751;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Ox8W2bMVJMfVIfzcRaMQ49l6YJW5Si9u8QMjb81tfM=;
        b=v+GZIhnwN1fd4iA1iiqfHrRKHmDws8yOTTqE+5P4/QXTXE5mLQifOfY5fuHivmWDwU2dV9
        vYwZBHiGTlAvRrBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07D2313440;
        Tue,  7 Mar 2023 13:12:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O7DdAT84B2SZSwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 07 Mar 2023 13:12:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7E37DA06F3; Tue,  7 Mar 2023 14:12:30 +0100 (CET)
Date:   Tue, 7 Mar 2023 14:12:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, jack@suse.cz, julianr@linux.ibm.com, axboe@kernel.dk,
        yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH] block: fix wrong mode for blkdev_put() from
 disk_scan_partitions()
Message-ID: <20230307131230.ucqnxpoagdisjss7@quack3>
References: <a3a4351375d51aa5e93e06bba212ba3637665885.camel@linux.ibm.com>
 <20230307105552.1560439-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307105552.1560439-1-yukuai1@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 07-03-23 18:55:52, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> If disk_scan_partitions() is called with 'FMODE_EXCL',
> blkdev_get_by_dev() will be called without 'FMODE_EXCL', however, follow
> blkdev_put() is still called with 'FMODE_EXCL', which will cause
> 'bd_holders' counter to leak.
> 
> Fix the problem by using the right mode for blkdev_put().
> 
> Reported-by: syzbot+2bcc0d79e548c4f62a59@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/lkml/f9649d501bc8c3444769418f6c26263555d9d3be.camel@linux.ibm.com/T/
> Tested-by: Julian Ruess <julianr@linux.ibm.com>
> Fixes: e5cfefa97bcc ("block: fix scan partition for exclusively open device again")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Thanks for fixing this! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/genhd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 3ee5577e1586..02d9cfb9e077 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -385,7 +385,7 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
>  	if (IS_ERR(bdev))
>  		ret =  PTR_ERR(bdev);
>  	else
> -		blkdev_put(bdev, mode);
> +		blkdev_put(bdev, mode & ~FMODE_EXCL);
>  
>  	if (!(mode & FMODE_EXCL))
>  		bd_abort_claiming(disk->part0, disk_scan_partitions);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
