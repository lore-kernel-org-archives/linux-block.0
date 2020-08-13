Return-Path: <SRS0=n79e=BX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1139BC433DF
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 03:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2159206A4
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 03:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHMDpp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Aug 2020 23:45:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9275 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726576AbgHMDpp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Aug 2020 23:45:45 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7EB4E69DEF4760746660;
        Thu, 13 Aug 2020 11:45:43 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Thu, 13 Aug 2020
 11:45:42 +0800
Subject: Re: [PATCH 1/3] nvme-core: fix io interrupt caused by non path error
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <kbusch@kernel.org>, <axboe@fb.com>, <sagi@grimberg.me>
References: <20200812081837.22144-1-lengchao@huawei.com>
 <20200812150939.GA29544@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <dfb86f35-45e6-56d3-89c8-51fe443782a1@huawei.com>
Date:   Thu, 13 Aug 2020 11:45:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200812150939.GA29544@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/8/12 23:09, Christoph Hellwig wrote:
> On Wed, Aug 12, 2020 at 04:18:37PM +0800, Chao Leng wrote:
>> For nvme multipath configured, just fail over to retry IO for path error,
>> but maybe blk_queue_dying return true, IO can not be retry at current
>> path, thus IO will interrupted.
>>
>> For nvme multipath configured, blk_queue_dying and path error both need
>> fail over to retry. We need check whether path-related errors first, and
>> then retry local or fail over to retry.
> 
> Err, no.  None of this really makes any sense.  The existing code
> actually works perfectly well unless you really insist on trying to
> use a completley unsupported multipathing configuration.  I would
> storngly recommend to not use dm-multipath with nvme, but if you
> insist please fix your problems without impacting the fully supported
> native path.
The scenario: IO already return with non path error(such as
NVME_SC_CMD_INTERRUPTED or NVME_SC_DATA_XFER_ERROR etc.), but is waiting
to be processed, at the same time, delete ctrl happens, delete ctrl may
set queue flag: QUEUE_FLAG_DYING when call nvme_remove_namespaces. Then
for example, if fabric is rdma, delete ctrl will call
nvme_rdma_delete_ctrl, nvme_rdma_delete_ctrl will drain qp first, thus
the IO, which return with non path error, can not be failover retry,
and also can not retry local, IO will interrupt.
Another solution can also avoid it: nvme_rdma_delete_ctrl first disable
irq instead of drain qp, then cancel all io(set path error), thus
nvme multipath will failover retry. There may be a little flaw: if
io complete success, which is waiting to be processed, will also be
canceled and failover retry.
