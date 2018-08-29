Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44644 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2WJl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 18:09:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so2620738pff.11
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 11:11:37 -0700 (PDT)
Subject: Re: [PATCH 0/4] lightnvm: pblk: collection of small fixes
To: javier@cnexlabs.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
 <5b8881cd-019a-a1d8-86ed-0131ef3b71af@lightnvm.io>
 <3F0AC430-4499-4D2D-B989-45B5635307A4@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <115fa3ea-c53b-557f-9465-5f61a02efa49@lightnvm.io>
Date: Wed, 29 Aug 2018 20:11:31 +0200
MIME-Version: 1.0
In-Reply-To: <3F0AC430-4499-4D2D-B989-45B5635307A4@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/29/2018 03:27 PM, Javier Gonzalez wrote:
> 
>> On 29 Aug 2018, at 15.14, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 08/29/2018 11:01 AM, Javier González wrote:
>>> Collection of small helper function fixes, removal of unused variables
>>> and comment typos.
>>> Javier González (4):
>>>    lightnvm: pblk: calculate line pad distance in helper
>>>    lightnvm: pblk: fix comment typo
>>>    lightnvm: pblk: remove unused variable.
>>>    lightnvm: pblk: guarantee emeta on line close
>>>   drivers/lightnvm/pblk-core.c     | 13 +++++++++++--
>>>   drivers/lightnvm/pblk-recovery.c |  2 --
>>>   drivers/lightnvm/pblk-write.c    |  2 +-
>>>   drivers/lightnvm/pblk.h          |  6 +++---
>>>   4 files changed, 15 insertions(+), 8 deletions(-)
>>
>> Thanks. Applied 2-4. The pad distance does not compile due to missing
>> update to pblk_pad_distance call from pblk-recovery.c.
>>
>> Also, it looks like pblk-recovery.c is the only user. Please consider
>> moving it the function from pblk.h to pblk-recovery.c
> 
> I reordered to send the helpers, but you can see that all these are made
> to support.
> 
>    lightnvm: pblk: recover open lines on 2.0 devices
> 
> Can you fix this directly and apply 1 too? I'm fine with moving it to
> pblk-recovery.c. The patch above will use it.
> 

Yes. I've fixed it up in pblk-recovery.c, and also moved the function to 
pblk-recovery.c. Applied for 4.20.
