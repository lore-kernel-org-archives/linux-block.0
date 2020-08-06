Return-Path: <SRS0=mumx=BQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC86C47425
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90432204FD
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgHFIHF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:07:05 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:3497 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727006AbgHFIER (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 04:04:17 -0400
X-IronPort-AV: E=Sophos;i="5.75,441,1589212800"; 
   d="scan'208";a="97699478"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 06 Aug 2020 16:03:22 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id C32244CE34E9;
        Thu,  6 Aug 2020 16:03:17 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 6 Aug 2020 16:03:18 +0800
Subject: Re: [PATCH] loop: Remove redundant status flag operation
To:     Martijn Coenen <maco@android.com>
CC:     linux-block <linux-block@vger.kernel.org>
References: <1591929831-2397-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <d2a8b662-a99a-104c-b749-c10293f71211@cn.fujitsu.com>
 <CAB0TPYEvfCSCNyBZTB5hMF2AfcV5jLMr0jyxmpjfeyvSwYcwUA@mail.gmail.com>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <933aa74f-4ee8-5e9c-4176-1a888ed7e035@cn.fujitsu.com>
Date:   Thu, 6 Aug 2020 16:03:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAB0TPYEvfCSCNyBZTB5hMF2AfcV5jLMr0jyxmpjfeyvSwYcwUA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: C32244CE34E9.AE661
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Martijn


> Hi Yang,
> 
> Thanks for the patch! I think it's correct, but I wonder whether it's
> confusing to read, especially since the comment says "For flags that
> can't be cleared, use previous values too" - it might not be obvious
> to the reader that ~SETTABLE is a subset of ~CLEARABLE, and they might
> think "well what about the settable flags we just cleared?"
> 
> To be honest I wouldn't mind leaving the code as-is, since it more
> clearly describes what happens, and presumably the compiler will be
> smart enough to optimize this anyway. But if you have other ideas on
> how to remove this line and make things easier to understand, let me
> know.
> 
Thanks for your reply. From code readability, I agree with you and keep 
this code here is better. So ignore this patch.

Best Regards
Yang Xu
> Best,
> Martijn
> 
> On Sat, Aug 1, 2020 at 5:04 AM Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:
>>
>> Hi
>> Ping.
>>
>>> Since ~LOOP_SET_STATUS_SETTABLE_FLAG is always a subset of ~LOOP_SET_STATUS_CLEARABLE_FLAGS
>>> ,remove this redundant flags operation.
>>>
>>> Cc: Martijn Coenen <maco@android.com>
>>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>>> ---
>>>    drivers/block/loop.c | 2 --
>>>    1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>>> index c33bbbf..2a61079 100644
>>> --- a/drivers/block/loop.c
>>> +++ b/drivers/block/loop.c
>>> @@ -1391,8 +1391,6 @@ static int loop_clr_fd(struct loop_device *lo)
>>>
>>>        /* Mask out flags that can't be set using LOOP_SET_STATUS. */
>>>        lo->lo_flags &= LOOP_SET_STATUS_SETTABLE_FLAGS;
>>> -     /* For those flags, use the previous values instead */
>>> -     lo->lo_flags |= prev_lo_flags & ~LOOP_SET_STATUS_SETTABLE_FLAGS;
>>>        /* For flags that can't be cleared, use previous values too */
>>>        lo->lo_flags |= prev_lo_flags & ~LOOP_SET_STATUS_CLEARABLE_FLAGS;
>>>
>>>
>>
>>
> 
> 


