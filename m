Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC51C433C1
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 08:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFAA06195D
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 08:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhC3Iua (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 04:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27523 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229530AbhC3IuU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 04:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617094219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NhqVQ817HwU5LWURD+dWlD0ONR0PaBLKta12Pq3I+u8=;
        b=aJckkscfWdsBItnacJAvPVzMU+AcUgitraaaMb+ZhhuYQdPVRrhOSLqmtQt3cnlcT5B/Yg
        z+E/iF6Bkwb2cx9GRoPtz0Krrzz701rNaJCOqMqmqQSYBk8qglHk/9ioEi6ycIJnZPAR6l
        e8xv/NG2Fcg16PVuehl1n3yelIrnKeI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-7OV1WLVsMuCpRSqrE-fwLA-1; Tue, 30 Mar 2021 04:50:15 -0400
X-MC-Unique: 7OV1WLVsMuCpRSqrE-fwLA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0FB8801814;
        Tue, 30 Mar 2021 08:50:13 +0000 (UTC)
Received: from T590 (ovpn-13-69.pek2.redhat.com [10.72.13.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E4B754272;
        Tue, 30 Mar 2021 08:49:56 +0000 (UTC)
Date:   Tue, 30 Mar 2021 16:49:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com
Subject: Re: [PATCH V4 11/12] block: add poll_capable method to support
 bio-based IO polling
Message-ID: <YGLmMVAImqorRZup@T590>
References: <20210329152622.173035-1-ming.lei@redhat.com>
 <20210329152622.173035-12-ming.lei@redhat.com>
 <162f000f-7f86-8988-4a15-2c3bf70de1b7@suse.de>
 <a213b9b1-992d-3deb-200d-c74eac500747@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a213b9b1-992d-3deb-200d-c74eac500747@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 30, 2021 at 02:50:51PM +0800, JeffleXu wrote:
> 
> 
> On 3/30/21 2:26 PM, Hannes Reinecke wrote:
> > On 3/29/21 5:26 PM, Ming Lei wrote:
> >> From: Jeffle Xu <jefflexu@linux.alibaba.com>
> >>
> >> This method can be used to check if bio-based device supports IO polling
> >> or not. For mq devices, checking for hw queue in polling mode is
> >> adequate, while the sanity check shall be implementation specific for
> >> bio-based devices. For example, dm device needs to check if all
> >> underlying devices are capable of IO polling.
> >>
> >> Though bio-based device may have done the sanity check during the
> >> device initialization phase, cacheing the result of this sanity check
> >> (such as by cacheing in the queue_flags) may not work. Because for dm
> >> devices, users could change the state of the underlying devices through
> >> '/sys/block/<dev>/io_poll', bypassing the dm device above. In this case,
> >> the cached result of the very beginning sanity check could be
> >> out-of-date. Thus the sanity check needs to be done every time 'io_poll'
> >> is to be modified.
> >>
> >> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> >> ---
> >>   block/blk-sysfs.c      | 14 +++++++++++---
> >>   include/linux/blkdev.h |  1 +
> >>   2 files changed, 12 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> >> index db3268d41274..c8e7e4af66cb 100644
> >> --- a/block/blk-sysfs.c
> >> +++ b/block/blk-sysfs.c
> >> @@ -426,9 +426,17 @@ static ssize_t queue_poll_store(struct
> >> request_queue *q, const char *page,
> >>       unsigned long poll_on;
> >>       ssize_t ret;
> >>   -    if (!q->tag_set || q->tag_set->nr_maps <= HCTX_TYPE_POLL ||
> >> -        !q->tag_set->map[HCTX_TYPE_POLL].nr_queues)
> >> -        return -EINVAL;
> >> +    if (queue_is_mq(q)) {
> >> +        if (!q->tag_set || q->tag_set->nr_maps <= HCTX_TYPE_POLL ||
> >> +            !q->tag_set->map[HCTX_TYPE_POLL].nr_queues)
> >> +            return -EINVAL;
> >> +    } else {
> >> +        struct gendisk *disk = queue_to_disk(q);
> >> +
> >> +        if (!disk->fops->poll_capable ||
> >> +            !disk->fops->poll_capable(disk))
> >> +            return -EINVAL;
> >> +    }
> >>         ret = queue_var_store(&poll_on, page, count);
> >>       if (ret < 0)
> >> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> >> index bfab74b45f15..a46f975f2a2f 100644
> >> --- a/include/linux/blkdev.h
> >> +++ b/include/linux/blkdev.h
> >> @@ -1881,6 +1881,7 @@ struct block_device_operations {
> >>       int (*report_zones)(struct gendisk *, sector_t sector,
> >>               unsigned int nr_zones, report_zones_cb cb, void *data);
> >>       char *(*devnode)(struct gendisk *disk, umode_t *mode);
> >> +    bool (*poll_capable)(struct gendisk *disk);
> >>       struct module *owner;
> >>       const struct pr_ops *pr_ops;
> >>   };
> >>
> > I really wonder how this would work for nvme multipath; but I guess it
> > doesn't change the current situation.

It should work for nvme multipath since the approach covers this case,
and bio submitted to underlying NVMe is marked with REQ_HIPRI and
REQ_POLL_CTX too.

> 
> I wonder, at least, md/dm, which is built upon other devices, or
> 'virtual device' in other words, should be distinguished from other
> 'original' bio-based device (e.g., nvme multipath) then. Maybe one extra
> flag or something.

There is REQ_NVME_MPATH, but not sure we need to deal with that.


Thanks,
Ming

