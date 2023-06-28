Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DFFEB64DD
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 08:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbjF1IWS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 04:22:18 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:41041 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbjF1IOY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 04:14:24 -0400
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-313f0ca48c7so896433f8f.0
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2023 01:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940063; x=1690532063;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yhf+D93t2hF5TyQymxDCyCJ2/QdID6WD7JzdyiVmt8s=;
        b=BUG6d6xYn9wQOCmC2t2of910aJAHr7eysj9r7BYitf1uRhsgYT3tu0Ka8rAITH+y6p
         /jQw4nPCQaIaRaNyNnHlUzEO/JP6bYMkUewQSZvULFB6RW8obTYv0tGiPl0fOeVh9Noq
         sN92KSfw6+au2t9jMrkKGf5g+uY8S29QqzvKdkcDkrixerWGwxeuAAp4iRcI/yEE1Jbd
         I6OjmFsSwat82uGvrroEjtXh/2CeXKIMInxUJok5cSchxpS5MyXKW5q5RFd8dfXFrcgH
         41cm9f+j1R1G9F16k5V5FmQU8aLLg6aD3ebndEQ/oiX0x0RabSbK6o1IQCN7aPa/btkV
         6qdw==
X-Gm-Message-State: AC+VfDwYPO5aZZMSoAh0m/vozB+WtopD3ntWDLFF7IEmQTJnES5jeLt0
        M0leNlBd3X2KnvvWQNgpcaE=
X-Google-Smtp-Source: ACHHUZ5R0HhectT5beWOt9I9uEKUEPSmy/YQduSYSGHDvkOnr2U/tjaSRzTDgHU8mjwgRLHaYl1emw==
X-Received: by 2002:adf:f703:0:b0:313:e9da:772c with SMTP id r3-20020adff703000000b00313e9da772cmr7886230wrp.5.1687940062678;
        Wed, 28 Jun 2023 01:14:22 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d638c000000b00313f61889e9sm6590300wru.36.2023.06.28.01.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 01:14:22 -0700 (PDT)
Message-ID: <000e3d0c-0022-c199-1f8d-97e191345197@grimberg.me>
Date:   Wed, 28 Jun 2023 11:14:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Content-Language: en-US
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, Yi Zhang <yi.zhang@redhat.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
References: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
 <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me>
 <8a15d10e-f94b-54b7-b080-1887d9c0bdac@nvidia.com>
 <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com>
 <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com>
 <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
 <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
 <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me>
 <83ef44fb-fcef-4b61-9de1-bc24e3c0f4d2@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <83ef44fb-fcef-4b61-9de1-bc24e3c0f4d2@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>
>>>> Yi,
>>>>
>>>> Do you have hostnqn and hostid files in your /etc/nvme directory?
>>>>
>>>
>>> No, only one discovery.conf there.
>>>
>>> # ls /etc/nvme/
>>> discovery.conf
>>
>> So the hostid is generated every time if it is not passed.
>> We should probably revert the patch and add it back when
>> blktests are passing.
> 
> Seems like the patch is doing exactly what it should do - fix wrong 
> behavior of users that override hostid.
> Can we fix the tests instead ?

Right, I got confused between a provided host and the default host...

I think we need to add check that /etc/nvme/[hostnqn,hostid] exist
in the test cases.
