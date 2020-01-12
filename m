Return-Path: <SRS0=6DrF=3B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E650C32771
	for <linux-block@archiver.kernel.org>; Sun, 12 Jan 2020 08:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8A02064C
	for <linux-block@archiver.kernel.org>; Sun, 12 Jan 2020 08:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbgALIVy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Jan 2020 03:21:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9159 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732382AbgALIVy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Jan 2020 03:21:54 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3DE98A866C941A8F4783;
        Sun, 12 Jan 2020 16:21:50 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Sun, 12 Jan 2020
 16:21:43 +0800
Subject: Re: [PATCH] kdev_t: mask mi with MINORMASK in MKDEV macro
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <dhowells@redhat.com>,
        <akpm@linux-foundation.org>, <torvalds@linux-foundation.org>
CC:     <bywxiaobai@163.com>, Mingfangsen <mingfangsen@huawei.com>,
        Guiyao <guiyao@huawei.com>, zhangsaisai <zhangsaisai@huawei.com>,
        renxudong <renxudong1@huawei.com>
References: <5d384dcb-5590-60f8-a4e1-efa6b8da151f@huawei.com>
 <d890c06e-5b56-629a-2e9f-bc19209238e4@acm.org>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <ec7bb0e3-3064-81a9-0cf2-844f61073f4f@huawei.com>
Date:   Sun, 12 Jan 2020 16:21:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d890c06e-5b56-629a-2e9f-bc19209238e4@acm.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/1/11 12:50, Bart Van Assche wrote:
> On 2020-01-09 22:37, Zhiqiang Liu wrote:
>>
>> In MKDEV macro, if mi is larger than MINORMASK, the major will be
>> affected by mi. For example, set dev = MKDEV(2, (1U << MINORBITS)),
>> then MAJOR(dev) will be equal to 3, incorrectly.
>>
>> Here, we mask mi with MINORMASK in MKDEV macro.
>>
>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>> ---
>>  include/linux/kdev_t.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/kdev_t.h b/include/linux/kdev_t.h
>> index 85b5151911cf..40a9423720b2 100644
>> --- a/include/linux/kdev_t.h
>> +++ b/include/linux/kdev_t.h
>> @@ -9,7 +9,7 @@
>>
>>  #define MAJOR(dev)	((unsigned int) ((dev) >> MINORBITS))
>>  #define MINOR(dev)	((unsigned int) ((dev) & MINORMASK))
>> -#define MKDEV(ma,mi)	(((ma) << MINORBITS) | (mi))
>> +#define MKDEV(ma, mi)	(((ma) << MINORBITS) | ((mi) & MINORMASK))
>>
>>  #define print_dev_t(buffer, dev)					\
>>  	sprintf((buffer), "%u:%u\n", MAJOR(dev), MINOR(dev))
> 
> Shouldn't the users of MKDEV() be fixed instead of changing the MKDEV()
> definition?
> 
> Thanks,
> 
> Bart.
Thanks for your reply.
I think that your opinion is much better. Users of MKDEV() should
make sure that the mi is not larger than MINORMASK. If we mask mi with
MINORMASK in MKDEV(), ma will be not affected by mi. But, the result
may be not the expected value of users.

So, please ignore the patch.


> 
> 
> 

