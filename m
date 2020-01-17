Return-Path: <SRS0=x5xE=3G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD8FC33CB1
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 07:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B56D2073A
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 07:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgAQHT3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jan 2020 02:19:29 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:41790 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbgAQHT3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jan 2020 02:19:29 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8AE6167721C7C7AD0231;
        Fri, 17 Jan 2020 15:19:27 +0800 (CST)
Received: from [10.173.221.193] (10.173.221.193) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Fri, 17 Jan 2020 15:19:19 +0800
Subject: Re: [Question] about shared tags for SCSI drivers
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        <john.garry@huawei.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
        <hare@suse.de>, Bart Van Assche <bvanassche@acm.org>,
        yanaijie <yanaijie@huawei.com>
References: <bd959b9f-78dd-e0e7-0421-8d7e3cd2f41b@huawei.com>
 <20200116090347.GA7438@ming.t460p>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <825dc368-1b97-b418-dc71-6541b1c20a70@huawei.com>
Date:   Fri, 17 Jan 2020 15:19:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116090347.GA7438@ming.t460p>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.193]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, ming

On 2020/1/16 17:03, Ming Lei wrote:
> On Thu, Jan 16, 2020 at 12:06:02PM +0800, Yufen Yu wrote:
>> Hi, all
>>
>> Shared tags is introduced to maintains a notion of fairness between
>> active users. This may be good for nvme with multiple namespace to
>> avoid starving some users. Right?
> 
> Actually nvme namespace is LUN of scsi world.
> 
> Shared tags isn't for maintaining fairness, it is just natural sw
> implementation of scsi host's tags, since every scsi host shares
> tags among all LUNs. If the SCSI host supports real MQ, the tags
> is hw-queue wide, otherwise it is host wide.
> 
>>
>> However, I don't understand why we introduce the shared tag for SCSI.
>> IMO, there are two concerns for scsi shared tag:
>>
>> 1) For now, 'shost->can_queue' is used as queue depth in block layer.
>> And all target drivers share tags on one host. Then, the max tags for
>> each target can get:
>>
>> 	depth = max((bt->sb.depth + users - 1) / users, 4U);
>>
>> But, each target driver may have their own capacity of tags and queue depth.
>> Does shared tag limit target device bandwidth?
> 
> No, if the 'target driver' means LUN, each LUN hasn't its independent
> tags, maybe it has its own queue depth, which is often for maintaining
> fairness among all active LUNs, not real queue depth.
> 
> You may see the patches[1] which try to bypass per-LUN queue depth for SSD.
> 
> [1] https://lore.kernel.org/linux-block/20191118103117.978-1-ming.lei@redhat.com/
> 
>>
>> 2) When add new target or remove device, it may need to freeze other device
>> to update hctx->flags of BLK_MQ_F_TAG_SHARED. That may hurt performance.
> 
> Add/removing device isn't a frequent event, so it shouldn't be a real
> issue, or you have seen effect on real use case?

Thanks a lot for your detailed explanation.

We found that removing scsi device will delay a long time (such as 6 * 30s)
for waiting the other device in the same host to complete all IOs, where
some IO retry multiple times. If our driver allowed more times to retry,
removing device will wait longer. That is not expected.

In fact, that is not problem before switching scsi blk-mq. All target
devices are independent when removing.

Thanks,
Yufen
