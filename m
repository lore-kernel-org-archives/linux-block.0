Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B786DECAAD4
	for <linux-block@archiver.kernel.org>; Wed, 31 Aug 2022 01:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiHaBWJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 21:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiHaBWH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 21:22:07 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54E8AC248;
        Tue, 30 Aug 2022 18:22:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VNo9SP._1661908923;
Received: from 30.227.181.248(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VNo9SP._1661908923)
          by smtp.aliyun-inc.com;
          Wed, 31 Aug 2022 09:22:04 +0800
Message-ID: <f13bd1a1-831a-0748-c30f-a7ae8bb91523@linux.alibaba.com>
Date:   Wed, 31 Aug 2022 09:22:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: [RFC PATCH] blk-mq: change bio_set_ioprio to inline
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1661852746-117244-1-git-send-email-liusong@linux.alibaba.com>
 <908d464e-e695-3a27-56f6-1ceabd727989@kernel.dk>
 <75f53b8f-30cd-23c3-1602-34d858302751@linux.alibaba.com>
 <9e093f5d-f9fb-1ed6-3598-5d4c46838a09@kernel.dk>
From:   Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <9e093f5d-f9fb-1ed6-3598-5d4c46838a09@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2022/8/31 08:59, Jens Axboe wrote:
> On 8/30/22 6:42 PM, Liu Song wrote:
>> On 2022/8/30 21:59, Jens Axboe wrote:
>>> On 8/30/22 3:45 AM, Liu Song wrote:
>>>> From: Liu Song <liusong@linux.alibaba.com>
>>>>
>>>> Change "bio_set_ioprio" to inline to avoid calling overhead.
>>> Let's not try to 2nd guess the compiler here. Most things that are
>>> marked inline should not be.
>> Agree, I think there is something wrong with the commit log written here,
>> it should be expected to reduce the call overhead, bio_set_ioprio seems
>> to be appropriate to use inline.
> I'm sure it's worth inlining, but did you check if it isn't already?
> If it's small I'd fully expect the compiler to inline it already,
> without needing to add things to do so.
>
It is indeed possible, thanks for your reply.

Thanks

