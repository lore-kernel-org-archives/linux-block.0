Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695BCC433EF
	for <linux-block@archiver.kernel.org>; Wed, 19 Jan 2022 09:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352324AbiASJC2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jan 2022 04:02:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41018 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351966AbiASJCY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jan 2022 04:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642582943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vCtc/eUM07QxPqgaFuv4NMuDMm9qfx8G9qd5wst1y6c=;
        b=c4JRiNbP12rB3SLVlexNkjV5vlWv5ENofy+OazHzE9Bsi1Bq0wH0aOcfOpa2nzOj3z5geM
        5A2WYuLOJm3sjRa6tKVkp3QjEXE9l0WGgge+qL2H5BiOR+9pNIDCVTaXH64B+leLGJPh/A
        IjXUH7PvOcgFu39a37J+k2093IQShbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-tsKOYjfxP1CLV4g6SMwyLw-1; Wed, 19 Jan 2022 04:02:19 -0500
X-MC-Unique: tsKOYjfxP1CLV4g6SMwyLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 837CC1853028;
        Wed, 19 Jan 2022 09:02:18 +0000 (UTC)
Received: from T590 (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3429373146;
        Wed, 19 Jan 2022 09:02:15 +0000 (UTC)
Date:   Wed, 19 Jan 2022 17:02:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3] block: don't drain file system I/O on del_gendisk
Message-ID: <YefTkiRGwvxY19hF@T590>
References: <20220116041815.1218170-1-ming.lei@redhat.com>
 <20220117081321.GA22627@lst.de>
 <YeUyB/5YtA1AGyt8@T590>
 <20220118082508.GB21847@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118082508.GB21847@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 18, 2022 at 09:25:08AM +0100, Christoph Hellwig wrote:
> On Mon, Jan 17, 2022 at 05:08:23PM +0800, Ming Lei wrote:
> > > We need it to have proper life times in the block layer.  Everything only
> > > needed for file system I/O and not blk-mq specific should slowly move
> > > from the request_queue to the gendisk and I have patches going in
> > > that direction.  In the end only the SCSI discovery code and the case
> > > of /dev/sg without SCSI ULP will ever do passthrough I/O purely on the
> > > gendisk.
> > > 
> > > So I think this series is moving in the wrong direction.  If you care
> > > about no doing two freeze cycles the right thing to do is to record
> > 
> > I just think that the extra draining point in del_gendisk() isn't useful,
> > can you share any use case with this change?
> 
> SCSI disk detach for example is a place where we need it.

SCSI disk detach doesn't need it, since 8e141f9eb803 ("block: drain file
system I/O on del_gendisk") is added for fixing q->disk in Sept., 2021, but
sd detach has been there for dozens of years.

del_gendisk() starts to prevent new IO from being submitted to queue,
and sync and flush dirty pages, but other in-flight IOs are still fine,
since disk release will wait for all of them.

> 
> > > if we ever did non-disk based passthrough I/O on a requeue_queue and
> > > if not simplify the request_queue cleanup.  Doing this is on my TODO
> > > list but I haven't look into the details yet.
> > > 
> > > > 1) queue freezing can't drain FS I/O for bio based driver
> > > 
> > > This is something I've started looking into it.
> > 
> > But that is one big problem, not sure you can solve it in short time,
> > also not sure if it is useful, cause FS already guaranteed that every
> > IO is drained before releasing disk, or IOs in the submission task are
> > drained when exiting the task.
> 
> Think of a hot unplug.  The device gets a removal even, but the file
> system still lives on.

No need the extra drain point, same with above.

> 
> > Firstly, FS layer has already guaranteed that every FS IO is done before
> > releasing disk, so no need to take so much effort and make code more
> > fragile to add one extra FS IO draining point in del_gendisk().
> 
> In the hot removal case the file system is still alive when del_gendisk
> is called.

Yeah, but draining IO in del_gendisk() doesn't make difference from FS
viewpoint, does it?

> 
> > Also the above two things aren't trivial enough to solve in short time, so
> > can we delay the FS draining in del_gendisk() until the two are done?
> 
> We already have the draining.  What are you trying to fix by removing it?

It is just added months ago, and doesn't mean it is reasonable/necessary.

Now I am thinking of handling this stuff in the following approach:

1) move block cgroup and rqos allocation into allocating disk, and move their
destroying into disk release handler; and in long term, both two can be moved
into gendisk, as you mentioned.

2) just run io accounting on passthrough request from user space, such
as, sg io and nvme ns io, and one RQF_USER_IO flag may help to do that; for
other private kinds of command, we needn't to account them and q->disk may
not be available for them.

3) once the above two are done, we still can remove the added io draining in
del_gendisk().


Thanks,
Ming

