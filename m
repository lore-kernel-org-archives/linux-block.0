Return-Path: <SRS0=hIdE=WV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D03C3A5A1
	for <linux-block@archiver.kernel.org>; Sun, 25 Aug 2019 12:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127692082F
	for <linux-block@archiver.kernel.org>; Sun, 25 Aug 2019 12:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=manuel-bentele.de header.i=@manuel-bentele.de header.b="QkQMNzqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfHYMPm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Aug 2019 08:15:42 -0400
Received: from host1.nc.manuel-bentele.de ([92.60.37.180]:52518 "EHLO
        host1.nc.manuel-bentele.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726511AbfHYMPl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Aug 2019 08:15:41 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: development@manuel-bentele.de)
        by host1.nc.manuel-bentele.de (Postcow) with ESMTPSA id 5E75A61067;
        Sun, 25 Aug 2019 14:15:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manuel-bentele.de;
        s=dkim; t=1566735338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HbdX2ZYe/J5bWwU7i8UbIpAl5I/wpsu4mjkkGTh42U8=;
        b=QkQMNzqHGhK4CXR1cUxU5u1m10gTdCkI1n0+LE4VBiXSvTt5MCtVCvktpt+X1XAU7FY+cn
        ASt1JfiAxFe0YaUQ4IuR+SK8HIIS1oRnS3uDvDJKlrwSBb5xjVqVxRES7abgsT4qkp9Mqc
        ilHOBB88sBuoi+TpigjJtD9KmbxMWhkmDzxhXKrMOFyw3CodnkOTKwCr56mss5BrKbgRzD
        +rSNi0mvwQOUlr4mEplJdUhilH47aScLnaiDAv4ZrhqLgNq6+GO7+0bPw/+Zf/conOjNBZ
        uimWvZuZCM0Dts1CA7BJazmrflsIwlEBCIycd7UMZOn0ZCq5eMD30i4eRKauDA==
From:   Manuel Bentele <development@manuel-bentele.de>
Subject: Re: [PATCH 0/5] block: loop: add file format subsystem and QCOW2 file
 format driver
To:     Bart Van Assche <bvanassche@acm.org>,
        Manuel Bentele <manuel-bentele@web.de>,
        linux-block@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20190823225619.15530-1-development@manuel-bentele.de>
 <da0a76ae-0627-24b8-1aa5-62463e8b3759@acm.org>
 <4cc02259-24c0-0858-5439-5b1b0649d4f2@web.de>
 <48618bb6-45c5-34c7-2a9a-1a6ddf828e8c@acm.org>
Message-ID: <ac915b98-9c4e-1f5e-70d8-258e2f6ef7ba@manuel-bentele.de>
Date:   Sun, 25 Aug 2019 14:15:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <48618bb6-45c5-34c7-2a9a-1a6ddf828e8c@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manuel-bentele.de; s=dkim; t=1566735338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HbdX2ZYe/J5bWwU7i8UbIpAl5I/wpsu4mjkkGTh42U8=;
        b=BbCRh9c55Imhx9mvKUivqpBwYHyXuSkWTyE2jKLOFbOYLczw0U6Q0yrlbGM8fCvOAaLQS2
        6lSyUPX+HzsZ6I9Z0/sDwDG53d9tVOdDem2s1jKJ6quqK1hQoSLREVzGATfnGg5+pGgZvu
        +U24RLz1NOh41FV2ih7Ti1BzVS9og4xhwX+riuBVKHZf6S6YheI/8g7+uT5TBkdSQCEK4K
        8Sb90Wsv0R5+5t3b4aMJuwJFh79ubr5K35vPUUycmzX4Hc7mXKJCz9T28nJ1fftM+zzEhz
        eC9w1MgZkVZopos5mCClJ7q7OZqIOeXz+WRTxibUtXy1qVbcG9nKFkmm+qmOnQ==
ARC-Seal: i=1; s=dkim; d=manuel-bentele.de; t=1566735338; a=rsa-sha256;
        cv=none;
        b=V7O8A/HBWixrJZb1UU4kVG9hUGAJlnkVi+YfI2y5ZsctiygmNqy7a3l7fG8Nu29Gdb2t5x
        yJHTx8IpJ++Mw0GKWXVhuAMo2kfFwzvoLIFEB9vH65hlNeIuswDp+zdHqTLmyo3U3x1Zzc
        KEx7PePY0OK0jv9OKRd4EmhQ2bmMLVo4FJzimjoM4cBW5ftSYbC67FT1jL7NU9lYwEnvER
        EInpv7j6UzUnKzb/016KGzjhj0JR2HDqUBPK/b8q+7euaZgOECBbXN2uwz20PR9MZnIchy
        4GEQ2bwYdnak/1ouwAp67z0ZcAAQ74wVBlTVH3AFfFap0sz+Gor+3RuQvbcefw==
ARC-Authentication-Results: i=1;
        host1.nc.manuel-bentele.de;
        auth=pass smtp.auth=development@manuel-bentele.de smtp.mailfrom=development@manuel-bentele.de
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/24/19 6:04 PM, Bart Van Assche wrote:
> On 8/24/19 2:14 AM, Manuel Bentele wrote:
>> On 8/24/19 5:37 AM, Bart Van Assche wrote:
>>> On 8/23/19 3:56 PM, development@manuel-bentele.de wrote:
>>>> During the discussion, it turned out that the implementation as device
>>>> mapper target is not applicable. The device mapper stacks different
>>>> functionality such as compression or encryption on multiple block
>>>> device
>>>> layers whereas an implementation for the QCOW2 container format
>>>> provides
>>>> these functionalities on one block device layer.
>>>
>>> Is there a more detailed discussion available of this subject?
> >
>> No, the only discussion is the referenced one [1]. But there was a
>> similar discussion in the master's thesis of Francesc Zacarias Ribot
>> [2]. Unfortunately, I found no attempt on the mailing list that proposes
>> his solution.
>>
>>> Are you familiar with the dm-crypt driver?
> >
>> I don't know the specific implementation details, but I use this driver
>> personally and I like it. Do you want to propose that only the storage
>> aspect of the QCOW2 container format should be used and all other
>> functionality inside the container should be provided by available
>> device mapper targets?
>
> (+Mike Snitzer)
>
> Hmm, I haven't found any reference to the device mapper in the
> document written by Francesc. Maybe that means that I overlooked
> something?
Oh sorry, you're right. I meant this in general for the topic 'QCOW2 in
the kernel space'.

> I referred to the dm-crypt driver because I think that's an example
> that shows that QCOW2 file format support could be implemented using
> the device mapper framework.
Okay, now I get it :)

> Mike, do you perhaps want to comment on what the most appropriate way
> is to implement such functionality?

To implement the QCOW2 format or other sparse container formats
correctly, the implementation must be able to ...
  - extend the capacity of the mapped block device
  - shrink the capacity of the mapped block device
  - rescan the paritions of the mapped block device

Are all three functionalities feasible using the device mapper framework?

> The entire patch series is available at
> https://lore.kernel.org/linux-block/86279379-32ac-15e9-2f91-68ce9c94cfbf@manuel-bentele.de/T/#t.

Note that PATCH [1/5] is missing in this series, although I've submitted
it twice. I asked already in [1] for the reason but haven't received any
answer, yet. Therefore, I temporarily insert a link to my repository
showing the missing PATCH [1/5]:
https://github.com/bahnwaerter/linux/commit/7a78da744b4c84809ad6aa20673a2b686bafb201

Regards,
Manuel

[1] https://www.spinics.net/lists/linux-block/msg44255.html

