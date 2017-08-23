Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45330 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753057AbdHWGqF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2017 02:46:05 -0400
Subject: Re: [PATCH V2 09/20] blk-mq: introduce BLK_MQ_F_SHARED_DEPTH
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Cc: "loberman@redhat.com" <loberman@redhat.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-10-ming.lei@redhat.com>
 <1503438955.2508.30.camel@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c21fd55d-664b-57cd-1abc-cc47a487c799@suse.de>
Date: Wed, 23 Aug 2017 08:46:03 +0200
MIME-Version: 1.0
In-Reply-To: <1503438955.2508.30.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/22/2017 11:55 PM, Bart Van Assche wrote:
> On Sat, 2017-08-05 at 14:56 +0800, Ming Lei wrote:
>> +	/*
>> +	 * if there is q->queue_depth, all hw queues share
>> +	 * this queue depth limit
>> +	 */
>> +	if (q->queue_depth) {
>> +		queue_for_each_hw_ctx(q, hctx, i)
>> +			hctx->flags |= BLK_MQ_F_SHARED_DEPTH;
>> +	}
>> +
>> +	if (!q->elevator)
>> +		goto exit;
> 
> Hello Ming,
> 
> It seems very fragile to me to set BLK_MQ_F_SHARED_DEPTH if and only if
> q->queue_depth != 0. Wouldn't it be better to let the block driver tell the
> block layer whether or not there is a queue depth limit across hardware
> queues, e.g. through a tag set flag?
> 
Yes, please.
I've come across this several times now, and am always tempted to
introduce this flag.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
