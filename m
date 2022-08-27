Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D56C0502A
	for <linux-block@archiver.kernel.org>; Sat, 27 Aug 2022 13:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiH0NLD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Aug 2022 09:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiH0NLD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Aug 2022 09:11:03 -0400
Received: from out199-4.us.a.mail.aliyun.com (out199-4.us.a.mail.aliyun.com [47.90.199.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1774C61C;
        Sat, 27 Aug 2022 06:10:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VNO2NEf_1661605851;
Received: from 30.39.65.74(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VNO2NEf_1661605851)
          by smtp.aliyun-inc.com;
          Sat, 27 Aug 2022 21:10:52 +0800
Message-ID: <84ad96a6-2dcd-2a5d-f526-74484324ee79@linux.alibaba.com>
Date:   Sat, 27 Aug 2022 21:10:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: [PATCH] blk-mq: determine in advance whether batch alloc can be
 performed
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1661477190-86862-1-git-send-email-liusong@linux.alibaba.com>
 <4fff9af8-90c3-86f9-37c7-75dcd3e95dc0@kernel.dk>
From:   Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <4fff9af8-90c3-86f9-37c7-75dcd3e95dc0@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2022/8/26 21:33, Jens Axboe wrote:
> On 8/25/22 7:26 PM, Liu Song wrote:
>> From: Liu Song <liusong@linux.alibaba.com>
>>
>> Some conditions for judging whether batch alloc can be performed are
>> included in "blk_mq_get_tags", and this function is only used by
>> "__blk_mq_alloc_requests_batch".
>>
>> This patch introduced a helper "can_do_batch_alloc" to prepend the
>> judgment condition and avoid unnecessary function calls.
> Curious if you saw any differences from this? Or do you just consider
> it a cleanup?
>
Hi

This patch aggregates the judgment conditions for whether batch alloc 
can be used,
which can be considered as clean up.

If it can be determined at the first judgment that batch alloc cannot be 
used, the
overhead of calling "blk_mq_get_tags" once will be reduced, are some 
differences.


Thanks

