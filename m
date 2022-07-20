Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB7BC43334
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 10:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiGTKXm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 06:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbiGTKXl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 06:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CF812E6B8
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 03:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658312619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TS4i9vOT4cA2mBdP6hD5BdlXwAwC5xJFml+WHstg60E=;
        b=iPXQkVzqLp+dhZQV55Saj16lrONYDppmBpFdNLHhqAua1n+t6ZdnyQcwCvGDGj7c/9intW
        Y25sUzruofhK5Ysr5IWGYM+jcvTxJLNFApVNVqXIQEoEzNberdgazc2SYQd6N0/f6WD89q
        u/BPKziL5Jok1cawelSGdcOkI95XTvg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-vogVgB3tPJGNzBM6mXWE-Q-1; Wed, 20 Jul 2022 06:23:30 -0400
X-MC-Unique: vogVgB3tPJGNzBM6mXWE-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6719285A584;
        Wed, 20 Jul 2022 10:23:30 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 694C9141511A;
        Wed, 20 Jul 2022 10:23:26 +0000 (UTC)
Date:   Wed, 20 Jul 2022 18:23:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 2/2] Revert "ublk_drv: fix request queue leak"
Message-ID: <YtfXmlbhN9WAPK71@T590>
References: <20220718062928.335399-1-hch@lst.de>
 <20220718062928.335399-2-hch@lst.de>
 <YtalgzqC/q3JpYCR@T590>
 <20220720060705.GB6734@lst.de>
 <YtezD/apQ1dM0n33@T590>
 <20220720090040.GA18210@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720090040.GA18210@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 20, 2022 at 11:00:40AM +0200, Christoph Hellwig wrote:
> On Wed, Jul 20, 2022 at 03:47:27PM +0800, Ming Lei wrote:
> > > What is broken in START_DEV/STOP_DEV?  Please explain the semantics you
> > > want and what doesn't work.  FYI, there is nothing in the test suite the
> > > complains.  And besides the obvious block layer bug that Jens found you
> > > seemed to be perfectly happy with the semantics.
> > 
> > START_DEV calls add_disk(), and STOP_DEV calls del_gendisk(), but if 
> > GD_OWNS_QUEUE is set, blk_mq_exit_queue() will be called in
> > del_gendisk(), then the following START_DEV will stuck.
> 
> Uh, yeah.  alloc_disk and add_disk are supposed to be paired and
> not split over different ioctls.  The lifetime rules here are
> rather broken.

Even though alloc_disk and add_disk is paired here, GD_OWNS_QUEUE still
can't be set because request queue has to be workable for the new alloc/
added disk, just like scsi.

So it is nothing to do with pair of alloc_disk/add_disk().

Not mention I don't see any thing wrong with adding/deleting disk
multiple times.

Thanks,
Ming

