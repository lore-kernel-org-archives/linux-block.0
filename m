Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D51BC77B73
	for <linux-block@archiver.kernel.org>; Mon,  1 May 2023 04:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjEAEeu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 00:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjEAEet (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 00:34:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E3B10C4
        for <linux-block@vger.kernel.org>; Sun, 30 Apr 2023 21:34:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8468868B05; Mon,  1 May 2023 06:34:44 +0200 (CEST)
Date:   Mon, 1 May 2023 06:34:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 2/9] block: Micro-optimize
 blk_req_needs_zone_write_lock()
Message-ID: <20230501043444.GA19847@lst.de>
References: <20230424203329.2369688-1-bvanassche@acm.org> <20230424203329.2369688-3-bvanassche@acm.org> <20230428054446.GC8549@lst.de> <1c28f0b9-14f1-5fc1-4e15-52c4f6c2c91c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c28f0b9-14f1-5fc1-4e15-52c4f6c2c91c@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 28, 2023 at 12:46:06PM -0700, Bart Van Assche wrote:
>>> +	if ((bio_op(bio) == REQ_OP_WRITE ||
>>> +	     bio_op(bio) == REQ_OP_WRITE_ZEROES) &&
>>> +	    disk_zone_is_seq(bio->bi_bdev->bd_disk, bio->bi_iter.bi_sector))
>>>   		return NULL;
>>
>> I find this a bit hard to hard to read.  Why not:
>>
>> 	if (disk_zone_is_seq(bio->bi_bdev->bd_disk, bio->bi_iter.bi_sector)) {
>> 	  	/*
>> 		 * Do not plug for writes that require zone locking.
>> 		 */
>> 		if (bio_op(bio) == REQ_OP_WRITE ||
>> 		    bio_op(bio) == REQ_OP_WRITE_ZEROES)
>> 			return NULL;
>> 	}
>
> In the above alternative the expensive check happens before a check that is not
> expensive at all. Do you really want me to call disk_zone_is_seq() before checking
> the operation type?

What expensive check?  The first check in disk_zone_is_seq is for
a zoned device, avoiding any further check if it is not.

