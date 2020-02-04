Return-Path: <SRS0=vwZl=3Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20619C35247
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 01:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9BC2084E
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 01:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgBDBVl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 20:21:41 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbgBDBVl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Feb 2020 20:21:41 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 46FACBF277107A2ED144;
        Tue,  4 Feb 2020 09:21:39 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 4 Feb 2020
 09:21:29 +0800
Subject: Re: [PATCH V4] brd: check and limit max_part par
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>, Guiyao <guiyao@huawei.com>,
        Louhongxiang <louhongxiang@huawei.com>
References: <76ad8074-c2ba-4bb3-3e8b-3a4925999964@huawei.com>
 <20200203122005.GB31450@ming.t460p>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <9d82e25c-c909-3180-e987-260f53de51a4@huawei.com>
Date:   Tue, 4 Feb 2020 09:21:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200203122005.GB31450@ming.t460p>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/2/3 20:26, Ming Lei wrote:
> On Tue, Jan 21, 2020 at 12:04:41PM +0800, Zhiqiang Liu wrote:
>>
>> In brd_init func, rd_nr num of brd_device are firstly allocated
>> and add in brd_devices, then brd_devices are traversed to add each
>> brd_device by calling add_disk func. When allocating brd_device,
>> the disk->first_minor is set to i * max_part, if rd_nr * max_part
>> is larger than MINORMASK, two different brd_device may have the same
>> devt, then only one of them can be successfully added.
>> when rmmod brd.ko, it will cause oops when calling brd_exit.
>>

>> +static inline void brd_check_and_reset_par(void)
>> +{
>> +	if (unlikely(!max_part))
>> +		max_part = 1;
>> +
>> +	if (max_part > DISK_MAX_PARTS) {
>> +		pr_info("brd: max_part can't be larger than %d, reset max_part = %d.\n",
>> +			DISK_MAX_PARTS, DISK_MAX_PARTS);
>> +		max_part = DISK_MAX_PARTS;
>> +	}
>> +
>> +	/*
>> +	 * make sure 'max_part' can be divided exactly by (1U << MINORBITS),
>> +	 * otherwise, it is possiable to get same dev_t when adding partitions.
>> +	 */
>> +	if ((1U << MINORBITS) % max_part != 0)
>> +		max_part = 1UL << fls(max_part);
>> +}
> 
> You should move the above change before capping it to DISK_MAX_PARTS
> since  1UL << fls() may increase 'max_part'.
> 
Thanks for your suggestion. I will send the v5 patch.

