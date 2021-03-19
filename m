Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D07FC433DB
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 10:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C16C264EF6
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 10:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhCSJ7x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 05:59:53 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:42526 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhCSJ7Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 05:59:25 -0400
Received: by mail-ed1-f53.google.com with SMTP id l18so1817420edc.9;
        Fri, 19 Mar 2021 02:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7TPHg/ghLNCDWDCcA33tYr4grwQlMYCvzF7RM2u1mQ4=;
        b=k0eycwsfFXCU18BD56l3J3D8okCFr8x/mzytyv8hisVTSxCK/T9G4mRGWpvosIHbhB
         BQg7HjaNz91dhPAsjU83iV1vbPPEgDSNvegDR8z3tgANs9bu6GFr//7WZXRgppPy52qw
         EuiXmds75WP1DYfg0OSVF/wp/v1mnYUOZA6vAyIQVUMt00YbesLC/zeFF8UOYpJigK0C
         fzebJIrussJ9NCj13FzL2DPFcFa7n5VgBbQRyeM0xpTaroQQ5eudePR1bOzFwtXoDtbL
         YTZ27yN3/pxwYKElEzrnPAleyD5aTKhhqwo0spQma99/FZ13WQraDCB6RLS6gpCtB4N3
         3rRQ==
X-Gm-Message-State: AOAM530+MA7wyS9dQI9VwyUL60CNPidoI48K3d+BMYAMeyEjnMb6RY1q
        FjA5I5Hw9Ul1WlP+dr1eqqpMtW7jkrc=
X-Google-Smtp-Source: ABdhPJxNLeL3Mmp19lusCeKZDpoMFosHRRJSz1XBvBoH4zBhXEMhq/MXI1QuGN3bOfEKD7QGAjiNWw==
X-Received: by 2002:a05:6402:1051:: with SMTP id e17mr8501228edu.42.1616147963409;
        Fri, 19 Mar 2021 02:59:23 -0700 (PDT)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id s13sm3792675edr.86.2021.03.19.02.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 02:59:22 -0700 (PDT)
Subject: Re: [PATCH][next] loop: Fix missing max_active argument in
 alloc_workqueue call
To:     Jens Axboe <axboe@kernel.dk>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210318151626.17442-1-colin.king@canonical.com>
 <13a1d187-4d6d-9e06-b94a-553d872de756@kernel.dk>
 <62cd71bc-86e1-412d-b2b9-716c0f8021be@canonical.com>
 <d32641ca-e34a-2bfd-9b86-28c95546f434@kernel.dk>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <a99533a9-d96e-4e45-502b-066fe9286a42@kernel.org>
Date:   Fri, 19 Mar 2021 10:59:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <d32641ca-e34a-2bfd-9b86-28c95546f434@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/03/2021 21:42, Jens Axboe wrote:
> On 3/18/21 2:24 PM, Colin Ian King wrote:
>> On 18/03/2021 20:12, Jens Axboe wrote:
>>> On 3/18/21 9:16 AM, Colin King wrote:
>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>
>>>> The 3rd argument to alloc_workqueue should be the max_active count,
>>>> however currently it is the lo->lo_number that is intended for the
>>>> loop%d number. Fix this by adding in the missing max_active count.
>>>
>>> Dan, please fold this (or something similar) in when you're redoing the
>>> series.
>>>
>> Appreciate this fix being picked up. Are we going to lose the SoB?
> 
> If it's being redone, would be silly to have that error in there. Do
> we have a tag that's appropriate for this? I often wonder when I'm
> folding in a fix. Ala Fixes-by: or something like that.

Why it is being redone if it was put into next? And even then, several
other maintainers just apply a fix on top (I think Andrew Morton, Greg
KH, Mark Brown) to avoid rebasing, preserve the history and also give
credits to the fixer.

Anyway, if it is going to be squashed at least SoB would be nice (as Dan
will take Colin's code).

Best regards,
Krzysztof
