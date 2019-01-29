Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CDBC282CD
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 00:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DF0214DA
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 00:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfA2Ark (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:47:40 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726803AbfA2Ark (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 19:47:40 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B15F296E0F73B55B9020;
        Tue, 29 Jan 2019 08:47:36 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Tue, 29 Jan 2019
 08:47:25 +0800
Subject: Re: [PATCH] block: set rq->cmd_flags with bio->opf instead of
 data->cmd_flags when bio is not Null
To:     Christoph Hellwig <hch@infradead.org>,
        John Garry <john.garry@huawei.com>
References: <1548337430-66690-1-git-send-email-chenxiang66@hisilicon.com>
 <1c34d6f9-8c3c-a7ff-a956-46e9dc3c2298@hisilicon.com>
 <20190128140716.GA18162@infradead.org>
 <55972c1a-051a-1396-6796-84f349830a35@huawei.com>
 <20190128155752.GA29076@infradead.org>
CC:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <17ca562e-1681-c501-1cd3-ac229d893dd9@hisilicon.com>
Date:   Tue, 29 Jan 2019 08:47:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190128155752.GA29076@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



在 2019/1/28 23:57, Christoph Hellwig 写道:
> On Mon, Jan 28, 2019 at 03:36:58PM +0000, John Garry wrote:
>> As I understood, the problem is the scenario of calling
>> blk_mq_make_request()->bio_integrity_prep() where we then allocate a bio
>> integrity payload in calling bio_integrity_alloc().
>>
>> In this case, bio_integrity_alloc() sets bio->bi_opf |= REQ_INTEGRITY, which
>> is no longer consistent with data.cmd_flags.
> I don't see how that could happen:
>
> static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
> {
> 	...
>
> 	if (!bio_integrity_prep(bio))
> 		return BLK_QC_T_NONE;
>
> 	...
>
> 	data.cmd_flags = bio->bi_opf;
>          rq = blk_mq_get_request(q, bio, &data);

Sorry to disturb, i used kernel 5.0-rc1 which has the issue, and it is 
fixed on linux-next branch.

>
>
> .
>


