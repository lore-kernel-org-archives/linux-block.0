Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246D2C19F28
	for <linux-block@archiver.kernel.org>; Wed,  3 Aug 2022 17:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbiHCRi3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Aug 2022 13:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbiHCRi3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Aug 2022 13:38:29 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56BD11819
        for <linux-block@vger.kernel.org>; Wed,  3 Aug 2022 10:38:26 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s14so19683777ljh.0
        for <linux-block@vger.kernel.org>; Wed, 03 Aug 2022 10:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6WTJCQXyI8vwHbXB7t9kZUlvByDeVZWO+/zcRb4gkY=;
        b=TyDk2tNCAQxsuFRuzm0EHOXJFf0a0YjIjsaK2OK3r77DlUNB30niGZ/SIQt3NQHPb7
         V3N3Q1XKfFwPaXSAISuwA3kbCc6vlY4EnxWoQ4aetTOuMUDsyOZlzgs1+3JHUAb0Xywi
         K7NwBfpH8F4e8NOfVzHngfMZo9n2WUzLibKO+PUMRnFDDnEx3JOvltIEYYfj8NGsKKHb
         0qwc7lKJzEfl/M6PWjkXzxzabTh/dMI5Zk9dZlWV8wGlN4kD4DtZnrlQHAWMaYV1DxpG
         58zsj/1M3YO/Rir3WsR1po+BM2AWYZh/vvEgHmeIVLPeOcSyprR3ErrgP8Il8VZ12GGm
         FMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6WTJCQXyI8vwHbXB7t9kZUlvByDeVZWO+/zcRb4gkY=;
        b=gI7l8o4ePOQrGAQNlcyoh3RFcHKX5i0z2QD8Un4JkC5qviBKNGeBXP2RncPejNjo2O
         pvz5xLr+DsJaKXQRkROFWaJaDZFC2oYKLXrawlCPmeUQF6gg74fq6GOLWVv4fVgqMfEZ
         /cmqHvqCVDD9l6sBdip49rGArGTATvq3LT+NakQ5yH2eWNI0/tHda1hlWn/UP61FtdpB
         AN1bGen3vI/QWM544/GlJw6TitblObMtz16DQE3/8j630QYDfdm8dFOhuAF+v2KdbcKg
         u4lIPRUtYy8JZLRQ/4mZeJKahdtgQ4immo2Ke8oQ4e2BJWLCXdlkDhJ5ERzJ99F3SPsq
         BuYw==
X-Gm-Message-State: AJIora/6zDezEo0GvyH4dMJSMuyx7NbxKMDZlVY68gimN6ZIT2vpcCxG
        dCAqUK+TlltwtyrlK9KEm4wepmnnmoqKkJdsa5cx6X9jhI6a2g==
X-Google-Smtp-Source: AGRyM1uxYLBu0KNympoAGKFIgqqgCHpNPUOreqSziN6K1nDd3aPqmUdNh6QxThsUSPEhigW/V5NFA15WUQKapho0LZY=
X-Received: by 2002:a05:651c:4cb:b0:25d:9a43:16fd with SMTP id
 e11-20020a05651c04cb00b0025d9a4316fdmr8280381lji.493.1659548305087; Wed, 03
 Aug 2022 10:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
 <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com>
 <YumYKVWYnoALoSBR@kbusch-mbp.dhcp.thefacebook.com> <74bb310b-b602-14eb-85f7-4b08327b0092@kernel.dk>
 <CAHk-=wgAeL8+BYsy4mnut+y7sBF_+LXmW5bjUfegBpg8SisBJQ@mail.gmail.com>
 <7d663c1a-67a2-159e-3f93-28ec18f3bd9d@kernel.dk> <CAHk-=wgALRccia0ouYywoDAH7RDCpi3rwfjwT0TZ7gV4O1+qaA@mail.gmail.com>
 <38164718-0f09-76e5-a21d-2122613cdf73@kernel.dk> <CAHk-=wii5SG2=P1kStBYJ9JiK97GYZcYdozy-JP15qNcfQXF3g@mail.gmail.com>
 <2ae97675-383b-c2c7-9bed-6a9a55ce64f1@kernel.dk> <CAHk-=wjQpMT+Z-=B4QzGT_BkSe0kuqDuK+hBvOq7YTXKmM2HEQ@mail.gmail.com>
 <c1b1b619-9142-9818-0536-ce4b97d3e979@kernel.dk> <3af4127a-f453-4cf7-f133-a181cce06f73@kernel.dk>
 <CAHk-=whx-CA1QpFc_6587OmiJHb5+OYDR9aRQQh6=06oJWZG8Q@mail.gmail.com>
 <CAKwvOdkpNRvD0kDe-j8N0Gkq+1Fdhd6=z-9ROm3gc12Sf0k-Kg@mail.gmail.com> <552201a1-2248-b16e-1118-54373531a158@kernel.dk>
In-Reply-To: <552201a1-2248-b16e-1118-54373531a158@kernel.dk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 3 Aug 2022 10:38:13 -0700
Message-ID: <CAKwvOdm3RE14sNrKX9OS-2YrSjEgmq2VqZwXjRQ+yTUXR1FzNQ@mail.gmail.com>
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 3, 2022 at 9:53 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/3/22 10:51 AM, Nick Desaulniers wrote:
> > On Wed, Aug 3, 2022 at 9:26 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >>
> >> On Wed, Aug 3, 2022 at 8:16 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>>
> >>> On the topic of warnings, on my new build box I get a lot of these:
> >>>
> >>> ld: warning: arch/x86/lib/putuser.o: missing .note.GNU-stack section implies executable stack
> >>> ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> >>>
> >>> which ends up polluting the output quite a bit.
> >>>
> >>> axboe@r7525 ~> ld --version
> >>> GNU ld (GNU Binutils for Debian) 2.38.90.20220713
> >>
> >> Ok, I have binutils 2.37, so it may be new to 2.38.
> >>
> >> Some googling around seems to imply that we'd need to so something like this
> >>
> >>    .section .note.GNU-stack,"",%progbits
> >>
> >> in all our *.S files.
> >>
> >> We do have some signs of that in our tooling, because apparently it
> >> has hit user-space, but I wonder what has triggered the need on the
> >> kernel side for you.
> >>
> >> I'd hate to add that pointless line to every asm file, but maybe we
> >> could so something like this
> >>
> >>    #ifdef __ASSEMBLY_
> >>    #ifdef OUTPUT_PROGBITS
> >>       .section .note.GNU-stack,"",%progbits
> >>       #undef OUTPUT_PROGBITS
> >>    #endif
> >>    #endif
> >>
> >> and then change our 'AS' command line to do '-DOUTPUT_PROGBITS' in our
> >> makefiles.
> >>
> >> *Most* asm files should include <linux/linkage.h> just for all the
> >> macros that declare variables externally, so that might catch the bulk
> >> of it.
> >>
> >> Somebody who knows the rules better than I would be a good idea.
> >
> > $ as --help | grep exec
> >   --execstack             require executable stack for this object
> >   --noexecstack           don't require executable stack for this object
> >   --statistics            print various measured statistics from execution
> >
> > Does adding `--noexecstack` to KBUILD_ASFLAGS for these architectures
> > help, rather than modifying every assembler source?
>
> I can try whatever here, but a quick grep doesn't find anything for
> KBUILD_ASFLAGS or anything close to it. What am I missing?

Sorry, I'm running between many meetings today...so suggestions aren't
tested and may not be fully coherent...

KBUILD_AFLAGS += -Wa,--noexecstack

There's also as-option Make macro in case older binutils doesn't
support that flag outright.

tools/perf/Makefile.config also uses noexecstack as a linker flag.
That might be an option, too.  It is the linker producing the
warnings, not the assembler, but the assembler flag is probably the
way to go to fix the warnings since it sounds like these are assembler
sources exclusively causing the issue.
-- 
Thanks,
~Nick Desaulniers
