Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED76C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 08:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7D72175B
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 08:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfCTIwy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:52:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726093AbfCTIwy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 04:52:54 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CC720486C8F936D0559D;
        Wed, 20 Mar 2019 16:52:51 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Mar 2019
 16:52:43 +0800
Subject: Re: [PATCH] blk-mq: fix a hung issue when set device state to blocked
 and restore running
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <houtao1@huawei.com>,
        <yanaijie@huawei.com>, <jianchao.w.wang@oracle.com>
References: <1553068921-6605-1-git-send-email-zhengbin13@huawei.com>
 <20190320081110.GA8408@ming.t460p>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <c0821276-2127-e6d8-97b0-b96628d11ba7@huawei.com>
Date:   Wed, 20 Mar 2019 16:52:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190320081110.GA8408@ming.t460p>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for your quick reply, I will study BLK_STS_DEV_RESOURCE in detail

> BLK_STS_DEV_RESOURCE means that the driver will rerun hw queue, so
> maybe you need to investigate why it is returned from scsi driver first.
because we set the device state to blocked,
scsi_queue_rq-->prep_to_mq(return BLK_STS_RESOURCE)
	     -->out_put_budget  transfer BLK_STS_RESOURCE to BLK_STS_DEV_RESOURCE
In this situtation, the request does not send to the driver.


If the device use sq, when we we set the device state to blocked and test dd, it will continue to
call blk_delay_queue.


If this test case really matters for you, we should try to run the hw queues after set state
to 'running'.
--->Maybe we should call blk_mq_run_hw_queue in scsi_device_set_state?


On 2019/3/20 16:11, Ming Lei wrote:
> On Wed, Mar 20, 2019 at 04:02:01PM +0800, zhengbin wrote:
>> When I use dd test a SCSI device which use blk-mq in the following steps:
>> 1.echo "blocked" >/sys/block/sda/device/state
>> 2.dd if=/dev/sda of=/mnt/t.log bs=1M count=10
>> 3.echo "running" >/sys/block/sda/device/state
>> dd should finish this work after step 3, unfortunately, still hung.
>>
>> After step2, the key code process is like this:
>> blk_mq_dispatch_rq_list-->scsi_queue_rq-->prep_to_mq
>>                        -->if ret is BLK_STS_RESOURCE, delay run hw queue
>>
>> prep_to_mq will return BLK_STS_RESOURCE, and scsi_queue_rq will transter
>> it to BLK_STS_DEV_RESOURCE. In this situtation, we should delay run hw
> 
> BLK_STS_DEV_RESOURCE means that the driver will rerun hw queue, so
> maybe you need to investigate why it is returned from scsi driver first.
> 
> BTW, I'd suggest you read the big comment on BLK_STS_DEV_RESOURCE first.
> 
> Thanks,
> Ming
> 
> .
> 

