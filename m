Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AA1C04EB8
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 01:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FED2082B
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 01:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkppqI7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FED2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbeLEBiZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:38:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38629 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeLEBiZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 20:38:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so8222786pgc.5
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 17:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=10fDMYp5jZQOjF0oWsEw6Oyeo2UyAiboRP37lTjMvEM=;
        b=JkppqI7BShQBfjzkTq3IRki2Cc8TVBL0B8DYBhVXjtoKhEedYrOONVUl8clTVW+sAt
         3lo3q3TzDyx5/6EVp1JT9wSi0UqAql5u9E9p1EkPa0tF8e1u6pYpsah0CYjsZIwcA4xd
         aAh8zRaKLhWqZPLF+JFxrqQf0YQ2J/lgJ0YMx9iX8d4GCT1el78QNoUj7UGBClbi70x0
         eUd3UbaF6UlurHf9otEWUDL7sWkv9VgBndkjQXbCDiCj0xZbLPk0UZ0IzSj2M//4dVrc
         6CVyrH3uuchvSPn+f1YI6WXhGdtNOcrzpJr2Zbdo8eymYmwUYZkGV4AymHjJhMbfslzz
         Azlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=10fDMYp5jZQOjF0oWsEw6Oyeo2UyAiboRP37lTjMvEM=;
        b=koh7k8I2rcqnM+iAIe2kqfR3JZpYdk/mvO7A9kdvXY5TKdiacaRWQlOz3tEVlPzjux
         J5b+DAHnVFTOe9LaMRM09yMaL6NMEuZaVzJrAOJSwrFK4/rA5numvis/kicaBNA53cIf
         Ps32sN7Lv1fs620oaWE5TdZek5FzvEAY/xz5NJ0GzlTKBEfvJUBqBWrZotZ82VL9BYJs
         PCLhpnVF+MaHs+EBoEhrPchsC/om50WnPkRHJT7TORzfojVkYEgcUpmeArxuUq8fLma9
         LvxbPHzlz70nKitNGJselxD6EjnkDx8Rg/77x50uQXIxFN3/AvG6vqkyyZTKcwTwCvFA
         Kb6g==
X-Gm-Message-State: AA+aEWaX4bvEBiPbIABLI2bfRkxJOd7oeFVEmUhB5fXTLREI2x2kp7hU
        /RBSA205gXUsQ91n+2xWhts=
X-Google-Smtp-Source: AFSGD/WVQT1tTBDnx/Uci4ZWpq4j8v3nWFavA9/dTLmPk7VPcHJZccYNLf+slkAg1LrM6S92P5X5Eg==
X-Received: by 2002:a63:588:: with SMTP id 130mr18518516pgf.273.1543973904156;
        Tue, 04 Dec 2018 17:38:24 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i123sm35673474pfg.164.2018.12.04.17.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 17:38:22 -0800 (PST)
Date:   Tue, 4 Dec 2018 17:38:21 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: fix corruption with direct issue
Message-ID: <20181205013821.GA19605@roeck-us.net>
References: <1d359819-5410-7af2-d02b-f0ecca39d2c9@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d359819-5410-7af2-d02b-f0ecca39d2c9@kernel.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 04, 2018 at 03:47:46PM -0700, Jens Axboe wrote:
> If we attempt a direct issue to a SCSI device, and it returns BUSY, then
> we queue the request up normally. However, the SCSI layer may have
> already setup SG tables etc for this particular command. If we later
> merge with this request, then the old tables are no longer valid. Once
> we issue the IO, we only read/write the original part of the request,
> not the new state of it.
> 
> This causes data corruption, and is most often noticed with the file
> system complaining about the just read data being invalid:
> 
> [  235.934465] EXT4-fs error (device sda1): ext4_iget:4831: inode #7142: comm dpkg-query: bad extra_isize 24937 (inode size 256)
> 
> because most of it is garbage...
> 
> This doesn't happen from the normal issue path, as we will simply defer
> the request to the hardware queue dispatch list if we fail. Once it's on
> the dispatch list, we never merge with it.
> 
> Fix this from the direct issue path by flagging the request as
> REQ_NOMERGE so we don't change the size of it before issue.
> 
> See also:
>   https://bugzilla.kernel.org/show_bug.cgi?id=201685
> 
> Fixes: 6ce3dd6eec1 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Tested-by: Guenter Roeck <linux@roeck-us.net>

... on two systems affected by the problem.

> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3f91c6e5b17a..d8f518c6ea38 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1715,6 +1715,15 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
>  		break;
>  	case BLK_STS_RESOURCE:
>  	case BLK_STS_DEV_RESOURCE:
> +		/*
> +		 * If direct dispatch fails, we cannot allow any merging on
> +		 * this IO. Drivers (like SCSI) may have set up permanent state
> +		 * for this request, like SG tables and mappings, and if we
> +		 * merge to it later on then we'll still only do IO to the
> +		 * original part.
> +		 */
> +		rq->cmd_flags |= REQ_NOMERGE;
> +
>  		blk_mq_update_dispatch_busy(hctx, true);
>  		__blk_mq_requeue_request(rq);
>  		break;
