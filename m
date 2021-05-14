Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E7BC433B4
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 15:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CDDE61166
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 15:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbhENPCK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 May 2021 11:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhENPCK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 May 2021 11:02:10 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979B0C06174A
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 08:00:58 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id o21so27952481iow.13
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vFbowzzPmTj3jyLGuQbNYzZiGpBZhRFAidVoo1PXCOE=;
        b=nSnM4FdnqKKZdRnCZ5mAj/2SIZby4F1z7eH5tCDrlx6dPi5pcoxOk6W1CsSyFERCNm
         fm2HWWqzIesnxZiIGrqaxzzjXEs1/wxJ9ZEH6+mXKBYt6y9lddtgQfB0jXRKQ3iXIL/R
         3mLlWLZfdLqQJbySkI5E7/Z7aJo8QxfY9M4MUCgYy1ESSmFqxzmzgcUCGrSeWkOmBx5N
         2SMMtuCy5hmvDXFMF6OwUbC3NScGKGU+GWYYftWR5x/rSU0p4hlXOlwS3slnN5umkeiC
         B6NUqgDXl/gA3iztIXIvlurZJyzwbcanoFLKtS+ZOv+WlpqZD3sgQmLQMCBBWW/e3oeB
         Agqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vFbowzzPmTj3jyLGuQbNYzZiGpBZhRFAidVoo1PXCOE=;
        b=cDB8lx06sVfhIFF1msBubrxf02SnKzIM83Fiok047g5OxoZQKXSiJzY8vkPPh8wlIP
         1jN9E1OlsPea8fWiYukSNK3N+As5ELJhK5wBhierkhjR5vKJBSZtNHjH8XuMuSy69khY
         6EK++3FOsRggEZ8cz77TOWn8vTaUs7TK2LYayNVYhuZdlsHCx16SFnZEGtRJePy7C/oE
         uQ36oyweZOl6s1gN5MHTz9v7RCCuA0qWc5hJRAgCWdFTPitvHyyIPRf/QEwRAxlJ92Pa
         AcIBbpATHVl3p/+np86KS/9hO6XIqgySYTdPiV9PCuWANccpkvIHpz1/YaLkplrmx2Ue
         fgew==
X-Gm-Message-State: AOAM530SPIzkXQ0AmLoYIrvfMpq9NJqmPMc/1OzAxdZS1kES/3ZiO9/t
        ZkB0T2zQKHxsWGqwMYQtYwu5wQ==
X-Google-Smtp-Source: ABdhPJyVcxAGjFolEtTidhP1667r0C4uVQOhyfuQG7f35Pu3QxM+iofTvJpr034kTL57GEgNZk/B3w==
X-Received: by 2002:a02:380d:: with SMTP id b13mr42709885jaa.77.1621004458045;
        Fri, 14 May 2021 08:00:58 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n16sm3117493ilq.44.2021.05.14.08.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 08:00:57 -0700 (PDT)
Subject: Re: [PATCH][next] rsxx: Use struct_size() in vmalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210513203730.GA212128@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fb567b7b-5ea4-fe8b-52cc-f148ff6a61b7@kernel.dk>
Date:   Fri, 14 May 2021 09:00:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210513203730.GA212128@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/13/21 2:37 PM, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows
> that, in the worst scenario, could lead to heap overflows.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.

Applied, thanks.

-- 
Jens Axboe

