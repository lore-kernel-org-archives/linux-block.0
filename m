Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CF5C433F5
	for <linux-block@archiver.kernel.org>; Mon, 11 Oct 2021 01:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60CAF60F23
	for <linux-block@archiver.kernel.org>; Mon, 11 Oct 2021 01:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhJKBiM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Oct 2021 21:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhJKBiL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Oct 2021 21:38:11 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679E3C06161C
        for <linux-block@vger.kernel.org>; Sun, 10 Oct 2021 18:36:12 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id s17so12699069ioa.13
        for <linux-block@vger.kernel.org>; Sun, 10 Oct 2021 18:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0bn13mcQUloSRmo2eFgDJ5AKWLlTB4WVGCyGBhdHi1I=;
        b=PUNzBLN0rAwEjaoY5DFZoIT6PAnDeq2HrcyPBsBdjDMJ+5ssrFHD6zCyoJc4z/zmj4
         pabBnmBUNZyRRmlPNPgboZ3JjUe66pkK44amXWcghmcZEHu97HCVtC56OR1j2eU1VSB+
         lVO3514+6RCocUyjvUJz3NtmM4cIiPWa2HbvR2JGDBzJ8UTCa+MrbQTVDTQPYK/ZRtKc
         TYfAQOWYsH2BAkU8T5d3Y3ezrTgTjLbZ2rmOaa2lCmNQHH3hjztRWyjnWX27Q7pv6Bx7
         NMalo4tJCCq0xjfYEowhJwjcd66AxppFPmZenfdHINg887eJ32+RYxIEHlglSWOHiBD/
         oR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0bn13mcQUloSRmo2eFgDJ5AKWLlTB4WVGCyGBhdHi1I=;
        b=4Fb8PZsZMx9xwqseIwDTUffR0YajUybqTZrcozmOvj1BVkhFt9fVk5GaVPQVh1DtTD
         pQxLYsc3inNq+YjPXmlxQ9AkyCYzfUKv6mJjccfs628lc1gvmypMNiv3ud7w5pVanxnB
         42jmYmBl3vdINrOa1ARKoTVXSW6CW279DIElX2msImfdd+4tEdp+AJHU16FCfQnHAsYE
         YEJ2Mqjyvq3f0pyvEXAnItVYnmqBGl+Y4wS6DvJerNjzDSQzI2ugSGtjiIV7kA226hlB
         ceIPXCsT3xBR3dy97+jgOl6H7RQoW3sx2s4ypBaoMPvlEorPSW/CyiX89SeV0dhDxvIc
         NikA==
X-Gm-Message-State: AOAM531Uj4bvQ3iaa4+YZwWa1LgRa8Yj13ZNdOrRmtRnNOAQA/09wDjr
        7fDOEgCy/E4aInND9maLyUezSg==
X-Google-Smtp-Source: ABdhPJxeONXJBLUs5vdfEPp0jHJoYSLvOIByQwSY9dL/Y1x8XfIolodZeK4pX3H1ag+3tXak4KjDeA==
X-Received: by 2002:a6b:7107:: with SMTP id q7mr8454iog.63.1633916171678;
        Sun, 10 Oct 2021 18:36:11 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id w23sm3121563iot.30.2021.10.10.18.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 18:36:11 -0700 (PDT)
Subject: Re: [PATCH] cdrom: docs: reformat table in
 Documentation/userspace-api/ioctl/cdrom.rst
To:     Phillip Potter <phil@philpotter.co.uk>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lumip@lumip.de
References: <20211007231720.31997-1-phil@philpotter.co.uk>
 <464a0b2f-c556-ccda-aa3c-26733fba4617@infradead.org>
 <YWOC2Iyszh7WAgzf@equinox>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d9a0177b-f6aa-c03b-0925-9858703d6607@kernel.dk>
Date:   Sun, 10 Oct 2021 19:36:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWOC2Iyszh7WAgzf@equinox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/10/21 6:18 PM, Phillip Potter wrote:
> On Thu, Oct 07, 2021 at 04:34:13PM -0700, Randy Dunlap wrote:
>> On 10/7/21 4:17 PM, Phillip Potter wrote:
>>> Add extra space to the first column of ioctl values table, and also realign
>>> the text in the second column, to fix a documentation build warning
>>> introduced by: commit 67f1e027c270 ("drivers/cdrom: improved ioctl for
>>> media change detection")
>>>
>>> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
>>> Fixes: 67f1e027c270 ("drivers/cdrom: improved ioctl for media change detection")
>>> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
>>
>> Looks good. Thanks.
>>
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>>
>>
>>> ---
>>>   Documentation/userspace-api/ioctl/cdrom.rst | 116 ++++++++++----------
>>>   1 file changed, 58 insertions(+), 58 deletions(-)
>>>
>>> diff --git a/Documentation/userspace-api/ioctl/cdrom.rst b/Documentation/userspace-api/ioctl/cdrom.rst
>>> index bac5bbf93ca0..682948fc88a3 100644
>>> --- a/Documentation/userspace-api/ioctl/cdrom.rst
>>> +++ b/Documentation/userspace-api/ioctl/cdrom.rst
>>
>>
>>
>> -- 
>> ~Randy
> 
> Thank you for the review Randy.

Applied.

-- 
Jens Axboe

