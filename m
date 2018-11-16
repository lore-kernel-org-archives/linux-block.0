Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFC5C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DBA2087A
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="lKQawXfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DBA2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeKPSpk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:45:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38838 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbeKPSpk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:45:40 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so3068236pfi.5
        for <linux-block@vger.kernel.org>; Fri, 16 Nov 2018 00:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iMCmpd55V0g/QKS2kEwCcQIfHtmB5ryB4KXVv+za0y4=;
        b=lKQawXfDN3/6UKeTfp0abL2n//ZrfNqTA618gu7uXZJAZ6y6ysBwa92OkbpnPcIPea
         aREpli96D37A+r8E4SQ0WkbQjvxdp4D2SSWeLvoqp6lSbFEXXEXrbjyKkSnVRetVbAKX
         ycKSjglAKl/JGLftNO7/CZ7OuowUPMn8k5JChaYLrl5seqMMvjyR4NwEqSG7NOm4jDYh
         Pag/P0dIMPXc399QSi7WLREufSmyrpVGlEziLD+Yyh7H5G6s2iGd+qt7g9IRZ6CkDYdG
         0ZvU+0neLlhObOWJDdXM/1KxGr6smIStOWTt8AWndTkw+leyo3K+q79kvE3FBR/KdT58
         ZGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iMCmpd55V0g/QKS2kEwCcQIfHtmB5ryB4KXVv+za0y4=;
        b=N71TQfKIb7ObPJpcw+gRuvLTKO1FO3W9bmzT0riIetm3NjHiUAuvMAp0TC7juON9+x
         efzp2sAxkRwZc4CUf+ouVWtdvJAIV6aza4OPdi5/p+OONYowL3/LmgYmd3i6FPdPd6b0
         DdIx3ps0i6twCGYjQtEjIl0KEAsMjqohLKPZrNYBVV2J6T79ZSXF66KlACDISIJbKken
         XZ7QKtU2lE2yuNnE8KhUlKiClVfeblyj/RJYjiXWPpI9bNFAmR2dWYFozOQRthlX6CPf
         Kjowq5fSnlyM/aULJGEQtLRCrHrrEOl4Rd1ZHmfYy48xut0IkToxxkF7w3CQqsOfuJoq
         7Utw==
X-Gm-Message-State: AGRZ1gLzACarV80DXF5k/dP9yI6xpUj0VWQv85XyI3if7+Htu6O2GsWi
        3/IpV2NSttL5UG0KDMj+K86fmw==
X-Google-Smtp-Source: AJdET5cYk3Oj/NaIPiLEdo7Ts815gk5H2lK+YyxePYxs+dSgyAmrvZyIenYvPJB0oTMGMF7ikw3J9g==
X-Received: by 2002:a62:1e42:: with SMTP id e63-v6mr10069163pfe.149.1542357259589;
        Fri, 16 Nov 2018 00:34:19 -0800 (PST)
Received: from vader ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id 85sm32597380pfw.17.2018.11.16.00.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 00:34:19 -0800 (PST)
Date:   Fri, 16 Nov 2018 00:34:18 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        linux-block@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 4/6] ide: don't acquire queue lock in ide_pm_execute_rq
Message-ID: <20181116083418.GQ23828@vader>
References: <20181116081006.5083-1-hch@lst.de>
 <20181116081006.5083-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116081006.5083-5-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16, 2018 at 09:10:04AM +0100, Christoph Hellwig wrote:
> There is nothing we can synchronize against over a call to
> blk_queue_dying.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/ide/ide-pm.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/ide/ide-pm.c b/drivers/ide/ide-pm.c
> index 51fe10ac02fa..56690f523100 100644
> --- a/drivers/ide/ide-pm.c
> +++ b/drivers/ide/ide-pm.c
> @@ -44,15 +44,12 @@ static int ide_pm_execute_rq(struct request *rq)
>  {
>  	struct request_queue *q = rq->q;
>  
> -	spin_lock_irq(&q->queue_lock);
>  	if (unlikely(blk_queue_dying(q))) {
>  		rq->rq_flags |= RQF_QUIET;
>  		scsi_req(rq)->result = -ENXIO;
> -		spin_unlock_irq(&q->queue_lock);
>  		blk_mq_end_request(rq, BLK_STS_OK);
>  		return -ENXIO;
>  	}
> -	spin_unlock_irq(&q->queue_lock);
>  	blk_execute_rq(q, NULL, rq, true);
>  
>  	return scsi_req(rq)->result ? -EIO : 0;
> -- 
> 2.19.1
> 
