Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AC6C433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 10:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiA0Km6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 05:42:58 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36982 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiA0Km6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 05:42:58 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 476021F37E;
        Thu, 27 Jan 2022 10:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643280177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tv+eUJRhWEEVj7lSMaQdKVvjEwjVSfmaWuxJPecm1fA=;
        b=zrAM2NYrjjeVFPpXbp1bzWerG2wiMCXSLvNOBARXZhHfoJ58PQHpn3hM4SOrpMWSNr7w8G
        OVDXXpN8YLNCPJs7/kDdBzbYFm3R6fSbxRGaHv4M/nEQqGYUWrcQtyQ0P5TaAKTR7HxNoW
        sDen++nEgrFfh70ATLg8t1qHCUOk82I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643280177;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tv+eUJRhWEEVj7lSMaQdKVvjEwjVSfmaWuxJPecm1fA=;
        b=kSSnwJaBReS2SO7qx5/7hKHSV9qgmdFLjXM2Of0QxzWNnSgpRDm6eacp4ecpGtNVPCQSY4
        pmxjd2Kbn32EMyDQ==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 36AB8A3B89;
        Thu, 27 Jan 2022 10:42:56 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 92F2AA05E6; Thu, 27 Jan 2022 11:42:56 +0100 (CET)
Date:   Thu, 27 Jan 2022 11:42:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 6/8] loop: don't freeze the queue in lo_release
Message-ID: <20220127104256.5tmkxo4m4uvcbqai@quack3.lan>
References: <20220126155040.1190842-1-hch@lst.de>
 <20220126155040.1190842-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126155040.1190842-7-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 26-01-22 16:50:38, Christoph Hellwig wrote:
> By the time the final ->release is called there can't be outstanding I/O.
> For non-final ->release there is no need for driver action at all.
> 
> Thus remove the useless queue freeze.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good, just one nit below. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 4b0058a67c48e..d9a0e2205762f 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1758,13 +1758,6 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
>  		 */
>  		loop_schedule_rundown(lo);
>  		return;
> -	} else if (lo->lo_state == Lo_bound) {
> -		/*
> -		 * Otherwise keep thread (if running) and config,
> -		 * but flush possible ongoing bios in thread.
> -		 */
> -		blk_mq_freeze_queue(lo->lo_queue);
> -		blk_mq_unfreeze_queue(lo->lo_queue);
>  	}

Maybe worth a comment like:

	/*
	 * No IO can be running at this point since there are no openers
	 * (covers filesystems, stacked devices, AIO) and the page cache is
	 * evicted.
	 */

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
