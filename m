Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D66C433F5
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 02:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 390EB610A0
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 02:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhIVCTv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 22:19:51 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:45765 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229943AbhIVCTv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 22:19:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UpB2D-U_1632277099;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UpB2D-U_1632277099)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Sep 2021 10:18:20 +0800
Subject: Re: [PATCH] block/mq-deadline: Fix unused-function compilation
 warning
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210901064705.55071-1-tianjia.zhang@linux.alibaba.com>
 <90507369-7beb-5337-5bb3-f5e2798dee2f@linux.alibaba.com>
 <c204fbcc-7d38-229a-772a-556333aed120@acm.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <151338f1-3271-6a58-6b30-93f36e2cad06@linux.alibaba.com>
Date:   Wed, 22 Sep 2021 10:18:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c204fbcc-7d38-229a-772a-556333aed120@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 9/19/21 6:22 AM, Bart Van Assche wrote:
> On 9/17/21 19:23, Tianjia Zhang wrote:
>> ping.
> 
> Please check Linus' master branch and Jens' for-next branch before posting
> block layer patches. This patch looks like a duplicate of patch
> https://lore.kernel.org/r/20210830091128.1854266-1-geert@linux-m68k.org,
> applied as commit 55a51ea14094a1e7dd0d7f33237d246033dd39ab.
> 
> Bart.

Sorry, please ignore this patch.

Best regards,
Tianjia
