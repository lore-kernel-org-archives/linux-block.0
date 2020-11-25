Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB24C5519F
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 12:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18213206E5
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 12:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NI3hsJLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgKYMZy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 07:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbgKYMZy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 07:25:54 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3132CC0613D4;
        Wed, 25 Nov 2020 04:25:54 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id f27so1408137qtv.6;
        Wed, 25 Nov 2020 04:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AzMPFzJsIYAM/Ura8MDMvcJNVcf2nY/hliPxxmhHH8E=;
        b=NI3hsJLo9ep6kUNCSc3HT9LB3wtoDh6y/+bb7SGCK9JFhUDcNjDyoJnAam9P0JArC+
         MC1eOpifZCh336PLstRZWiSdKwSL9TZ3aMG9ok2baLd8zdlMfiiLks0JhD7cJSnPhqXs
         oGzHvu6HnlkPkkGZz1+0eryde/cY/YAQg6G4mbcw+HGTHFiIGze0urQxCXfazwxw4ej8
         M/Y5HryeaBPzmIcejhp/HOcLXRSDiKYM5XLvsl+VpKFVIYPSaYjhi8oYHHeyFcJG0HBx
         EpQLIYEEXrtDNvuIByXG23b0WaLXSAdlPGYdsSnlwsHALlvHurynZMMQBGRJ9x5dGXov
         7k3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AzMPFzJsIYAM/Ura8MDMvcJNVcf2nY/hliPxxmhHH8E=;
        b=luT+20Suk7AlqgRfIvTGEaEZ3TsSpeIjbpfD+dja/KMuf8TdwpEnrm0DclcgGR9QaT
         UX2VEpio3yiXUQKYQezBM2Xv07okJwuMZVo4fx9anTTxHLcHdz/EyIGlkG5/ToOJQvLA
         YIa+2ztG0Hsj6uB7S7zj8qtooO5w2d2cJFr1VqRdpD4oFCL/J8cpJFVAqqQBZeW7RQ8m
         SZGQyUovD9yfYobG6TqcByQM+eEU62xqvw8zXD9g4TtYctoZ9BYDQicCaUHw2JO3xpWx
         12SM03Jn8QV21GfkLq5fShIVh5Mh9mQr+ymbAQZsJ4NE9aUgaY5HhLtfavJXBlSz0+gu
         BKWg==
X-Gm-Message-State: AOAM532Xc7GHFhbBTwvzcjYY9c4FJmBqBHl+J+6Hhc7lp464WHp3LhTw
        cGLK5e3N0wDdKlFH8v5oRBAgz2W7p4IxJA==
X-Google-Smtp-Source: ABdhPJz6rkfqMXBD5RfnLcrxuJBxqoo6Y7ksjwMgc60r/aG5Zm4G96TGymWQnmMGdicRaIbHMje7eg==
X-Received: by 2002:ac8:6642:: with SMTP id j2mr2708156qtp.323.1606307153347;
        Wed, 25 Nov 2020 04:25:53 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id j13sm2333491qtc.81.2020.11.25.04.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 04:25:52 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 Nov 2020 07:25:29 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] blk-iocost: Factor out the active iocgs' state check
 into a separate function
Message-ID: <X75NOaW6AYyGZSF7@mtj.duckdns.org>
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
 <aa1f4c6e637974d7195bf4e019880e50acdd5ca5.1606186717.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa1f4c6e637974d7195bf4e019880e50acdd5ca5.1606186717.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Tue, Nov 24, 2020 at 11:33:35AM +0800, Baolin Wang wrote:
> -static void ioc_timer_fn(struct timer_list *timer)
> +/*
> + * Waiters determine the sleep durations based on the vrate they
> + * saw at the time of sleep.  If vrate has increased, some waiters
> + * could be sleeping for too long.  Wake up tardy waiters which
> + * should have woken up in the last period and expire idle iocgs.
> + */

Please reflow the comment.

...
> +	nr_debtors = ioc_check_iocg_state(ioc, &now);

How about ioc_check_iocgs()?

> +
>  	commit_weights(ioc);

I think it'd make more sense to move commit_weights() inside the new
function.

Thanks.

-- 
tejun
