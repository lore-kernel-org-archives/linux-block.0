Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A80C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158D0208E7
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="qqF6K6zO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158D0208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeKPSsz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:48:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46668 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbeKPSsz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:48:55 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so10281265pgp.13
        for <linux-block@vger.kernel.org>; Fri, 16 Nov 2018 00:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RbMFablAdgFTJYp+1XflhmpMqwX8f5JHd8RAaMlX3cI=;
        b=qqF6K6zO8bniGs07J9fBZxxay6BzYGJkMIOVr7Xx2nPzWAXIrPfO6YVnme1FcYtPoj
         FNpz/lWEDfqz+wo4e0ZnwgbtE+tRi9EWgsDVkghg/CIuHdKiNdK6qDctGQNfV0UQr/7/
         okR15t3zWcc5fz2/iI8KUh4fHVKU/0aTESgoDCHegvM178A8dYQw7ZAxXgEFFV0Htpd1
         DbM3HSbQWBUE2z7886hJJedsl0gYuYMHcZW5eByKTtvYqx4xiGXfrLn9IwMJwvNgBdEh
         ZJKJEdhw1LuGDu6i8vK5wfLX/HQPJyuHj96PMzabuHEjUKJuF98dt0G8qBVquDJb2whZ
         mqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RbMFablAdgFTJYp+1XflhmpMqwX8f5JHd8RAaMlX3cI=;
        b=AUA+XHyoUmEEIiUJz6O3AVI/EY0wqONKSWrMID943g34hFVKlCAULEJCJCHN/v8psn
         DTeRtSL7k/DP+MPKCIglX617cP691YjSXo+KsrjDUHGI75pRb6uccxIhgSzuAle5xI7r
         2+vzjTfSwXnC9UI4aI2jZ4fXxEyGn+/OdgJbPuZwNFhVrCuUU7kcBpA8+mCzMzGEh3xv
         1DjyCEwwWnwiBnvpoz9l9I+zcD8fE3JNTyJtPf44Q6CysuLmzVWtfDpPlkRlVpmw0YM4
         HSMv4FGkSyUYuCwrxNc+zeSSiyTm3wUd+gNh8wy1DYFyFuojquFnHrF/YHVa1YpCGEbq
         QQzA==
X-Gm-Message-State: AGRZ1gII7sV01e/3Dc428OizWwJyzu34eXW8bK0aA26e5LkP7mpD+tMt
        uVCg3UDezfVhlD02E1vh7bJLqVDemI6MtA==
X-Google-Smtp-Source: AJdET5cKhupBgVY/TiLEY3ZBuj1M/Ay1MczHZ/QE8lJdvR+u2akV9z94zu83rIma/eLftWTEu3zSKg==
X-Received: by 2002:a63:e4d:: with SMTP id 13mr8455886pgo.369.1542357454036;
        Fri, 16 Nov 2018 00:37:34 -0800 (PST)
Received: from vader ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id r2sm9674356pfh.57.2018.11.16.00.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 00:37:33 -0800 (PST)
Date:   Fri, 16 Nov 2018 00:37:32 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        linux-block@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 5/6] ide: don't acquire queue_lock in ide_complete_pm_rq
Message-ID: <20181116083732.GR23828@vader>
References: <20181116081006.5083-1-hch@lst.de>
 <20181116081006.5083-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116081006.5083-6-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16, 2018 at 09:10:05AM +0100, Christoph Hellwig wrote:
> blk_mq_stop_hw_queues doesn't need any locking, and the ide
> dev_flags field isn't protected by it either.

Is it a bug that dev_flags is no longer protected by queue_lock after
the mq conversion?

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/ide/ide-pm.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/ide/ide-pm.c b/drivers/ide/ide-pm.c
> index 56690f523100..192e6c65d34e 100644
> --- a/drivers/ide/ide-pm.c
> +++ b/drivers/ide/ide-pm.c
> @@ -201,7 +201,6 @@ void ide_complete_pm_rq(ide_drive_t *drive, struct request *rq)
>  {
>  	struct request_queue *q = drive->queue;
>  	struct ide_pm_state *pm = ide_req(rq)->special;
> -	unsigned long flags;
>  
>  	ide_complete_power_step(drive, rq);
>  	if (pm->pm_step != IDE_PM_COMPLETED)
> @@ -211,12 +210,10 @@ void ide_complete_pm_rq(ide_drive_t *drive, struct request *rq)
>  	printk("%s: completing PM request, %s\n", drive->name,
>  	       (ide_req(rq)->type == ATA_PRIV_PM_SUSPEND) ? "suspend" : "resume");
>  #endif
> -	spin_lock_irqsave(&q->queue_lock, flags);
>  	if (ide_req(rq)->type == ATA_PRIV_PM_SUSPEND)
>  		blk_mq_stop_hw_queues(q);
>  	else
>  		drive->dev_flags &= ~IDE_DFLAG_BLOCKED;
> -	spin_unlock_irqrestore(&q->queue_lock, flags);
>  
>  	drive->hwif->rq = NULL;
>  
> -- 
> 2.19.1
> 
