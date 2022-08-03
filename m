Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5807C19F28
	for <linux-block@archiver.kernel.org>; Wed,  3 Aug 2022 16:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbiHCQvc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Aug 2022 12:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237077AbiHCQva (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Aug 2022 12:51:30 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF9D3FA2F
        for <linux-block@vger.kernel.org>; Wed,  3 Aug 2022 09:51:29 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id z20so12423796ljq.3
        for <linux-block@vger.kernel.org>; Wed, 03 Aug 2022 09:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfRP7FGCVok/FfjtI9cUOoV1RW2CDvXvq1ZNhhexnuM=;
        b=ob2ovtTmP0zXy8yhdVagTihhFaB8uvjbBEOjKhh/Pg5PUMcIuz0IUMAcNPnzdXBSuD
         OHwUM0SFxW9d0Pggbp/w5O6taFX1QkkRDv2hTpIVXyNIOxm/2K+8s6EDYNz0M8cXdIwk
         pWXEVX59RVAg/ctBkIphsMHZeXgDfDfPgIkfI+sbm6cHgTgxwO+b6iiQVrfrHXeCb2li
         u4/rrZ+lvVDlBr7i6Q37tP1eMQDU7GB6CzcJStjJDWScz2N/kdU6gSPWXGD3rNKqKwZ6
         vZvFfbpwJMStAQKddpHtWNNjxjdGhnZ4mVsVuQTTMdpswNPDfjrbk6DXbFLLcDG0ubJK
         ztoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfRP7FGCVok/FfjtI9cUOoV1RW2CDvXvq1ZNhhexnuM=;
        b=e65+nzfd/P0s6UUzcUcH0HAO/I1f0RQaC/9HfxyAHCWFU/JWDhRuN+/DfsVzl/l8G7
         wpNe7QRgOTdMzbjZzwlC4RGsEmsKfsyp2CSyiuY0PC1yMqQ208uUl8BY6hTEawLllA6J
         jt9HnjIw55zUUXhAWtJmdigCIbjTQ0pvx/jidOrjdmqYZ5xyOhPYUQ/t8sSnFLRQ34fr
         0DrBqZNPHlwca6iZrirHKPysfZf/8IZBMgq6WU6XZHV8CiG3hV7jPRPsIVj1AxXqDwlG
         7eadWpiOiafZBggXsLX6afXItXTTVp3BRavRXn9lJOV13VVcIMzJyJaj/yJbyNQGcA6a
         kKGA==
X-Gm-Message-State: AJIora9+9kFcWm+v2QaUsP47OBb/L/2/1zi5a6uMSj8JKPMuxcie81ik
        5Qrbrl25QA20/aHsquRvw79vFM2e6L+dvTqOQL3DQw==
X-Google-Smtp-Source: AGRyM1vcIQlG30nh244iD4VZ/86DrYdx+LExEoaez7sxrAeh0dtDDMuF4WTDKkv/uHTM6+djliW8mcKHh2RcNHEjeLw=
X-Received: by 2002:a05:651c:4cb:b0:25d:9a43:16fd with SMTP id
 e11-20020a05651c04cb00b0025d9a4316fdmr8229195lji.493.1659545487859; Wed, 03
 Aug 2022 09:51:27 -0700 (PDT)
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
In-Reply-To: <CAHk-=whx-CA1QpFc_6587OmiJHb5+OYDR9aRQQh6=06oJWZG8Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 3 Aug 2022 09:51:16 -0700
Message-ID: <CAKwvOdkpNRvD0kDe-j8N0Gkq+1Fdhd6=z-9ROm3gc12Sf0k-Kg@mail.gmail.com>
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Mark Rutland <mark.rutland@arm.com>,
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

On Wed, Aug 3, 2022 at 9:26 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Aug 3, 2022 at 8:16 AM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On the topic of warnings, on my new build box I get a lot of these:
> >
> > ld: warning: arch/x86/lib/putuser.o: missing .note.GNU-stack section implies executable stack
> > ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> >
> > which ends up polluting the output quite a bit.
> >
> > axboe@r7525 ~> ld --version
> > GNU ld (GNU Binutils for Debian) 2.38.90.20220713
>
> Ok, I have binutils 2.37, so it may be new to 2.38.
>
> Some googling around seems to imply that we'd need to so something like this
>
>    .section .note.GNU-stack,"",%progbits
>
> in all our *.S files.
>
> We do have some signs of that in our tooling, because apparently it
> has hit user-space, but I wonder what has triggered the need on the
> kernel side for you.
>
> I'd hate to add that pointless line to every asm file, but maybe we
> could so something like this
>
>    #ifdef __ASSEMBLY_
>    #ifdef OUTPUT_PROGBITS
>       .section .note.GNU-stack,"",%progbits
>       #undef OUTPUT_PROGBITS
>    #endif
>    #endif
>
> and then change our 'AS' command line to do '-DOUTPUT_PROGBITS' in our
> makefiles.
>
> *Most* asm files should include <linux/linkage.h> just for all the
> macros that declare variables externally, so that might catch the bulk
> of it.
>
> Somebody who knows the rules better than I would be a good idea.

$ as --help | grep exec
  --execstack             require executable stack for this object
  --noexecstack           don't require executable stack for this object
  --statistics            print various measured statistics from execution

Does adding `--noexecstack` to KBUILD_ASFLAGS for these architectures
help, rather than modifying every assembler source?

>
> I've added random people who have touched those linkage things in the
> past to the participants, in the hope that somebody goes, "No, Linus,
> just add flag XYZ to the linker script" or other and there's a clear
> and obvious solution.
>
>                Linus



-- 
Thanks,
~Nick Desaulniers
