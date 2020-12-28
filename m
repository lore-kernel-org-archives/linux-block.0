Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1DDC433E0
	for <linux-block@archiver.kernel.org>; Mon, 28 Dec 2020 01:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28AE7229C4
	for <linux-block@archiver.kernel.org>; Mon, 28 Dec 2020 01:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgL1B5H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Dec 2020 20:57:07 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9693 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgL1B5H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Dec 2020 20:57:07 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D40xR5QjFzkx1T;
        Mon, 28 Dec 2020 09:55:23 +0800 (CST)
Received: from [10.174.177.185] (10.174.177.185) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Mon, 28 Dec 2020 09:56:15 +0800
Subject: Re: [PATCH 1/3] blk-mq: allow hardware queue to get more tag while
 sharing a tag set
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
References: <20201226102808.2534966-1-yukuai3@huawei.com>
 <20201226102808.2534966-2-yukuai3@huawei.com> <20201227115859.GA3282759@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <04c39621-0c4a-e593-5545-c4bd274c5fc2@huawei.com>
Date:   Mon, 28 Dec 2020 09:56:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201227115859.GA3282759@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.185]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2020/12/27 19:58, Ming Lei wrote:
> Hi Yu Kuai,
> 
> On Sat, Dec 26, 2020 at 06:28:06PM +0800, Yu Kuai wrote:
>> When sharing a tag set, if most disks are issuing small amount of IO, and
>> only a few is issuing a large amount of IO. Current approach is to limit
>> the max amount of tags a disk can get equally to the average of total
>> tags. Thus the few heavy load disk can't get enough tags while many tags
>> are still free in the tag set.
> 
> Yeah, current approach just allocates same share for each active queue
> which is evaluated in each timeout period.
> 
> That said you are trying to improve the following case:
> - heavy IO on one or several disks, and the average share for these
>    disks become bottleneck of IO performance
> - small amount IO on other disks attached to the same host, and all IOs are
> submitted to disk in <30 second period.
> 
> Just wondering if you may share the workload you are trying to optimize,
> or it is just one improvement in theory? And what is the disk(hdd, ssd
> or nvme) and host? And how many disks in your setting? And how deep the tagset
> depth is?

The details of the environment that we found the problem are as follows:

  total driver tags: 128
  number of disks: 13 (network drive, and they form a dm-multipath)
  default queue_depth: 32
  disk performance: when test with 4k randread and single thread, iops is
                    300. And can up to 4000 with 32 thread.
  test cmd: fio -ioengine=psync -numjobs=32 ...

We found that mpath will issue sg_io periodically(about 15s)£¬which lead
to active_queues setting to 13 for about 5s in every 15s.

By the way, I'm not sure this is a common scenario, however, sq don't
have such problem,

Thanks
Yu Kuai
