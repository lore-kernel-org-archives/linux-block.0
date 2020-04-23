Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E009BC2BA19
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 07:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76242076C
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 07:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgDWHcB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:32:01 -0400
Received: from verein.lst.de ([213.95.11.211]:56475 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgDWHcB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Apr 2020 03:32:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7869168BEB; Thu, 23 Apr 2020 09:31:59 +0200 (CEST)
Date:   Thu, 23 Apr 2020 09:31:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V7 4/9] blk-mq: support rq filter callback when
 iterating rqs
Message-ID: <20200423073159.GD10951@lst.de>
References: <20200418030925.31996-1-ming.lei@redhat.com> <20200418030925.31996-5-ming.lei@redhat.com> <02c79673-44d8-16b6-bd45-93b7b8467497@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02c79673-44d8-16b6-bd45-93b7b8467497@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 20, 2020 at 11:34:11AM +0100, John Garry wrote:
>>   EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
>> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
>> index 2b8321efb682..fdf095d513e5 100644
>> --- a/block/blk-mq-tag.h
>> +++ b/block/blk-mq-tag.h
>> @@ -21,6 +21,7 @@ struct blk_mq_tags {
>>   	struct list_head page_list;
>>   };
>>   +typedef bool (busy_rq_iter_fn)(struct request *, void *, bool);
>>     extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, 
>> unsigned int reserved_tags, int node, int alloc_policy);
>>   extern void blk_mq_free_tags(struct blk_mq_tags *tags);
>> @@ -34,6 +35,9 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
>>   extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
>>   void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>>   		void *priv);
>> +void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
>> +		busy_tag_iter_fn *fn, busy_rq_iter_fn *busy_rq_fn,
>> +		void *priv);
>
> Could you please pay attention to alignment of the arguments and the 
> opening brace? This patchset fails that in many places.

Mings patch use the perfectly fine two tab alignment, which in many
ways is much easier to deal with than the weird brace alignment.
