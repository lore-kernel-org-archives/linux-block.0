Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D456FC433ED
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 12:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C1FD61106
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 12:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhDHMu6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 08:50:58 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2806 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhDHMu6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 08:50:58 -0400
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FGLXv371Lz687Qt;
        Thu,  8 Apr 2021 20:43:43 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 14:50:45 +0200
Received: from [10.47.1.29] (10.47.1.29) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 13:50:44 +0100
Subject: Re: [PATCH v6 2/5] blk-mq: Introduce atomic variants of
 blk_mq_(all_tag|tagset_busy)_iter
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Hannes Reinecke" <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Khazhy Kumykov <khazhy@google.com>
References: <20210406214905.21622-1-bvanassche@acm.org>
 <20210406214905.21622-3-bvanassche@acm.org>
 <31402243-57ca-8fa5-473a-d5ce20774c50@huawei.com>
 <1610af81-ce46-26c4-5aae-d84aba5cf1f5@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <14be9975-fbd1-796a-e44e-3342c5a330fb@huawei.com>
Date:   Thu, 8 Apr 2021 13:48:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1610af81-ce46-26c4-5aae-d84aba5cf1f5@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.1.29]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 07/04/2021 19:42, Bart Van Assche wrote:
>>
>>> - scsi_host_busy(), scsi_host_complete_all_commands() and
>>>    scsi_host_busy_iter() are used by multiple SCSI LLDs so analyzing 
>>> whether
>>>    or not these functions may sleep is hard. Instead of performing that
>>>    analysis, make it safe to call these functions from atomic context.
>>
>> Please help me understand this solution. The background is that we are 
>> unsure if the SCSI iters callback functions may sleep. So we use the 
>> blk_mq_all_tag_iter_atomic() iter, which tells us that we must not 
>> sleep. And internally, it uses rcu read lock protection mechanism, 
>> which relies on not sleeping. So it seems that we're making the SCSI 
>> iter functions being safe in atomic context, and, as such, rely on the 
>> iter callbacks not to sleep.
>>
>> But if we call the SCSI iter function from non-atomic context and the 
>> iter callback may sleep, then that is a problem, right? We're still 
>> using rcu.
> 

Hi Bart,

> 
> Please take a look at the output of the following grep command:
> 
> git grep -nHEw 'blk_mq_tagset_busy_iter|scsi_host_busy_iter'\ drivers/scsi
> 
> Do you agree with me that it is safe to call all the callback functions 
> passed to blk_mq_tagset_busy_iter() and scsi_host_busy_iter() from an 
> atomic context?
> 

That list output I got is at the bottom (with this patchset, not 
mainline - not sure which you meant).

The following does not look atomic safe with the mutex usage:
drivers/block/nbd.c:819:        blk_mq_tagset_busy_iter(&nbd->tag_set, 
nbd_clear_req, NULL);

static bool nbd_clear_req(struct request *req, void *data, bool reserved)
{
	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);

	mutex_lock(&cmd->lock);
	cmd->status = BLK_STS_IOERR;
	mutex_unlock(&cmd->lock);

	blk_mq_complete_request(req);
	return true;
}

But blk_mq_tagset_busy_iter() uses BT_TAG_ITER_MAY sleep flag in your 
series.

As for the fc, I am not sure. I assume that you would know more about 
this. My concern is

__nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_fcp_op *op)
{
...

	ctrl->lport->ops->fcp_abort(&ctrl->lport->localport, ..);
}

Looking at many instances of fcp_abort callback, they look atomic safe 
from general high usage of spinlock, but I am not certain. They are 
quite complex.

Thanks,
John

block/blk-core.c:287: * blk_mq_tagset_busy_iter() and also for their 
atomic variants to finish
block/blk-mq-debugfs.c:418: 
blk_mq_tagset_busy_iter(hctx->queue->tag_set, hctx_show_busy_rq,
block/blk-mq-tag.c:405: * blk_mq_tagset_busy_iter - iterate over all 
started requests in a tag set
block/blk-mq-tag.c:416:void blk_mq_tagset_busy_iter(struct 
blk_mq_tag_set *tagset,
block/blk-mq-tag.c:436:EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
drivers/block/mtip32xx/mtip32xx.c:2685: 
blk_mq_tagset_busy_iter(&dd->tags, mtip_queue_cmd, dd);
drivers/block/mtip32xx/mtip32xx.c:2690: 
blk_mq_tagset_busy_iter(&dd->tags,
drivers/block/mtip32xx/mtip32xx.c:3800: 
blk_mq_tagset_busy_iter(&dd->tags, mtip_no_dev_cleanup, dd);
drivers/block/nbd.c:819:        blk_mq_tagset_busy_iter(&nbd->tag_set, 
nbd_clear_req, NULL);
drivers/nvme/host/core.c:392: 
blk_mq_tagset_busy_iter(ctrl->tagset,
drivers/nvme/host/core.c:402: 
blk_mq_tagset_busy_iter(ctrl->admin_tagset,
drivers/nvme/host/fc.c:2477: 
blk_mq_tagset_busy_iter(&ctrl->tag_set,
drivers/nvme/host/fc.c:2500: 
blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
drivers/nvme/host/pci.c:2504:   blk_mq_tagset_busy_iter(&dev->tagset, 
nvme_cancel_request, &dev->ctrl);
drivers/nvme/host/pci.c:2505: 
blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, 
&dev->ctrl);
drivers/nvme/target/loop.c:420: 
blk_mq_tagset_busy_iter(&ctrl->tag_set,
drivers/nvme/target/loop.c:430: 
blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
include/linux/blk-mq.h:527:void blk_mq_tagset_busy_iter(struct 
blk_mq_tag_set *tagset,
lines 1-18/18 (END)
