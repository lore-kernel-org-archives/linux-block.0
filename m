Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D22DC7618B
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 14:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D337B22ADB
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 14:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="owQQYxCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfGXOr4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:47:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37502 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfGXOr4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jul 2019 10:47:56 -0400
Received: by mail-io1-f65.google.com with SMTP id q22so90127338iog.4
        for <linux-block@vger.kernel.org>; Wed, 24 Jul 2019 07:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NSfRJjNYeuIvp3rBv75DLwJLR80WZ9CF2HMW50HmyC0=;
        b=owQQYxCek+9gq1xIgcC0iptre8EObSknF5QHsINZ0zQmxSgD8ksHVmuT0q149lY7BG
         7LZhGwFE+SugBVQQEZqSevOZiA8kmSS7G88IEjHOCnAqiOYhJTFbQkfDXvTgEO2u9iwe
         F85Oej5kc6NA8tf6FhtHxhn0uNW/aenpA2LR0f8LAFO4RmlBQ77GSIXpS3X2S9sLNjQz
         YJ8Cm1A+iS5abrqqYdPM2BNdVZuVeOarZhwPsDH/FKA4AkE/o6s/TQiBzXfY7Yg9zfk1
         WlYDegrB0EWGAVHyunGdsRycsRyvrOzon+QL39MoyS6u6KigytIZmpDIacuQrmvMWKz4
         sLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NSfRJjNYeuIvp3rBv75DLwJLR80WZ9CF2HMW50HmyC0=;
        b=ViJ0Ae+jKSS6FNGDJ/UsevK2jTKNpa6qtz3RdLRS0t9YVNjj/vjUJUbwIBIO6i+RPz
         NfcwXhGULyZOAC6pyn/UfsL346vKNmeH4OD7+livBZ09CnGt4ekkDB/ng7FslYvXCNV/
         BMps4PPPmboRMSF/y9WfMfL0CXai+5gh5w6cn6SRWczIlNNbqF3Y0USaRVb6aLlfiuWa
         R/bo/XSIFQ3xlLbwYCM3Z6RYWyI0DlHNjrA7sKiTwebWQCzmbg8Me/Muih65CbVwxXBw
         1AGmcX8Y2j4ld66NcdP9ZOy/J/bjiOaUBOGAyMq6ccZAp488WF8IQvYJndT2BpAKziiM
         fM0Q==
X-Gm-Message-State: APjAAAXVVU+t1uR583JdlxbelzG+K0KIAeqH8Y0BH27atWI1QPjXpech
        5hacKYutcOmycnFMloNE8MPzdeFa5nY=
X-Google-Smtp-Source: APXvYqzTt5BDEMUu9dGKAZp3j+SRwNgL1+40xV2G3scOzbkKy9VTTMO/s8kC953yt7BUaTAFSwANrw==
X-Received: by 2002:a6b:1ca:: with SMTP id 193mr79948261iob.264.1563979675174;
        Wed, 24 Jul 2019 07:47:55 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e26sm39594810iod.10.2019.07.24.07.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 07:47:54 -0700 (PDT)
Subject: Re: io_uring completly hang my pc
To:     Daniel Kozak <kozzi11@gmail.com>
Cc:     linux-block@vger.kernel.org
References: <CABbHjzYH7q6zV8uErKJUTQWhrNw2DFH_7XFbPG7ORGcWTuH36g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <50b09674-1f91-97b2-2e05-936fa3fc0200@kernel.dk>
Date:   Wed, 24 Jul 2019 08:47:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CABbHjzYH7q6zV8uErKJUTQWhrNw2DFH_7XFbPG7ORGcWTuH36g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/24/19 8:11 AM, Daniel Kozak wrote:
> Hi,
> 
> I am playing with io_uring interface and for some reason it is causing
> freezing my pc.  Here is some example code which cause this:
> 
> https://bitbucket.org/kozzi11/uring_hang/src/master/main.c
> 
> When runing this and test it with wrk (https://github.com/wg/wrk) :
> wrk --latency -d 15 -c 2048 --timeout 8 -t 8 http://localhost:8080/
> 
> it completly hang pc.
> 
> Thank you for any hint if there is something wrong with way how I am
> using io_uring interface or it is a bug in io_uring itself.
> 
> Daniel Kozak
> 

Does this help?


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 7343d655f247..fb94cfe0ff3a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1599,7 +1599,7 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 	list_del_init(&poll->wait.entry);
 
 	if (mask && spin_trylock_irqsave(&ctx->completion_lock, flags)) {
-		list_del(&req->list);
+		list_del_init(&req->list);
 		io_poll_complete(ctx, req, mask);
 		spin_unlock_irqrestore(&ctx->completion_lock, flags);
 

-- 
Jens Axboe

