Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33880 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbeBWGM3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Feb 2018 01:12:29 -0500
Received: by mail-lf0-f66.google.com with SMTP id l191so10804303lfe.1
        for <linux-block@vger.kernel.org>; Thu, 22 Feb 2018 22:12:28 -0800 (PST)
Subject: Re: [PATCH] lightnvm: fix memory leak in pblk_luns_init
To: Huaicheng Li <huaicheng@cs.uchicago.edu>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180222210147.GA29523@gmail.com>
 <CANr0WEcDSy3YuZ8kaNuB7Z0wFfiV6AwT=bg4W3MNq--2txX2xQ@mail.gmail.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <870ebf31-340a-1673-d4b3-e755dd2be493@lightnvm.io>
Date: Fri, 23 Feb 2018 07:12:26 +0100
MIME-Version: 1.0
In-Reply-To: <CANr0WEcDSy3YuZ8kaNuB7Z0wFfiV6AwT=bg4W3MNq--2txX2xQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/23/2018 12:03 AM, Huaicheng Li wrote:
> Please ignore my previous email as I found the memory is free'ed at
> pblk_init()'s error handling logic.
> Sorry for the interruption.
> 
> On Thu, Feb 22, 2018 at 3:01 PM, Huaicheng Li <huaicheng@cs.uchicago.edu>
> wrote:
> 
>> Signed-off-by: Huaicheng Li <huaicheng@cs.uchicago.edu>
>> ---
>> drivers/lightnvm/pblk-init.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>> index 93d671ca518e..330665d91d8d 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -510,6 +510,7 @@ static int pblk_luns_init(struct pblk *pblk, struct
>> ppa_addr *luns)
>>                  if (ret) {
>>                          while (--i >= 0)
>>                                  kfree(pblk->luns[i].bb_list);
>> +                       kfree(pblk->luns);
>>                          return ret;
>>                  }
>>          }
>> --
>> 2.13.6
>>
>>
> 

No worries. The initialization part is pretty complex due to all the 
data structures being set up. I would love to have a clean 
initialization function, which cleans up after it self. But being able 
to share the "fail" bringup and tear-down code is very helpful and makes 
other parts easier.
