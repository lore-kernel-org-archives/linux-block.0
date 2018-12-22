Return-Path: <SRS0=4yxV=O7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AC4C43387
	for <linux-block@archiver.kernel.org>; Sat, 22 Dec 2018 19:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BAA72196E
	for <linux-block@archiver.kernel.org>; Sat, 22 Dec 2018 19:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389719AbeLVTVi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Dec 2018 14:21:38 -0500
Received: from gateway33.websitewelcome.com ([192.185.145.87]:18084 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730527AbeLVTVi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Dec 2018 14:21:38 -0500
X-Greylist: delayed 1209 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Dec 2018 14:21:38 EST
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 34FE0D847D1
        for <linux-block@vger.kernel.org>; Sat, 22 Dec 2018 13:01:29 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id amWfg4NGG2PzOamWfgnlM0; Sat, 22 Dec 2018 13:01:29 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=38056 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gamWM-003ck2-Qy; Sat, 22 Dec 2018 13:01:28 -0600
Subject: Re: [PATCH] lightnvm: pblk: fix use-after-free bug
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        Igor Konopko <igor.j.konopko@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181222073952.GA11561@embeddedor>
 <1992ea52-cc13-c704-4653-7fbe667b1c5a@lightnvm.io>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <b25d175f-ec2d-5906-bd90-68c12c2c975d@embeddedor.com>
Date:   Sat, 22 Dec 2018 13:01:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1992ea52-cc13-c704-4653-7fbe667b1c5a@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1gamWM-003ck2-Qy
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.106.44]:38056
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/22/18 12:30 PM, Matias Bjørling wrote:
> On 12/22/18 8:39 AM, Gustavo A. R. Silva wrote:
>> Remove one of the calls to function bio_put(), so *bio* is only
>> freed once.
>>
>> Notice that bio is being dereferenced in bio_put(), hence leading to
>> a use-after-free bug once *bio* has already been freed.
>>
>> Addresses-Coverity-ID: 1475952 ("Use after free")
>> Fixes: 55d8ec35398e ("lightnvm: pblk: support packed metadata")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/lightnvm/pblk-recovery.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/lightnvm/pblk-recovery.c 
>> b/drivers/lightnvm/pblk-recovery.c
>> index 3fcf062d752c..5ee20da7bdb3 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -418,7 +418,6 @@ static int pblk_recov_scan_oob(struct pblk *pblk, 
>> struct pblk_line *line,
>>       if (ret) {
>>           pblk_err(pblk, "I/O submission failed: %d\n", ret);
>>           bio_put(bio);
>> -        bio_put(bio);
>>           return ret;
>>       }
>>
> 
> Thanks Gustavo. I missed that one.
> 
> Jens, if possible could you please pick this up?
> 
> Happy holidays!
> 

Glad to help. :)

Happy holidays everybody.

--
Gustavo
