Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87226C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C8A2082B
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C8A2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbeLDPAY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:00:24 -0500
Received: from verein.lst.de ([213.95.11.211]:44295 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbeLDPAY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 10:00:24 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7C49A68BDB; Tue,  4 Dec 2018 16:00:22 +0100 (CET)
Date:   Tue, 4 Dec 2018 16:00:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 01/13] block: move queues types to the block layer
Message-ID: <20181204150022.GA3440@lst.de>
References: <20181202164628.1116-1-hch@lst.de> <20181202164628.1116-2-hch@lst.de> <5a1cd7aa-8937-ae23-c9ae-c8ddaf525080@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a1cd7aa-8937-ae23-c9ae-c8ddaf525080@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 03, 2018 at 04:49:56PM -0800, Sagi Grimberg wrote:
>> @@ -103,12 +101,17 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
>>   						     unsigned int flags,
>>   						     unsigned int cpu)
>>   {
>> -	int hctx_type = 0;
>> +	enum hctx_type type = HCTX_TYPE_DEFAULT;
>> +
>> +	if (q->tag_set->nr_maps > HCTX_TYPE_POLL &&
>> +	    ((flags & REQ_HIPRI) && test_bit(QUEUE_FLAG_POLL, &q->queue_flags)))
>> +		type = HCTX_TYPE_POLL;
>>   -	if (q->mq_ops->rq_flags_to_type)
>> -		hctx_type = q->mq_ops->rq_flags_to_type(q, flags);
>> +	else if (q->tag_set->nr_maps > HCTX_TYPE_READ &&
>> +		 ((flags & REQ_OP_MASK) == REQ_OP_READ))
>> +		type = HCTX_TYPE_READ;
>
> Nit, there seems to be an extra newline that can be omitted here before
> the else if statement (if I'm reading this correctly)...

Empty lines can always be ommited, but in this case I actually like it
as it seems to help readability..
