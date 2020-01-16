Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F03DC33CAF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 04:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F7D2465A
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 04:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbgAPEGO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jan 2020 23:06:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9629 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729110AbgAPEGO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 23:06:14 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1BAE9EDE8B23924BD077;
        Thu, 16 Jan 2020 12:06:13 +0800 (CST)
Received: from [10.173.221.193] (10.173.221.193) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 16 Jan 2020 12:06:02 +0800
From:   Yufen Yu <yuyufen@huawei.com>
Subject: [Question] abort shared tags for SCSI drivers
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     <john.garry@huawei.com>, Ming Lei <ming.lei@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Message-ID: <bd959b9f-78dd-e0e7-0421-8d7e3cd2f41b@huawei.com>
Date:   Thu, 16 Jan 2020 12:06:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.193]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, all

Shared tags is introduced to maintains a notion of fairness between
active users. This may be good for nvme with multiple namespace to
avoid starving some users. Right?

However, I don't understand why we introduce the shared tag for SCSI.
IMO, there are two concerns for scsi shared tag:

1) For now, 'shost->can_queue' is used as queue depth in block layer.
And all target drivers share tags on one host. Then, the max tags for
each target can get:

	depth = max((bt->sb.depth + users - 1) / users, 4U);

But, each target driver may have their own capacity of tags and queue depth.
Does shared tag limit target device bandwidth?

2) When add new target or remove device, it may need to freeze other device
to update hctx->flags of BLK_MQ_F_TAG_SHARED. That may hurt performance.

Recently we discuss abort hostwide shared tags for SCSI[0] and sharing tags
across hardware queues[1]. These discussion are abort shared tag. But, I
confuse whether shared tag across hardware queues can solve my concerns as mentioned.

I have not deeply understand for SCSI and please correct me if I got wrong.

[0] https://www.spinics.net/lists/linux-scsi/msg136131.html
[1] https://www.spinics.net/lists/linux-block/msg47504.html

Thanks,
Yufen
