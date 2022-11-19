Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2A0C43217
	for <linux-block@archiver.kernel.org>; Sat, 19 Nov 2022 03:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiKSDAu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 22:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiKSDAo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 22:00:44 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6158CA4653
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 19:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hIjDnzJd2TvPjk/3Xa6mtdft/xgss0m+CweC3wweBkI=; b=hRQivk6KqKB47zKOEy5oOajNqd
        FHH1k6OX7jqy3ZrEVZFRIVnb/ajlMEYyHlXsE6yE3KEuohwIMNgkP0WUg+4NLXNWAwOsi7/YJXMvc
        ULkRoq7Za5Jg53OkxtG9HKAgfH4N7I+nTDuQBXrRq9N4boZjQwCkP1TioWkFK+wj84WlhsQ+CRmqC
        3vj9eKJKQB7+3jyXgf9WEYCp+XUpkF8X+o2sf16rov/cLXa0EHVpqcjRldO+o1LnmS1XNgindn5AP
        fzcyy9VL3y2O9iwnanrBYakvWoR3zfCXNVkVDqzV9HXqit6xMm7iPZJiYjeXOhcIAeJbj5/EU7XKv
        5NzR0Mmw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1owE5v-004yJb-3B;
        Sat, 19 Nov 2022 03:00:40 +0000
Date:   Sat, 19 Nov 2022 03:00:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: untangle the request_queue refcounting from the queue kobject v2
Message-ID: <Y3hG1/1Ki/cTaSWx@ZenIV>
References: <20221114042637.1009333-1-hch@lst.de>
 <Y3g9P8NB+ubuKaqA@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3g9P8NB+ubuKaqA@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 19, 2022 at 02:19:43AM +0000, Al Viro wrote:
> On Mon, Nov 14, 2022 at 05:26:32AM +0100, Christoph Hellwig wrote:
> > Hi Jens,
> > 
> > this series cleans up the registration of the "queue/" kobject, and given
> > untangles it from the request_queue refcounting.
> > 
> > Changes since v1:
> >  - also change the blk_crypto_sysfs_unregister prototype
> >  - add two patches to fix the error handling in blk_register_queue
> 
> Umm...  Do we ever want access to queue parameters of the stuff that has
> a queue, but no associated gendisk?  SCSI tape, for example...
> 
> 	Re refcounting: AFAICS, blk_mq_alloc_disk_for_queue() is broken.

[snip]

> can't be right - we might fail in blk_get_queue(), returning NULL with
> unchanged refcount, we might succeed and return the new gendisk that
> has consumed the extra reference grabbed by blk_get_queue() *OR*
> we might grab an extra reference, fail in __alloc_disk_node() and
> return NULL with refcount on q bumped.  No way for caller to tell these
> failure modes from each other...  The callers (both sd and sr) treat
> both as "no reference grabbed", i.e. leak the queue refcount if they
> fail past grabbing the queue.

Speaking of leaks, how can this
	q = blk_mq_init_queue(&sdev->host->tag_set);
	if (IS_ERR(q)) {
		/* release fn is set up in scsi_sysfs_device_initialise, so
		 * have to free and put manually here */
		put_device(&starget->dev);
		kfree(sdev);
		goto out;
	}
	kref_get(&sdev->host->tagset_refcnt);
	sdev->request_queue = q;
	q->queuedata = sdev;
	__scsi_init_queue(sdev->host, q);

	depth = sdev->host->cmd_per_lun ?: 1;

	/*
	 * Use .can_queue as budget map's depth because we have to
	 * support adjusting queue depth from sysfs. Meantime use
	 * default device queue depth to figure out sbitmap shift
	 * since we use this queue depth most of times.
	 */
	if (scsi_realloc_sdev_budget_map(sdev, depth)) {
		put_device(&starget->dev);
		kfree(sdev);
		goto out;
	}
	...
out:
        if (display_failure_msg)
                printk(ALLOC_FAILURE_MSG, __func__);
        return NULL;


in scsi_alloc_sdev() possibly avoid leaking sdev->request_queue on the
second failure exit?  AFAICS scsi_realloc_sdev_budget_map() will see
NULL in sdev->budget_map.map, attempt
        ret = sbitmap_init_node(&sdev->budget_map,
                                scsi_device_max_queue_depth(sdev),
                                new_shift, GFP_KERNEL,
                                sdev->request_queue->node, false, true);
and if that fails - return without having even looked at sdev->request_queue.
Then we drop startget->dev (which has no way to observe sdev or anything in
it) and kfree sdev, which leaves q the only place where we have the address
of queue.  And we don't look at q after that point...

Shouldn't we do blk_mq_destroy_queue()/blk_put_queue() on that failure
exit?
