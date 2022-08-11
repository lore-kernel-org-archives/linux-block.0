Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149D3C19F2A
	for <linux-block@archiver.kernel.org>; Thu, 11 Aug 2022 09:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbiHKJgO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Aug 2022 05:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiHKJgN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Aug 2022 05:36:13 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BB17434A
        for <linux-block@vger.kernel.org>; Thu, 11 Aug 2022 02:36:11 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso2371399wmq.3
        for <linux-block@vger.kernel.org>; Thu, 11 Aug 2022 02:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=DK6hIvfNJmmPv3MAsVSk2g/l4JEAuweSmbOZl+8rwLg=;
        b=wONVnD/UuQA/fG/cBsJL62IiMWZmrWesr6f2azKENUP7yPoygzASDTQqU1PSH6jJW1
         b7z5+vWrfKnLs0XMBcQGnALJE3uFJQFLTA4KIPpu4c2Q520VqMnHBQDhqxiX36d+vrnz
         OdxycNFqjwZPp4ltNKEMVG379o/sdo5qQ1NZFzGMMXRzLmgvxJOKO7PJjOM+41lq6Iqg
         LC1Hg6EMBMi2HqhJ4+MgqakCxTfJ3eXQExynRjOinUuV6hkmu/Sz6f9M6dpKaOP/Nptm
         wvJeSC8F6PWoIwBkyLmKdSq3IHWeynRGFtYpzw2i8vYUNELr9ZkGUh8XZapQBcZ6LyxG
         /BmA==
X-Gm-Message-State: ACgBeo2AuiFh5839qarHHbZMtoZmDs1RIMqTzy1u33BUiOBGsOdBI/Y6
        8ygsghtwEd4XOWUE3LxSHLTZcKnEc8k=
X-Google-Smtp-Source: AA6agR5eSX2zL7y/pnqAB7Hx+c7iKtYqCARnJPfBOgIMSss5NluS9164WMGoeQwgWpD8jL/QQeQRXw==
X-Received: by 2002:a05:600c:1e8f:b0:3a3:1cfc:ba6 with SMTP id be15-20020a05600c1e8f00b003a31cfc0ba6mr4993714wmb.177.1660210570255;
        Thu, 11 Aug 2022 02:36:10 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t188-20020a1c46c5000000b003a327f19bf9sm5289035wma.14.2022.08.11.02.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 02:36:09 -0700 (PDT)
Message-ID: <53ed5142-f9ee-f373-25fc-69c14bc372b3@grimberg.me>
Date:   Thu, 11 Aug 2022 12:36:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [bug report][bisected] blktests nvme/tcp nvme/030 failed on
 latest linux-block/for-next
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "Belanger, Martin" <Martin.Belanger@dell.com>
References: <CAHj4cs_7kR6DXi19CWh3veespFT=cJSTD0YGEFt8tw_Y8fEqZA@mail.gmail.com>
 <CAHj4cs8zXRTPpHt0Xu5BtSGtERK8cgniwrRPygEL9R=6qxjT5w@mail.gmail.com>
 <3af8153e-5e7a-f803-4dd4-cf7088a9d7d4@nvidia.com>
 <CAHj4cs90B+=Sjr43Xf+DWXw=oMCFLNPmMdenhyQn9fG=-ZXtVA@mail.gmail.com>
 <SJ0PR19MB45449CEC5FCA24EBE6C9BB90F29F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <CAHj4cs82ssuVX25yeHXhtqkkApxJbWDaoyOgq=0u5C4LWF2btg@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs82ssuVX25yeHXhtqkkApxJbWDaoyOgq=0u5C4LWF2btg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>>>> nvme/030 triggered several errors during CKI tests on
>>>>>> linux-block/for-next, pls help check it, and feel free to let me
>>>>>> know if you need any test/info, thanks.
>>
>> Hi Chaitanya and Yi,
>>
>> This commit (submitted last February) simply exposes two read-only attributes
>> to the sysfs.
> 
> Seems it was not the culprit, but nvme/030 can pass after I revert
> that commit on v5.19.
> 
> Hi Sagi
> 
> I did more testing and finally found that reverting this udev rule
> change in nvme-cli fix the nvme/030 failure issue,  could you check
> it?
> 
> commit f86faaaa2a1ff319bde188dc8988be1ec054d238 (refs/bisect/bad)
> Author: Sagi Grimberg <sagi@grimberg.m
> Date:   Mon Jun 27 11:06:50 2022 +0300
> 
>      udev: re-read the discovery log page when a discovery controller reconnected
> 
>      When using persistent discovery controllers, if the discovery
>      controller loses connectivity and manage to reconnect after a while,
>      we need to retrieve again the discovery log page in order to learn
>      about possible changes that may have occurred during this time as
>      discovery log change events were lost.
> 
>      Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>      Signed-off-by: Daniel Wagner <dwagner@suse.de>
>      Link: https://lore.kernel.org/r/20220627080650.108936-1-sagi@grimberg.me

Yes, this change is reverted now from nvme-cli...
I'm thinking how should we solve the original issue, the only way I can
think of at this moment is a "reconnected" event. Does anyone have an
idea how userspace can do the right thing here without it?
