Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4248CC63777
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 01:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6E6B20857
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 01:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgLABy2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 20:54:28 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:54684 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726055AbgLABy2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 20:54:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UH4t9mB_1606787625;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UH4t9mB_1606787625)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Dec 2020 09:53:46 +0800
Subject: Re: [PATCH] block: fix inflight statistics of part0
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <20201126094833.61309-1-jefflexu@linux.alibaba.com>
 <20201130170548.GA10078@infradead.org>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <8928d65c-00ea-3002-d9f9-9525fdbbbaf5@linux.alibaba.com>
Date:   Tue, 1 Dec 2020 09:53:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130170548.GA10078@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The traditional single queue block device has no problem. Following is
the output when I writes to sda3 on version v3.10.

$cat /sys/block/sda/sda3/inflight
       0       33
$cat /sys/block/sda/inflight
       0       33


On the other hand, we can analyze this from the code. Following code
path for single-queue block device is from v4.19.

1. When reading '/sys/block/sda/inflight', the statistics is actually
fetched from part 0.

part_inflight_show
  part_in_flight_rw
	inflight[0] = atomic_read(&part->in_flight[0]);
	inflight[1] = atomic_read(&part->in_flight[1]);


2. part 0 will always be updated whenever sub partition is updated.

blk_queue_bio
    add_acct_request
        blk_account_io_start
            part_inc_in_flight
                atomic_inc(&part->in_flight[rw])
                if (part->partno)
			atomic_inc(part0.in_flight[rw]);


On 12/1/20 1:05 AM, Christoph Hellwig wrote:
> On Thu, Nov 26, 2020 at 05:48:33PM +0800, Jeffle Xu wrote:
>> The inflight of partition 0 doesn't include inflight IOs to all
>> sub-partitions, since currently mq calculates inflight of specific
>> partition by simply camparing the value of the partition pointer.
>>
>> Thus the following case is possible:
>>
>> $ cat /sys/block/vda/inflight
>> ?? ?? ?? ??0 ?? ?? ?? ??0
>> $ cat /sys/block/vda/vda1/inflight
>> ?? ?? ?? ??0 ?? ?? ??128
>>
>> Partition 0 should be specially handled since it represents the whole
>> disk.
> 
> I'm not sure and can see arguments for either side.  In doubt we should
> stick to historic behavior, can you check what old kernels (especially
> before blk-mq) did?
> 

-- 
Thanks,
Jeffle
