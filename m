Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E39C48BD1
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 18:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B225613E1
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 18:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhFJS7K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 14:59:10 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:39438 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhFJS7G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 14:59:06 -0400
Received: by mail-lf1-f46.google.com with SMTP id p17so4820881lfc.6
        for <linux-block@vger.kernel.org>; Thu, 10 Jun 2021 11:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fRLZs+xpPU0awlv/sVbELYsIsLJoY4yzfXqdoTcuQ/A=;
        b=N7QJDxWDEjuPBEPA12jyVO3YWDYYqbNGXTo1BRgU5oCecpzdx8aNTH5DOHymsmQDFW
         bM6009FTN+jOq0LFqGFGMXMPP21MQXClexESyGzTEThu4AXhimLTKMLcGuhoQmMeObv4
         vKQi6VaJqiVAgxlZQuMHHR7MXSYsdMaF0cbPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRLZs+xpPU0awlv/sVbELYsIsLJoY4yzfXqdoTcuQ/A=;
        b=l6ZVZh5fhf/jdVPTfJMfYend7bqNq9COgbdnyggdoJQ6a3h8OPy0LTovp3S506kl9z
         Gt4MwkvWTP56WP+jo3frG42FoEBDUixZYGYIPtAm3ShCLYpvvyJwL+Aafp3RXB++dmT+
         ioKgEQTyIomYQHAXCcCQN/3uoMm6xo1f2YTXha19XzELKtx5pd7HbqKWgDcG/y4rqpQK
         OOE16S8usgGHd1evhHdXDplKJHiKP9Pv9ebtSFCbFPXGTXRne4gjqQWlexR0aadU5EzP
         wDgqwfbygU7Uiz7QcF3YctOBVUB2qzFRg+zGlpOxlT0NZTVkaAMnqlbv18nZ67uN+cBq
         RE0g==
X-Gm-Message-State: AOAM530cEyMJ7viwna4Nnq1Ee2Ps2Z79osyIe9moBY0VE7VjSf36MvRg
        5/blmDoYhl0AhU7M1o8sw9SXNrJJTFH8stso
X-Google-Smtp-Source: ABdhPJx7ajyT3cuSM2r2ojl1pI56E8p1HZkVzEazWJIIplg1Tn6h+gXBSUmatczRqf+6YAoljDUn8w==
X-Received: by 2002:a05:6512:1327:: with SMTP id x39mr165900lfu.37.1623351359516;
        Thu, 10 Jun 2021 11:55:59 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id j16sm374829lfk.155.2021.06.10.11.55.58
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 11:55:59 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id i10so4831471lfj.2
        for <linux-block@vger.kernel.org>; Thu, 10 Jun 2021 11:55:58 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr149804lfs.377.1623351358045;
 Thu, 10 Jun 2021 11:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <YH2hs6EsPTpDAqXc@mit.edu> <nycvar.YFH.7.76.2104281228350.18270@cbobk.fhfr.pm>
 <YIx7R6tmcRRCl/az@mit.edu> <alpine.DEB.2.22.394.2105271522320.172088@gentwo.de>
 <YK+esqGjKaPb+b/Q@kroah.com> <c46dbda64558ab884af060f405e3f067112b9c8a.camel@HansenPartnership.com>
 <b32c8672-06ee-bf68-7963-10aeabc0596c@redhat.com> <5038827c-463f-232d-4dec-da56c71089bd@metux.net>
In-Reply-To: <5038827c-463f-232d-4dec-da56c71089bd@metux.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jun 2021 11:55:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiB6FJknDC5PMfpkg4gZrbSuC3d391VyReM4Wb0+JYXXA@mail.gmail.com>
Message-ID: <CAHk-=wiB6FJknDC5PMfpkg4gZrbSuC3d391VyReM4Wb0+JYXXA@mail.gmail.com>
Subject: Re: Maintainers / Kernel Summit 2021 planning kick-off
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     David Hildenbrand <david@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Greg KH <greg@kroah.com>, Christoph Lameter <cl@gentwo.de>,
        "Theodore Ts'o" <tytso@mit.edu>, Jiri Kosina <jikos@kernel.org>,
        ksummit@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Netdev <netdev@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 10, 2021 at 11:08 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> And I know *a lot* of people who will never take part in this generic
> human experiment that basically creates a new humanoid race (people
> who generate and exhaust the toxic spike proteine, whose gene sequence
> doesn't look quote natural). I'm one of them, as my whole family.

Please keep your insane and technically incorrect anti-vax comments to yourself.

You don't know what you are talking about, you don't know what mRNA
is, and you're spreading idiotic lies. Maybe you do so unwittingly,
because of bad education. Maybe you do so because you've talked to
"experts" or watched youtube videos by charlatans that don't know what
they are talking about.

But dammit, regardless of where you have gotten your mis-information
from, any Linux kernel discussion list isn't going to have your
idiotic drivel pass uncontested from me.

Vaccines have saved the lives of literally tens of millions of people.

Just for your edification in case you are actually willing to be
educated: mRNA doesn't change your genetic sequence in any way. It is
the exact same intermediate - and temporary - kind of material that
your cells generate internally all the time as part of your normal
cell processes, and all that the mRNA vaccines do is to add a dose
their own specialized sequence that then makes your normal cell
machinery generate that spike protein so that your body learns how to
recognize it.

The half-life of mRNA is a few hours. Any injected mRNA will be all
gone from your body in a day or two. It doesn't change anything
long-term, except for that natural "your body now knows how to
recognize and fight off a new foreign protein" (which then tends to
fade over time too, but lasts a lot longer than a few days). And yes,
while your body learns to fight off that foreign material, you may
feel like shit for a while. That's normal, and it's your natural
response to your cells spending resources on learning how to deal with
the new threat.

And of the vaccines, the mRNA ones are the most modern, and the most
targeted - exactly because they do *not* need to have any of the other
genetic material that you traditionally have in a vaccine (ie no need
for basically the whole - if weakened - bacterial or virus genetic
material). So the mRNA vaccines actually have *less* of that foreign
material in them than traditional vaccines do. And  a *lot* less than
the very real and actual COVID-19 virus that is spreading in your
neighborhood.

Honestly, anybody who has told you differently, and who has told you
that it changes your genetic material, is simply uneducated.  You need
to stop believing the anti-vax lies, and you need to start protecting
your family and the people around you.  Get vaccinated.

I think you are in Germany, and COVID-19 numbers are going down. It's
spreading a lot less these days, largely because people around you
have started getting the vaccine - about half having gotten their
first dose around you, and about a quarter being fully vaccinated. If
you and your family are more protected these days, it's because of all
those other people who made the right choice, but it's worth noting
that as you see the disease numbers go down in your neighborhood,
those diminishing numbers are going to predominantly be about people
like you and your family.

So don't feel all warm and fuzzy about the fact that covid cases have
dropped a lot around you. Yes, all those vaccinated people around you
will protect you too, but if there is another wave, possibly due to a
more transmissible version - you and your family will be at _much_
higher risk than those vaccinated people because of your ignorance and
mis-information.

Get vaccinated. Stop believing the anti-vax lies.

And if you insist on believing in the crazy conspiracy theories, at
least SHUT THE HELL UP about it on Linux kernel discussion lists.

                Linus
