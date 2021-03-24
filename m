Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B338AC433C1
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 00:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B18619A4
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 00:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbhCXALw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 20:11:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28560 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231535AbhCXAKd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 20:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616544630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nUMW97mUE/mOzpAy2Ox0F8J7K0mMzQfU1Gcf+0CRFII=;
        b=BvlHTntn/JmhBrwFbUODzgx3gD7lmagGdpnLpWDbXIH+6eTzqPiSZG/LzX8an5VA9i1qyo
        QS+SHxxDnIFU3vSrX5bg5fXxzZopV828+yNuLxeSWddKNIARZ5mkToRksb0M6pZlXlpu2H
        WUbijihq5cQ2/8V4Qj6CzsnAr4f+lG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-VHBRTS8fO52vI7H03DxWrA-1; Tue, 23 Mar 2021 20:10:26 -0400
X-MC-Unique: VHBRTS8fO52vI7H03DxWrA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D18C5101371F;
        Wed, 24 Mar 2021 00:10:23 +0000 (UTC)
Received: from T590 (ovpn-12-85.pek2.redhat.com [10.72.12.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D219F18B84;
        Wed, 24 Mar 2021 00:10:10 +0000 (UTC)
Date:   Wed, 24 Mar 2021 08:10:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Subject: Re: [RFC PATCH V2 09/13] block: use per-task poll context to
 implement bio based io poll
Message-ID: <YFqDXeEsDNBfoWqW@T590>
References: <20210318164827.1481133-1-ming.lei@redhat.com>
 <20210318164827.1481133-10-ming.lei@redhat.com>
 <522a2c87-e9f3-e62a-e09b-084821c698a0@grimberg.me>
 <YFnYhBIiFhiyX8Wb@T590>
 <713f2a27-4a2c-8723-3dfd-de6d68956eb2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <713f2a27-4a2c-8723-3dfd-de6d68956eb2@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 23, 2021 at 09:54:36AM -0700, Sagi Grimberg wrote:
> 
> > > > +static void blk_bio_poll_post_submit(struct bio *bio, blk_qc_t cookie)
> > > > +{
> > > > +	bio->bi_iter.bi_private_data = cookie;
> > > > +}
> > > > +
> > > 
> > > Hey Ming, thinking about nvme-mpath, I'm thinking that this should be
> > > an exported function for failover. nvme-mpath updates bio.bi_dev
> > > when re-submitting I/Os to an alternate path, so I'm thinking
> > > that if this function is exported then nvme-mpath could do as little
> > > as the below to allow polling?
> > > 
> > > --
> > > diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> > > index 92adebfaf86f..e562e296153b 100644
> > > --- a/drivers/nvme/host/multipath.c
> > > +++ b/drivers/nvme/host/multipath.c
> > > @@ -345,6 +345,7 @@ static void nvme_requeue_work(struct work_struct *work)
> > >          struct nvme_ns_head *head =
> > >                  container_of(work, struct nvme_ns_head, requeue_work);
> > >          struct bio *bio, *next;
> > > +       blk_qc_t cookie;
> > > 
> > >          spin_lock_irq(&head->requeue_lock);
> > >          next = bio_list_get(&head->requeue_list);
> > > @@ -359,7 +360,8 @@ static void nvme_requeue_work(struct work_struct *work)
> > >                   * path.
> > >                   */
> > >                  bio_set_dev(bio, head->disk->part0);
> > > -               submit_bio_noacct(bio);
> > > +               cookie = submit_bio_noacct(bio);
> > > +               blk_bio_poll_post_submit(bio, cookie);
> > >          }
> > >   }
> > > --
> > > 
> > > I/O failover will create misalignment from the polling context cpu and
> > > the submission cpu (running requeue_work), but I don't see if there is
> > > something that would break here...
> > 
> > I understand requeue shouldn't be one usual event, and I guess it is just
> > fine to fallback to IRQ based mode?
> 
> Well, when it will failover, it will probably be directed to the poll
> queues. Maybe I'm missing something...

In this patchset, because it isn't submitted directly from FS, there
isn't one polling context associated with this bio, so its HIPRI flag
will be cleared, then fallback to irq mode.

> 
> > This patchset actually doesn't cover such bio submission from kernel context.
> 
> What is the difference?

So far upper layer(io_uring, or dio, ..) needs to get the returned cookie, then
pass it to blk_poll().

For this case, the cookie can't be passed to FS caller of submit_bio(FS bio), so
it can't be polled by in-tree's code.



Thanks,
Ming

