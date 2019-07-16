Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7ACC76188
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 08:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CF121721
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 08:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfGPIOK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 04:14:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38448 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbfGPIOJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 04:14:09 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D218347276216DDC1B86;
        Tue, 16 Jul 2019 16:14:03 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 16 Jul 2019
 16:13:58 +0800
Subject: Re: [RFC PATCH 0/7] blk-mq: improvement on handling IO during CPU
 hotplug
To:     Ming Lei <tom.leiming@gmail.com>
CC:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>,
        chenxiang <chenxiang66@hisilicon.com>
References: <20190712024726.1227-1-ming.lei@redhat.com>
 <c2c83d98-2012-13af-ab46-5a28303c0f87@huawei.com>
 <CACVXFVPz49Sp7cOE-HLKWp9iMC-XJVaROx8L5Oj+-+GvK4QhCQ@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f122e8f2-5ede-2d83-9ca0-bc713ce66d01@huawei.com>
Date:   Tue, 16 Jul 2019 16:13:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACVXFVPz49Sp7cOE-HLKWp9iMC-XJVaROx8L5Oj+-+GvK4QhCQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.223.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

在 16/07/2019 15:18, Ming Lei 写道:
>> So you have plans to post an updated "[PATCH 0/9] blk-mq/scsi: convert
>> private reply queue into blk_mq hw queue" then?

Hi Ming,

> V2 has been in the following tree for a while:
> 
> https://github.com/ming1/linux/commits/v5.2-rc-host-tags-V2
> 
> It works, however the implementation is a bit ugly even though the idea
> is simple.

Yeah, sorry to say that I agree - the BLK_MQ_F_TAG_HCTX_SHARED checks 
look bolted on.

> 
> So I think we may need to think of it further, for better implementation or
> approach.

Understood.

But at least we may test it to ensure no performance regression.

Thanks,
John

> 
> Thanks,
> Ming Lei


