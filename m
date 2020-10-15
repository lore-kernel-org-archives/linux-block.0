Return-Path: <SRS0=w0su=DW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5523EC43457
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 22:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D30162084C
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 22:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YyI2hHjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbgJOWFY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Oct 2020 18:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731165AbgJOWFY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Oct 2020 18:05:24 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0C9C0613CF
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2020 15:05:24 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gm14so219784pjb.2
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2020 15:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=700dSlreVGZIbwr3AdAuK7QeFJxaPoeuAx3F/ELDRDo=;
        b=YyI2hHjlGVMdiNNuzARzWWPUiBmNs3oQjJCJGo+DBpaEJkZHTSch2TDv7bhYi0ayd7
         0Tiug6g9ouWnCvNCvyppOJJMcWJ70krwZeHg307DjM4M4ciwWM168DIguFHICNfGwBTQ
         0fztJeUGNoHaZGzvewoMRmJZE7w9xAixVlOhJ8kgsfddznBNmg7jA67fAyG1fZqnRzW2
         H7jW2xnA80M0pgO+LpVdhsflSYVJaXXgjY2LiFONp4lXtOo4wWFoml2ngxy7G+CNmI8f
         ygiE+osIjuskN1NPsYcVMTu++R4xxzF9U+Uu7hIfFBksBQ7z2UX3TIoPsOA67aVRk4rr
         pL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=700dSlreVGZIbwr3AdAuK7QeFJxaPoeuAx3F/ELDRDo=;
        b=d0tC/duJDZNN9B1gXV9xGdf5gQBLEsN3YRPeapxJC+hOE7Psey4RTPHdIwp0uobdnr
         5qS8jI+r0oVeOFIXt2JCV51cB0tH4Go08gbk3SgVpqUGYq4nVtNYQoUclI0ek6uwQxSP
         IBXJaPOrabAP3P5ZS+Usew7ckcuYYbKIQ4kX/lqt5lBkCB685JKz3oc+5NX7Yg+a1/vF
         C9Bksuunvu2gAnU4XqgwpB7ubF1MJ1rJPzMn/EBImVknRBCwQLOd55ZZ+pZ6hDNpRi74
         2Zhhzfry6Id58I61SrfbVOvTpK6Nysnqui2Yax14xDtRoOm/+TdltN4F1H9y/1ewmVMD
         YQ1w==
X-Gm-Message-State: AOAM533AVDo2l9FGA/elVhj/ymaT6bvh7U7t/HXBXZfrhbgED9mysopx
        G20+CcGKZj/f+P3u3hRgQAgu2w==
X-Google-Smtp-Source: ABdhPJzUX9wxifuk/NX4KO9hxnbTmPIzCu5nOp+krk3Lv2bCZAZCkS014tzTx/UPz0a1f2BvXPsGKQ==
X-Received: by 2002:a17:90a:9317:: with SMTP id p23mr762160pjo.160.1602799523789;
        Thu, 15 Oct 2020 15:05:23 -0700 (PDT)
Received: from google.com (154.137.233.35.bc.googleusercontent.com. [35.233.137.154])
        by smtp.gmail.com with ESMTPSA id e8sm295045pgj.8.2020.10.15.15.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 15:05:23 -0700 (PDT)
Date:   Thu, 15 Oct 2020 22:05:19 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 2/3] dm: add support for passing through inline crypto
 support
Message-ID: <20201015220519.GB48329@google.com>
References: <20200909234422.76194-1-satyat@google.com>
 <20200909234422.76194-3-satyat@google.com>
 <20200924012103.GE10500@redhat.com>
 <20200924073842.GA1894729@google.com>
 <20200924142353.GC13849@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924142353.GC13849@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 24, 2020 at 10:23:54AM -0400, Mike Snitzer wrote:
> On Thu, Sep 24 2020 at  3:38am -0400,
> Satya Tangirala <satyat@google.com> wrote:
> 
> > On Wed, Sep 23, 2020 at 09:21:03PM -0400, Mike Snitzer wrote:
> > > On Wed, Sep 09 2020 at  7:44pm -0400,
> > > Satya Tangirala <satyat@google.com> wrote:
> > > 
> > > > From: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > Update the device-mapper core to support exposing the inline crypto
> > > > support of the underlying device(s) through the device-mapper device.
> > > > 
> > > > This works by creating a "passthrough keyslot manager" for the dm
> > > > device, which declares support for encryption settings which all
> > > > underlying devices support.  When a supported setting is used, the bio
> > > > cloning code handles cloning the crypto context to the bios for all the
> > > > underlying devices.  When an unsupported setting is used, the blk-crypto
> > > > fallback is used as usual.
> > > > 
> > > > Crypto support on each underlying device is ignored unless the
> > > > corresponding dm target opts into exposing it.  This is needed because
> > > > for inline crypto to semantically operate on the original bio, the data
> > > > must not be transformed by the dm target.  Thus, targets like dm-linear
> > > > can expose crypto support of the underlying device, but targets like
> > > > dm-crypt can't.  (dm-crypt could use inline crypto itself, though.)
> > > > 
> > > > When a key is evicted from the dm device, it is evicted from all
> > > > underlying devices.
> > > > 
> > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > > Co-developed-by: Satya Tangirala <satyat@google.com>
> > > > Signed-off-by: Satya Tangirala <satyat@google.com>
> > > > ---
> > > >  block/blk-crypto.c              |  1 +
> > > >  block/keyslot-manager.c         | 34 ++++++++++++
> > > >  drivers/md/dm-core.h            |  4 ++
> > > >  drivers/md/dm-table.c           | 52 +++++++++++++++++++
> > > >  drivers/md/dm.c                 | 92 ++++++++++++++++++++++++++++++++-
> > > >  include/linux/device-mapper.h   |  6 +++
> > > >  include/linux/keyslot-manager.h |  7 +++
> > > >  7 files changed, 195 insertions(+), 1 deletion(-)
> > > > 
> 
> > > > diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
> > > > index c4ef1fceead6..4542050eebfc 100644
> > > > --- a/drivers/md/dm-core.h
> > > > +++ b/drivers/md/dm-core.h
> > > > @@ -12,6 +12,7 @@
> > > >  #include <linux/kthread.h>
> > > >  #include <linux/ktime.h>
> > > >  #include <linux/blk-mq.h>
> > > > +#include <linux/keyslot-manager.h>
> > > >  
> > > >  #include <trace/events/block.h>
> > > >  
> > > > @@ -49,6 +50,9 @@ struct mapped_device {
> > > >  
> > > >  	int numa_node_id;
> > > >  	struct request_queue *queue;
> > > > +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> > > > +	struct blk_keyslot_manager ksm;
> > > > +#endif
> > > >  
> > > >  	atomic_t holders;
> > > >  	atomic_t open_count;
> > > 
> > > Any reason you placed the ksm member where you did?
> > > 
> > > Looking at 'struct blk_keyslot_manager' I'm really hating adding that
> > > bloat to every DM device for a feature that really won't see much broad
> > > use (AFAIK).
> > > 
> > > Any chance you could allocate 'struct blk_keyslot_manager' as needed so
> > > that most users of DM would only be carrying 1 extra pointer (set to
> > > NULL)?
> >
> > I don't think there's any technical problem with doing that - the only
> > other thing that would need addressing is that the patch uses
> > "container_of" on that blk_keyslot_manager in dm_keyslot_evict() to get
> > a pointer to the struct mapped_device. I could try adding a "private"
> > field to struct blk_keyslot_manager and store a pointer to the struct
> > mapped_device there).
> 
> Yes, that'd be ideal.
> 
> As for the lifetime of the struct blk_keyslot_manager pointer DM would
> manage (in your future code revision): you meantioned in one reply that
> the request_queue takes care of setting up the ksm... but the ksm
> is tied to the queue at a later phase using blk_ksm_register(). 
> 
I probably wasn't clear in that reply :(. So the request_queue isn't
responsible for setting up the ksm - setting up the ksm in the request
queue is the responsibility of the DM device.
> In any case, I think my feature reequest (to have DM allocate the ksm
> struct only as needed) is a bit challenging because of how DM allocates
> the request_queue upfront in alloc_dev() and then later completes the
> request_queue initialization based on DM_TYPE* in dm_setup_md_queue().
> 
> It _could_ be that you'll need to add a new DM_TYPE_KSM_BIO_BASED or
> something.  But you have a catch-22 in that the dm-table.c code to
> establish the intersection of supported modes assumes ksm is already
> allocated.  So something needs to give by reasoning through: _what_ is
> the invariant that will trigger the delayed allocation of the ksm
> struct?  I don't yet see how you can make that informed decision that
> the target(s) in the DM table _will_ use the ksm if it exists.
> 
What I tried doing in the next version that I just sent out was to get
the DM device to set up the ksm as appropriate on table swaps (and also
to verify the "new" ksm on table swaps and loads, so that we reject any
new table that would require a new ksm that would drop any capabability
that the current ksm supports)
> But then once the ksm is allocated, it never gets allocated again
> because md->queue->ksm is already set, and it inherits the lifetime that
> is used when destroying the mapped_device (md->queue, etc).
>
This is what the new version of the series does :). It also just sets up
the ksm directly in md->queue, and completely drops the md->ksm field
(because unless I'm misunderstanding things, each DM device is
associated with exactly one queue).

Btw, the new version is at

https://lore.kernel.org/linux-block/20201015214632.41951-1-satyat@google.com/

> Mike
> 
