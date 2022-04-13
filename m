Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2291C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 06:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiDMGPN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 02:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiDMGPN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 02:15:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DFE651322
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 23:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649830372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Ux7XB9elwVH5NdCYl17IXEufEqJfJJdXr0Uu64WT7w=;
        b=LeTD26nH2AKWGgqrPsibOOIbdwA8ts7+lyHKGbzB7I3ytwo0dk2VjBXg+pK+q7mn2UuVwS
        oleOBDsmkh2J7K8OlZOBp/v01VTh9FcIPGi8Vu36YT/U718WW1/Co0NNXwJ4gxE6mxXbpd
        q9MVND1nO9z95ZraEr3wZuwMn8ZSfms=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520--EzOkjvqN0Syiapu2bMa9Q-1; Wed, 13 Apr 2022 02:12:50 -0400
X-MC-Unique: -EzOkjvqN0Syiapu2bMa9Q-1
Received: by mail-qk1-f198.google.com with SMTP id l68-20020a378947000000b0067df0c430d8so550258qkd.13
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 23:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Ux7XB9elwVH5NdCYl17IXEufEqJfJJdXr0Uu64WT7w=;
        b=Q+4EmrDNhvo3a2rUNoz/s9OPbCLjgGDzC5GghJom4/WOqY8a4UisbIWfTR/TBo5wpt
         AQ1lkWOgwHzsK97rMs8KRIL1d1kV6Ri3SDD4Jkq14KyEczL8/L0eZ24dzOH3XDqCOGGZ
         wjGH9GvNpINt6kKijmkVLT2F0nrbdtGjltGhiyXdpKI0/KPurwlrBM7FbQZsfM8//XOD
         U6bwdsTZwPxgrIJaIw9AuWwYFqt2p7H4I0wayG5wvdlAMlgPNdLHPIMye/0FcMpBEhgQ
         c0TQQbk0LukzZeV6NVdXYz/3fVSDsNKjheh8GFRvD9DTIpqEVt4qClko7pmd74Mv8p+v
         zj/w==
X-Gm-Message-State: AOAM532R2WHZJsN2r3eEEMXy+xRKKyB+F1I+i5cqFSbEMMJrtH5v86Ts
        ORzRmHNFjmyc3OTiqSgJJk68VJAMVgQBdUSY8QRIIONtCPVIOMeyu2Nn0q7CaxeWNK8l4nShii4
        nqM6aVPCKtnDyFCyWOg/DzA==
X-Received: by 2002:ac8:7281:0:b0:2ee:ed60:777a with SMTP id v1-20020ac87281000000b002eeed60777amr6076752qto.197.1649830370335;
        Tue, 12 Apr 2022 23:12:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE3nUhkGCZlB8Nm7wu43fO17nO28Q703b9H7cthQ7uYqf2jU3Gae9pL5zRpbhxMG+0RVfwsg==
X-Received: by 2002:ac8:7281:0:b0:2ee:ed60:777a with SMTP id v1-20020ac87281000000b002eeed60777amr6076742qto.197.1649830370053;
        Tue, 12 Apr 2022 23:12:50 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id s4-20020ae9de04000000b0069c3a577b0asm2648615qkf.51.2022.04.12.23.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 23:12:49 -0700 (PDT)
Date:   Wed, 13 Apr 2022 02:12:47 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 5/8] dm: always setup ->orig_bio in alloc_io
Message-ID: <YlZp3+VrP930VjIQ@redhat.com>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
 <20220412085616.1409626-6-ming.lei@redhat.com>
 <YlXmmB6IO7usz2c1@redhat.com>
 <YlYt2rzM0NBPARVp@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlYt2rzM0NBPARVp@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 12 2022 at  9:56P -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> On Tue, Apr 12, 2022 at 04:52:40PM -0400, Mike Snitzer wrote:
> > On Tue, Apr 12 2022 at  4:56P -0400,
> > Ming Lei <ming.lei@redhat.com> wrote:
> > 
> > > The current DM codes setup ->orig_bio after __map_bio() returns,
> > > and not only cause kernel panic for dm zone, but also a bit ugly
> > > and tricky, especially the waiting until ->orig_bio is set in
> > > dm_submit_bio_remap().
> > > 
> > > The reason is that one new bio is cloned from original FS bio to
> > > represent the mapped part, which just serves io accounting.
> > > 
> > > Now we have switched to bdev based io accounting interface, and we
> > > can retrieve sectors/bio_op from both the real original bio and the
> > > added fields of .sector_offset & .sectors easily, so the new cloned
> > > bio isn't necessary any more.
> > > 
> > > Not only fixes dm-zone's kernel panic, but also cleans up dm io
> > > accounting & split a bit.
> > 
> > You're conflating quite a few things here.  DM zone really has no
> > business accessing io->orig_bio (dm-zone.c can just as easily inspect
> > the tio->clone, because it hasn't been remapped yet it reflects the
> > io->origin_bio, so there is no need to look at io->orig_bio) -- but
> > yes I clearly broke things during the 5.18 merge and it needs fixing
> > ASAP.
> 
> You can just consider the cleanup part of this patches, :-)

I will.  But your following list doesn't reflect any "cleanup" that I
saw in your patchset.  Pretty fundamental changes that are similar,
but different, to the dm-5.19 changes I've staged.

> 1) no late assignment of ->orig_bio, and always set it in alloc_io()
>
> 2) no waiting on on ->origi_bio, especially the waiting is done in
> fast path of dm_submit_bio_remap().

For 5.18 waiting on io->orig_bio just enables a signal that the IO was
split and can be accounted.

For 5.19 I also plan on using late io->orig_bio assignment as an
alternative to the full-blown refcounting currently done with
io->io_count.  I've yet to quantify the gains with focused testing but
in theory this approach should scale better on large systems with many
concurrent IO threads to the same device (RCU is primary constraint
now).

I'll try to write a bpfrace script to measure how frequently "waiting on
io->orig_bio" occurs for dm_submit_bio_remap() heavy usage (like
dm-crypt). But I think we'll find it is very rarely, if ever, waited
on in the fast path.

> 3) no split for io accounting

DM's more recent approach to splitting has never been done for benefit
or use of IO accounting, see this commit for its origin:
18a25da84354c6b ("dm: ensure bio submission follows a depth-first tree walk")

Not sure why you keep poking fun at DM only doing a single split when:
that is the actual design.  DM splits off orig_bio then recurses to
handle the remainder of the bio that wasn't issued.  Storing it in
io->orig_bio (previously io->bio) was always a means of reflecting
things properly. And yes IO accounting is one use, the other is IO
completion. But unfortunately DM's IO accounting has always been a
mess ever since the above commit. Changes in 5.18 fixed that.

But again, DM's splitting has _nothing_ to do with IO accounting.
Splitting only happens when needed for IO submission given constraints
of DM target(s) or underlying layers.

All said, I will look closer at your entire set and see if it better
to go with your approach.  This patch in particular is interesting
(avoids cloning and other complexity of bio_split + bio_chain):
https://patchwork.kernel.org/project/dm-devel/patch/20220412085616.1409626-6-ming.lei@redhat.com/

