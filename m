Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3893AC3815B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 10:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB4120CC7
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 10:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgDTKer (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 06:34:47 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2062 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbgDTKer (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 06:34:47 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 88DA0E7E68D10C74890E;
        Mon, 20 Apr 2020 11:34:45 +0100 (IST)
Received: from [127.0.0.1] (10.47.7.108) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 20 Apr
 2020 11:34:44 +0100
Subject: Re: [PATCH V7 4/9] blk-mq: support rq filter callback when iterating
 rqs
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200418030925.31996-1-ming.lei@redhat.com>
 <20200418030925.31996-5-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <02c79673-44d8-16b6-bd45-93b7b8467497@huawei.com>
Date:   Mon, 20 Apr 2020 11:34:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200418030925.31996-5-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.7.108]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>   EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> index 2b8321efb682..fdf095d513e5 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -21,6 +21,7 @@ struct blk_mq_tags {
>   	struct list_head page_list;
>   };
>   
> +typedef bool (busy_rq_iter_fn)(struct request *, void *, bool);
>   
>   extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsigned int reserved_tags, int node, int alloc_policy);
>   extern void blk_mq_free_tags(struct blk_mq_tags *tags);
> @@ -34,6 +35,9 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
>   extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
>   void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>   		void *priv);
> +void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> +		busy_tag_iter_fn *fn, busy_rq_iter_fn *busy_rq_fn,
> +		void *priv);

Could you please pay attention to alignment of the arguments and the 
opening brace? This patchset fails that in many places.

Thanks,
John

>   
>   static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
>   						 struct blk_mq_hw_ctx *hctx)
> 

