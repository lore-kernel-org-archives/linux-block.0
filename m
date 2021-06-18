Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F2EC48BDF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 16:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF84B613D5
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 16:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbhFRQsj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 12:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhFRQsi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 12:48:38 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C79C061574
        for <linux-block@vger.kernel.org>; Fri, 18 Jun 2021 09:46:29 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id q10so11179415oij.5
        for <linux-block@vger.kernel.org>; Fri, 18 Jun 2021 09:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K2FkotfuKg6pfAJpJYk+li5QNH8XPl4be8IUWffEIGg=;
        b=lZjz7+7H0uwi3ZHgz1KExUl+2NQHK84D54h582A17pQq6XC/0S/sgNIkO8GKCQv1HX
         qYJ5x5puhoYQVYeNK8SqF+nDAwUE2yHD6lN1w6pgPori0o93XcGj2V3WiWI0xwBjXHGs
         /5gg9RynEKlO6i8LkQtiYblSNJNoHpCCYDa+XMKVCPWWwe5H/ILLeTNsvl8hN65aoBxQ
         j+TTFSdL6iCykn7XUneuJp3gRj9K9G/BhJxl933XzAxV/4AQJ9s38wJ0bWzEEYa0Xv90
         sXSp2hFRU6HrM21KittRtCSs5tHTGUbTGJxNxGr9+BIgpw73JOgBIxJNkJydKPmQ4fhh
         fejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K2FkotfuKg6pfAJpJYk+li5QNH8XPl4be8IUWffEIGg=;
        b=uG/Ra5nm5B5g2Si20+4DgmkUtl18d/3CcWKsSsMw0kYFJKgAtfe5ehDKsI8MgFg/lK
         7YL0bG3xEUQzc+YJ2v/ZB1d2moxxBn2jW+kXFzupx68Nc/RX1ptHMU8r4qnfv+V62WRJ
         UDusxGr72pdLmICVWcYL0Ifhoe/3rRqhvvaK8NLv+sy6faG3fe+Ns0eWo6eTJtBMyEdH
         eUmxbeqYpTFW17XyCg8uXFtLFBYlYnaQSN7AOdhTLTRzEvemZ1PecfHKebbYTcBPCuyo
         pNqEp+Ah+XDm+O5YqfJHGYuD8381PAEriOptFlnPaKdCOPx/gfujVlZtdzVWTyP2/Rcq
         Qsnw==
X-Gm-Message-State: AOAM5334+JOdqiAsj55GqIHE2dj6IGZN+a/CuQG6DE2sscweUCP8KZ0j
        dxCwfrZtO/drZtL2Au/DR+N9ng==
X-Google-Smtp-Source: ABdhPJz4TbEo+GvlwHE7zFx8IVnqLx1SJ/Rklb/hfB0WK3lw27OU722BHUcqKTB/P3HGAxtmU05LCw==
X-Received: by 2002:aca:f444:: with SMTP id s65mr14669879oih.38.1624034788796;
        Fri, 18 Jun 2021 09:46:28 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id b198sm1906809oii.19.2021.06.18.09.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 09:46:28 -0700 (PDT)
Subject: Re: [PATCH] block: remove useless comments
To:     lijiazi <jqqlijiazi@gmail.com>, linux-block@vger.kernel.org
Cc:     lijiazi <lijiazi@xiaomi.com>
References: <1623986240-13878-1-git-send-email-lijiazi@xiaomi.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <48f03363-d36d-6ebb-1646-28113abb57d7@kernel.dk>
Date:   Fri, 18 Jun 2021 10:46:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1623986240-13878-1-git-send-email-lijiazi@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/21 9:17 PM, lijiazi wrote:
> Now wbt_wait return void, so remove useless comments.

Reworded a bit and applied, thanks.

-- 
Jens Axboe

