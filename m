Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A79DC433EF
	for <linux-block@archiver.kernel.org>; Fri,  1 Jul 2022 21:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiGAVJP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Jul 2022 17:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiGAVJO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jul 2022 17:09:14 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6824D37A3F
        for <linux-block@vger.kernel.org>; Fri,  1 Jul 2022 14:09:12 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id g1so2697980qkl.9
        for <linux-block@vger.kernel.org>; Fri, 01 Jul 2022 14:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lmh2DXHdd9zUpt+ZM652uY0erz/sbuLnVvhvieIFyDc=;
        b=P05T6B4PF03R9R7FoUJtXIkp4vx6ZXLt5QiXuRZkQFLpB224tueetOlxXg4PDHSY+a
         f/gvvoZ2hkh4f/DZHsQjZ2NHrilGAIMqnQoBHGXQcrbfJslXHjYvFQqYM2BMDq95KoLZ
         47taWgWvbxI25bggxLZAcSF7puphNzH04Th0Y1TQ7TXkkkmjGqjGxJS3hVE4BBc3n9D4
         SF2SudZTMvdegiEzG4Kdzj7BVSQoDxnkbdnjH8tGdaK3FlNsbPDFlSvv1VLdgQ6JFPUc
         xcGJ2RjAbOaVAVTLIpx7Kr2VMevjPqGxQQa8upBuHrJcum++OapoCGRMxr9tjHTFewj1
         +xWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lmh2DXHdd9zUpt+ZM652uY0erz/sbuLnVvhvieIFyDc=;
        b=AkvWcTzo2Wjbdg/OUAje6yOqMtF6cTWri1QCyt7rzREudInE9ISIrGP/R1+OBd70LF
         yVXQdUitjJaNS93P92/Ie5hi1GEzMor89ERYsXaxe06F1guUKlEFcj6VKrVBJ/ciDVNg
         HklD/QJEZJB5olJ0hyCU6bE9D1u/Mrl+H8ZD1ugcMCSzwVytYtSnugO8/gaWfluWEOOs
         AMnvpNAYXthy4G9UMWIl3agCZj80GsJGc96YkwbBb8u/ktQHfAG7/98OvsLyDDF1uNX6
         VLM40qstAe/XKxi38XdNBEWec0zwPwpVSpWgM/VjsOaYXq4dqtCb5wrtcybzk9pFnVnV
         Y3TQ==
X-Gm-Message-State: AJIora928lZlT7lPRVAtqsrbQ22CdnqWNIYmpkJ0vIKraSXoeSC2uzqW
        eOdP1aG0Ic+l9K2LH7Z/wPojf568VY7gxFU=
X-Google-Smtp-Source: AGRyM1s4APE6/bCx07qx5C96Q5YLy1DDaOjPMssv3bm12xPXOIlOiSyxNSOEQbXpq/LKeOEvrqL63Q==
X-Received: by 2002:a05:620a:44c6:b0:6b0:3757:4521 with SMTP id y6-20020a05620a44c600b006b037574521mr12349439qkp.655.1656709751384;
        Fri, 01 Jul 2022 14:09:11 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id x9-20020a05620a448900b006a708baa069sm12724705qkp.101.2022.07.01.14.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 14:09:10 -0700 (PDT)
Date:   Fri, 1 Jul 2022 17:09:09 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <20220701210909.vgyb5ls644pldr2g@moria.home.lan>
References: <20220628042610.wuittagsycyl4uwa@moria.home.lan>
 <YrqyiCcnvPCqsn8F@T590>
 <20220628163617.h3bmq3opd7yuiaop@moria.home.lan>
 <Yrs9OLNZ8xUs98OB@redhat.com>
 <20220628175253.s2ghizfucumpot5l@moria.home.lan>
 <YrvsDNltq+h6mphN@redhat.com>
 <20220629181154.eejrlfhj5n4la446@moria.home.lan>
 <YrzykX0jTWpq5DYQ@T590>
 <20220630011454.c6djuzkwsn33x7y6@moria.home.lan>
 <Yr5w6+/AAYSxcHaf@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr5w6+/AAYSxcHaf@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 01, 2022 at 11:58:35AM +0800, Ming Lei wrote:
> Why do we need to pay the cost(4 bytes added to bio and the updating
> in absolutely fast path) if rewind isn't used? So far, only dm requeue
> needs it, and it is one very unusual event.
> 
> Assuming fixed bio end sector should cover most of cases, especially
> if bio_rewind is only for dm or driver.
> 
> I'd suggest to not take this way until turning out bio_rewind() is not
> enough for new requirement or usages.

Well, you're proposing add this to the block layer, not just dm, so we should be
looking at potential users and not just this one use case.

Check out block/blk-crypto-fallback.c -> blk_crypto_fallback_decrypt_bio: it's
using __bio_for_each_segment, which is how I found it. It's also using a
bio_crypt_ctx they've stashed in their per-bio bio_fallback_crypt_ctx, in
blk_crypto_fallback_bio_prep, in addition to saving a copy of bio->bi_iter.

bio_crypt_ctx is 40 bytes, struct bvec_iter is currently 20 bytes, so we'd be
replacing 60 bytes of per-bio state with 8 bytes, if we went with bio_pos. And
this code path is used by block/blk-crypto.c as well, not just
blk-crypto-fallback.c.

drivers/md/dm-integrity.c: Again, we're saving a bvec_iter (using
dm_bio_record()) so that after the bio completes we can walk through the bio as
it was when we submitted it. Here, we're also interested in bi_integrity, but
what dm_bio_record() is doing looks highly suspect - we're only saving a copy of
the bio->bi_integrity pointer, but bio_integrity_payload contains another
bvec_iter and that's probably what should be getting saved.

So for this code, switching bio_(get|set)_pos would likely either be eliminating
the need for a tricky workaround I haven't spotted yet, or perhaps fixing an
actual bug - and it'd be saving 20 bytes of state in dm_bio_details.

Side note: according to the comment in dm_bio_details, what that code is trying
to do is actually something rather interesting - fully restore the state of a
bio so it can be resubmitted to another device after an error. This is probably
something that's worth promoting to block/bio.c, so it can be kept in sync with
e.g. bio_init() and bio_reset, and because we have other code in the kernel
that's doing similar stuff and might want to make use of it if it was standard
(btrfs, bcachefs, md-multipath, perhaps aoe).

drivers/block/aoe/aoecmd.c: here we're also saving bvec_iter, but this code is
doing a different trick that it's able to do because it's not submitting the bio
to other block drivers, the terminal handling is in its own code. It's not
modifying bio->bi_iter at all, which is neat because it makes resubmitting after
an error trivial.

This code is smart, and I would consider it a vote in favor of the bio_iter
approach (but see below, I'm not actually advocating we do that). I do something
similar in bcachefs, my read retry path: the original bio may have been
fragmented, and a retry may be for only a fragment of an original bio. Having a
separate bvec_iter means that the retry path can submit a retry for only a
fragment of the original bio, without having to mutate it or race with other
threads that are doing things with other parts of the original bio. It's not
strictly necessary functionality - I could've also solved this by not freeing
the fragment and retrying that - but it kept things simpler in other ways (the
retry may itself end up being fragmented if the extents we're reading from
changed, which means in the normal read path fragment bch_read_bios only ever
point to toplevel bch_read_bios, but retrying fragment bch_read_bios would mean
when doing retries we'd have fragments pointing to fragments pointing to
fragments, and memory allocations bounded only by the maximum number of retries
we could do).

So the struct bio_iter approach - segregating all the things we mutate when
iterating over a bio into a sub-type, i.e. what I was originally doing with
bvec_iter - has some nice and useful properties, but OTOH with integrity and now
bio_crypt_ctx it doesn't look super practical anymore - bio_iter would always
have to contain whatever it is we need for iterating over crypt and integrity if
those features are #ifdef'd in, whereas now an individual bio only pays the
memory overhead for those features if they're in use.

OTOH, looking at actual code, bio_(get|set)_pos gets us 90% of the elegance of a
separate iterator type, and it works for what all the code I've looked at is
trying to do (except for bcachefs, but I have no interest in blk crypt or
integrity so I'm fine with the current situation).

That's just what I found with a bit of perusing - there's other things I'd want
to look at if I wanted to be thorough (anything with multipath in the name for
sure, I haven't looked at all at the nvme multipath code yet).
