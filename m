Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39590 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752714AbdASOTH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Jan 2017 09:19:07 -0500
Subject: Re: [bug report] blk-mq-tag: cleanup the normal/reserved tag
 allocation
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20170119105449.GA18622@mwanda>
CC: <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <43ac5634-0158-666d-b56c-6dfaf12db8c7@fb.com>
Date: Thu, 19 Jan 2017 06:13:59 -0800
MIME-Version: 1.0
In-Reply-To: <20170119105449.GA18622@mwanda>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/19/2017 02:54 AM, Dan Carpenter wrote:
> Hello Jens Axboe,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 4941115bef2b: "blk-mq-tag: cleanup the normal/reserved tag 
> allocation" from Jan 13, 2017, leads to the following Smatch 
> complaint:
> 
> block/blk-mq-tag.c:142 blk_mq_get_tag()
> 	 warn: variable dereferenced before check 'data->hctx' (see line 102)
> 
> block/blk-mq-tag.c
>    101	{
>    102		struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
>                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> We added a new "data->hctx" dereference here.
> 
>    103		struct sbitmap_queue *bt;
>    104		struct sbq_wait_state *ws;
>    105		DEFINE_WAIT(wait);
>    106		unsigned int tag_offset;
>    107		int tag;
>    108	
>    109		if (data->flags & BLK_MQ_REQ_RESERVED) {
>    110			if (unlikely(!tags->nr_reserved_tags)) {
>    111				WARN_ON_ONCE(1);
>    112				return BLK_MQ_TAG_FAIL;
>    113			}
>    114			bt = &tags->breserved_tags;
>    115			tag_offset = 0;
>    116		} else {
>    117			bt = &tags->bitmap_tags;
>    118			tag_offset = tags->nr_reserved_tags;
>    119		}
>    120	
>    121		tag = __blk_mq_get_tag(data->hctx, bt);
>    122		if (tag != -1)
>    123			goto found_tag;
>    124	
>    125		if (data->flags & BLK_MQ_REQ_NOWAIT)
>    126			return BLK_MQ_TAG_FAIL;
>    127	
>    128		ws = bt_wait_ptr(bt, data->hctx);
>    129		do {
>    130			prepare_to_wait(&ws->wait, &wait, TASK_UNINTERRUPTIBLE);
>    131	
>    132			tag = __blk_mq_get_tag(data->hctx, bt);
>    133			if (tag != -1)
>    134				break;
>    135	
>    136			/*
>    137			 * We're out of tags on this hardware queue, kick any
>    138			 * pending IO submits before going to sleep waiting for
>    139			 * some to complete. Note that hctx can be NULL here for
>    140			 * reserved tag allocation.
>    141			 */
>    142			if (data->hctx)
> 
> We're in a loop here so it's possible we don't need to check the first
> item in the list, but it's kind of new so I thought I would forward the
> message anyway even though it might be a false positive.

It's no longer possible for 'hctx' to be passed in as NULL, so the above
dereference is safe. I'll tend to this superfluous hctx check.


-- 
Jens Axboe

