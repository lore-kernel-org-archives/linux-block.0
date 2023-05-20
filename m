Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCFBC7EE26
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 04:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjETE4v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 May 2023 00:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjETE4u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 00:56:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE98BA0
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 21:56:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5F3CB68CFE; Sat, 20 May 2023 06:56:44 +0200 (CEST)
Date:   Sat, 20 May 2023 06:56:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 7/7] blk-mq: don't use the requeue list to queue flush
 commands
Message-ID: <20230520045644.GB32182@lst.de>
References: <20230519044050.107790-1-hch@lst.de> <20230519044050.107790-8-hch@lst.de> <36dbbde0-e7f4-c1bd-8015-6265ac812786@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36dbbde0-e7f4-c1bd-8015-6265ac812786@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 19, 2023 at 12:55:45PM -0700, Bart Van Assche wrote:
>>   	LIST_HEAD(rq_list);
>> -	struct request *rq, *next;
>> +	LIST_HEAD(flush_list);
>> +	struct request *rq;
>>     	spin_lock_irq(&q->requeue_lock);
>>   	list_splice_init(&q->requeue_list, &rq_list);
>> +	list_splice_init(&q->flush_list, &flush_list);
>>   	spin_unlock_irq(&q->requeue_lock);
>
> "rq_list" stands for "request_list". That name is now confusing since this patch
> add a second request list (flush_list).

It is.  But I think you were planning on doing a bigger rework in this
area anyway?
