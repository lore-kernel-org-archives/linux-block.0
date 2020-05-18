Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4041EC433E0
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 08:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2117920787
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 08:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgERInz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 04:43:55 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2217 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726357AbgERInz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 04:43:55 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 0FEEC994EAA976CCDE46;
        Mon, 18 May 2020 09:43:54 +0100 (IST)
Received: from [127.0.0.1] (10.210.170.146) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 18 May
 2020 09:43:53 +0100
Subject: Re: [PATCH 9/9] blk-mq: drain I/O when all CPUs in a hctx are offline
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
References: <20200518063937.757218-1-hch@lst.de>
 <20200518063937.757218-10-hch@lst.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8057f6f6-60ab-b0ae-fb41-8ccdc59aff93@huawei.com>
Date:   Mon, 18 May 2020 09:42:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200518063937.757218-10-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.146]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/05/2020 07:39, Christoph Hellwig wrote:
> +
>   /*
>    * 'cpu' is going away. splice any existing rq_list entries from this

Do we need to fix up this comment again?

Cheers,
John

>    * software queue to the hw queue dispatch list, and ensure that it
> @@ -2296,6 +2382,9 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
>   	enum hctx_type type;
>   
>   	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
> +	if (!cpumask_test_cpu(cpu, hctx->cpumask))
> +		return 0;
> +
>   	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
>   	type = hctx->type;

