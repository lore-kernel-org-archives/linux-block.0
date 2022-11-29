Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE55C4332F
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 19:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbiK2TOK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Nov 2022 14:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbiK2TOB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 14:14:01 -0500
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFF36A76C
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 11:13:56 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so18286611pjs.4
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 11:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V51Z4h9kBJAuT9meyaXz4DdPbKBfb3kBygffgUMARbY=;
        b=ZddmPYKoS8f2mrb08lFKhmkUgAJ3sAsrT7wZVSUHG4Dck361UKRmjGOuFFgCHPFztp
         z5XPhkp7j3nzupVN7tNw8RLyOFLv8LFlRIKIjner2snezFrEh1w00bVQzjeWLHhiDbs0
         D1vfLC9jesibWMIPDq1OyMV89PBcxe0tqiE3H1gHus3m2O626H4dZJ7nNoi3iH/Gg1wJ
         Ly8n1e61kRh4YpuBMDG/+qofUUd+eONOb7Uvh3kiN+B/ZR0p1Sok29xc+d9L7y33fkuw
         2gp2HIualP7JyCSLVLL+mBoFqrEwlYNJaAiDxmffXfi9fm+dIzz5Q6AkO++oQgvGa1OI
         PMRw==
X-Gm-Message-State: ANoB5pkaSQLl933AoTMQKcxbX1zWAGsigHrtnooZAsCCg9zDSAyxQ4Fc
        77+gNSFPFVk6vOwpvyiLiSX2AJDvfUQ=
X-Google-Smtp-Source: AA0mqf5bP9MJ3XNSwqM8Jzp3Rb9T+jSaJu7MAiAwezKPYVRIZnWo2CTzZk/PkssIp+VsCw0s9M2I+w==
X-Received: by 2002:a17:902:f68a:b0:176:71be:cc64 with SMTP id l10-20020a170902f68a00b0017671becc64mr40207521plg.141.1669749235792;
        Tue, 29 Nov 2022 11:13:55 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:7d15:8e62:30bb:9a14? ([2620:15c:211:201:7d15:8e62:30bb:9a14])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902e54900b00178aaf6247bsm11302122plf.21.2022.11.29.11.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 11:13:55 -0800 (PST)
Message-ID: <b1efe64c-7b8d-b10f-a041-bae26aa3e637@acm.org>
Date:   Tue, 29 Nov 2022 11:13:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: blktests: block/027 failing consistently
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <f9490310-11e2-fdc9-db3f-2b4a51170c85@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f9490310-11e2-fdc9-db3f-2b4a51170c85@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/22 10:49, Chaitanya Kulkarni wrote:
> blktest:block/027 failing consistently on latest linux-block/for-next

Hi Chaitanya,

Is this report perhaps a duplicate of 
https://lore.kernel.org/linux-block/69af7ccb-6901-c84c-0e95-5682ccfb750c@acm.org/ 
?

Thanks,

Bart.
