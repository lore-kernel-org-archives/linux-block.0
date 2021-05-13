Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B05BC433ED
	for <linux-block@archiver.kernel.org>; Thu, 13 May 2021 01:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12540611AE
	for <linux-block@archiver.kernel.org>; Thu, 13 May 2021 01:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhEMB2D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 21:28:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230322AbhEMB2C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 21:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620869213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0IeOLvkrAZQGTtr6LkMNlIliT+Himhj1UgnIENWNGN4=;
        b=SW//Z+E/Nv7AR/eGCAZrvhG+how9cxrfXK43c8uppYGYFOxt2yp933cJLUX5kXgbTK4a7A
        6+7S01hRP0OHtG1c+hOFat4rZrrxYJTRV8Ac4j9dy0tgQznjT5PLjq/uHvMaiZKqVm1t8V
        2Rw2fWGTs4FFhiCoB/KVsS+Py4CzfV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-Vn8JPlHkNsmVXoreJ5GFCQ-1; Wed, 12 May 2021 21:26:49 -0400
X-MC-Unique: Vn8JPlHkNsmVXoreJ5GFCQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 312B5801107;
        Thu, 13 May 2021 01:26:48 +0000 (UTC)
Received: from T590 (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42FC25D9D7;
        Thu, 13 May 2021 01:26:34 +0000 (UTC)
Date:   Thu, 13 May 2021 09:26:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 12/15] block: switch polling to be bio based
Message-ID: <YJyARt6S2JQ9H/Ew@T590>
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-13-hch@lst.de>
 <45d66945-165c-ae48-69f4-75dc553b0386@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45d66945-165c-ae48-69f4-75dc553b0386@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 12, 2021 at 03:03:40PM -0700, Sagi Grimberg wrote:
> 
> 
> On 5/12/21 6:15 AM, Christoph Hellwig wrote:
> > Replace the blk_poll interface that requires the caller to keep a queue
> > and cookie from the submissions with polling based on the bio.
> > 
> > Polling for the bio itself leads to a few advantages:
> > 
> >   - the cookie construction can made entirely private in blk-mq.c
> >   - the caller does not need to remember the request_queue and cookie
> >     separately and thus sidesteps their lifetime issues
> >   - keeping the device and the cookie inside the bio allows to trivially
> >     support polling BIOs remapping by stacking drivers
> >   - a lot of code to propagate the cookie back up the submission path can
> >     be removed entirely.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>

...

> > +int bio_poll(struct bio *bio, unsigned int flags)
> > +{
> > +	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> > +	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
> > +
> > +	if (cookie == BLK_QC_T_NONE ||
> > +	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> > +		return 0;
> > +
> > +	if (current->plug)
> > +		blk_flush_plug_list(current->plug, false);
> > +
> > +	/* not yet implemented, so this should not happen */
> > +	if (WARN_ON_ONCE(!queue_is_mq(q)))
> 
> What happens if the I/O wasn't (yet) queued to the bottom device
> (i.e. no available path in nvme-mpath)?
> 
> In this case the disk would be the mpath device node (which is
> not mq...)

->bi_cookie is only set in blk_mq_start_request() for blk-mq request,
if the I/O isn't queued to bottom device, it won't be polled because
->bi_cookie is still BLK_QC_T_NONE.


Thanks,
Ming

