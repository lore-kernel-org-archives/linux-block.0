Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986B2C43334
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 17:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiF1Rxn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 13:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbiF1RxU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 13:53:20 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFFA1BA
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 10:52:55 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id u124so10208992qkb.12
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 10:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ewm/D54QJwPydqqMESWdGD9ZAIStLXJg44P7oeFTnc4=;
        b=ErIsmJXR7LWczilN2+MpE8zoFzdwjIHyWkmYyRBC7qbZO8Gag/I2B+hkf+n9GQoRla
         rzmHsx4XCWFSnLnoKg73Fcw5rXPHJSpj8OR0TQkTeYhYZIlEP4+a4DuDri3mU91+A2cT
         ZOmTltrdlsHd+5EjbMFnWTmR6J8w4mkrl4WX51UM45JZKNatido2624sihpklRl9D45T
         MxC7T01MG/hUc6xq4IbwkQSHLuD4XJPFUTwsdxsFPB2lAue9vKaGUoIQSkjXRuYvWswd
         icIy7LqF9XOcMqOcx6ZEQCigXCHbxQoA52YY7tc8aDQxm1a/fh91yzSzW538Hsl+IDeb
         3CEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ewm/D54QJwPydqqMESWdGD9ZAIStLXJg44P7oeFTnc4=;
        b=1ROHWIeKcTvSGJ2pOWYflloiXvNwCLf3gwrIlHDoZvsG9jUvE4wexhGPKV8QmeAvay
         hI7lPNDQeNSR4qQCujiDSyoJcTw5UFChqtCIlSBPNKpJFgIFGReZKqP6SjuNlkdBaxTQ
         atlt/AFU/rQU0AxuxYzPZXk2vnkQhFwjBkRG0b6aK8p7tJ4mRFgutgSlKf7O+iv8AceC
         lBoXwAHuDaGpm00zpK4w4Wvpkwn5XbvTlhlQibAA41k6oMfKWvm1KCkNsegLq79+LseP
         pNFXciAMDsT+cNVma1MAuJoSHUJCHyo1xLcDiPpUN94mDoyv52PUc7estpqyNRt2hkGb
         ohiw==
X-Gm-Message-State: AJIora+IYUx85iE/JCr7ewKUPnrvW8CLXZsjr02SA2fgx4HOanbuSume
        AYwrDGbT/pNosNc6MPhNOA==
X-Google-Smtp-Source: AGRyM1v2jHOLNo75aMnY6qO6lwP4wH61BoDXlZP+NDawv2fIOw5rhViYFT1b6L+U1xEzQTF8j+LSKQ==
X-Received: by 2002:a37:355:0:b0:6ae:e5a7:bb5c with SMTP id 82-20020a370355000000b006aee5a7bb5cmr12528898qkd.758.1656438774998;
        Tue, 28 Jun 2022 10:52:54 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id cb24-20020a05622a1f9800b003187c484027sm3631751qtb.73.2022.06.28.10.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 10:52:53 -0700 (PDT)
Date:   Tue, 28 Jun 2022 13:52:53 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <20220628175253.s2ghizfucumpot5l@moria.home.lan>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
 <20220624141255.2461148-2-ming.lei@redhat.com>
 <20220626201458.ytn4mrix2pobm2mb@moria.home.lan>
 <Yrld9rLPY6L3MhlZ@T590>
 <20220628042610.wuittagsycyl4uwa@moria.home.lan>
 <YrqyiCcnvPCqsn8F@T590>
 <20220628163617.h3bmq3opd7yuiaop@moria.home.lan>
 <Yrs9OLNZ8xUs98OB@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrs9OLNZ8xUs98OB@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 28, 2022 at 01:41:12PM -0400, Mike Snitzer wrote:
> On Tue, Jun 28 2022 at 12:36P -0400,
> Kent Overstreet <kent.overstreet@gmail.com> wrote:
> 
> > On Tue, Jun 28, 2022 at 03:49:28PM +0800, Ming Lei wrote:
> > > On Tue, Jun 28, 2022 at 12:26:10AM -0400, Kent Overstreet wrote:
> > > > On Mon, Jun 27, 2022 at 03:36:22PM +0800, Ming Lei wrote:
> > > > > Not mention bio_iter, bvec_iter has been 32 bytes, which is too big to
> > > > > hold in per-io data structure. With this patch, 8bytes is enough
> > > > > to rewind one bio if the end sector is fixed.
> > > > 
> > > > And with rewind, you're making an assumption about the state the iterator is
> > > > going to be in when the IO has completed.
> > > > 
> > > > What if the iterator was never advanced?
> > > 
> > > bio_rewind() works as expected if the iterator doesn't advance, since bytes
> > > between the recorded position and the end position isn't changed, same
> > > with the end position.
> > > 
> > > > 
> > > > So say you check for that by saving some other part of the iterator - but that
> > > > may have legitimately changed too, if the bio was redirected (bi_sector changes)
> > > > or trimmed (bi_size changes)
> > > > 
> > > > I still think this is an inherently buggy interface, the way it's being proposed
> > > > to be used.
> > > 
> > > The patch did mention that the interface should be for situation in which end
> > > sector of bio won't change.
> > 
> > But that's an assumption that you simply can't make!
> 
> Why not?  There is clear use-case for this API, as demonstrated in the
> patchset: DM can/will make use of it for the purposes of enhancing its
> more unlikely bio requeuing work (that is needed to make the more
> likely bio splitting scenario more efficient).
> 
> > We allow block device drivers to be stacked in _any_ combination. After a bio is
> > completed it may have been partially advanced, fully advanced, trimmed, not
> > trimmed, anything - and bi_sector and thus also bio_end_sector() may have
> > changed, and will have if there's partition tables involved.
> 
> We don't _need_ this API to cure cancer for all hypothetical block
> drivers.
> 
> If consumers of the API follow the rule that end sector of the
> _original bio_ isn't changed then it is all fine.  It is that simple.
> 
> Stacked drivers will work just fine.  The lower layers will be
> modifying their bios as needed. Because for DM those bios happen to
> be clones, so there is isolation to the broader design flaw you are
> trying to say is a major problem. As this patchset demonstrates.
> 
> I do concede that policing who can use an API is hard.  But if some
> consumer of an API tries something that invalidates rules of the API
> they get to keep the N pieces when it breaks.

Mike, keep in mind that when bio_rewind() was originally introduced, it
immediately grew users that were _inherently buggy_ (of the "users can break
this trivially") variety, and the whole thing had to be reverted, and I was
really annoyed - mostly at myself, because I would have caught it if I'd been
paying attention to the mailing list more.

And I _guarantee_ you that if this makes it in, we'll have the same thing
happening all over again - we have a lot of different block drivers being
written by a lot of different people, and most of them do not understand all the
subtleties of the block layer and the ways different things can interact, and so
the onus is on us to not add tools that they aren't going to immediately turn
around and slice themselves with.

The 32 bytes you're trying to save is meaningless. Think instead about the weeks
of engineer time that get wasted by bugs like this - chasing the bugs,
babysitting the patches in to fix it, then the _endless_ -stable backports.

_Please_ try to think more defensively when you're writing code.

So, and I'm sorry I have to be the killjoy here, but hard NACK on this patchset.
Hard, hard NACK.

I'll be happy to assist in coming up with alternate, less dangerous solutions
though (and I think introducing a real bio_iter is overdue, so that's probably
the first thing we should look at).

Cheers
