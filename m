Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D654C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 16:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442E7218A2
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 16:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfC2QoP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:44:15 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:46076 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbfC2QoP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 12:44:15 -0400
Received: from tux.wizards.de (pD9EBF050.dip0.t-ipconnect.de [217.235.240.80])
        by mail02.iobjects.de (Postfix) with ESMTPSA id 7FD264164E66;
        Fri, 29 Mar 2019 17:44:13 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id 4D335F01606;
        Fri, 29 Mar 2019 17:44:13 +0100 (CET)
Subject: Re: [PATCH] block/bfq: fix ifdef for CONFIG_BFQ_GROUP_IOSCHED=y
To:     Jens Axboe <axboe@kernel.dk>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-kernel@vger.kernel.org
References: <155386807826.3190.16175453392005064129.stgit@buzz>
 <c40b8d4a-c504-fdf4-0b96-64aaeb167435@applied-asynchrony.com>
 <5234a971-2b6a-47b1-0071-8f3bd07d9fc3@kernel.dk>
 <cf0dc6b2-6ecf-c895-6c21-8746700bdae4@applied-asynchrony.com>
 <6be15f08-dbb4-6b43-3d95-44044f1acdbc@kernel.dk>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <3c87a84f-9fb2-2407-a5a3-723b314d8e58@applied-asynchrony.com>
Date:   Fri, 29 Mar 2019 17:44:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6be15f08-dbb4-6b43-3d95-44044f1acdbc@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/19 5:15 PM, Jens Axboe wrote:
>>>> Good catch! I run without group scheduling and therefore didn't notice these
>>>> stray defines earlier. For 5.1 it should merge cleanly; adding this on top of
>>>> the pending 5.2 BFQ patches required a small context fixup in hunk #1 due to
>>>> "block, bfq: do not idle for lowest-weight queues".
>>>
>>> I'm hesitant to apply this, since the group scheduling stuff has obviously never
>>> been tested.
>>
>> This is simply a regression in 5.1 caused by 73d58118498b - nothing else,
>> and as such this fix needs to go into 5.1 as well. I'm sure Paolo will agree.
>> What you so ominously  call "the group scheduling stuff" has been there and
>> shipping in mainline since day 1 of the BFQ merge, and it works fine in 5.0.
> 
> If that's the case (I didn't check how far back it went), then yes, it should
> of course go into 5.1.

Yay.

> The ominous nature of my reply I'll chalk up to your interpretation

Fair enough ;)

A more interesting question is why upstream uses undefined defines
for patches. That's a first-rate self-grenade if I've ever seen one,
and obviously something that is easily missed. Paolo?

-h
