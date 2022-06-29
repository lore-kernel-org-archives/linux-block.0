Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250FBC43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 18:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiF2SMA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 14:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiF2SL6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 14:11:58 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EC81EC63
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 11:11:57 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id c1so25994034qvi.11
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 11:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gijk56NMdB/sja9dAmbjVTkCB9EEiLswQtfTGFbcORI=;
        b=Gg9+QKQ5hLDCJkkzKwPksV0KY/LD1W5vAjrrXFA9U+OE6AfDZAg7/dqP8IrpqnrSut
         nKJmNKC7vMlPbjLNuT9CZ8bsHS06bJNVaxOGgWbfLhV3wyQSWAG3mSmmTF7eCwvShNAW
         2qOgNLPONuWIR43C9+N+dag/P8pJNAGN2z9S243eWwaLWRK20/f55TAgkmNhfTaBeAOt
         dGromqGGGNcfbdKaKii6o1EmeV0GmubkVtYNcNo9ReSPQItYnhw7aqJvwL9r0Jzp7DZv
         nI2SdCZEt0ueLNk5AVeWevb3MT+1uai4jvoB+cizwU4VX83CHQyC5FX3LybQ4tgUKNBa
         CFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gijk56NMdB/sja9dAmbjVTkCB9EEiLswQtfTGFbcORI=;
        b=KXkbAcYpg7tcSdKzGzA/Ea1cLSzEEBeKWM9dYCASOO8saxHV5qaidIjzs80ZWLm7q9
         w8492w7D1FGN2aYSGD++pmHp6vxxF6HmLCKle3tKQXqG0ixPQQ+xt9Sdcd4IwIml4pys
         fevfOEaE2yMbKz0nV5oeprHUKya2yBhlOVxjLGfsG9gT10fc3tPw/D87aPMY4L2hmFUj
         YBx7ck4g5ShJui4lQBupHxIx2tNusNvXpbLVyL7chGFxcIXyoIzjiAY7l9wGyZHGxENH
         h2fo0GP4zqs3o+7NITIwV/W+nozlOA3qecIAbcVd6xrBNv0sHJ7DWhG3jVe6o4htKu9v
         4rjw==
X-Gm-Message-State: AJIora8h/WDlMC4BUHDZbyVbEXrbRMKHEDtNOrp/k9DFEtwc8s54QC0P
        5SpoitxGmSs7VdJ0QUlWSw==
X-Google-Smtp-Source: AGRyM1sPrUbtuaytU8RpCVUWuNrZiasGP0JPuy3ZOunsnIkksLe8Hvawxu7sMDiOu7MTU+ctUVOggA==
X-Received: by 2002:ac8:5fc3:0:b0:31d:2637:7ed6 with SMTP id k3-20020ac85fc3000000b0031d26377ed6mr2811002qta.282.1656526316309;
        Wed, 29 Jun 2022 11:11:56 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id g6-20020ac842c6000000b00317ccc66971sm10357618qtm.52.2022.06.29.11.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:11:55 -0700 (PDT)
Date:   Wed, 29 Jun 2022 14:11:54 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <20220629181154.eejrlfhj5n4la446@moria.home.lan>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
 <20220624141255.2461148-2-ming.lei@redhat.com>
 <20220626201458.ytn4mrix2pobm2mb@moria.home.lan>
 <Yrld9rLPY6L3MhlZ@T590>
 <20220628042610.wuittagsycyl4uwa@moria.home.lan>
 <YrqyiCcnvPCqsn8F@T590>
 <20220628163617.h3bmq3opd7yuiaop@moria.home.lan>
 <Yrs9OLNZ8xUs98OB@redhat.com>
 <20220628175253.s2ghizfucumpot5l@moria.home.lan>
 <YrvsDNltq+h6mphN@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrvsDNltq+h6mphN@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 29, 2022 at 02:07:08AM -0400, Mike Snitzer wrote:
> Please try to dial down the hyperbole and judgment. Ming wrote this
> code. And you haven't been able to point out anything _actually_ wrong
> with it (yet).
> 
> This patch's header does need editing for clarity, but we can help
> improve it and the documentation above bio_rewind() in the code.
> 
> > So, and I'm sorry I have to be the killjoy here, but hard NACK on this patchset.
> > Hard, hard NACK.
> 
> <insert tom-delonge-wtf.gif>
> 
> You see this bio_rewind() as history repeating itself, but it isn't
> like what you ranted about in the past:
> https://marc.info/?l=linux-block&m=153549921116441&w=2
> 
> I can certainly see why you think it similar at first glance. But this
> patchset shows how bio_rewind() must be used, and how DM benefits from
> using it safely (with no impact to struct bio or DM's per-bio-data).
> 
> bio_rewind() usage will be as niche as DM's use-case for it. If other
> code respects the documented constraint, that the original bio's end
> sector be preserved, then they can use it too.
> 
> The key is for a driver to maintain enough state to allow this fixed
> end be effectively immutable. (DM happens to get this state "for free"
> simply because it was already established for its IO accounting of
> split bios).
> 
> The Linux codebase requires precision. This isn't new.

Mike, that's not justification for making things _more_ dangerous.

> 
> > I'll be happy to assist in coming up with alternate, less dangerous solutions
> > though (and I think introducing a real bio_iter is overdue, so that's probably
> > the first thing we should look at).
> 
> It isn't dangerous. It is an interface whose constraint needs to be
> respected. Just like is documented for a myriad other kernel
> interfaces.
> 
> Factoring out a bio_iter will bloat struct bio for functionality most
> consumers don't need. And gating DM's ability to achieve this
> patchset's functionality with some overdue refactoring is really _not_
> acceptable.

Mike, you're the one who's getting seriously hyperbolic here. You're getting
frustrated because you've got this one thing you really want to get done, and
you feel like you're running into a brick wall when I tell you "no".

And yes, coding in the kernel is a complicated, dangerous environment with many
rules that need to be respected.

That does not mean it's ok to be adding to that complexity, and making it even
more dangerous, without a _really fucking good reason_. This doesn't fly. Maybe
it would if it was some device mapper private thing, but you're acting like it's
only going to be used by device mapper when you're trying to add it to the
public interface for core block layer bio code. _That_ needs real justification.

Also, bio_iter is something we should definitely be considering because of the
way integrity and now crypt has been tacked on to struct bio.

When I originally wrote the modern bvec_iter code, the ability to use an
iterator besides the one in struct bio was an important piece of functionality,
one that's still in use (including in device mapper; see
__bio_for_each_segment()). The fact that we're growing additional data
structures that in theory want to be iterated in lockstep with the main bio
payload but _aren't_ iterated over with bi_iter is, at best, a code smell and a
lurking footgun.

However, I can see that the two of you are not likely take on figuring out how
to clean that up, and truthfully I don't have the time right now either, much as
it pains me.

Here's an alternative approach:

The fundamental problem with bio_rewind() (and I know that you two are super
serious that this is completely safe for your use case and no one else is going
to use it for anything else) is that we're using it to get back to some initial
state, but it's not invariant w.r.t. what's been done to the bio since then, and
the nature of the block layer is that that's a problem.

So here's what you do:

You bring back bi_done: bi_done counts bytes advanced, total, since the start
of the bio. Then we introduce a type:

struct bio_pos {
	unsigned	bi_done;
	unsigned	bi_size;
};

And two new functions:

struct bio_pos bio_get_pos(struct bio *)
{
	...
}

void bio_set_pos(struct bio *, struct bio_pos)
{
	...
}

That gets you the same functionality as bio_rewind(), but it'll be much more
broadly useful.
