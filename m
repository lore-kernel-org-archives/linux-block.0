Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80EBC43334
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 17:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiF1RlT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 13:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiF1RlS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 13:41:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6268F32ED5
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 10:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656438076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YEqy8AJWkJJDvettILGtUJ75qUrhxClJ6WIqJBOIecg=;
        b=XEtdgWFBX19L3cJBOrocf6h2MzqPotcqME+YRlCBl0vZLHKlCyOqrpzHGAIYiUwnaIZoyY
        X2A8g9lpEJ2jmavdHszZt/ItANSYfX7AzTHyvZeK3Bua6UCDV5KE0xEPpL9ocSKoq2vsAC
        ERjlSGSTZbxX3fkjDolDqy8e5i397C8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-Gwn26hOXM9GKnsCDaoaY_Q-1; Tue, 28 Jun 2022 13:41:15 -0400
X-MC-Unique: Gwn26hOXM9GKnsCDaoaY_Q-1
Received: by mail-qv1-f72.google.com with SMTP id g7-20020a0ce747000000b0047079ec462dso13104235qvn.20
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 10:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YEqy8AJWkJJDvettILGtUJ75qUrhxClJ6WIqJBOIecg=;
        b=FD03mvHijMi7S2TaJhzTw+DdcW8vi6rGiWs0WR+VR4DORB6w9mXKVZUx1Q21KPi24b
         jKkZA6mcpQ4RGp3pw+FAiKA1mB4fm3vXZOOAH18fUl6YrXNy8FJjpcf7YEiX0mfgbT3D
         DyWDnCcpzFRkuMv0zJb0ptns2BB/eR1/UlJor8z7pR7zfc140Wp1E45UHqgWOjgdT0Gf
         NxI8FU4SpAC4ISb8OF14YVEtS7yE8BhpCAo4xTF/wliDdeLpojnLh0esZ/dfOhyT9i6C
         pSzSioL+3DyBSDk0ACynHOHOr/HawyjOn1y0FdJx8NZfYkQwuZXSoa6ga1caCq+KvsME
         UYfA==
X-Gm-Message-State: AJIora88PCWivRG2mjsFqBnXFEZzv7uF+8HlzBHA0fx9DbQM47WrJ5Tr
        mH2iRAjAsfbnKm19dScT3Sc1C7xXbDiJjEV+bYk6cohU9kS9fQxYlqjGNzIsUeYnS3R1b9FpLoE
        D7dq740Zsgyc7q8eSUspksA==
X-Received: by 2002:ac8:4e87:0:b0:31b:f6ef:bdf6 with SMTP id 7-20020ac84e87000000b0031bf6efbdf6mr1387337qtp.64.1656438074391;
        Tue, 28 Jun 2022 10:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tYZSza3RsF03B25ldB7UEUb4Qecw+TQaQzfhz1NKC38rky8U47pk/edeUSb3sncuxS5QQZ1w==
X-Received: by 2002:ac8:4e87:0:b0:31b:f6ef:bdf6 with SMTP id 7-20020ac84e87000000b0031bf6efbdf6mr1387321qtp.64.1656438074129;
        Tue, 28 Jun 2022 10:41:14 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id g16-20020ae9e110000000b006aefa015c05sm10866149qkm.25.2022.06.28.10.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 10:41:13 -0700 (PDT)
Date:   Tue, 28 Jun 2022 13:41:12 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <Yrs9OLNZ8xUs98OB@redhat.com>
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
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 28 2022 at 12:36P -0400,
Kent Overstreet <kent.overstreet@gmail.com> wrote:

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

Why not?  There is clear use-case for this API, as demonstrated in the
patchset: DM can/will make use of it for the purposes of enhancing its
more unlikely bio requeuing work (that is needed to make the more
likely bio splitting scenario more efficient).

> We allow block device drivers to be stacked in _any_ combination. After a bio is
> completed it may have been partially advanced, fully advanced, trimmed, not
> trimmed, anything - and bi_sector and thus also bio_end_sector() may have
> changed, and will have if there's partition tables involved.

We don't _need_ this API to cure cancer for all hypothetical block
drivers.

If consumers of the API follow the rule that end sector of the
_original bio_ isn't changed then it is all fine.  It is that simple.

Stacked drivers will work just fine.  The lower layers will be
modifying their bios as needed. Because for DM those bios happen to
be clones, so there is isolation to the broader design flaw you are
trying to say is a major problem. As this patchset demonstrates.

I do concede that policing who can use an API is hard.  But if some
consumer of an API tries something that invalidates rules of the API
they get to keep the N pieces when it breaks.

Mike

