Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F3EC433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 06:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238122AbiFTGUS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 02:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiFTGUQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 02:20:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B3FBE35
        for <linux-block@vger.kernel.org>; Sun, 19 Jun 2022 23:20:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 25B3C6732D; Mon, 20 Jun 2022 08:20:12 +0200 (CEST)
Date:   Mon, 20 Jun 2022 08:20:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/6] block: remove QUEUE_FLAG_DEAD
Message-ID: <20220620062011.GA10640@lst.de>
References: <20220619060552.1850436-1-hch@lst.de> <20220619060552.1850436-4-hch@lst.de> <463adfd1-45fb-0f9f-2f25-34408b76e75c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <463adfd1-45fb-0f9f-2f25-34408b76e75c@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jun 19, 2022 at 07:07:20AM -0700, Bart Van Assche wrote:
>> -	if (blk_queue_dead(q))
>> +	if (blk_queue_dying(q))
>>   		return -ENOENT;
>
> I'm missing an explanation of why this patch forbids triggering a queue run 
> in the dying state. "dying" means that allocation of new requests will 
> fail. Unless if something fundamentally has changed in the block layer it 
> should still be safe to trigger a queue run in the "dying" state.

It is safe, but not worth having another queue state for given that we
can otherwise remove the QUEUE_FLAG_DEAD bit.
