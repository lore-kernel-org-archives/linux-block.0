Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E57EC433DB
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 03:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C8764DEE
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 03:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhA2Dbb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 22:31:31 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2973 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA2Dba (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 22:31:30 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DRjWL00zRz5MTk;
        Fri, 29 Jan 2021 11:29:33 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 29 Jan 2021 11:30:47 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 29
 Jan 2021 11:30:47 +0800
Subject: Re: [PATCH v4 4/5] nvme-rdma: avoid IO error for nvme native
 multipath
To:     Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>
References: <20210126081539.13320-1-lengchao@huawei.com>
 <20210126081539.13320-5-lengchao@huawei.com>
 <5a368693-65fd-1bdf-924a-f90df7f59b2a@grimberg.me>
 <9c30b18a-6fdd-be1c-f3bc-1d44c35ae274@huawei.com>
 <ca300cac-1f6c-01b2-8691-9a545381523a@grimberg.me>
 <29ccc5e0-66e9-93db-e9b9-09012f1c8fe2@huawei.com>
 <1651456a-3251-77db-42c9-fc1a2d2c5c13@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <b5b70392-d4f7-6f0c-d337-a6023dc4b992@huawei.com>
Date:   Fri, 29 Jan 2021 11:30:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1651456a-3251-77db-42c9-fc1a2d2c5c13@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme709-chm.china.huawei.com (10.1.199.105) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/1/29 11:24, Sagi Grimberg wrote:
> 
>>>>> Why not just call set the status and call nvme_rdma_complete_rq and
>>>>> return here?
>>>> If the err is ENOMEM or EAGAIN, I am not sure the err must be a
>>>> path-related error for all HBA drivers. So reused the error check code.
>>>> I think it would be more reasonable to assume any errors returned by HBA
>>>> driver as path-related errors.
>>>> If you think so, I will modify it in next patch version.
>>>
>>> Meant to do that only for -EIO. We should absolutely not do any of this
>>> for stuff like EINVAL, EOPNOTSUPP, EPERM or any strange error that may
>>> return due to a bug or anything like that.
>> ok, please review again, thank you.
>> ---
>>   drivers/nvme/host/rdma.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index b7ce4f221d99..66b697461bd9 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -2084,8 +2084,13 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>>
>>          err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
>>                          req->mr ? &req->reg_wr.wr : NULL);
>> -       if (unlikely(err))
>> +       if (unlikely(err)) {
>> +               if (err == -EIO) {
>> +                       nvme_complete_failed_rq(rq, NVME_SC_HOST_PATH_ERROR);
> 
> I was thinking about:
> -- 
>          err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
>                          req->mr ? &req->reg_wr.wr : NULL);
>          if (unlikely(err)) {
>                  if (err == -EIO) {
>                          /*
>                           * Fail the reuqest so upper layer can failover I/O
>                           * if another path is available
>                           */
>                          req->status = NVME_SC_HOST_PATH_ERROR;
>                          nvme_rdma_complete_rq(rq);
>                          return BLK_STS_OK;Need to do clean. so can not directly return.
> 
>                  }
>                  goto err_unmap;
>          }
> -- 
> .
