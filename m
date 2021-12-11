Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD42C433EF
	for <linux-block@archiver.kernel.org>; Sat, 11 Dec 2021 14:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhLKOVd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Dec 2021 09:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhLKOVc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Dec 2021 09:21:32 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981F0C061714
        for <linux-block@vger.kernel.org>; Sat, 11 Dec 2021 06:21:32 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id g18so10990638pfk.5
        for <linux-block@vger.kernel.org>; Sat, 11 Dec 2021 06:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FekVagPR4dXcdP7uCFP0bvB/Z8TAk+0KsA2Qc/XbD5o=;
        b=sfPz8A52lShEbmglLHjKdvUCMiUMbzRltBUE1sFRStCWOsJvUxFSDvYfisK6eNaknF
         kGfBp0iV6g0jhJNvGFnicM0yEcIIW4DQm7IAubr3a6Q4zZU2qzzAJDWPpE/ya8r+hBmf
         3OYDCEtNLbut33y8RBHEuOEoipKBXbca4Qar7aPvrYnDh9DCsMWyKFh+bT69QAauQBu1
         zk/AsnW6cYsnOzSDuQilPoMYZAVTz0i3M16NnX+fijdl3aL+HT49GPcCWjoobyNdHURV
         sK7yjc0y00Z8+2uqEykaVj27RUUOOYB/cvFBBRaO4wN5us0BJbrG7DslZ2yVi+xhSK8n
         EI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FekVagPR4dXcdP7uCFP0bvB/Z8TAk+0KsA2Qc/XbD5o=;
        b=V/BkTFTVPZ181pIaavMLd8nH7L0ZVXDeXWg/MuRz8Ai3wc9VfU7V9FxMWrJ/tRdo95
         gP49FUGHkSo0/+J7I+b2QNrW9BhstB0HEtkCOFMcl95U3aw8kKxKIs22YkpIwvEwwT3b
         KoBfT0XJqeBdVEfwzkYyrCUmS4JWGcolt+NrY28JJYAYxalyuLghw+q/2VPpKFApP4RS
         dpCZDa/tEvkJFiCqt8mjcn7VwNGcAwmkEzFAruUqPMHFmzyvUelsJWZdjfUIRw8MNIqJ
         brSGhYGtsdgDb0v2Isr2VVrL9Za36kFxIjhIp1/55UaMN1+gH11I+iVSv2cpSlH6p6tB
         8Wgg==
X-Gm-Message-State: AOAM532TCJPKMy7vR2T1igw17NBaHFf91NXp5MoXuKG++8kOG6nz/Ace
        ToO/CSaNdupTczAzGc6X3Aa6wQ==
X-Google-Smtp-Source: ABdhPJwixsbfy1EcS7D11sG6Xm/+t6AUFl1VNzSPMMVewBfh8zL/+dyGLuyG6f/vL4/zQWBciSC5Fg==
X-Received: by 2002:a63:5a18:: with SMTP id o24mr43568267pgb.459.1639232491977;
        Sat, 11 Dec 2021 06:21:31 -0800 (PST)
Received: from [172.20.4.26] ([66.185.175.30])
        by smtp.gmail.com with ESMTPSA id q17sm7628946pfu.117.2021.12.11.06.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Dec 2021 06:21:31 -0800 (PST)
Subject: Re: Random high CPU utilization in blk-mq with the none scheduler
To:     Dexuan Cui <decui@microsoft.com>,
        "'ming.lei@redhat.com'" <ming.lei@redhat.com>,
        'Christoph Hellwig' <hch@lst.de>,
        "'linux-block@vger.kernel.org'" <linux-block@vger.kernel.org>
Cc:     Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com>
 <BYAPR21MB1270DCE17A0FE017AF3272F1BF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <b80bfe9a-bece-1f32-3d2a-fb4d94b1fa8c@kernel.dk>
 <BYAPR21MB1270B5DAD526C42C070ECB9EBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <c5c8f95e-f430-6655-bab5-d2a2948ab81d@kernel.dk>
 <BYAPR21MB127011609EBF6567126EBF83BF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <BYAPR21MB1270B53CFDDFD52AD942B3AEBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b4350274-7219-1d1f-7a39-3f445c081fd1@kernel.dk>
Date:   Sat, 11 Dec 2021 07:21:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR21MB1270B53CFDDFD52AD942B3AEBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/21 12:09 AM, Dexuan Cui wrote:
>> From: Dexuan Cui
>> Sent: Friday, December 10, 2021 7:45 PM
>>
>>> From: Jens Axboe <axboe@kernel.dk>
>>>
>>> Just out of curiosity, can you do:
>>>
>>> # perf record -a -g -- sleep 3
>>>
>>> when you see the excessive CPU usage, then attach the output of
>>>
>>> # perf report -g
>>>
>>> to a reply?
> 
> I realized you only asked for the output of "pref report -g", which
> is much smaller. Please see the attachment for it. 
> try_to_grab_pending() is the hottest function, e.g. see line 2479.

Sorry, can you do:

# perf report -g --no-children

instead?

-- 
Jens Axboe

