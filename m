Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD660C2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 08:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F51620780
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 08:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3OMZeqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgJ2Iko (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Oct 2020 04:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727525AbgJ2Ikn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 04:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603960842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yXpoCp5F69SBdTWlSKxi7RVRiKULxtrkX0olXYHBSW4=;
        b=e3OMZeqRCdsOjwQlzsPG8GmTsgqOBcH5M1HhvyUA5xP/D735OJCcs/pY/pQtM5PJKTAfYh
        M2LwUX1WMoV0/iRjkNtIfYOEpGOcKbN8Zgybf8tbehBbI50TWPqgIu1ynywsnyIgY3Pg7R
        9kkxE8uAHN+hpHdNwHq7SYqxXDrxWrY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-M0HUPgRGNuC5FYcwFNwxNg-1; Thu, 29 Oct 2020 04:40:38 -0400
X-MC-Unique: M0HUPgRGNuC5FYcwFNwxNg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 558B164149;
        Thu, 29 Oct 2020 08:40:37 +0000 (UTC)
Received: from T590 (ovpn-12-130.pek2.redhat.com [10.72.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 142145C1D0;
        Thu, 29 Oct 2020 08:40:30 +0000 (UTC)
Date:   Thu, 29 Oct 2020 16:40:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        lining <lining2020x@163.com>, Josef Bacik <josef@toxicpanda.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] nbd: don't update block size after device is started
Message-ID: <20201029084027.GA1970901@T590>
References: <20201028072434.1922108-1-ming.lei@redhat.com>
 <20201029075149.GA1602@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029075149.GA1602@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 29, 2020 at 07:51:49AM +0000, Christoph Hellwig wrote:
> On Wed, Oct 28, 2020 at 03:24:34PM +0800, Ming Lei wrote:
> > Mounted NBD device can be resized, one use case is rbd-nbd.
> > 
> > Fix the issue by setting up default block size, then not touch it
> > in nbd_size_update() any more. This kind of usage is aligned with loop
> > which has same use case too.
> 
> I think the only reasonable fix here is to remove the set_blocksize
> call entirely.  The concept of block size set by it is a file system
> construct and nbd has not business setting it at all.

I think the idea is reasonable, we have several drivers(loop, nbd, zram,
pktcdvd, bcache) which call into set_blocksize().

Also ioctl(BLKBSZSET) which is used by 'blockdev --setbsz', still not
understand which kind of use case is served for.


Thanks,
Ming

