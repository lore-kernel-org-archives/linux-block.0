Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE995C33CB1
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 12:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAB3207FF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 12:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgAPMSF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:18:05 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2273 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbgAPMSE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jan 2020 07:18:04 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 650C1496F414022771CF;
        Thu, 16 Jan 2020 12:18:01 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 16 Jan 2020 12:18:00 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 12:18:00 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: [Question] about shared tags for SCSI drivers
To:     Ming Lei <ming.lei@redhat.com>, Yufen Yu <yuyufen@huawei.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
References: <bd959b9f-78dd-e0e7-0421-8d7e3cd2f41b@huawei.com>
 <20200116090347.GA7438@ming.t460p>
Message-ID: <26ba5f43-e3f7-9b10-9b1b-af9b9742b2d4@huawei.com>
Date:   Thu, 16 Jan 2020 12:17:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200116090347.GA7438@ming.t460p>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 16/01/2020 09:03, Ming Lei wrote:

(fixed title)

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

Note that in scsi_alloc_sdev(), sdev default queue depth is set to 
shost->cmd_per_lun. Slightly different for ATA devices - see 
ata_scsi_dev_config().

There is then also the scsi_host_template.change_queue_depth() callback 
for SCSI hosts can use to set this.

>> And all target drivers share tags on one host. Then, the max tags for
>> each target can get:
>>
>> 	depth = max((bt->sb.depth + users - 1) / users, 4U);

The host HW is limited by the amount of simultaneous commands it can 
issue, regardless of where these tags are managed.

And you seem to be assuming in this equation that all users will own a 
subset of host tags, which is not true.

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
> 
>>
>> Recently we discuss abort hostwide shared tags for SCSI[0] and sharing tags
>> across hardware queues[1]. These discussion are abort shared tag. But, I
>> confuse whether shared tag across hardware queues can solve my concerns as mentioned.
> 
> Both [1] and [0] are for converting some single queue SCSI host into MQ
> because these HBAs support multiple reply queue for completing request,
> meantime they only have single tags(so they are SQ driver now). So far
> not many such kind of hardwares(HPSA, hisi sas, megaraid_sas, ...).
> 
> 
> Thanks,
> Ming
> 

thanks Ming

> .
> 

