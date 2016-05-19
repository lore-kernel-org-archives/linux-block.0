Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:34073 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753433AbcESPRx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Thu, 19 May 2016 11:17:53 -0400
MIME-Version: 1.0
In-Reply-To: <573DB43F.2070303@lightnvm.io>
References: <1463639921-1824-1-git-send-email-wwtao0320@163.com>
	<573DB43F.2070303@lightnvm.io>
Date: Thu, 19 May 2016 23:17:52 +0800
Message-ID: <CACygaLAL-gWw3XA5DaAC5xcRB=7CmmHHtgi4+gbS=E-2mWmZaQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] lightnvm: break the loop when rqd is not null
From: Wenwei Tao <ww.tao0320@gmail.com>
To: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc: Wenwei Tao <wwtao0320@163.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

That is okay with me.

2016-05-19 20:40 GMT+08:00 Matias Bjørling <mb@lightnvm.io>:
> On 05/19/2016 08:38 AM, Wenwei Tao wrote:
>>
>> From: Wenwei Tao <ww.tao0320@gmail.com>
>>
>> Break the loop when rqd is not null to reduce
>> unnecessary schedule.
>>
>> Signed-off-by: Wenwei Tao <ww.tao0320@gmail.com>
>> ---
>>   drivers/lightnvm/rrpc.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
>> index 2103e97..2915e39 100644
>> --- a/drivers/lightnvm/rrpc.c
>> +++ b/drivers/lightnvm/rrpc.c
>> @@ -98,6 +98,9 @@ static void rrpc_discard(struct rrpc *rrpc, struct bio
>> *bio)
>>
>>         do {
>>                 rqd = rrpc_inflight_laddr_acquire(rrpc, slba, len);
>> +               if (rqd)
>> +                       break;
>> +
>>                 schedule();
>>         } while (!rqd);
>>
>>
>
> If that case, mind if I convert the do..while to while?
>
> while(1) {
>         rqd = rrpc_inflight_laddr_acquire(rrpc, slba, len);
>         if (rqd)
>                 break;
>         schedule();
> }
