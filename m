Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04195C4332B
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC602067C
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbhAZWAE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405444AbhAZUNA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 15:13:00 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF5BC061573
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 12:12:20 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id p15so2661874pjv.3
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 12:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e/0XUqjr09TladXkIrd5yDjsUkoOh12VBnyvWgcj8/4=;
        b=G00TMMO++d1zszQe70QWLvbmKenVilkozeA4Q6hOUWcT4K5kRAoorIVWb8bbJZx6JX
         6DAX8Jj6KIalMVzCd9hoGdqxwSxkYFMOueu3sN2aSbcYtbhFG1m10g5ulx+sFLmPdFKb
         h9IegjqBULQEtwuZnUaVnDGcHeyqTuzCTnT1ns/FCESt5xQLIBVJF64Kn1yC/BIqIStH
         rtCZdRQNbVMCvwIrGPQhWVTWfsPnkQtLAIADpwQS7jL3wVS6IH/2JBjPpedqGoxnB8KZ
         qFNcRyvXNLvQK4blNGTWjQYDdHTRE50iBxCD1PgmLabEoKJJbG0zn0uVr1NNFvt37v+l
         QjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e/0XUqjr09TladXkIrd5yDjsUkoOh12VBnyvWgcj8/4=;
        b=gK+uarvACXBD6Z8ZMFSC0RN43FWxDEtU0t+BunDT5ie3j/54Y+OTAZ80ASG97jYyNa
         IdU3qS18Y6zSwyFb34dC3WxVu+SznVLmHBxSiwvaPTmyqYQXV5NOor6X6rwCSPlBA0Db
         gNGo8yRO4v01YIARDHuWfhFPZEVJNJsMsNyKPvXr7Uo/YxzMgAB05fL7cre4Gq0e3B6m
         wpFhTQpARbV2ugPqtHr793QPhQPT3qgFpUaBLLZIVEi7nWNEhVKhwtTxVBTHplEfEL4e
         20KZeRSGSJnLYyWJDN2EigQwWSln7rmD31gtiH+rNU5JO0h4PMypqZwlZ52fkoT2dMPr
         iYqg==
X-Gm-Message-State: AOAM531b/mis8ss54uDhCd/CYrrYmWNkc4r3YurD/BDSrNsLriJ8hcnt
        hHd780wPUl1UhrHshtgwEREtmM/02I04nA==
X-Google-Smtp-Source: ABdhPJyEcuWrXgTYjoekllVV8h5T+Zxh4bExeQe6d/1hORtoggOW7e5A1yPdFHBqTUNWpdI1+rT6Lw==
X-Received: by 2002:a17:902:8349:b029:df:d13d:bf83 with SMTP id z9-20020a1709028349b02900dfd13dbf83mr7548500pln.69.1611691939582;
        Tue, 26 Jan 2021 12:12:19 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id a2sm19804082pgi.8.2021.01.26.12.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 12:12:19 -0800 (PST)
Subject: Re: [PATCH] zram: fix NULL check before some freeing functions is not
 needed
To:     Tian Tao <tiantao6@hisilicon.com>, minchan@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com
Cc:     linux-block@vger.kernel.org
References: <1611562381-14985-1-git-send-email-tiantao6@hisilicon.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0a3e8d22-5ff0-1b7e-c814-5e293cf4cfed@kernel.dk>
Date:   Tue, 26 Jan 2021 13:12:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1611562381-14985-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/25/21 1:13 AM, Tian Tao wrote:
> fixed the below warning:
> /drivers/block/zram/zram_drv.c:534:2-8: WARNING: NULL check
> before some freeing functions is not needed.

Applied, thanks.

-- 
Jens Axboe

