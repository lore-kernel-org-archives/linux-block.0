Return-Path: <SRS0=PnPs=7I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAA1C433DF
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 18:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778F4206F1
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 18:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590517915;
	bh=PcBDaM5aceqkX7fvSzO0h7Yd9xAYtumquZkhqZPi6D0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=mf8r4j4PqruinBNJhkr0RpxaHYEdbBpFEnHDuqWVHxQ7jZ3WU9lU+DiwI2qRIUdwP
	 AG1HiAndB0hSouAzfs9TUIAYmmngYW3Dteqf2hxl+lSVSsQB4UddZDDiBy1E6yuj/s
	 gAIWv4ORC5x0tBd1i2RhnpWBPR+rOl5xc+oRoMao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgEZSby (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 May 2020 14:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbgEZSby (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 May 2020 14:31:54 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E298F2068D;
        Tue, 26 May 2020 18:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590517914;
        bh=PcBDaM5aceqkX7fvSzO0h7Yd9xAYtumquZkhqZPi6D0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=i8itfqPLREwNNI/VKdXo5BFXbl3rdAnJRvKw1LHH7KVeLqD1OFQc+ClOAiW1zbpvx
         ktKrib/m79kOTTw5cicXicVLVo6iMlIvOxFx7/mGCYN0UzYADObzCud9OpI7lJej4P
         cBd+s6nNpXZ0Pr2dmpQhYyn4CkJYrvxOfUk2mmEE=
Date:   Tue, 26 May 2020 20:31:50 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>,
        Omar Sandoval <osandov@fb.com>
cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Libor Pechacek <lpechacek@suse.cz>
Subject: Re: [PATCH] block/floppy: fix contended case in floppy_queue_rq()
In-Reply-To: <nycvar.YFH.7.76.2005261146420.25812@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.2005262031160.25812@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2005261146420.25812@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


[ forgot to CC Omar, fixing ]

On Tue, 26 May 2020, Jiri Kosina wrote:

> From: Jiri Kosina <jkosina@suse.cz>
> 
> Since the switch of floppy driver to blk-mq, the contended (fdc_busy) case 
> in floppy_queue_rq() is not handled correctly.
> 
> In case we reach floppy_queue_rq() with fdc_busy set (i.e. with the floppy 
> locked due to another request still being in-flight), we put the request 
> on the list of requests and return BLK_STS_OK to the block core, without 
> actually scheduling delayed work / doing further processing of the 
> request. This means that processing of this request is postponed until 
> another request comes and passess uncontended.
> 
> Which in some cases might actually never happen and we keep waiting 
> indefinitely. The simple testcase is
> 
> 	for i in `seq 1 2000`; do echo -en $i '\r'; blkid --info /dev/fd0 2> /dev/null; done
> 
> run in quemu. That reliably causes blkid eventually indefinitely hanging 
> in __floppy_read_block_0() waiting for completion, as the BIO callback 
> never happens, and no further IO is ever submitted on the (non-existent) 
> floppy device. This was observed reliably on qemu-emulated device.
> 
> Fix that by not queuing the request in the contended case, and return 
> BLK_STS_RESOURCE instead, so that blk core handles the request 
> rescheduling and let it pass properly non-contended later.
> 
> Fixes: a9f38e1dec107a ("floppy: convert to blk-mq")
> Cc: stable@vger.kernel.org
> Tested-by: Libor Pechacek <lpechacek@suse.cz>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
>  drivers/block/floppy.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index c3daa64cb52c..975cd0a6baa1 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -2938,17 +2938,17 @@ static blk_status_t floppy_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		 (unsigned long long) current_req->cmd_flags))
>  		return BLK_STS_IOERR;
>  
> -	spin_lock_irq(&floppy_lock);
> -	list_add_tail(&bd->rq->queuelist, &floppy_reqs);
> -	spin_unlock_irq(&floppy_lock);
> -
>  	if (test_and_set_bit(0, &fdc_busy)) {
>  		/* fdc busy, this new request will be treated when the
>  		   current one is done */
>  		is_alive(__func__, "old request running");
> -		return BLK_STS_OK;
> +		return BLK_STS_RESOURCE;
>  	}
>  
> +	spin_lock_irq(&floppy_lock);
> +	list_add_tail(&bd->rq->queuelist, &floppy_reqs);
> +	spin_unlock_irq(&floppy_lock);
> +
>  	command_status = FD_COMMAND_NONE;
>  	__reschedule_timeout(MAXTIMEOUT, "fd_request");
>  	set_fdc(0);
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
> 

-- 
Jiri Kosina
SUSE Labs

