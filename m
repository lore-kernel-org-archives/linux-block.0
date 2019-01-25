Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC1DC282C3
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 00:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279C5218CD
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 00:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfAYA5e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 19:57:34 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:44976 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726015AbfAYA5e (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 19:57:34 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C7E8C7E76369B5562B92;
        Fri, 25 Jan 2019 08:57:31 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Fri, 25 Jan 2019
 08:57:24 +0800
Subject: Re: [PATCH] block: set rq->cmd_flags with bio->opf instead of
 data->cmd_flags when bio is not Null
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
References: <1548337430-66690-1-git-send-email-chenxiang66@hisilicon.com>
CC:     <linuxarm@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <john.garry@huawei.com>,
        <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <1c34d6f9-8c3c-a7ff-a956-46e9dc3c2298@hisilicon.com>
Date:   Fri, 25 Jan 2019 08:57:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1548337430-66690-1-git-send-email-chenxiang66@hisilicon.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

+cc Jens + linux-block

ÔÚ 2019/1/24 21:43, chenxiang Ð´µÀ:
> In function blk_mq_make_request(), though data->cmd_flags will be
> initialized with bio->opf, later bio->opf may be set as REQ_INTEGRITY
> if enabled DIX. So need to use bio->opf instead of data->cmd_flags in
> function blk_mq_rq_ctx_init(), or  flags REQ_INTEGRITY will not be set
> for rq->cmd_flags. It will cause dix=0 in function
> sd_setup_read_write_cmnd() when enabled DIX, which will cause IO
> exception when enabled DIX.
>
> For some IOs such as internal IO from SCSI layer, the parameter bio of
> function blk_mq_get_request() is Null, so need to check bio to
> decise rq->cmd_flags.
>
> Fixes: f9afca4d367b ("blk-mq: pass in request/bio flags to queue mapping")
>
> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> Reviewed-by: John Garry <john.garry@huawei.com>
> ---
>   block/blk-mq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3ba37b9..c4a1c63 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -394,7 +394,7 @@ static struct request *blk_mq_get_request(struct request_queue *q,
>   		return NULL;
>   	}
>   
> -	rq = blk_mq_rq_ctx_init(data, tag, data->cmd_flags);
> +	rq = blk_mq_rq_ctx_init(data, tag, bio ? bio->bi_opf : data->cmd_flags);
>   	if (!op_is_flush(data->cmd_flags)) {
>   		rq->elv.icq = NULL;
>   		if (e && e->type->ops.prepare_request) {


