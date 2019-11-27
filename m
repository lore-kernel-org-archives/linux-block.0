Return-Path: <SRS0=Lpm0=ZT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E70C432C0
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 09:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CA620722
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 09:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfK0Jvc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Nov 2019 04:51:32 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2123 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbfK0Jvb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 04:51:31 -0500
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 3DDBFDC0B1A771D6D990;
        Wed, 27 Nov 2019 09:51:30 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 27 Nov 2019 09:51:29 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 09:51:29 +0000
Subject: Re: [PATCH 3/3] block: Add support for sharing tags across hardware
 queues
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Christoph Hellwig" <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
References: <20191126175656.67638-1-bvanassche@acm.org>
 <20191126175656.67638-4-bvanassche@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5183ab13-0c81-95f0-95ba-40318569c6c6@huawei.com>
Date:   Wed, 27 Nov 2019 09:51:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191126175656.67638-4-bvanassche@acm.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26/11/2019 17:56, Bart Van Assche wrote:
> Add a boolean member 'share_tags' in struct blk_mq_tag_set. If that member
> variable is set, make all hctx->tags[] pointers identical. Implement the
> necessary changes in the functions that allocate, free and resize tag sets.
> Modify blk_mq_tagset_busy_iter() such that it continues to call the
> callback function once per request. Modify blk_mq_queue_tag_busy_iter()
> such that the callback function is only called with the correct hctx
> as first argument. Modify the debugfs code such that it keeps showing only
> matching tags per hctx.
> 

Hi Bart,

 > This patch has been tested by running blktests on top of a kernel that
 > includes the following change to enable shared tags for all block drivers
 > except the NVMe drivers:

Could something be broken here with this approach, see ***:

static int
nvme_init_request(struct blk_mq_tag_set *set, struct request *req,
unsigned int hctx_idx, unsigned int numa_node)
{
	struct nvme_dev *dev = set->driver_data;
	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
	int queue_idx = (set == &dev->tagset) ? hctx_idx + 1 : 0;
	struct nvme_queue *nvmeq = &dev->queues[queue_idx];

	BUG_ON(!nvmeq);
	iod->nvmeq = nvmeq; ***

	nvme_req(req)->ctrl = &dev->ctrl;
	return 0;
}

All iods are from hctx0, but could use different hctx's and nvme queues.

Obviously NVMe would not want shared tags, but I am just trying to 
illustrate a potential problem in how requests are associated with 
queues. I haven't audited all users.

Thanks,
John
