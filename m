Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34234C433FE
	for <linux-block@archiver.kernel.org>; Tue, 30 Nov 2021 15:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245121AbhK3PGu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Nov 2021 10:06:50 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37414 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244537AbhK3PCS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Nov 2021 10:02:18 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B68072177B;
        Tue, 30 Nov 2021 14:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638284338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r2Igo5hL1mYEI2W8Olpj4v4PglMYCJEnjV5Lyrgbp6k=;
        b=sUORPQGbgTy89xfnHT3v305hI1L00IyHLxEyLXIgLpMxycXcU2oHH305R+LccM5v+wwyUW
        sd7oWe6xzbL/88gE9UiavZE0FupkUMP76P6y5tUXay5k/LWmhfrBTHBjj9PXfj0bVu2c0E
        /SOM1eJl/7IHZSZjbI2I2Tz+YtXGcbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638284338;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r2Igo5hL1mYEI2W8Olpj4v4PglMYCJEnjV5Lyrgbp6k=;
        b=jW14tXIBU+JcRTRDdGeJZ1s3R/Tvfr4zo92aucU1XsAWmeXlcVWjc8BdIh2u8h4g/sKDs0
        KuoL5jQzy11qgaBg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id A9722A3B8D;
        Tue, 30 Nov 2021 14:58:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8495D1E1494; Tue, 30 Nov 2021 15:58:55 +0100 (CET)
Date:   Tue, 30 Nov 2021 15:58:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: [PATCH 5/7] block: refactor put_io_context
Message-ID: <20211130145855.GG7174@quack2.suse.cz>
References: <20211130124636.2505904-1-hch@lst.de>
 <20211130124636.2505904-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130124636.2505904-6-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 30-11-21 13:46:34, Christoph Hellwig wrote:
> Move the code to delay freeing the icqs into a separate helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-ioc.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index 04f3d2b0ca7db..902bca2b273ba 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -143,6 +143,24 @@ static void ioc_release_fn(struct work_struct *work)
>  	kmem_cache_free(iocontext_cachep, ioc);
>  }
>  
> +/*
> + * Releasing icqs requires reverse order double locking and we may already be
> + ( holding a queue_lock.  Do it asynchronously from a workqueue.
    ^^^ typo here

Otherwise looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
