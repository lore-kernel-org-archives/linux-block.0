Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225E9C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 17:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbiDMSBZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 14:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbiDMSBV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 14:01:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECAB56D854
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649872738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4hM+Chfsa5J4PPFDg9Ok3mc3K63QtgcqVgQPGOHg6sk=;
        b=DsgOY6f/RWxMrc1S50qauAGUNo15Xbu3h1SHDyLy8qqXSnGCaWPGKIRO1easU5+Be+XkBb
        Qe7WXEBfCPZCjziNCKn4RtSO6ZS7jrsnKZDxW1zz5++IrbTHKWXVT41ft+Tthzj+y48dlL
        rrePk/jZTK7YHGYbRR5IjlX0Mam960E=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-77-T42Ba1Q2Nd6ognzwrbMUBw-1; Wed, 13 Apr 2022 13:58:56 -0400
X-MC-Unique: T42Ba1Q2Nd6ognzwrbMUBw-1
Received: by mail-qk1-f197.google.com with SMTP id y13-20020a05620a44cd00b0069c35f1ea3eso1690607qkp.0
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 10:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4hM+Chfsa5J4PPFDg9Ok3mc3K63QtgcqVgQPGOHg6sk=;
        b=XgzjSra2Xp97Wn4PsQFwDWhdjTxAHL77TCQA8FmhvwguM+BR3Z5ZjhOV/JLVpNA3fp
         SpD4KY4Aek4sv4Prni90E9hI8VMzm4SOMiyRktWaWbUuLOqC745GSF8sLy1JndN0PwY7
         jHYuO/xjA3GVRaI7GGdavD5YI8FulBMlciZetdhJTUPmeEd6zyQKuefn9Ba+1x3cgwXa
         v/Bnm8j6LFs35CDuFLLWfvBZXramDWOzToLGxcnJQmJOiloIzvCi4ZRaaA2HUz/m9IAR
         5g00AivEYKdTCDm9p+GB3puRIoacgm8jnJ82BuJW+qxOuzLuA/r/gZY37kCvyqeQ2c2Z
         D1sA==
X-Gm-Message-State: AOAM5332dtSssNKT8SsXoTTEY6mc51Xz+PyR9e/01IGdC1BfbVDYJpLI
        zBs10gzlTsYQn59kr5+NmJ+mmzZNVWk1+Q8Jwcl9yEXHuDJAJGVnC/JnK3dutnSOTqIis3VZ13M
        sbO5sio4lPh2e90OeEq8Yqg==
X-Received: by 2002:ac8:4d95:0:b0:2f0:9b6e:9f8c with SMTP id a21-20020ac84d95000000b002f09b6e9f8cmr6802364qtw.67.1649872736356;
        Wed, 13 Apr 2022 10:58:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIT6cKvlt6w4AizSTiMzakFlr4r0QPKPdrFqBubBJ0QCS9JXuw7OaltzRJra/JrlkfGV2GqQ==
X-Received: by 2002:ac8:4d95:0:b0:2f0:9b6e:9f8c with SMTP id a21-20020ac84d95000000b002f09b6e9f8cmr6802360qtw.67.1649872736093;
        Wed, 13 Apr 2022 10:58:56 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id y7-20020a05620a0e0700b00699a30d6d10sm21151314qkm.111.2022.04.13.10.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 10:58:55 -0700 (PDT)
Date:   Wed, 13 Apr 2022 13:58:54 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 5/8] dm: always setup ->orig_bio in alloc_io
Message-ID: <YlcPXslr6Y7cHOSU@redhat.com>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
 <20220412085616.1409626-6-ming.lei@redhat.com>
 <YlXmmB6IO7usz2c1@redhat.com>
 <YlYt2rzM0NBPARVp@T590>
 <YlZp3+VrP930VjIQ@redhat.com>
 <YlbBf0mJa/BPHSSq@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlbBf0mJa/BPHSSq@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 13 2022 at  8:26P -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> On Wed, Apr 13, 2022 at 02:12:47AM -0400, Mike Snitzer wrote:
> > On Tue, Apr 12 2022 at  9:56P -0400,
> > Ming Lei <ming.lei@redhat.com> wrote:
> > 
> > > On Tue, Apr 12, 2022 at 04:52:40PM -0400, Mike Snitzer wrote:
> > > > On Tue, Apr 12 2022 at  4:56P -0400,
> > > > Ming Lei <ming.lei@redhat.com> wrote:
> > > > 
> > > > > The current DM codes setup ->orig_bio after __map_bio() returns,
> > > > > and not only cause kernel panic for dm zone, but also a bit ugly
> > > > > and tricky, especially the waiting until ->orig_bio is set in
> > > > > dm_submit_bio_remap().
> > > > > 
> > > > > The reason is that one new bio is cloned from original FS bio to
> > > > > represent the mapped part, which just serves io accounting.
> > > > > 
> > > > > Now we have switched to bdev based io accounting interface, and we
> > > > > can retrieve sectors/bio_op from both the real original bio and the
> > > > > added fields of .sector_offset & .sectors easily, so the new cloned
> > > > > bio isn't necessary any more.
> > > > > 
> > > > > Not only fixes dm-zone's kernel panic, but also cleans up dm io
> > > > > accounting & split a bit.
> > > > 
> > > > You're conflating quite a few things here.  DM zone really has no
> > > > business accessing io->orig_bio (dm-zone.c can just as easily inspect
> > > > the tio->clone, because it hasn't been remapped yet it reflects the
> > > > io->origin_bio, so there is no need to look at io->orig_bio) -- but
> > > > yes I clearly broke things during the 5.18 merge and it needs fixing
> > > > ASAP.
> > > 
> > > You can just consider the cleanup part of this patches, :-)
> > 
> > I will.  But your following list doesn't reflect any "cleanup" that I
> > saw in your patchset.  Pretty fundamental changes that are similar,
> > but different, to the dm-5.19 changes I've staged.
> > 
> > > 1) no late assignment of ->orig_bio, and always set it in alloc_io()
> > >
> > > 2) no waiting on on ->origi_bio, especially the waiting is done in
> > > fast path of dm_submit_bio_remap().
> > 
> > For 5.18 waiting on io->orig_bio just enables a signal that the IO was
> > split and can be accounted.
> > 
> > For 5.19 I also plan on using late io->orig_bio assignment as an
> > alternative to the full-blown refcounting currently done with
> > io->io_count.  I've yet to quantify the gains with focused testing but
> > in theory this approach should scale better on large systems with many
> > concurrent IO threads to the same device (RCU is primary constraint
> > now).
> > 
> > I'll try to write a bpfrace script to measure how frequently "waiting on
> > io->orig_bio" occurs for dm_submit_bio_remap() heavy usage (like
> > dm-crypt). But I think we'll find it is very rarely, if ever, waited
> > on in the fast path.
> 
> The waiting depends on CPU and device's speed, if device is quicker than
> CPU, the wait should be longer. Testing in one environment is usually
> not enough.
> 
> > 
> > > 3) no split for io accounting
> > 
> > DM's more recent approach to splitting has never been done for benefit
> > or use of IO accounting, see this commit for its origin:
> > 18a25da84354c6b ("dm: ensure bio submission follows a depth-first tree walk")
> > 
> > Not sure why you keep poking fun at DM only doing a single split when:
> > that is the actual design.  DM splits off orig_bio then recurses to
> > handle the remainder of the bio that wasn't issued.  Storing it in
> > io->orig_bio (previously io->bio) was always a means of reflecting
> > things properly. And yes IO accounting is one use, the other is IO
> > completion. But unfortunately DM's IO accounting has always been a
> > mess ever since the above commit. Changes in 5.18 fixed that.
> > 
> > But again, DM's splitting has _nothing_ to do with IO accounting.
> > Splitting only happens when needed for IO submission given constraints
> > of DM target(s) or underlying layers.
> 
> What I meant is that the bio returned from bio_split() is only for
> io accounting. Yeah, the comment said it can be for io completion too,
> but that is easily done without the splitted bio.
>
> > All said, I will look closer at your entire set and see if it better
> > to go with your approach.  This patch in particular is interesting
> > (avoids cloning and other complexity of bio_split + bio_chain):
> > https://patchwork.kernel.org/project/dm-devel/patch/20220412085616.1409626-6-ming.lei@redhat.com/
> 
> That patch shows we can avoid the extra split, also shows that the
> splitted bio from bio_split() is for io accounting only.

Yes I see that now.  But it also served to preserve the original bio
for use in completion.  Not a big deal, but it did track the head of
the bio_chain.

The bigger issue with this patch is that you've caused
dm_submit_bio_remap() to go back to accounting the entire original bio
before any split occurs.  That is a problem because you'll end up
accounting that bio for every split, so in split heavy workloads the
IO accounting won't reflect when the IO is actually issued and we'll
regress back to having very inaccurate and incorrect IO accounting for
dm_submit_bio_remap() heavy targets (e.g. dm-crypt).

Mike

