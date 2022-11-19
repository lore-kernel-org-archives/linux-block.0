Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826C0C4332F
	for <linux-block@archiver.kernel.org>; Sat, 19 Nov 2022 02:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiKSCdi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 21:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiKSCdY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 21:33:24 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705EBCB969
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 18:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dIO5XSXejWrRTqUhCAd0BrkP1TqT4A2bGj1dzMsGG9Q=; b=opl/0OFefmq5R8HWbgP6328Cz7
        MoYq3niZG+n346iue5N3XtbqEK7ccwe9y0QQsYVJztmBOWfBPIKK/uusYPnfm/JmyI+8KMR/+aPa8
        UDIbYt4Kg9l3mMBn2T2VkmHurSMFPx+01rAL1SabUI7kfnHtrdYu+Uoeyp63JS3/4F99YyUI36Tq1
        AXysGVnCVsHOShu9hLH/t87vW3/7/ZL0kgVoa856/cjF7ZfbXxW8+hdNAvQrJJuC4wqSjECI/RgFw
        /3GgmyYRrur5X0uK+r2WLLd9Ezbz26yu/8u6nZF7VbekpeEqakQ3hHJ6DdE3QNiRyJ4QFhDfqf5f3
        B2EGLvgQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1owDSK-004xtE-04;
        Sat, 19 Nov 2022 02:19:44 +0000
Date:   Sat, 19 Nov 2022 02:19:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: untangle the request_queue refcounting from the queue kobject v2
Message-ID: <Y3g9P8NB+ubuKaqA@ZenIV>
References: <20221114042637.1009333-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114042637.1009333-1-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 14, 2022 at 05:26:32AM +0100, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up the registration of the "queue/" kobject, and given
> untangles it from the request_queue refcounting.
> 
> Changes since v1:
>  - also change the blk_crypto_sysfs_unregister prototype
>  - add two patches to fix the error handling in blk_register_queue

Umm...  Do we ever want access to queue parameters of the stuff that has
a queue, but no associated gendisk?  SCSI tape, for example...

	Re refcounting: AFAICS, blk_mq_alloc_disk_for_queue() is broken.
__alloc_disk_node() consumes queue reference (and stuffs it into gendisk->queue)
on success; on failure it leaves the reference alone.  E.g. this

struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
		struct lock_class_key *lkclass)
{
	struct request_queue *q;
	struct gendisk *disk;

	q = blk_mq_init_queue_data(set, queuedata);
	if (IS_ERR(q))
		return ERR_CAST(q);

// we hold the initial reference to q
	disk = __alloc_disk_node(q, set->numa_node, lkclass);
	if (!disk) {
// __alloc_disk_node() failed, we are still holding q
		blk_mq_destroy_queue(q);
		blk_put_queue(q);
// reference dropped
		return ERR_PTR(-ENOMEM);
	}
	set_bit(GD_OWNS_QUEUE, &disk->state);
	return disk;
// ... and on success, the reference is consumed by disk, which is returned to caller
}

is fine; however, this
struct gendisk *blk_mq_alloc_disk_for_queue(struct request_queue *q,
		struct lock_class_key *lkclass)
{
	if (!blk_get_queue(q))
		return NULL;
	return __alloc_disk_node(q, NUMA_NO_NODE, lkclass);
}
can't be right - we might fail in blk_get_queue(), returning NULL with
unchanged refcount, we might succeed and return the new gendisk that
has consumed the extra reference grabbed by blk_get_queue() *OR*
we might grab an extra reference, fail in __alloc_disk_node() and
return NULL with refcount on q bumped.  No way for caller to tell these
failure modes from each other...  The callers (both sd and sr) treat
both as "no reference grabbed", i.e. leak the queue refcount if they
fail past grabbing the queue.

Looks like we should drop the queue if __alloc_disk_node() fails.  As in

struct gendisk *blk_mq_alloc_disk_for_queue(struct request_queue *q,
		struct lock_class_key *lkclass)
{
	struct gendisk *disk;

	if (!blk_get_queue(q))
		return NULL;
	disk = __alloc_disk_node(q, NUMA_NO_NODE, lkclass);
	if (!disk)
		blk_put_queue(q);
	return disk;
}

Objections?
