Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234B4C433EF
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 09:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbiA0JsQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 04:48:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55262 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiA0JsO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 04:48:14 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D8DE6218D9;
        Thu, 27 Jan 2022 09:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643276893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tpTPkRZfcS/38YhUHskUXSGEPwqJT3YOw/SnH97qzrQ=;
        b=L3ILhLPFhvxMp7Qr/SGweL2z1BQzeHj3ZHEJsOvPceMCG6yo7Vbt8mD3qoi6wyQrIlsUrY
        xJcI1mesGX5ABm0vodDIZJz7b6t6t0NjKx2JdKbK07blo+eCIqrtEkq2aJhMn7NYVUoINC
        pc568Z92Wq3Se/UPdZ++tNYZxvetY5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643276893;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tpTPkRZfcS/38YhUHskUXSGEPwqJT3YOw/SnH97qzrQ=;
        b=8xGoK1nQop6QxnXmUGHw2WjmboSerQ8mhImOZ52mf6QmtmKTsMvCNKGEsZxtyaSntxY5fU
        0eV8C6eUCogfwCBA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C003FA3B89;
        Thu, 27 Jan 2022 09:48:13 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 58FEEA05E6; Thu, 27 Jan 2022 10:48:13 +0100 (CET)
Date:   Thu, 27 Jan 2022 10:48:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 4/8] loop: only take lo_mutex for the last reference in
 lo_release
Message-ID: <20220127094813.ra7nslwycdcaw2gi@quack3.lan>
References: <20220126155040.1190842-1-hch@lst.de>
 <20220126155040.1190842-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126155040.1190842-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 26-01-22 16:50:36, Christoph Hellwig wrote:
> lo_refcnt is only incremented in lo_open and decremented in lo_release,
> and thus protected by open_mutex.  Only take lo_mutex when lo_release
> actually takes action for the final release.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yup, good idea. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/loop.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index d3a7f281ce1b6..43980ec69dfdd 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1740,10 +1740,10 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
>  {
>  	struct loop_device *lo = disk->private_data;
>  
> -	mutex_lock(&lo->lo_mutex);
> -	if (atomic_dec_return(&lo->lo_refcnt))
> -		goto out_unlock;
> +	if (!atomic_dec_and_test(&lo->lo_refcnt))
> +		return;
>  
> +	mutex_lock(&lo->lo_mutex);
>  	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
>  		if (lo->lo_state != Lo_bound)
>  			goto out_unlock;
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
