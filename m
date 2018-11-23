Return-Path: <SRS0=Lvn3=OC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F1FC43441
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 08:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9198220645
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 08:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="OO/CxISE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9198220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408516AbeKWTHM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:07:12 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:44801 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731828AbeKWTHL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Nov 2018 14:07:11 -0500
Received: by mail-lj1-f177.google.com with SMTP id k19-v6so9921602lji.11
        for <linux-block@vger.kernel.org>; Fri, 23 Nov 2018 00:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HIfelMlnLBH4z2Mnp8iWztGi0Pyq+RYmCWqVegN7yz8=;
        b=OO/CxISEAHwYLusZ2lqc/VFIueoLBZbA2HaFbm4YzdF3wuB33DYzS408OoiKVCwv4v
         cBwilKqIyIEV8u8O6mUatX6I5ssUy39WBx1whNpoZJB0LyXOpCikuNCINEFuAoz8xG90
         3k8rRIFC2aS21rYYA3c1fk5KGlZcggkfDl3+B4/8bY9CMAXAzkqzeu6MuU1MenJ6D5XG
         H37CT16aGTUA/Uo4Brj6ZH3nFMNIdvIwOHut/xZ+3Xdvv5uNnR9GcyEj9siLgWhOG2Qe
         AwxnT1iHa0Y2RHd4g+0hFdkLZ82MND3VYa/WFxwtdmYgjLBGtDuTdKr5fd4k9tEDNKAM
         /Uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HIfelMlnLBH4z2Mnp8iWztGi0Pyq+RYmCWqVegN7yz8=;
        b=djM8GQSIxU8l1oISzBoyI7RAEyMCWXgdOdZv9++evGAEidmQfowknCeVDUNvulvHi+
         B2pNjdvyHivm1+KRaoN69oTmCZikD9UcSXysQpokh2Zw7fNkVMZ2DjL6N9F8YFMyjhyc
         cs10WsfnarMviyiYNddfJiCJzjc0Nl3fjhW+bny1SKIy+Lbi6FQWqddoW9/1XFoepB14
         1bpi3h16JP3pMj9H2llI+7OnoSx0aHataofTaj2MboQsV9t6CadDi8ATdS2ifiZDHGFs
         APXqgM1L9fHQUxIQYCbCxILU6JYJ3N0lF4Qghjk/o40Qqf/stYPmWLiGuGOSmJtRuAjB
         J0Sw==
X-Gm-Message-State: AA+aEWb/azAf/2c5hfLbRmVR3HXvC8rjc5wkYBXDDI8nBsnhagSA7pUq
        Hm8yO/kL7MRGU8V1j40Voektpw==
X-Google-Smtp-Source: AFSGD/WqEVkH1SQf76yKO5VFAGOE8gTG0gdPdMmgUDqPzmYxzqGhCHxDnhaZkTCRdbaYNb+VhGUmzw==
X-Received: by 2002:a2e:8007:: with SMTP id j7-v6mr5605266ljg.22.1542961437653;
        Fri, 23 Nov 2018 00:23:57 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id k63sm6706233lfe.13.2018.11.23.00.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 00:23:57 -0800 (PST)
Subject: Re: lightnvm: pblk: avoid ref warning on cache creation
To:     javier@cnexlabs.com
Cc:     javier@javigon.com, hans.holmberg@cnexlabs.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1542894410-14047-1-git-send-email-javier@cnexlabs.com>
 <2ef4bc58-98cf-fdfc-195d-d6f88e85f4a6@lightnvm.io>
 <2D1F9096-EFF8-43C2-8403-9897B3D36409@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <cfcc4dee-c07f-156f-4523-1bda9c878b02@lightnvm.io>
Date:   Fri, 23 Nov 2018 09:23:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2D1F9096-EFF8-43C2-8403-9897B3D36409@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/2018 09:16 AM, Javier Gonzalez wrote:
> 
> 
>> On 23 Nov 2018, at 09.14, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>>> On 11/22/2018 02:46 PM, Javier González wrote:
>>> Matias,
>>> Can you pick this up for 4.20? Even though it is not an error per se, it
>>> does trigger an ugly false positive warning when CONFIG_REFCOUNT_FULL is
>>> set.
>>> Thanks,
>>> Javier
>>> Javier González (1):
>>>    lightnvm: pblk: avoid ref warning on cache creation
>>>   drivers/lightnvm/pblk-init.c | 14 +++++---------
>>>   1 file changed, 5 insertions(+), 9 deletions(-)
>>
>> It is too late to get it for 4.20. I'll pull it in for 4.21.
> 
> Well, if it is a fix it’s not too late AFAIK. It also applies to a patch picked up in this series. We should have catches this before.
> 
> But I guess it’s your call.

There is a likelihood that Linus would catch it, with the result of fire 
& fury. I don't feel like using one of my cat life's for this one.

> 
>>
>> We can put on a Fixes: 1864de94ec9d6 "lightnvm: pblk: stop recreating global caches" if you want Greg and friends to pick picked it up for stable kernels?
> 
> I didn’t add it as it is not a bug in itself. But it is good to add it. Can you do it.
> 

I'll do it.

> Javier.
> 

