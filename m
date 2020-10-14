Return-Path: <SRS0=vf5w=DV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ECAC433E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 09:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC77206D9
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 09:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FSV8qQvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgJNJWp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbgJNJWD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Oct 2020 05:22:03 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF82C0A88C0
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 18:19:12 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f19so958213pfj.11
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 18:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QtPhvr5nJhYR8mVPaK88pwj4EUDGimveBI94+CiyEAA=;
        b=FSV8qQvGJSUeTfNJHa4b4LHjcKlpA0qJustLR/eqxalbJCXCdneW4j7fwCoxuhQln0
         yDti5BiglEkGggEzp+x1ktgm6wptiT3L6hn67rfhz/plhZQSB+CZ9VOdwraqcoRONUEB
         AHA/w5S7ZJ0VGkG1q67Fo0bxsw9wmM+jdY+dPe3JyLkC4574WewHgRB9hn0IGAim7HWY
         VcO2LNabde8NnknOgKeU6pNjz2883fOwZUe9XDJbp4e2g+d3X5JYD13gFECPs+cmWqjD
         QP6tkoExNECJNVg3bQ2439lBgnrF/b3i8DMo5227Oejn6E5HmCdoucN8mnJTWtrf8O7+
         6pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QtPhvr5nJhYR8mVPaK88pwj4EUDGimveBI94+CiyEAA=;
        b=IGsrgUhJr+L8nBVBeCLegJrJ8tFdFlrXfHouRS9qOVfGiWCs9F+5998LgPEV4Vy7Um
         Zc0vOH6aD4yxogoFFwiPnSzDZPRStpyNsZoKX9RwNe19rd40EitGNg25GA8PcAduKfyW
         KPsRPQxKHErOiRwR7uJ+V5Xooo5Ns0Sn8Y8kWQwvF9UzuIdppJtgNbi0hdWAtvT2/2fv
         VULg8yYsKc6yJPAbnWNCfiESMnu9LTCWL/ON2DwBvoXJDMBWYxO3izpGpy6lVM6U0Xq5
         hU7unue5/oFGKuVp59EKCySwbCs8Q7bKuhqAxaRJQLeD+niS8ZP/6EE8XVBJFyqlfpWt
         hnBg==
X-Gm-Message-State: AOAM530gblRwDA0yekpXowad0KGuZG51F2YnuGXx3bUKd119eV1D6Asm
        AYut1HZOJ9wDRl4h9Mywodacug==
X-Google-Smtp-Source: ABdhPJxQYNPFUFGOio85WJO3Ek8sfZH4GkHK9hs3IUbkxOetcTpsY/HaZeoEfiYv3A8Aeq3KOPqOHw==
X-Received: by 2002:a65:6719:: with SMTP id u25mr1830586pgf.346.1602638352014;
        Tue, 13 Oct 2020 18:19:12 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i2sm531372pjk.12.2020.10.13.18.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 18:19:11 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] DASD FC endpoint security
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
 <20201012183550.GA12341@imap.linux.ibm.com>
 <07b0f296-e0b2-1383-56a1-0d5411c101da@kernel.dk>
 <b5038d44-aa46-bbde-7a9f-0de46fed516a@linux.ibm.com>
 <17e1142c-4108-6f74-971a-dee007162786@kernel.dk>
 <ad3caaf7-ed8e-9f21-c3a6-c385139feb7b@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6468cfad-e14c-060d-a525-00d75fe66819@kernel.dk>
Date:   Tue, 13 Oct 2020 19:19:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ad3caaf7-ed8e-9f21-c3a6-c385139feb7b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/20 2:15 PM, Stefan Haberland wrote:
> Am 13.10.20 um 21:40 schrieb Jens Axboe:
>> On 10/12/20 1:50 PM, Stefan Haberland wrote:
>>> Am 12.10.20 um 21:33 schrieb Jens Axboe:
>>>> On 10/12/20 1:06 PM, Stefan Haberland wrote:
>>>>> Hi Jens,
>>>>>
>>>>> quick ping. Are you going to apply this for 5.10?
>>>> I actually wasn't planning on it - it arrived a bit late, and
>>>> it seemed like one of those things that needed a bit more review
>>>> talk before being able to be applied.
>>>>
>>> OK, too bad. I had hoped that this was still OK.
>>> The patches have been tested and reviewed internally for quite a while.
>>> Which actually was the reason for the late submission. Cornelia also
>>> gave her RB last week.
>> I'm not worried about the stability of it as much as whether the special
>> feature is warranted. From the former point of view, it's probably fine
>> to go in now.
>>> But OK, if you think this needs some more review we will have to wait
>>> for 5.11.
>> I'd definitely feel more comfortable with that.
>>
> 
> OK, I will take care that features will be sent earlier next time.

Thanks, ideally I like to have new stuff like that in my tree (and for-next)
for at least a week prior to the merge window opening.

> So, instead could you please apply the patches for 5.11 as soon as it is
> suitable?

I will - I have it queued up, won't create anything public until we
get past the merge window.

-- 
Jens Axboe

