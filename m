Return-Path: <SRS0=CAbX=AS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE73C433DF
	for <linux-block@archiver.kernel.org>; Tue,  7 Jul 2020 06:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDB08206F6
	for <linux-block@archiver.kernel.org>; Tue,  7 Jul 2020 06:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGGGjX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:39:23 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2431 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727090AbgGGGjW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Jul 2020 02:39:22 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 6933858D9F20D7E905D6;
        Tue,  7 Jul 2020 07:39:21 +0100 (IST)
Received: from [127.0.0.1] (10.47.9.47) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 7 Jul 2020
 07:39:20 +0100
Subject: Re: [PATCH] blk-mq: centralise related handling into
 blk_mq_get_driver_tag
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20200706144111.3260859-1-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <841c8170-f082-814a-70cc-b0e3e8b5be54@huawei.com>
Date:   Tue, 7 Jul 2020 07:37:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200706144111.3260859-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.9.47]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/07/2020 15:41, Ming Lei wrote:
>   
> -	hctx = flush_rq->mq_hctx;
>   	if (!q->elevator) {

Is there a specific reason we do:

if (!a)
	do x
else
	do y

as opposed to:

if (a)
	do y
else
	do x

Do people find this easier to read or more obvious? Just wondering.

> -		blk_mq_tag_set_rq(hctx, flush_rq->tag, fq->orig_rq);
> -		flush_rq->tag = -1;
> +		flush_rq->tag = BLK_MQ_NO_TAG;
>   	} else {
>   		blk_mq_put_driver_tag(flush_rq);
> -		flush_rq->internal_tag = -1;
> +		flush_rq->internal_tag = BLK_MQ_NO_TAG;
>   	}
>   

