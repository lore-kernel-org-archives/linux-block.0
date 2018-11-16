Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8220C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9F42087A
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="DCpZRC+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9F42087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeKPSoi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:44:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37041 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbeKPSoi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:44:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so4402025plr.4
        for <linux-block@vger.kernel.org>; Fri, 16 Nov 2018 00:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JfxLlY5VPht0WFH7iUdrjYD9TzMzQo5ByumvpKDs6eQ=;
        b=DCpZRC+xf784lRYJWbqVG8gQYobCLpq0TUS6RFv+2PstTg4GxSMmy8ZeWfodpovsPs
         OODA68fxzJ7FdC0e3oLbWKFQSz00RpmZoVmE0Eqj2nheFIlUEoQxZ56X+xSi7jVUOuqV
         RLUmlWZp5Q1QYnQiZ3kORGtBkxv3sP4JVjcm+7GwL5qvp2tyGel6DUDKnGqX2cVGvZxI
         qj4eGrtsh8AeKTmXbZ8S78FpEY65GmJqNaBsUF9yMQasYbgVFSNFQl8vVX5SwB65QraK
         Ex81FTA3VUp1a3snSWUSkNNxSBdXwxAbajzFWkmggviPhhuWwdCiWgQ4XNf5JnpDgyIy
         GHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JfxLlY5VPht0WFH7iUdrjYD9TzMzQo5ByumvpKDs6eQ=;
        b=hAoghXULvIFBuSQz/gZBRFFrQKvYAauTHewT6uQ0MncgliMmqDIZ+0Kyt8BtOSNocJ
         ARUXp3Y+eZ5nVPSqSRsIhKLDqK9Fgx8CHp2gonD81SUa+ltoX5BLNf/zGPv39nu9KxcG
         5N6B/VtKF4+pgUl8PlDlR63dcuA/z1zBIVYobnufk2zwZ8+zGmoQ/RGgAul/SQlLBVWd
         qXveSMNkjMZI/lH+vyZmgsAsdGC5qePGOj2pUaOwpbVhS0BeudVBdm2T2azuNVqlsXOn
         4URUw1eCFUAWdXOAooh58oV0WUPwPYorLPRbTyfu+O7eRHxcTgZxvHtPh2xvnk1PmWKd
         GiZg==
X-Gm-Message-State: AGRZ1gLPcxRLzjGqBmotqjpkr34OHmYLQAbudDvMzUJvxhRZJkGyaPjT
        GkGHxBdz/XQn7W4FTFPNiETINw==
X-Google-Smtp-Source: AJdET5et4KCtOvNBwGhiLHFY+KJtJcGAmA6ho07bV/vQ5bo+uBZFe7KbM+iAnkCcbyzkZXlj55XlIQ==
X-Received: by 2002:a17:902:bccc:: with SMTP id o12-v6mr10016694pls.281.1542357198104;
        Fri, 16 Nov 2018 00:33:18 -0800 (PST)
Received: from vader ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id g190sm29688784pgc.28.2018.11.16.00.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 00:33:17 -0800 (PST)
Date:   Fri, 16 Nov 2018 00:33:16 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        linux-block@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 2/6] floppy: remove queue_lock around floppy_end_request
Message-ID: <20181116083316.GO23828@vader>
References: <20181116081006.5083-1-hch@lst.de>
 <20181116081006.5083-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116081006.5083-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16, 2018 at 09:10:02AM +0100, Christoph Hellwig wrote:
> There is nothing the queue_lock could protect inside floppy_end_request,
> so remove it.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/floppy.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index eeb4be8d000b..218099dd8e44 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -2254,10 +2254,7 @@ static void request_done(int uptodate)
>  		if (block > _floppy->sect)
>  			DRS->maxtrack = 1;
>  
> -		/* unlock chained buffers */
> -		spin_lock_irqsave(&q->queue_lock, flags);
>  		floppy_end_request(req, 0);
> -		spin_unlock_irqrestore(&q->queue_lock, flags);
>  	} else {
>  		if (rq_data_dir(req) == WRITE) {
>  			/* record write error information */
> @@ -2269,9 +2266,7 @@ static void request_done(int uptodate)
>  			DRWE->last_error_sector = blk_rq_pos(req);
>  			DRWE->last_error_generation = DRS->generation;
>  		}
> -		spin_lock_irqsave(&q->queue_lock, flags);
>  		floppy_end_request(req, BLK_STS_IOERR);
> -		spin_unlock_irqrestore(&q->queue_lock, flags);
>  	}
>  }
>  
> -- 
> 2.19.1
> 
