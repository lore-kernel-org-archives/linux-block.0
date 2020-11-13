Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FABC55ABD
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 21:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036672224F
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 21:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="i5cOjee5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgKMVcV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Nov 2020 16:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgKMVbt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 16:31:49 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2733C061A51
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2020 13:24:39 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id d17so3635784plr.5
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2020 13:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cK3jhY8vrc/zWQCSKfoK46kQ7WAzDxZD7JgMz9Lrv1M=;
        b=i5cOjee5RIZcs26cPi5Pl1Lat6gDG6/wLCOJ5Tr1imIvpeiu4D+oFzPVe/40YkTQv3
         X3QhQeGf0kIdmqCbzNkT6JUJuhcOd5eP/S9uChXaJnnsFqWD3Il5Qpu0HX6xr4XhVxLs
         yD26ETyNwMjs5EScOO1i8EJEC0DqGtiv98B6ttmdVeh2s64qj70WU8gdWsHnnEds++kX
         l4pEycDaqwK7uWOUHz61Kl/mVXEAleVbWK1TCv6IxNkLzoAqQrhOdHyTPyd4YDyMy3RZ
         Lxu3WTtv6Jkl7rKqTDln3AUoa5puWShSr8linw/Gheh6LvzdQOpu34554utQ6+tx5hZT
         j2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cK3jhY8vrc/zWQCSKfoK46kQ7WAzDxZD7JgMz9Lrv1M=;
        b=ORVBpQhCDzqse/oTLtM3GK4BLrEBluddBTxuQm9VhbmBy/Hz5BMY5TBoTcuy/Cp/ZU
         C7b7ahEsktFg6Qqmkp0Uz+v7xw28BXEPr3KPtU01uFTZ/GEeNCB5gbYGnquCYg5LuVJn
         sNQO/ooslLdF9Pli9I4bFnYsWFef6HMl+NERLyp+G9jduMWhBT5hUzrkwmt7nUS8aS9D
         VMU1vFj0UuhmrfBtKO0ObH2tK3unHcEK7StTTVSMiLOAa9mc/67xg6DSyQsGEIovz31j
         xai0WTlrvpXXwQ091/CfPYHWDh0fczMiRkI5/AJ6m9b46TLHSi3bxh6965S139zP1CDx
         36hQ==
X-Gm-Message-State: AOAM5332NAuuf8UyeBBtSHYtBsWzUO7ARd4FECHEx/5El2SmBOkPdRs2
        n/WRYRrUq+jPxHpIcpmlw4W6/Q==
X-Google-Smtp-Source: ABdhPJzdntkX48EJ/tAiwYUXdFZlMLAJmpHStF42zzo6kJoKxtyidj2HQf0cHRUXXJiKMZIrX2abPg==
X-Received: by 2002:a17:902:342:b029:d5:ab9e:19ce with SMTP id 60-20020a1709020342b02900d5ab9e19cemr3793624pld.48.1605302679350;
        Fri, 13 Nov 2020 13:24:39 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q11sm9736044pgm.79.2020.11.13.13.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 13:24:38 -0800 (PST)
Subject: Re: [PATCH] block: mark flush request as IDLE when it is really
 finished
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
References: <20201113134448.1074373-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <00aa56e6-dfa4-bfa5-c0bf-32412b4393e2@kernel.dk>
Date:   Fri, 13 Nov 2020 14:24:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113134448.1074373-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/13/20 6:44 AM, Ming Lei wrote:
> For avoiding use-after-free on flush request, we call its .end_io() from
> both timeout code path and __blk_mq_end_request().
> 
> When flush request's ref doesn't drop to zero, it is still used, we
> can't mark it as IDLE, so fix it by marking IDLE when its refcount drops
> to zero really.

Applied, thanks.

-- 
Jens Axboe

