Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E048C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 15:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D632171F
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 15:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfA1PhU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:37:20 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48822 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726693AbfA1PhU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 10:37:20 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 32BD1F30C2BA0B8F7769;
        Mon, 28 Jan 2019 23:37:11 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Mon, 28 Jan 2019
 23:37:04 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] block: set rq->cmd_flags with bio->opf instead of
 data->cmd_flags when bio is not Null
To:     Christoph Hellwig <hch@infradead.org>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
References: <1548337430-66690-1-git-send-email-chenxiang66@hisilicon.com>
 <1c34d6f9-8c3c-a7ff-a956-46e9dc3c2298@hisilicon.com>
 <20190128140716.GA18162@infradead.org>
CC:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <55972c1a-051a-1396-6796-84f349830a35@huawei.com>
Date:   Mon, 28 Jan 2019 15:36:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190128140716.GA18162@infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 28/01/2019 14:07, Christoph Hellwig wrote:
>>> for rq->cmd_flags. It will cause dix=0 in function
>>> sd_setup_read_write_cmnd() when enabled DIX, which will cause IO
>>> exception when enabled DIX.
>>>
>>> For some IOs such as internal IO from SCSI layer, the parameter bio of
>>> function blk_mq_get_request() is Null, so need to check bio to
>>> decise rq->cmd_flags.
>
> We have data->cmd_flags to deal with the NULL bio case.
> blk_mq_make_request initializes data->cmd_flags from bio->bi_opf
> just before calling blk_mq_get_request, so I'm really missing what you
> are trying to fix here.

As I understood, the problem is the scenario of calling 
blk_mq_make_request()->bio_integrity_prep() where we then allocate a bio 
integrity payload in calling bio_integrity_alloc().

In this case, bio_integrity_alloc() sets bio->bi_opf |= REQ_INTEGRITY, 
which is no longer consistent with data.cmd_flags.

John

>
> .
>


