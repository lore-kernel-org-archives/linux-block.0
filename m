Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA43C12002
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 18:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6CCA61221
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 18:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhGUSMx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jul 2021 14:12:53 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3444 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhGUSMx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 14:12:53 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GVPZD2vknz6H7Wr;
        Thu, 22 Jul 2021 02:41:56 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Jul 2021 20:53:27 +0200
Received: from [10.47.85.43] (10.47.85.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 21 Jul
 2021 19:53:26 +0100
Subject: Re: [PATCH V5 2/3] blk-mq: mark if one queue map uses managed irq
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "Christoph Hellwig" <hch@lst.de>, <linux-block@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        "Hannes Reinecke" <hare@suse.de>
References: <20210721091723.1152456-1-ming.lei@redhat.com>
 <20210721091723.1152456-3-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6d2e0c81-6efd-69eb-7b00-85565533e5b4@huawei.com>
Date:   Wed, 21 Jul 2021 19:53:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210721091723.1152456-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.43]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 21/07/2021 10:17, Ming Lei wrote:

FWIW,

Reviewed-by: John Garry <john.garry@huawei.com>

> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 1d18447ebebc..d54a795ec971 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -192,7 +192,8 @@ struct blk_mq_hw_ctx {
>   struct blk_mq_queue_map {
>   	unsigned int *mq_map;
>   	unsigned int nr_queues;
> -	unsigned int queue_offset;
> +	unsigned int queue_offset:31;
> +	unsigned int use_managed_irq:1;

late nit: I'd be inclined to call this "drain_hw_queue" or similar, 
which is what it means to blk-mq

>   };

Thanks
