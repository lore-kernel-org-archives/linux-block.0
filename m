Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A52C2BB9A
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 07:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01542388E
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 07:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgLQHyq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 02:54:46 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:44002 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726999AbgLQHyp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 02:54:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UIuR4xQ_1608191639;
Received: from 30.21.164.59(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UIuR4xQ_1608191639)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Dec 2020 15:54:00 +0800
Subject: Re: [PATCH 2/2] blk-iocost: Use alloc_percpu_gfp() to simplify the
 code
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1ba7a38d5a6186b1e71432ef424c23ba1904a365.1607591591.git.baolin.wang@linux.alibaba.com>
 <aa518c5b5c7185e660a1c8515c10d9513fe92132.1607591591.git.baolin.wang@linux.alibaba.com>
 <X9Iv/MlqQI00wZRn@mtj.duckdns.org>
 <33480f8a-89a3-3ed9-6fd0-95b2944ccbdd@linux.alibaba.com>
 <X9ol4gE65kD6qIyh@mtj.duckdns.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <efa9e363-d9fc-354a-da89-59798e6efe79@linux.alibaba.com>
Date:   Thu, 17 Dec 2020 15:53:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <X9ol4gE65kD6qIyh@mtj.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Tejun,

> Hello,
> 
> On Fri, Dec 11, 2020 at 03:13:29PM +0800, Baolin Wang wrote:
>> Thanks for teaching me this, at least I did not get this from the local_ops
>> Documentation before. Just out of curiosity, these local[64]_t variables are
>> also allocated from budy allocator ultimately, why they can not be
>> initialized to zeros on some ARCHs with __GFP_ZERO? Could you elaborate on
>> about this restriction? Thanks.
> 
> * It's highly unlikely but theoretically possible that some arch might need
>    more than raw value to implement local semantics.
> 
> * People might wanna add debug annotations which may require more than just
>    the raw value.

Thanks for your explanation. It will be helpful to add these comments 
for the code in case someone else wants to do the same thing like this 
patch in future. I can send a patch to add these comments if you have no 
objection.

>> By the way, seems the kyber-iosched has the same issue, since the 'struct
>> kyber_cpu_latency' also contains an atomic_t variable.
>>
>> 	kqd->cpu_latency = alloc_percpu_gfp(struct kyber_cpu_latency,
>> 					    GFP_KERNEL | __GFP_ZERO);
>> 	if (!kqd->cpu_latency)
>> 		goto err_kqd;
> 
> Yeah, the lines become blurry when all existing usages are fine with zeroing
> and we do end up needing to clean up those when the need arises (e.g. we
> used to zero some spinlocks too). It's just a better form to stick with
> initializers when they are provided.

OK. Sounds it is worth sending a patch to initialize this structure 
explicitly to keep consistent.
