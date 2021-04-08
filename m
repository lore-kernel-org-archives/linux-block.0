Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11BCC433ED
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 16:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54078610CF
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 16:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhDHQiK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:38:10 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2808 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhDHQiK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 12:38:10 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FGRb20xQHz686p9;
        Fri,  9 Apr 2021 00:30:54 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 8 Apr 2021 18:37:56 +0200
Received: from [10.47.1.29] (10.47.1.29) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 17:37:55 +0100
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
 <14be9975-fbd1-796a-e44e-3342c5a330fb@huawei.com>
 <9774f2c5-0d76-59b4-c272-22a627c1ed84@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <0047a549-efa4-c011-fff4-11ac1803fc3c@huawei.com>
Date:   Thu, 8 Apr 2021 17:35:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <9774f2c5-0d76-59b4-c272-22a627c1ed84@acm.org>
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

Hi Bart,

>> But blk_mq_tagset_busy_iter() uses BT_TAG_ITER_MAY sleep flag in your
>> series.
> 
> I will mention the nbd driver in the commit message.
> 
>> As for the fc, I am not sure. I assume that you would know more about
>> this. My concern is
>>
>> __nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_fcp_op *op)
>> {
>> ...
>>
>>      ctrl->lport->ops->fcp_abort(&ctrl->lport->localport, ..);
>> }
>>
>> Looking at many instances of fcp_abort callback, they look atomic safe
>> from general high usage of spinlock, but I am not certain. They are
>> quite complex.
> I have not tried to analyze whether or not it is safe to call
> __nvme_fc_abort_op() from an atomic context. Instead I analyzed the
> contexts from which this function is called, namely the
> blk_mq_tagset_busy_iter() calls in __nvme_fc_abort_outstanding_ios() and
> __nvme_fc_abort_outstanding_ios(). Both blk_mq_tagset_busy_iter() calls
> are followed by a call to a function that may sleep. Hence it is safe to
> sleep inside the blk_mq_tagset_busy_iter() calls from the nvme_fc code.
> I have not tried to analyze whether it would be safe to change these
> blk_mq_tagset_busy_iter() calls into blk_mq_tagset_busy_iter_atomic()
> calls. Does this answer your question?

Yes, fine.

Thanks,
John
