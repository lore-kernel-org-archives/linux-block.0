Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FC5C4332F
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 09:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiAQJIz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 04:08:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232619AbiAQJIy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 04:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642410534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jW5D2ERgawesUqlNSwP7hlu0lpi3I08Xd1+MoofN+wE=;
        b=JN6j3OB3rQMeHyc2ydVs1D2jVLnFrcINUcNHZF0cnOa1xhgFazlvOwWnVrfeud2eNW0kY2
        +opPyU7YrWt1VnxLz3jB5R0MNFlXPvESM9u2bc9yFw8dWI1NeBWoUKWjLc7QS4Z5+f1aNY
        CGM1eRms3al8X0qZhpYwJ1TxygBgm8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-kvJE8VEkOYOa9RRx2a41yA-1; Mon, 17 Jan 2022 04:08:50 -0500
X-MC-Unique: kvJE8VEkOYOa9RRx2a41yA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73BC92F24;
        Mon, 17 Jan 2022 09:08:49 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA0796A023;
        Mon, 17 Jan 2022 09:08:28 +0000 (UTC)
Date:   Mon, 17 Jan 2022 17:08:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3] block: don't drain file system I/O on del_gendisk
Message-ID: <YeUyB/5YtA1AGyt8@T590>
References: <20220116041815.1218170-1-ming.lei@redhat.com>
 <20220117081321.GA22627@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117081321.GA22627@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 17, 2022 at 09:13:21AM +0100, Christoph Hellwig wrote:
> On Sun, Jan 16, 2022 at 12:18:12PM +0800, Ming Lei wrote:
> > Hello,
> > 
> > Draining FS I/O on del_gendisk() is added for just avoiding to refer to
> > recently added q->disk in IO path, and it isn't actually needed.
> 
> We need it to have proper life times in the block layer.  Everything only
> needed for file system I/O and not blk-mq specific should slowly move
> from the request_queue to the gendisk and I have patches going in
> that direction.  In the end only the SCSI discovery code and the case
> of /dev/sg without SCSI ULP will ever do passthrough I/O purely on the
> gendisk.
> 
> So I think this series is moving in the wrong direction.  If you care
> about no doing two freeze cycles the right thing to do is to record

I just think that the extra draining point in del_gendisk() isn't useful,
can you share any use case with this change?

> if we ever did non-disk based passthrough I/O on a requeue_queue and
> if not simplify the request_queue cleanup.  Doing this is on my TODO
> list but I haven't look into the details yet.
> 
> > 1) queue freezing can't drain FS I/O for bio based driver
> 
> This is something I've started looking into it.

But that is one big problem, not sure you can solve it in short time,
also not sure if it is useful, cause FS already guaranteed that every
IO is drained before releasing disk, or IOs in the submission task are
drained when exiting the task.

> 
> > 2) it isn't easy to move elevator/cgroup/throttle shutdown during
> > del_gendisk, and q->disk can still be referred in these code paths
> 
> I've also done some prep work to land this cycle here, as all that
> code is only used for FS I/O.

IMO,

Firstly, FS layer has already guaranteed that every FS IO is done before
releasing disk, so no need to take so much effort and make code more
fragile to add one extra FS IO draining point in del_gendisk().

Also the above two things aren't trivial enough to solve in short time, so
can we delay the FS draining in del_gendisk() until the two are done?

Thanks,
Ming

