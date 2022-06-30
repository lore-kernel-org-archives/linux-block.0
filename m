Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F87EC43334
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 08:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiF3Iul (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 04:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiF3Iuk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 04:50:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079F3427E2
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 01:50:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B955C21C8F;
        Thu, 30 Jun 2022 08:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656579038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ykT6Q+EutwjEyePO55nGWPq8jAr92jLqcIAmhuzpnEg=;
        b=LQsa+pW2Xu1pU/vne161LbSi3lyTXZ4JLRk7YzR6cyS97DjvHFbj+upAhx44MqwTi9iPpr
        K1tsw46lmuRFjqBiGFL/n9pcf9a3pKobeSiyUG63ntGI78TI+40F5VLzeHC8eZf+N19oeR
        uSme9vq65S7btrzzD3T46LiGsjBoLlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656579038;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ykT6Q+EutwjEyePO55nGWPq8jAr92jLqcIAmhuzpnEg=;
        b=I82QZcrvEv465gjjuRq00winTBBIb0vkVGkDWhPNI+emGyaemLV2/499FlviRretsNilH6
        8eycnPXGamsWVGCw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A183D2C141;
        Thu, 30 Jun 2022 08:50:38 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 47F53A061F; Thu, 30 Jun 2022 10:50:38 +0200 (CEST)
Date:   Thu, 30 Jun 2022 10:50:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 48/63] fs/direct-io: Reduce the size of struct dio
Message-ID: <20220630085038.7ubc7zemwwsyjd3e@quack3.lan>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <20220629233145.2779494-49-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629233145.2779494-49-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 29-06-22 16:31:30, Bart Van Assche wrote:
> Reduce the size of struct dio by combining the 'op' and 'op_flags' into
> the new 'opf' member. Use the new blk_opf_t type to improve static type
> checking. This patch does not change any functionality.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Just one nit below.

> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 840752006f60..b72706d163f5 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -117,8 +117,7 @@ struct dio_submit {
>  /* dio_state communicated between submission path and end_io */
>  struct dio {
>  	int flags;			/* doesn't change */
> -	int op;
> -	int op_flags;
> +	blk_opf_t opf;			/* request operation type and flags */
>  	struct gendisk *bio_disk;
>  	struct inode *inode;
>  	loff_t i_size;			/* i_size when submitted */
> @@ -154,6 +153,11 @@ struct dio {
>  
>  static struct kmem_cache *dio_cache __read_mostly;
>  
> +static inline bool op_is_read(blk_opf_t opf)
> +{
> +	return !op_is_write(opf);
> +}
> +

This is a bit dangerous although currently OK for direct IO code. I'm just
afraid someone will extend direct IO code (unlikely) or copy-paste this to
a place where there can be more operations than read & write... Maybe just
add here a comment like /* Direct IO code does only reads or writes */.

Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
