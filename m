Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1702C282CD
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917C12082E
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbfA1QGJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:06:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2687 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731956AbfA1QGI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 11:06:08 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B7849267FA9724854A59;
        Tue, 29 Jan 2019 00:06:02 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Tue, 29 Jan 2019
 00:05:53 +0800
Subject: Re: [PATCH] block: set rq->cmd_flags with bio->opf instead of
 data->cmd_flags when bio is not Null
To:     Christoph Hellwig <hch@infradead.org>
References: <1548337430-66690-1-git-send-email-chenxiang66@hisilicon.com>
 <1c34d6f9-8c3c-a7ff-a956-46e9dc3c2298@hisilicon.com>
 <20190128140716.GA18162@infradead.org>
 <55972c1a-051a-1396-6796-84f349830a35@huawei.com>
 <20190128155752.GA29076@infradead.org>
CC:     "chenxiang (M)" <chenxiang66@hisilicon.com>,
        <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <872f8c26-1c88-fe50-ffec-01c1e882245b@huawei.com>
Date:   Mon, 28 Jan 2019 16:05:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190128155752.GA29076@infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 28/01/2019 15:57, Christoph Hellwig wrote:
> On Mon, Jan 28, 2019 at 03:36:58PM +0000, John Garry wrote:
>> As I understood, the problem is the scenario of calling
>> blk_mq_make_request()->bio_integrity_prep() where we then allocate a bio
>> integrity payload in calling bio_integrity_alloc().
>>
>> In this case, bio_integrity_alloc() sets bio->bi_opf |= REQ_INTEGRITY, which
>> is no longer consistent with data.cmd_flags.
>
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
>         rq = blk_mq_get_request(q, bio, &data);
>
>

Your code is different to mine, then I see that this has been fixed in 
5.0-rc3:

commit 7809167da5c86fd6bf309b33dee7a797e263342f
Author: Ming Lei <ming.lei@redhat.com>
Date:   Wed Jan 16 19:08:15 2019 +0800

     block: don't lose track of REQ_INTEGRITY flag

     We need to pass bio->bi_opf after bio intergrity preparing, otherwise
     the flag of REQ_INTEGRITY may not be set on the allocated request, then
     breaks block integrity.

     Fixes: f9afca4d367b ("blk-mq: pass in request/bio flags to queue 
mapping")
     Cc: Hannes Reinecke <hare@suse.com>
     Cc: Keith Busch <keith.busch@intel.com>
     Signed-off-by: Ming Lei <ming.lei@redhat.com>
     Signed-off-by: Jens Axboe <axboe@kernel.dk>


Sorry for the noise,
John

> .
>


