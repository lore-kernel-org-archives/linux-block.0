Return-Path: <SRS0=Lvn3=OC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358CBC43441
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 08:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F243620820
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 08:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="0pWO5nsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F243620820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408672AbeKWTYf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:24:35 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33043 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393741AbeKWTYf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Nov 2018 14:24:35 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so10010536ljd.0
        for <linux-block@vger.kernel.org>; Fri, 23 Nov 2018 00:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NASO6w8iq0/I+Yv6zcX0VeHitPHQNzrUiLj86Flj2OA=;
        b=0pWO5nsqlD08txvlTGK7K1YqX4D54lItp2XEr6hT+t0AhsLTOzT2K273CDhE7uS6DV
         xQkblEZ+XR5bqaDhOLvd8aGFK2T3mB/fnvBKmguHCTfStSMwwzy+szy4YcSXya7oclph
         pEGnOPhIXSRl08RpoXvUA366EPbtIyUyq+JBhEpm+VTL7lV4qh5jGLqizFqG0+d52aQh
         R08eq9HaAm9I8jUD+/8bsTYPw0cOOw/6zB60BuF3eWrSNc0gekr5LO/bAjSUDrsKpTdh
         J4CWdpfh1qGi/FYbzcSGAdgLxeXnGQHL+BDy9Whosk1ueeEvpNeK1pB8VbGRhlNZEEA4
         TR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NASO6w8iq0/I+Yv6zcX0VeHitPHQNzrUiLj86Flj2OA=;
        b=lVFNkz1z4AVcYf+BrFOdbAefu5X6ro2/QFUWztApwNrlhBVubmuC2OGpTWrcwtLfNS
         MznOQbtuiwjdRxHFofTNc/BzhI4uh2qk02uzOvZI6q6ZJH2EVTT6vlbsE8wDY4vnLqHJ
         6YrdIvMoEW2Hd+OQxmJdzR4/XmHtZsI9qy+MHwy1ma7hUNoUTmKk0jJVbdCP/PhOIShO
         s5c6tQh7wPzaets6d8FoEhR/1LganQVPkCAOUJbejPg2PZ0QpOFHbPOCn9XkpnXRQRR3
         EWR+kqCGesr63pQ0Nf8aoltmyoCJ4GnScT50+KpXLB2DZHOn398x9hbC7cGQ7BqA/oSB
         9L1w==
X-Gm-Message-State: AGRZ1gJl6jswtn8Jxyc+d1jr+6GjPBE/+qguRU5Thlp4K1xVRQB0AL4/
        l7Wgqh/Fd9Cr+FhoMxwoXFWiJw==
X-Google-Smtp-Source: AFSGD/W+lWGL9VpIq1mSk9TAqZjJfBtsI8PKfEvRAIWhfqoK0Uy9qMrVm0z4ejd/GHvLNEcEwkeTqA==
X-Received: by 2002:a2e:117:: with SMTP id 23-v6mr9019978ljb.131.1542962477066;
        Fri, 23 Nov 2018 00:41:17 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id x18-v6sm8489635lji.27.2018.11.23.00.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 00:41:16 -0800 (PST)
Subject: Re: lightnvm: pblk: avoid ref warning on cache creation
To:     javier@cnexlabs.com
Cc:     javier@javigon.com, hans.holmberg@cnexlabs.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1542894410-14047-1-git-send-email-javier@cnexlabs.com>
 <2ef4bc58-98cf-fdfc-195d-d6f88e85f4a6@lightnvm.io>
 <2D1F9096-EFF8-43C2-8403-9897B3D36409@cnexlabs.com>
 <cfcc4dee-c07f-156f-4523-1bda9c878b02@lightnvm.io>
 <2A862095-B029-4CBF-A67D-74D8704F5137@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <7c4344a3-d3d2-1e91-9683-a2ee735c341a@lightnvm.io>
Date:   Fri, 23 Nov 2018 09:41:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2A862095-B029-4CBF-A67D-74D8704F5137@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/2018 09:31 AM, Javier Gonzalez wrote:
> 
> 
>> On 23 Nov 2018, at 09.24, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 11/23/2018 09:16 AM, Javier Gonzalez wrote:
>>>> On 23 Nov 2018, at 09.14, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>
>>>>> On 11/22/2018 02:46 PM, Javier González wrote:
>>>>> Matias,
>>>>> Can you pick this up for 4.20? Even though it is not an error per se, it
>>>>> does trigger an ugly false positive warning when CONFIG_REFCOUNT_FULL is
>>>>> set.
>>>>> Thanks,
>>>>> Javier
>>>>> Javier González (1):
>>>>>    lightnvm: pblk: avoid ref warning on cache creation
>>>>>   drivers/lightnvm/pblk-init.c | 14 +++++---------
>>>>>   1 file changed, 5 insertions(+), 9 deletions(-)
>>>>
>>>> It is too late to get it for 4.20. I'll pull it in for 4.21.
>>> Well, if it is a fix it’s not too late AFAIK. It also applies to a patch picked up in this series. We should have catches this before.
>>> But I guess it’s your call.
>>
>> There is a likelihood that Linus would catch it, with the result of fire & fury. I don't feel like using one of my cat life's for this one.
> 
> I don’t get how a fix in rc3 will result in Jens or Linus complaining. But Ok, let’s release 4.20 with a false positive warning for use-after-free on pblk creation.
> 

It is a warning that would trigger only for kernel developers. The 
REFCOUNT_FULL is used when debugging code, and is usually not on in 
production kernels.

To my understanding, the rc's, are meant for errors that would affect 
end-users.

> 
>>>> We can put on a Fixes: 1864de94ec9d6 "lightnvm: pblk: stop recreating global caches" if you want Greg and friends to pick picked it up for stable kernels?
>>> I didn’t add it as it is not a bug in itself. But it is good to add it. Can you do it.
>>
>> I'll do it.
> 
> Thanks.
> 
> Javier.
> 

