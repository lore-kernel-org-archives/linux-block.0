Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22F1C19F2D
	for <linux-block@archiver.kernel.org>; Sat,  6 Aug 2022 18:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiHFShJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Aug 2022 14:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiHFShI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Aug 2022 14:37:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C97D13B
        for <linux-block@vger.kernel.org>; Sat,  6 Aug 2022 11:37:06 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z22so6953874edd.6
        for <linux-block@vger.kernel.org>; Sat, 06 Aug 2022 11:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YOuCAuJv9B33lhDQ/WIlTMu/AvAFlKqYIlDyi4jBEH0=;
        b=dOljKcv5gKD2837WBWM6dXNUJ5AtbA1HFkOrsZSw6p9WjZuNagTtPZ1e4QnDUrIjOF
         vhfaZ3SBC9McAN8kGK74PFAlZS4Tks1xzHDLScdMRAfi6LCIpF4WkZ/klkM6tQd9SQCS
         8F37FRmEqb95rzWhOrHv9zAFzjYcrN9o+TUPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YOuCAuJv9B33lhDQ/WIlTMu/AvAFlKqYIlDyi4jBEH0=;
        b=zg8fAf0+iTBHhsQE1l9jr7GTXnFP/iYtMvn5ptsA88ETu9yDd429KWWL8i37CsdmAA
         VaXj5vd3sajsc6k0RGfN8hbQ2FTZ1xwBOAZVSB+3J5SEn10/W1Mc4t9FoFq7tQzx22D8
         Z/lP9zYTUAyUNaUqASpjKNYa6ZrilTOukRvv5g77bOQyv+leKGayFcC4jwPiehXOAbn7
         2vslKPByfzyRVCINvLDqZopdJoC8KrmGz/vduh4o6gPr+bDQ9f0m715RQMZMdaCJDFNV
         rhROsHw1TbJFwK4NUNurIOhr48udhK1woSsFOxdImvZqqQfeT7V8BsmppDPThoKlgf4v
         ufkQ==
X-Gm-Message-State: ACgBeo36CU16DwMYJAbvoQ4n+tZYne158fB/c8cZ19kvE8cLAGD7JPZn
        UmySXKdIIYXx0SPPJJZky7rhfklK8bikDW8G
X-Google-Smtp-Source: AA6agR4P1hNdFKPNxRPV0uRiVdhxFrsTyjzZaLsYqmp8Q0dQkcI65qr1trfd2TmcoMzpVaGIc2QuOg==
X-Received: by 2002:a05:6402:2079:b0:43d:a218:9b8a with SMTP id bd25-20020a056402207900b0043da2189b8amr11413570edb.357.1659811024754;
        Sat, 06 Aug 2022 11:37:04 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id e12-20020a170906314c00b007246492658asm2929447eje.117.2022.08.06.11.37.03
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 11:37:04 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id q30so6506877wra.11
        for <linux-block@vger.kernel.org>; Sat, 06 Aug 2022 11:37:03 -0700 (PDT)
X-Received: by 2002:a05:6000:178d:b0:222:c7ad:2d9a with SMTP id
 e13-20020a056000178d00b00222c7ad2d9amr146107wrg.274.1659811023524; Sat, 06
 Aug 2022 11:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <YugiaQ1TO+vT1FQ5@redhat.com> <Yu1rOopN++GWylUi@redhat.com>
 <CAHk-=wj5w+Nga81wGmO6aYtcLrn6c_R_-gQrtnKwjzOZczko=A@mail.gmail.com> <Yu6zXVPLmwjqGg4V@redhat.com>
In-Reply-To: <Yu6zXVPLmwjqGg4V@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Aug 2022 11:36:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+ywtyBEp7pmEKxgwRE+iJBct6iih=ssGk2EWqaYL_yg@mail.gmail.com>
Message-ID: <CAHk-=wj+ywtyBEp7pmEKxgwRE+iJBct6iih=ssGk2EWqaYL_yg@mail.gmail.com>
Subject: Re: [git pull] Additional device mapper changes for 6.0
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Milan Broz <gmazyland@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Aug 6, 2022 at 11:30 AM Mike Snitzer <snitzer@kernel.org> wrote:
>
> >
> > Please don't use version numbers for ABI issues. Version numbers are
> > for human consumption, nothing more, and shouldn't be used for
> > anything that has semantics.
>
> Yes, I know you mentioned this before and I said I'd look to switch to
> feature bitmasks. Yet here we are. Sorry about that, but I will take
> a serious look at fixing this over the next development cycle(s).

Well, right now we're in the situation where there are certain kernels
that say that they implement "version 1.9" of the thing, but they
don't actually implement the "version 1.8.1" extensions.

So anybody who asks for "v1.8.1 or newer" will literally get random behavior.

And yes, that random behavior hopefully then doesn't happen with any
*tagged* kernel version, but it's an example of how broken version
numbers are as an ABI. Imagine you are bisecting something entirely
unrelated, and then end up testing one of those "this says it does
1.9, but doesn't do 1.8.1" kernels..

Presumably (and hopefully) these features are all so esoteric that
absolutely nobody cares.

IOW, I sincerely _hope_ the solution to the version number mess is
"nobody actually uses that field anyway".

Because if it matters, it's broken. It's broken by design, but we
literally seem to have one example of active breakage in the tree
right now.

               Linus
