Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B753CC77B7D
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 06:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjEQGqD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 02:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEQGqC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 02:46:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A41CCE
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 23:46:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 445516732A; Wed, 17 May 2023 08:45:57 +0200 (CEST)
Date:   Wed, 17 May 2023 08:45:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v5 03/11] block: Introduce op_is_zoned_write()
Message-ID: <20230517064556.GA24536@lst.de>
References: <20230516223323.1383342-1-bvanassche@acm.org> <20230516223323.1383342-4-bvanassche@acm.org> <84348f20-6849-549c-5113-2faf1a6b40ad@kernel.org> <3cba6052-69ed-4ec4-dcbb-c0347a9ebd48@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cba6052-69ed-4ec4-dcbb-c0347a9ebd48@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 16, 2023 at 05:00:29PM -0700, Bart Van Assche wrote:
> On 5/16/23 16:30, Damien Le Moal wrote:
>> Or if you really want to rewrite this, may be something like:
>>
>> static inline bool bdev_op_is_zoned_write(struct block_device *bdev,
>>    					  enum req_op op)
>> {
>> 	return bdev_is_zoned(bdev) &&
>> 	       (op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES);
>> }
>>
>> which is very easy to understand.
>
> The op_is_zoned_write() function was introduced to use it in patch 4/11 of 
> this series. Anyway, I will look into open-coding it.

I think the idea here is that we're testing for an operation that needs
zone locking.  Maybe that needs to be reflected in the name?
op_needs_zone_write_locking() ?
