Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC00C74A2B
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 16:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2001F20844
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 16:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqDbIkse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfGJQcw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 12:32:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41558 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfGJQcw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 12:32:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id q4so1499879pgj.8
        for <linux-block@vger.kernel.org>; Wed, 10 Jul 2019 09:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QvTcsemynIFomhEEtzipZF54KLQFA+64PbaSiVuZn74=;
        b=NqDbIkse5Xv1YsG6BSDYAP28uZhhWtOD5rOcsTBcoeQ+4EG1C9c2fIiPjalDbXFPtH
         XpT+Hgc0YbsDs6hEoiwung0A6BQcnSNSLWprDY4+pk7MH3EkeSa7QRZafCtzOluP7Iy/
         coHzhxxPEbiJrRJvWDGYI7D1a49J6n+SJ147XcQQSAaKn0XmRVQ7nJbH7+sS+8AsP/jJ
         m3GoTLGbU/Nl8wlrSTbzGqPa1iF7CFmNT/vISLNrkftM/Fe11sCljRQYgBDnB/fZqwCU
         vXBdnxLBHTuvOVCebEZnvkHUK35VebKND1Pb722+ix97QnOjsKjJkvP27B5DwgTSUK4S
         ZDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QvTcsemynIFomhEEtzipZF54KLQFA+64PbaSiVuZn74=;
        b=TTW9wMK1IehOi6qXLz3jY5wfOGKOm//Zd4CWNyQjz/gZk7dAyePvSHnS1798/9Em2g
         3pAiyYGAbi7VGpa2fENTzF2sYUTaHV7DRG5zr+3UwRP+e6EgbaKHjr0QzVkOsQCvSsQd
         Bv18hayIY5/Mm6+wtCrlbhBuTLk2oK8fXWnWgGLw8myrijGCK64X+QvFMJHsMeSmhGmK
         ETtFtD//U1vLP8k/8cBovM4U+YraYWRuIlMR3uisUEL9o2TsrKP0HwSCdunxNKfeXfeX
         dyDVFDywLx9OdP0QGnxg0IFNGVHu0NExVYwyTUhqLVTf3Y26uCavTqauM90BOQMOfaDO
         BKxw==
X-Gm-Message-State: APjAAAWfMSec+XxScDbRpxZLa+sXHPGttlow1bmrlSr39YYNdS0TEyoj
        wgGZ+nYbosDZk/Wb6Fpn8RClj4EPLgQ=
X-Google-Smtp-Source: APXvYqwSZR+rTxLpPfRCzoa1xWa9kzpgHhOyo1/6MluqXXw3F5a025zReCaYpJ+Z0TU5CzA+HlxT7Q==
X-Received: by 2002:a63:9245:: with SMTP id s5mr23496837pgn.123.1562776371501;
        Wed, 10 Jul 2019 09:32:51 -0700 (PDT)
Received: from continental (189.26.176.28.dynamic.adsl.gvt.net.br. [189.26.176.28])
        by smtp.gmail.com with ESMTPSA id 14sm2867636pfy.40.2019.07.10.09.32.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 09:32:50 -0700 (PDT)
Date:   Wed, 10 Jul 2019 13:33:41 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: Remove unused definitions
Message-ID: <20190710163341.GA26575@continental>
References: <20190710155608.11227-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710155608.11227-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 11, 2019 at 12:56:08AM +0900, Damien Le Moal wrote:
> The ELV_MQUEUE_XXX definitions in include/linux/elevator.h are unused
> since the removal of elevator_may_queue_fn in kernel 5.0. Remove these
> definitions and also remove the documentation of elevator_may_queue_fn
> in Documentiation/block/biodoc.txt.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  Documentation/block/biodoc.txt | 5 -----
>  include/linux/elevator.h       | 9 ---------
>  2 files changed, 14 deletions(-)
> 
> diff --git a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
> index ac18b488cb5e..f0d15b0cb3c0 100644
> --- a/Documentation/block/biodoc.txt
> +++ b/Documentation/block/biodoc.txt
> @@ -844,11 +844,6 @@ elevator_latter_req_fn		These return the request before or after the
>  
>  elevator_completed_req_fn	called when a request is completed.
>  
> -elevator_may_queue_fn		returns true if the scheduler wants to allow the
> -				current context to queue a new request even if
> -				it is over the queue limit. This must be used
> -				very carefully!!
> -
>  elevator_set_req_fn
>  elevator_put_req_fn		Must be used to allocate and free any elevator
>  				specific storage for a request.
> diff --git a/include/linux/elevator.h b/include/linux/elevator.h
> index 6e8bc53740f0..9842e53623f3 100644
> --- a/include/linux/elevator.h
> +++ b/include/linux/elevator.h
> @@ -160,15 +160,6 @@ extern struct request *elv_rb_find(struct rb_root *, sector_t);
>  #define ELEVATOR_INSERT_FLUSH	5
>  #define ELEVATOR_INSERT_SORT_MERGE	6
>  
> -/*
> - * return values from elevator_may_queue_fn
> - */
> -enum {
> -	ELV_MQUEUE_MAY,
> -	ELV_MQUEUE_NO,
> -	ELV_MQUEUE_MUST,
> -};

Acked-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

> -
>  #define rq_end_sector(rq)	(blk_rq_pos(rq) + blk_rq_sectors(rq))
>  #define rb_entry_rq(node)	rb_entry((node), struct request, rb_node)
>  
> -- 
> 2.21.0
> 
