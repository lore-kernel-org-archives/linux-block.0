Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA51FA373D
	for <linux-block@archiver.kernel.org>; Wed, 26 Oct 2022 08:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiJZIv4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 04:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbiJZIvz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 04:51:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F91C97D76
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 01:51:53 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4My2VV3WGCzmV6v;
        Wed, 26 Oct 2022 16:46:58 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 16:51:51 +0800
Subject: Re: [PATCH 16/17] blk-mq: add tagset quiesce interface
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, Hannes Reinecke <hare@suse.de>
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-17-hch@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <05e7fdd0-a2fc-2944-679a-dac3d4755f14@huawei.com>
Date:   Wed, 26 Oct 2022 16:51:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221025144020.260458-17-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/10/25 22:40, Christoph Hellwig wrote:
> @@ -315,6 +315,31 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
>   
> +void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
> +{
> +	struct request_queue *q;
> +
> +	mutex_lock(&set->tag_list_lock);
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		if (!blk_queue_skip_tagset_quiesce(q))
> +			blk_mq_quiesce_queue_nowait(q);
> +	}
> +	blk_mq_wait_quiesce_done(set);
> +	mutex_unlock(&set->tag_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_tagset);
> +
> +void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
> +{
> +	struct request_queue *q;
> +
> +	mutex_lock(&set->tag_list_lock);
> +	list_for_each_entry(q, &set->tag_list, tag_set_list)
> +		blk_mq_unquiesce_queue(q);
We should add the check of blk_queue_skip_tagset_quiesce() to keep consistent
with blk_mq_quiesce_tagset(), it doesn't make much sense, but maybe look a little better.
		if (!blk_queue_skip_tagset_quiesce(q))
			blk_mq_unquiesce_queue(q);
