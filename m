Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12DEC3A59C
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 15:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DA82086C
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 15:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfHPPpb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Aug 2019 11:45:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbfHPPpb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Aug 2019 11:45:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E60F4302C087;
        Fri, 16 Aug 2019 15:45:30 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38C675C1D6;
        Fri, 16 Aug 2019 15:45:22 +0000 (UTC)
Date:   Fri, 16 Aug 2019 23:45:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH] block: don't acquire .sysfs_lock before removing mq &
 iosched kobjects
Message-ID: <20190816154513.GA29878@ming.t460p>
References: <20190816135506.29253-1-ming.lei@redhat.com>
 <14a9ae85-0d65-483d-30f7-d692c4058e46@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14a9ae85-0d65-483d-30f7-d692c4058e46@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 16 Aug 2019 15:45:31 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 16, 2019 at 08:31:06AM -0700, Bart Van Assche wrote:
> On 8/16/19 6:55 AM, Ming Lei wrote:
> > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > index 977c659dcd18..46f033b48917 100644
> > --- a/block/blk-sysfs.c
> > +++ b/block/blk-sysfs.c
> > @@ -1021,6 +1021,7 @@ EXPORT_SYMBOL_GPL(blk_register_queue);
> >   void blk_unregister_queue(struct gendisk *disk)
> >   {
> >   	struct request_queue *q = disk->queue;
> > +	bool has_elevator;
> >   	if (WARN_ON(!q))
> >   		return;
> > @@ -1035,8 +1036,9 @@ void blk_unregister_queue(struct gendisk *disk)
> >   	 * concurrent elv_iosched_store() calls.
> >   	 */
> >   	mutex_lock(&q->sysfs_lock);
> > -
> >   	blk_queue_flag_clear(QUEUE_FLAG_REGISTERED, q);
> > +	has_elevator = q->elevator;
> > +	mutex_unlock(&q->sysfs_lock);
> 
> blk_queue_flag_clear() modifies queue flags atomically so no need to hold
> sysfs_lock around calls of that function.

If you take a look at the above comment, you will see why the sysfs lock
is needed.

> 
> > @@ -1044,16 +1046,13 @@ void blk_unregister_queue(struct gendisk *disk)
> >   	 */
> >   	if (queue_is_mq(q))
> >   		blk_mq_unregister_dev(disk_to_dev(disk), q);
> > -	mutex_unlock(&q->sysfs_lock);
> >   	kobject_uevent(&q->kobj, KOBJ_REMOVE);
> >   	kobject_del(&q->kobj);
> >   	blk_trace_remove_sysfs(disk_to_dev(disk));
> > -	mutex_lock(&q->sysfs_lock);
> > -	if (q->elevator)
> > +	if (has_elevator)
> >   		elv_unregister_queue(q);
> > -	mutex_unlock(&q->sysfs_lock);
> 
> Have you considered to move the q->elevator check into
> elv_unregister_queue() such that no new 'has_elevator' variable has to be
> introduced in this function?

No, I'd keep to read 'q->elevator' with .sysfs_lock.

Thanks,
Ming
