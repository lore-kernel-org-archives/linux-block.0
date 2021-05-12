Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4900BC433ED
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 15:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 152FE619C5
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 15:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhELPLG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 11:11:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:36010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232981AbhELPJG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 11:09:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 13903AFCD;
        Wed, 12 May 2021 15:07:57 +0000 (UTC)
Subject: Re: [PATCH v1 1/8] block: refcount the request_queue early in
 __device_add_disk()
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210512064629.13899-1-mcgrof@kernel.org>
 <20210512064629.13899-2-mcgrof@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ae439ba5-ad0e-f898-8eda-9c5533af58f8@suse.de>
Date:   Wed, 12 May 2021 17:07:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210512064629.13899-2-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/21 8:46 AM, Luis Chamberlain wrote:
> We refcount the request_queue right now towards the end of the
> __device_add_disk(), however when we add error handling on this
> function we'll want to refcount the request_queue first, to help
> make less complicated changes on drivers on their error paths.
> 
> For instance, today a driver may call add_disk without error handling
> but still handle other errors:
> 
> int foo_block_add(...)
> {
> 	...
> 	queue = blk_mq_init_queue(...);
> 	...
> 	disk->queue = queue;
> 	disk = alloc_disk(...);
> 	if (!disk)
> 		goto out_free_queue;
> 	...
>          add_disk(disk);
> 	...
>          return 0;
> 
> out_free_queue:
>          blk_cleanup_queue(queue);
> 	/* Note: we never call put_disk() as add_disk() never failed */
> 	...
> }
> 
> We want drivers to cleanup with put_disk() on the error path if
> add_disk() fails. However, calling blk_cleanup_queue() will already
> put the queue, and so the last put_disk() on the error path will
> be extra. This can be simplified later if once error handling is
> added to __device_add_disk(), if refcounting the request_queue
> fails right away on __device_add_disk() we just return early and
> set disk->NULL for the driver. That would ensure driver error
> paths chug on with their error paths, and all they'd need to
> expand with is the missing put_disk().
> 
> The collateral evolution for adding error paths for add_disk() becomes
> larger with the alternative of replacing the blk_cleanup_queue() with
> a put_disk(). We'd still need to sprinkle then some blk_cleanup_queue()
> calls on the driver paths up above prior to add_disk(). And how would
> we know we reached a part of add_disk() which did refcount then?
> 
> A related commit is 5a0ec388ef0 ("pktcdvd: Fix pkt_setup_dev() error
> path") which *had* to take the approach of removing the blk_cleanup_queue()
> because otherwise the driver crashes.
> 
> Moving this to the top ensure our future error path can easily just
> handle this itself. For instance, if it was not able to refcount the
> request_queue it can disk->queue to NULL, that way allowing a
> blk_cleanup_queue() call followed but a put_disk(). And if the
> refcount was incremented, we'd still be able to keep the same error
> path of blk_cleanup_queue() followed by put_disk().
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   block/genhd.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
