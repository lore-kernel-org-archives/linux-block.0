Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A792FC43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 01:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiF2BDW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 21:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiF2BDW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 21:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88D7BCE1E
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 18:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656464599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9DfL0TKwCbIIHmZiaEvsohNBWaKHM+N3CHK7MX6pw2E=;
        b=ItmRsYDyL3sJpVwVfdxT6R6HEn82a9/5RmnHwiynrcy5FKKVbeN6P8YjsxJPBSlL/NY78k
        AlxAQKQJH5cN2S/2zHwAeVKXsQwo6Ct28ZdE77Nf3Xs90R7/UwmkxPXNkD/RxGpPfGfJVv
        6nu8QcRB4uIM/xbcY1Hja9KXwkgC7f8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-no6mbkG4Pgydx_hrYyPEGw-1; Tue, 28 Jun 2022 21:03:10 -0400
X-MC-Unique: no6mbkG4Pgydx_hrYyPEGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5313B80029D;
        Wed, 29 Jun 2022 01:03:10 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAE852026D64;
        Wed, 29 Jun 2022 01:03:04 +0000 (UTC)
Date:   Wed, 29 Jun 2022 09:02:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <YrukwsgbFxd69wA1@T590>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
 <20220624141255.2461148-2-ming.lei@redhat.com>
 <20220626201458.ytn4mrix2pobm2mb@moria.home.lan>
 <Yrld9rLPY6L3MhlZ@T590>
 <20220628042610.wuittagsycyl4uwa@moria.home.lan>
 <YrqyiCcnvPCqsn8F@T590>
 <20220628163617.h3bmq3opd7yuiaop@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628163617.h3bmq3opd7yuiaop@moria.home.lan>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 28, 2022 at 12:36:17PM -0400, Kent Overstreet wrote:
> On Tue, Jun 28, 2022 at 03:49:28PM +0800, Ming Lei wrote:
> > On Tue, Jun 28, 2022 at 12:26:10AM -0400, Kent Overstreet wrote:
> > > On Mon, Jun 27, 2022 at 03:36:22PM +0800, Ming Lei wrote:
> > > > Not mention bio_iter, bvec_iter has been 32 bytes, which is too big to
> > > > hold in per-io data structure. With this patch, 8bytes is enough
> > > > to rewind one bio if the end sector is fixed.
> > > 
> > > And with rewind, you're making an assumption about the state the iterator is
> > > going to be in when the IO has completed.
> > > 
> > > What if the iterator was never advanced?
> > 
> > bio_rewind() works as expected if the iterator doesn't advance, since bytes
> > between the recorded position and the end position isn't changed, same
> > with the end position.
> > 
> > > 
> > > So say you check for that by saving some other part of the iterator - but that
> > > may have legitimately changed too, if the bio was redirected (bi_sector changes)
> > > or trimmed (bi_size changes)
> > > 
> > > I still think this is an inherently buggy interface, the way it's being proposed
> > > to be used.
> > 
> > The patch did mention that the interface should be for situation in which end
> > sector of bio won't change.
> 
> But that's an assumption that you simply can't make!

Of course, we can, at least for this DM's use case, the bio is issued
from FS or split from DM, and it won't be issued to underlying queue any
more, and simply owned by DM core code.

> 
> We allow block device drivers to be stacked in _any_ combination. After a bio is
> completed it may have been partially advanced, fully advanced, trimmed, not
> trimmed, anything - and bi_sector and thus also bio_end_sector() may have
> changed, and will have if there's partition tables involved.

How can bio (partial)advance change bio's end sector?

bio end sector can be changed only when bio->bi_iter.bi_size is changed
manually(include bio_trim), or ->bi_bdev is changed. But inside one
driver, if the bio is owned by this driver(such as the driver is the
finally layer request based driver), the assumption often can make.


Thanks,
Ming

