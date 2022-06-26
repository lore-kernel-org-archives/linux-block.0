Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54594C433EF
	for <linux-block@archiver.kernel.org>; Sun, 26 Jun 2022 20:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiFZUKH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jun 2022 16:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiFZUKH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jun 2022 16:10:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC501E4;
        Sun, 26 Jun 2022 13:10:06 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z7so10325502edm.13;
        Sun, 26 Jun 2022 13:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rJuPbA3mvgQ1UavLWynKCu9taYSl+atEyiGP6lqPI3M=;
        b=ajtUqXckHgU6DGnQL9ONt5weSMn3lBryMp/NIrCV5ARpsHUc1E4QGrpiRTXv/mwINt
         sBhxbx2R3bPlYrqBekxXQGwdoDqfEZ9zyv54axatAIGfBhpnCkf/gHBEYnEa2r7MXJ+P
         4DZligf6GxCBb688Qr+9HPG5ciKA58o9qVyKYJVVdFAUNXO6E+3GYFEdcUhCo7li/YTc
         6ftJMyPXUurcpjWPVrAQ6DIRW+3aDJ80Je1XqUwlAxgzuT8XxGJK2IucAgoRIK5rhMWo
         qgT5XebyXXKGka7qoXSf3c9dmnFK4RkB6SOdeU+eizYnpkoETkR9i1yB9WkaELo0+3cr
         BGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rJuPbA3mvgQ1UavLWynKCu9taYSl+atEyiGP6lqPI3M=;
        b=8LMF2bsS2lYB3AbXuvamUGR5QmcOuRfew6ZEB2LQN4ygzUtEB32t/1+mNUfzrkLP9o
         9YjYReYARqABHP+YUE133SCmg3W6VBqVi2w/jJ0JvUzVn40V70M1P8+vyulrtd86XDQT
         hNtnvLdvAMS/DG+sUPvVmCC5ybSRCdiVIA6de9i1mTKbRErWTXu6BYkONDAAIJf29pwp
         gxkQ+iNSfs4DNIz0yAEUqJUMaxQLVbh4FntOS3onolZPl3dwTyOfSw1srw7dg5OE+TsV
         wLjKa3iBl3YX+wY994CXV4Lw0KoL4f31wScLjF3mvsXha44A9sim8WGukI9pdZoaFET9
         BE0w==
X-Gm-Message-State: AJIora8VGg4UwrcYBbfGuW45VrbcV7Y/DW8Hf9YQJvEGh3yxjCuKm6a+
        6WVh6anCdZU/cwws7nvXeYGKj2P3Vdw=
X-Google-Smtp-Source: AGRyM1trgn07anM7aN9BfQtE0rP2AzDTjsMWWheDa8E0MoFWc6csekvylKhH9z6DkSRkDhL8A22xHg==
X-Received: by 2002:a50:fc90:0:b0:435:6b30:f1b0 with SMTP id f16-20020a50fc90000000b004356b30f1b0mr12691484edq.423.1656274204544;
        Sun, 26 Jun 2022 13:10:04 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id op23-20020a170906bcf700b0070aaad0a173sm4105969ejb.192.2022.06.26.13.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 13:10:04 -0700 (PDT)
Date:   Sun, 26 Jun 2022 22:10:02 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH 51/51] fs/zonefs: Fix sparse warnings in tracing code
Message-ID: <20220626201002.net2d4clpe23j24n@mail>
References: <20220623180528.3595304-1-bvanassche@acm.org>
 <20220623180528.3595304-52-bvanassche@acm.org>
 <20220624045613.GA4505@lst.de>
 <aa044f61-46f0-5f21-9b17-a1bb1ff9c471@acm.org>
 <20220625092349.GA23530@lst.de>
 <3eed7994-8de2-324d-c373-b6f4289a2734@acm.org>
 <20220626095814.7wtma47w4sph7dha@mail>
 <CAHk-=wj8gM8q04v2jS5JGjEdoE2d+B4_nm74xrFjZ77f9YRsbA@mail.gmail.com>
 <CAHk-=whMV0CAb66pJASCcAwMZNfJpRKrO=EwXcm-vWUnXF7gDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whMV0CAb66pJASCcAwMZNfJpRKrO=EwXcm-vWUnXF7gDA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jun 26, 2022 at 09:50:50AM -0700, Linus Torvalds wrote:
> On Sun, Jun 26, 2022 at 9:33 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >  (a) for the casting part, I actually suspect we should drop the
> > warning about castign integers to restricted types.
> 
> Heh. Trying that out, I find we seem to do this at the wrong point anyway.
> 
> I removed the check for "value of 0 is ok", and it continues to warn
> about casting "-1".
> 
> Because it does that before "-1" has even been simplified, so it
> actually sees it as an *expression* ("negate the constant 1") rather
> than as the *value* -1, and it warns.
> 
> That's a bit sad since really -1 and ~0 really both should be ok for
> the same reason plain zero is ok - regardless of the whole "do we just
> allow it for constants in general" thing.

Well, this "there is no negative constants, only minus positive ones" 
is kinda special. Maybe we can special-case this, just doing an early
mini-expansion of PREOP('-', EXPR_VALUE). I'm not sure about all
implications it would have on typechecking though.

> I think the bitwise thing was always a bit half-baked. It was designed
> for detecting little-endian and big-endian issues, and "bitmask"
> types. And it's wonderful for the basics of that, but I think it was
> never really thought through for this kind of extended use where we
> end up having generic macros that do still make sense for them, but
> aren't that exact "avoid assigning bitwise values to other values"

Yes, I fully agree
Also, it's the only 'strong' type that sparse has (IIRC nocast was
too weak), so it's used for everything. Allowing only the bitwise
operators is often too restrictive. I think that often what people
just need is an unique type that doesn't mix with other types
but that can 1) mix with constants (certainly with 0, 1 and -1) and
2) can use the usual arithmetic operations (certainly the compares).

-- Luc
