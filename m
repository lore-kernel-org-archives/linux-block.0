Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51D3C433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 09:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF52260ED7
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 09:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhINJVQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:21:16 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:16197 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhINJUv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 05:20:51 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H7ySn28mvz1DH1P;
        Tue, 14 Sep 2021 17:18:33 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 17:19:32 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 14 Sep 2021 17:19:31 +0800
Subject: Re: [PATCH v5 5/6] nbd: convert to use blk_mq_find_and_get_req()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <hch@infradead.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yi.zhang@huawei.com>
References: <20210909141256.2606682-1-yukuai3@huawei.com>
 <20210909141256.2606682-6-yukuai3@huawei.com> <YT/2z4PSeW5oJWMq@T590>
 <c6af73a2-f12d-eeef-616e-ae0cdb4f6f2d@huawei.com> <YUBE4BJ7+kN1c4l8@T590>
 <374c6b37-b4b2-fe01-66be-ca2dbbc283e9@huawei.com> <YUBTVBioqJ7qas2R@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <b8301834-5541-76ee-13a9-0fa565fce7e3@huawei.com>
Date:   Tue, 14 Sep 2021 17:19:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YUBTVBioqJ7qas2R@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On дк 2021/09/14 15:46, Ming Lei wrote:

> If the above can happen, blk_mq_find_and_get_req() may not fix it too, just
> wondering why not take the following simpler way for avoiding the UAF?
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 5170a630778d..dfa5cce71f66 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -795,9 +795,13 @@ static void recv_work(struct work_struct *work)
>   						     work);
>   	struct nbd_device *nbd = args->nbd;
>   	struct nbd_config *config = nbd->config;
> +	struct request_queue *q = nbd->disk->queue;
>   	struct nbd_cmd *cmd;
>   	struct request *rq;
>   
> +	if (!percpu_ref_tryget(&q->q_usage_counter))
> +                return;
> +
>   	while (1) {
>   		cmd = nbd_read_stat(nbd, args->index);
>   		if (IS_ERR(cmd)) {
> @@ -813,6 +817,7 @@ static void recv_work(struct work_struct *work)
>   		if (likely(!blk_should_fake_timeout(rq->q)))
>   			blk_mq_complete_request(rq);
>   	}
> +	blk_queue_exit(q);
>   	nbd_config_put(nbd);
>   	atomic_dec(&config->recv_threads);
>   	wake_up(&config->recv_wq);
> 

Hi, Ming

This apporch is wrong.

If blk_mq_freeze_queue() is called, and nbd is waiting for all
request to complete. percpu_ref_tryget() will fail here, and deadlock
will occur because request can't complete in recv_work().

Thanks,
Kuai
