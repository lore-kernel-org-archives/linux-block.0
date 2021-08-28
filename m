Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EF9C4320E
	for <linux-block@archiver.kernel.org>; Sat, 28 Aug 2021 05:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E51C060EBC
	for <linux-block@archiver.kernel.org>; Sat, 28 Aug 2021 05:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhH1FSS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Aug 2021 01:18:18 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61549 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhH1FSS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Aug 2021 01:18:18 -0400
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17S5HQWV080787;
        Sat, 28 Aug 2021 14:17:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sat, 28 Aug 2021 14:17:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17S5HQLl080759
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 28 Aug 2021 14:17:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: sort out the lock order in the loop driver v2
To:     Hillf Danton <hdanton@sina.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-block <linux-block@vger.kernel.org>,
        Milan Broz <gmazyland@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210826133810.3700-1-hch@lst.de>
 <20210827130259.2622-1-hdanton@sina.com>
 <20210828035114.2762-1-hdanton@sina.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f315574f-2844-71c9-d66f-13807364120f@i-love.sakura.ne.jp>
Date:   Sat, 28 Aug 2021 14:17:20 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210828035114.2762-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/28 12:51, Hillf Danton wrote:
> On Fri, 27 Aug 2021 23:10:53 +0900 Tetsuo Handa wrote:
>> On 2021/08/27 22:02, Hillf Danton wrote:
>>> This is a known issue [1] and the quick fix is destroy workqueue without
>>> holding lo_mutex.
>>>
>>> Please post a link to the drivers/block/loop.c you tested, Tetsuo.
>>>
>>> [1] https://lore.kernel.org/linux-block/0000000000005b27b805c853007b@google.com/
>>>
>>
>> Which link? https://lkml.kernel.org/r/2901b9c2-f798-413e-4073-451259718288@i-love.sakura.ne.jp [2]?
>> Too many failures to remember...
> 
> Take another look at [2] and what is reported in this thread (see below),
> what is common in both cases is lo->workqueue is destroyed under
> disk->open_mutex.
> 
> And down the lock chain in blkdev_get_by_dev() disk->open_mutex will be
> taken again... seems it will not be solved without taking open_mutex
> into account.

We are no longer interested in this series which tries to hold lo->lo_mutex from loop_add().

We are discussing https://lkml.kernel.org/r/b9d7b6b1-236a-438b-bee7-6d65b7b58905@i-love.sakura.ne.jp
which no longer tries to hold loop_ctl_mutex or lo->lo_mutex from loop_add().

