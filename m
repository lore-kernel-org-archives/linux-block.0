Return-Path: <SRS0=rrL6=BA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06BEC433E0
	for <linux-block@archiver.kernel.org>; Tue, 21 Jul 2020 01:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B61602072E
	for <linux-block@archiver.kernel.org>; Tue, 21 Jul 2020 01:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgGUBxm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:53:42 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:56840 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbgGUBxl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 21:53:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0U3MI5C7_1595296418;
Received: from ali-186590e05fa3.local(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0U3MI5C7_1595296418)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jul 2020 09:53:38 +0800
Subject: Re: [PATCH v2] block: delete unused Kconfig
To:     Jens Axboe <axboe@kernel.dk>, tj@kernel.org
Cc:     linux-block@vger.kernel.org
References: <1595233988-28342-1-git-send-email-jiufei.xue@linux.alibaba.com>
 <c889122c-890e-405b-8f93-0affd2882c6b@kernel.dk>
 <f24171eb-b1f8-746d-d379-4478ebe9ad70@linux.alibaba.com>
 <87ab9c56-74a7-8874-6373-453970a89b7f@kernel.dk>
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
Message-ID: <1d2dc1b4-4b62-15b0-750d-abd25d75370f@linux.alibaba.com>
Date:   Tue, 21 Jul 2020 09:53:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87ab9c56-74a7-8874-6373-453970a89b7f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/7/21 上午9:51, Jens Axboe wrote:
> On 7/20/20 7:50 PM, Jiufei Xue wrote:
>>
>>
>> On 2020/7/20 下午11:49, Jens Axboe wrote:
>>> On 7/20/20 2:33 AM, Jiufei Xue wrote:
>>>> Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
>>>> ---
>>>>  block/Kconfig | 1 -
>>>>  1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/block/Kconfig b/block/Kconfig
>>>> index 9357d73..d52c9bc 100644
>>>> --- a/block/Kconfig
>>>> +++ b/block/Kconfig
>>>> @@ -146,7 +146,6 @@ config BLK_CGROUP_IOLATENCY
>>>>  config BLK_CGROUP_IOCOST
>>>>  	bool "Enable support for cost model based cgroup IO controller"
>>>>  	depends on BLK_CGROUP=y
>>>> -	select BLK_RQ_IO_DATA_LEN
>>>>  	select BLK_RQ_ALLOC_TIME
>>>>  	help
>>>>  	Enabling this option enables the .weight interface for cost
>>>
>>> What's the difference between v1 and v2? A commit message would
>>> also be nice...
>>> Sorry for the confusion. I have misspelled *unused* in patch v1.
> 
> Ah I see. Can you send a v3 that has a simple commit message at least?
> 
Of course. I will send v3 soon.
