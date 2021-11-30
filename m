Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2A7C433FE
	for <linux-block@archiver.kernel.org>; Tue, 30 Nov 2021 15:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245190AbhK3PHC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Nov 2021 10:07:02 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37468 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244634AbhK3PCf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Nov 2021 10:02:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E2EB921763;
        Tue, 30 Nov 2021 14:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638284355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJBPsr4fuOspvJtNH7vZuA9Xx0xItQUy/xGbUiJQzMo=;
        b=qeMF5j1MCt9w7Wg1xChJ/C/cdKkbzR7UInZ2wp0tzkX1kIeHK08bhDcJ5CFb+4CbR9F/t5
        vDhBDMgPxp0xwQn54lGV20YlOUu9shPvWDP/diVHmIbeObDdquvka8Lq3rbU7xjkT8RRan
        Q1IRVLpCNo8rCl2uk2YvZA/RA9MesNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638284355;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJBPsr4fuOspvJtNH7vZuA9Xx0xItQUy/xGbUiJQzMo=;
        b=qfejaeBJBULE4GKp3qKf+ATTZet4ASDKkqrTVuew+aJkME82xRlD9RewCtoaItA+FJs6Km
        C3Pyr1T3pAPqs+Bg==
Received: from quack2.suse.cz (jack.udp.ovpn2.prg.suse.de [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id CDCE7A3B8A;
        Tue, 30 Nov 2021 14:59:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9C9D21E1494; Tue, 30 Nov 2021 15:59:15 +0100 (CET)
Date:   Tue, 30 Nov 2021 15:59:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/7] block: remove the NULL ioc check in put_io_context
Message-ID: <20211130145915.GH7174@quack2.suse.cz>
References: <20211130124636.2505904-1-hch@lst.de>
 <20211130124636.2505904-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130124636.2505904-5-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 30-11-21 13:46:33, Christoph Hellwig wrote:
> No caller passes in a NULL pointer, so remove the check.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk-ioc.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index 0380e33930e31..04f3d2b0ca7db 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -155,9 +155,6 @@ void put_io_context(struct io_context *ioc)
>  	unsigned long flags;
>  	bool free_ioc = false;
>  
> -	if (ioc == NULL)
> -		return;
> -
>  	BUG_ON(atomic_long_read(&ioc->refcount) <= 0);
>  
>  	/*
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
