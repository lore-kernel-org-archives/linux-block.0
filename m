Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2892C35E04
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 18:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889E62082F
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 18:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582655274;
	bh=1ByXosMMDdYNeqtP69L/IiTPKKdM2qVjlS/Y1To24ko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NhUIxQGdoxOgabmhQ1vymwJONZz1Ci5JQpEbL7c0amI2WI1Qqbz2kXGoOTRTS+i6P
	 +zM3lvKFwpUbkLkOrcStGZ8B11kSS+czm6utqvRsIPYInu/7hPqasBIBdt0lL7Veq0
	 PSKEKt+urkP28cn70Wy9+WY+CKmKjHlDm2lFZWk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbgBYS1y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:27:54 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39743 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgBYS1x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 13:27:53 -0500
Received: by mail-lf1-f68.google.com with SMTP id n30so9680878lfh.6
        for <linux-block@vger.kernel.org>; Tue, 25 Feb 2020 10:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuecmF1yO4tHT3TnahV50e2HzEnXvd8V5CGAOVbnplY=;
        b=OqJ+vlEoWFx5gLSWgF61ab1/Q32WWhXbHNDXycmahm/2WHj3sW13PHAFhc/97Lcjm3
         VSMQMXqHCzPkueoOB2jz8PRFLmWZY4M2AybZF6quz9J+a5EMqVT4V/ip8ce/YaL8wYWI
         FnqkptEVf112Bjo5/UCNc1rFsaQgVSVoiz7xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuecmF1yO4tHT3TnahV50e2HzEnXvd8V5CGAOVbnplY=;
        b=r2zHEc1fkqLav0ZAdbAwxFJnlgym1uOmR7zR6For0WX88gLnNQmA0GN5KK9Db6zyvE
         vbjlY2mrx7RAVbG6oCw0dk7XWoZ7sckfrRsjHELGR3VF8zcwKqHj6dMynlHwpYFhpkRI
         Qg7W1HSqnB5q3CalP7AAblj96VfMxQh/SVnQ7I94Wa13M+1jpgyEWtCt/LzGiNk2UYa/
         whDrYX07pK+aSan8NbbY7NOMLbsB8ehBZdKDyROJqCXaZiC1EN6zlxioipoD//2frnEF
         6HkJeo7mANfkgm0F0/YCwIOE/vJP1hiZBTH3zg1pApUdjbM3ov/dthN4bvHXEApEJkL5
         7Huw==
X-Gm-Message-State: APjAAAXzVkPXR9y9k3TTgz9VgY+TptBSPtrTLBMb4dIrv6oPL9PPdxsh
        FMDNIW70CVHXOVfAjc8qFdMcfwu/KbQ=
X-Google-Smtp-Source: APXvYqz2g4DnKFIS/2+fVs5ZHqoodcDjf2EAMy6rJwsn1CsolCekiW8+zMOfAcBNMW1DFT9G9zpcWQ==
X-Received: by 2002:a05:6512:3041:: with SMTP id b1mr90262lfb.136.1582655271644;
        Tue, 25 Feb 2020 10:27:51 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id j7sm8314412ljg.25.2020.02.25.10.27.50
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 10:27:50 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id y6so25666lji.0
        for <linux-block@vger.kernel.org>; Tue, 25 Feb 2020 10:27:50 -0800 (PST)
X-Received: by 2002:a05:651c:555:: with SMTP id q21mr193655ljp.241.1582655270148;
 Tue, 25 Feb 2020 10:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20200224212352.8640-1-w@1wt.eu> <20200224212352.8640-2-w@1wt.eu>
 <CAHk-=wi4R_nPdE4OuNW9daKFD4FpV74PkG4USHqub+nuvOWYFg@mail.gmail.com>
 <28e72058-021d-6de0-477e-6038a10d96da@linux.com> <20200225034529.GA8908@1wt.eu>
 <c181b184-1785-b221-76fa-4313bbada09d@linux.com> <20200225140207.GA31782@1wt.eu>
 <10bc7df1-7a80-a05a-3434-ed0d668d0c6c@linux.com> <CAHk-=wggnfCR2JcC-U9LxfeBo2UMagd-neEs8PwDHsGVfLfS=Q@mail.gmail.com>
 <20200225181541.GA1138@1wt.eu>
In-Reply-To: <20200225181541.GA1138@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Feb 2020 10:27:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=whyEQy771ixppPmMSYtPcFS5ZtqVWUYow8gWd=pMnATNA@mail.gmail.com>
Message-ID: <CAHk-=whyEQy771ixppPmMSYtPcFS5ZtqVWUYow8gWd=pMnATNA@mail.gmail.com>
Subject: Re: [PATCH 01/10] floppy: cleanup: expand macro FDCS
To:     Willy Tarreau <w@1wt.eu>
Cc:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 25, 2020 at 10:15 AM Willy Tarreau <w@1wt.eu> wrote:
>
> On Tue, Feb 25, 2020 at 10:08:51AM -0800, Linus Torvalds wrote:
> >
> > So we can remove at least the FD_IOPORT mess from the header file, I bet.
> >
> > Worst case - if somebody finds some case that uses them, we can put it back.
>
> I like that. And at least we'll know how they use it (likely without the
> dependency on fdc).

Note that the way uapi header files generally got created was by just
moving header files that user space used mechanically. See for example
commit 607ca46e97a1 ("UAPI: (Scripted) Disintegrate include/linux")
which created most of them.

There was no careful vetting of "this is the part that is used by user
space". It was just a "these are the files user space has used".

So it's not really a "the uapi files are set in stone and you can't
change them". Instead, you should think of the uapi files as a big red
blinking warning that says "sure, you can change them, but you need to
be very careful and think about the fact that user space may be
including this thing".

So it's a "think hard about it" rather than a "don't go there".

Of course, usually it's much _simpler_ to just "don't go there" ;)

            Linus
