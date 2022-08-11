Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57C5C19F2A
	for <linux-block@archiver.kernel.org>; Thu, 11 Aug 2022 12:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiHKM21 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Aug 2022 08:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiHKM20 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Aug 2022 08:28:26 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE4C90C7F
        for <linux-block@vger.kernel.org>; Thu, 11 Aug 2022 05:28:24 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id z12so21171301wrs.9
        for <linux-block@vger.kernel.org>; Thu, 11 Aug 2022 05:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Hiur2WQwytzBMaRfND7WTjEUNQaTxaBXs1jRHWSw7q4=;
        b=HpGrswq1puhBrmfkLW9+PmS7otzfYDHUDAV74FQYn3dC/ROKyj9ffTG5BnbQlSAuAO
         CISuVNRmAN+dGk58oH32DgpAUarBArfGJSMmhZywax1ue3giglZEOCcE4u0mZHikjpu1
         J7i6BPc2KWdiSc2MNcTzGqiZ3ln6dDQK/5Q6CWJX2HBxvb9BtcRiNILEEOe03reMblYc
         ODrJBvu42Bmqcv/FLyqMdB8pFhW9Agtqxq4yOUDM9O8bKnAafVBQVk7FG0ovtx5DHyiB
         waoEKylCNYWJ9EI27m6mRSecwLC9ZSsXF/Il0296tmn3vZXRVVbebY6z89ufkA/aYmvu
         trww==
X-Gm-Message-State: ACgBeo02kTN3XmYE2EntlA52DR+scTWO0D3epd99+5ezOGnVB3AUP/C3
        Sz3sDgx1islDMHXp4/9NLJc=
X-Google-Smtp-Source: AA6agR7qE/+mauxY//meaViDX9Obd4PY92EXON4OnbWH/Ay3qmLs/V0iE3IbfLffGnKjgzye11IPmg==
X-Received: by 2002:a05:6000:184c:b0:223:2c8b:c43c with SMTP id c12-20020a056000184c00b002232c8bc43cmr10416480wri.16.1660220903401;
        Thu, 11 Aug 2022 05:28:23 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j3-20020adfa543000000b00223654e0eccsm9711287wrb.9.2022.08.11.05.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 05:28:22 -0700 (PDT)
Message-ID: <8a510b95-96e3-433e-221e-ffff06e04cf6@grimberg.me>
Date:   Thu, 11 Aug 2022 15:28:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [bug report][bisected] blktests nvme/tcp nvme/030 failed on
 latest linux-block/for-next
Content-Language: en-US
To:     "Belanger, Martin" <Martin.Belanger@dell.com>,
        Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <CAHj4cs_7kR6DXi19CWh3veespFT=cJSTD0YGEFt8tw_Y8fEqZA@mail.gmail.com>
 <CAHj4cs8zXRTPpHt0Xu5BtSGtERK8cgniwrRPygEL9R=6qxjT5w@mail.gmail.com>
 <3af8153e-5e7a-f803-4dd4-cf7088a9d7d4@nvidia.com>
 <CAHj4cs90B+=Sjr43Xf+DWXw=oMCFLNPmMdenhyQn9fG=-ZXtVA@mail.gmail.com>
 <SJ0PR19MB45449CEC5FCA24EBE6C9BB90F29F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <CAHj4cs82ssuVX25yeHXhtqkkApxJbWDaoyOgq=0u5C4LWF2btg@mail.gmail.com>
 <53ed5142-f9ee-f373-25fc-69c14bc372b3@grimberg.me>
 <SJ0PR19MB4544485314F5FDAF0159C0ABF2649@SJ0PR19MB4544.namprd19.prod.outlook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <SJ0PR19MB4544485314F5FDAF0159C0ABF2649@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>>>>>> nvme/030 triggered several errors during CKI tests on
>>>>>>>> linux-block/for-next, pls help check it, and feel free to let me
>>>>>>>> know if you need any test/info, thanks.
>>>>
>>>> Hi Chaitanya and Yi,
>>>>
>>>> This commit (submitted last February) simply exposes two read-only
>>>> attributes to the sysfs.
>>>
>>> Seems it was not the culprit, but nvme/030 can pass after I revert
>>> that commit on v5.19.
>>>
>>> Hi Sagi
>>>
>>> I did more testing and finally found that reverting this udev rule
>>> change in nvme-cli fix the nvme/030 failure issue,  could you check
>>> it?
>>>
>>> commit f86faaaa2a1ff319bde188dc8988be1ec054d238 (refs/bisect/bad)
>>> Author: Sagi Grimberg <sagi@grimberg.m
>>> Date:   Mon Jun 27 11:06:50 2022 +0300
>>>
>>>       udev: re-read the discovery log page when a discovery controller
>>> reconnected
>>>
>>>       When using persistent discovery controllers, if the discovery
>>>       controller loses connectivity and manage to reconnect after a while,
>>>       we need to retrieve again the discovery log page in order to learn
>>>       about possible changes that may have occurred during this time as
>>>       discovery log change events were lost.
>>>
>>>       Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>       Signed-off-by: Daniel Wagner <dwagner@suse.de>
>>>       Link:
>>> https://urldefense.com/v3/__https://lore.kernel.org/r/20220627080650.1
>>> 08936-1-
>> sagi@grimberg.me__;!!LpKI!lYFKeBqI0lmp0AycSrZ6krKxEMUNjSwCO-tY
>>> -FyMAu5KLid5bBqYpfEBGaRgfGtk1c3HLXUekSSPXr6pKw$ [lore[.]kernel[.]org]
>>
>> Yes, this change is reverted now from nvme-cli...
>> I'm thinking how should we solve the original issue, the only way I can think of
>> at this moment is a "reconnected" event. Does anyone have an idea how
>> userspace can do the right thing here without it?
> 
> Hi Sagi. We had a discussion regarding this back in January (or February?).
> 
> I needed such an event on a reconnect for my project, nvme-stas:
> https://github.com/linux-nvme/nvme-stas
> 
> This event was needed so that the host could re-register with a CDC on a
> reconnect (per TP8010). At your suggestion, I added "NVME_EVENT=connected"
> in host/core.c. This has been working great for me. Maybe the udev rule
> could be modified to look for this event.

That is exactly what it does, that is why nvme discover unexpectedly
connects to all log entries, because the udev event triggers..

In order to address the problem of missed AEN while controller was
disconnected, we need to re-issue the log-page on a re-conect, not
a first connect.
