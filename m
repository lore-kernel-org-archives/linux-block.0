Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35B0C433E0
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 14:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C03D820782
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 14:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aczgHww4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgHKORO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57753 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728516AbgHKORN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 10:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597155431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rhMEElIgLI6foDJlpXolXaiRFwFQ+nGqhKAlQPcV4D0=;
        b=aczgHww44TgvkJ0n4QqY/8Y4tmwHB9UY4NCVQVewJ+fFCOVrZm+iFMiSAU7B7YFWvq003B
        HzxAkQDPI4fnLEFOvSYVmPSiVWri4362GGfH8AmqpIbN+OfqL8GadtSbMCBr6ic6YtjYDx
        OZyFXJ9b6I52g3fSy/mDHuwPGJKhU4s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-DJj8enMxMhemJIVLqbdN9Q-1; Tue, 11 Aug 2020 10:17:09 -0400
X-MC-Unique: DJj8enMxMhemJIVLqbdN9Q-1
Received: by mail-wm1-f72.google.com with SMTP id q15so854787wmj.6
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2020 07:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rhMEElIgLI6foDJlpXolXaiRFwFQ+nGqhKAlQPcV4D0=;
        b=R+tq3YymfxtUUhPOb6PiSONeBkgvqZsrhF4rxo89uwWIt8cxMImAwlWW7sW4HNr7cv
         wO74notRULNb7LkdqQYuZ5EOq5Fw9JCbqhKWHwOvZs/cm/TIldJ3WhZMolBjkBj2R7QU
         VW5pAm85TeuirYpcixkgvY7eIkLlcXrufTZS+N2lK6KSFC7WxDniYyM6hdjf7umgj7p8
         HtUEVJbWc7zppDYAbq0r/m0eM+hHbAdI1Te/3MjqTUpuF+hSNnNZVAVvz2WqAI3Qe7jc
         Eq5mtJajb/3VSCkHMoRRieSHxwSjgK5S7Kgogsgybaa4COFy4abpKeLtguGSCu36QVh/
         Jb+Q==
X-Gm-Message-State: AOAM533IPB8Q1FZONlSIP+VPDD0+Uh3zCeGjoKpN2Fefv60cXjcFV/s3
        GADiqwXhgBj0FkZHGGqdEoPUjVmBD64Nhm0S9YBELZz9kS9FKvLsjU7tSf/uv8RZPOXdbN0PNlM
        sWZDB1rxK1hOfFVgWI9akjmw=
X-Received: by 2002:a05:600c:220b:: with SMTP id z11mr4156761wml.48.1597155428408;
        Tue, 11 Aug 2020 07:17:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7+eHGnO4GxDehZO8vMboI8nA5pU1sKUYFs0OwNtNAUN3oWMjZj9rQ2k7MZKwENZLkkUvWTg==
X-Received: by 2002:a05:600c:220b:: with SMTP id z11mr4156748wml.48.1597155428182;
        Tue, 11 Aug 2020 07:17:08 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id m16sm26287424wrr.71.2020.08.11.07.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 07:17:07 -0700 (PDT)
Date:   Tue, 11 Aug 2020 16:16:43 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Changpeng Liu <changpeng.liu@intel.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 2/2] block: virtio_blk: fix handling single range discard
 request
Message-ID: <20200811141643.5s7s3ktpr3src64d@steredhat>
References: <20200811092134.2256095-1-ming.lei@redhat.com>
 <20200811092134.2256095-3-ming.lei@redhat.com>
 <20200811123044.mzsc2clpf6nxf6f6@steredhat>
 <20200811130953.GA2225752@T590>
 <20200811133925.m6szpaxqetsxxutz@steredhat>
 <20200811134326.GA2266621@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811134326.GA2266621@T590>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 11, 2020 at 09:43:26PM +0800, Ming Lei wrote:
> On Tue, Aug 11, 2020 at 03:39:25PM +0200, Stefano Garzarella wrote:
> > On Tue, Aug 11, 2020 at 09:09:53PM +0800, Ming Lei wrote:
> > > On Tue, Aug 11, 2020 at 02:30:44PM +0200, Stefano Garzarella wrote:
> > > > Hi Ming,
> > > > 
> > > > On Tue, Aug 11, 2020 at 05:21:34PM +0800, Ming Lei wrote:
> > > > > 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support") starts
> > > > > to support multi-range discard for virtio-blk. However, the virtio-blk
> > > > > disk may report max discard segment as 1, at least that is exactly what
> > > > > qemu is doing.
> > > > > 
> > > > > So far, block layer switches to normal request merge if max discard segment
> > > > > limit is 1, and multiple bios can be merged to single segment. This way may
> > > > > cause memory corruption in virtblk_setup_discard_write_zeroes().
> > > > > 
> > > > > Fix the issue by handling single max discard segment in straightforward
> > > > > way.
> > > > > 
> > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
> > > > > Cc: Christoph Hellwig <hch@lst.de>
> > > > > Cc: Changpeng Liu <changpeng.liu@intel.com>
> > > > > Cc: Daniel Verkamp <dverkamp@chromium.org>
> > > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > ---
> > > > >  drivers/block/virtio_blk.c | 23 +++++++++++++++--------
> > > > >  1 file changed, 15 insertions(+), 8 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > > index 63b213e00b37..05b01903122b 100644
> > > > > --- a/drivers/block/virtio_blk.c
> > > > > +++ b/drivers/block/virtio_blk.c'
> > > > > @@ -126,14 +126,21 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
> > > > >  	if (!range)
> > > > >  		return -ENOMEM;
> > > > 
> > > > We are allocating the 'range' array to contain 'segments' elements.
> > > > When queue_max_discard_segments() returns 1, should we limit 'segments'
> > > > to 1?
> > > 
> > > That is block layer's responsibility to make sure that 'segments' is <=
> > > 1, and we can double check & warn here.
> > 
> > So, IIUC, the number of bio in a request may not be the same as
> > the return value of blk_rq_nr_discard_segments(). Is it right?
> 
> In case that queue_max_discard_segments() is 1, it is right. If
> queue_max_discard_segments() is > 1, nr_range is supposed to be
> same with number of bios in a request.

Got it. Thanks for clarify.

In the meantime I took a look at nvme_setup_discard() and there is
WARN_ON_ONCE(n != segments), maybe we should do the same.

Thanks,
Stefano

