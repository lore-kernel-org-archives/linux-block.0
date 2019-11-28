Return-Path: <SRS0=c8VV=ZU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143E6C432C0
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 09:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D936C216F4
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 09:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfK1J3Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Nov 2019 04:29:24 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2132 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726510AbfK1J3Y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Nov 2019 04:29:24 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id D7C18A2E1CFE1374C5DE;
        Thu, 28 Nov 2019 09:29:22 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 28 Nov 2019 09:29:22 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 28 Nov
 2019 09:29:22 +0000
Subject: Re: [PATCH V4 3/5] blk-mq: stop to handle IO and drain IO before hctx
 becomes dead
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>,
        chenxiang <chenxiang66@hisilicon.com>
References: <20191014015043.25029-1-ming.lei@redhat.com>
 <20191014015043.25029-4-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <849aea76-755f-f06d-3927-13c35b7720cd@huawei.com>
Date:   Thu, 28 Nov 2019 09:29:21 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191014015043.25029-4-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 14/10/2019 02:50, Ming Lei wrote:
> 		break;
> +		msleep(5);
> +	}
> +}
> +
>   static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
>   {
> +	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> +			struct blk_mq_hw_ctx, cpuhp_online);
> +
> +	if ((cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) == cpu) &&
> +	    (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) >=
> +	     nr_cpu_ids)) {
> +		set_bit(BLK_MQ_S_INTERNAL_STOPPED, &hctx->state);
> +		blk_mq_hctx_drain_inflight_rqs(hctx);

Hi Ming,

> +        }

This goes a bit beyond a nit: The indentation needs to be fixed here.

Thanks,
John

>   	return 0;
>   }
>   
> @@ -2246,6 +2284,8 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
>   	ctx

