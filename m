Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9825FC433FE
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 07:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 628AD23B26
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 07:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389900AbgLKHO0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Dec 2020 02:14:26 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:60855 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390203AbgLKHON (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Dec 2020 02:14:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UID7YA0_1607670809;
Received: from 30.21.164.54(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UID7YA0_1607670809)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Dec 2020 15:13:29 +0800
Subject: Re: [PATCH 2/2] blk-iocost: Use alloc_percpu_gfp() to simplify the
 code
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1ba7a38d5a6186b1e71432ef424c23ba1904a365.1607591591.git.baolin.wang@linux.alibaba.com>
 <aa518c5b5c7185e660a1c8515c10d9513fe92132.1607591591.git.baolin.wang@linux.alibaba.com>
 <X9Iv/MlqQI00wZRn@mtj.duckdns.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <33480f8a-89a3-3ed9-6fd0-95b2944ccbdd@linux.alibaba.com>
Date:   Fri, 11 Dec 2020 15:13:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <X9Iv/MlqQI00wZRn@mtj.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Tejun,

> Hello,
> 
> On Thu, Dec 10, 2020 at 06:56:45PM +0800, Baolin Wang wrote:
>> Use alloc_percpu_gfp() with __GFP_ZERO flag, which can remove
>> some explicit initialization code.
> 
> __GFP_ZERO is implicit for percpu allocations and local[64]_t's initial
> states aren't guaranteed to be all zeros on different archs.

Thanks for teaching me this, at least I did not get this from the 
local_ops Documentation before. Just out of curiosity, these local[64]_t 
variables are also allocated from budy allocator ultimately, why they 
can not be initialized to zeros on some ARCHs with __GFP_ZERO? Could you 
elaborate on about this restriction? Thanks.

By the way, seems the kyber-iosched has the same issue, since the 
'struct kyber_cpu_latency' also contains an atomic_t variable.

	kqd->cpu_latency = alloc_percpu_gfp(struct kyber_cpu_latency,
					    GFP_KERNEL | __GFP_ZERO);
	if (!kqd->cpu_latency)
		goto err_kqd;
