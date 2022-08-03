Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7D2C19F28
	for <linux-block@archiver.kernel.org>; Wed,  3 Aug 2022 16:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiHCQ0g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Aug 2022 12:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbiHCQ0f (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Aug 2022 12:26:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627646437
        for <linux-block@vger.kernel.org>; Wed,  3 Aug 2022 09:26:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id uj29so19257362ejc.0
        for <linux-block@vger.kernel.org>; Wed, 03 Aug 2022 09:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ok3jEUCH7C6U/rWWLx1fx5n8cpqu+dEHYVayrJJDOZQ=;
        b=AP0ROEWz99K4MogF3klHzWYWJpUIySKZCBV70gW9+yF2lz4GEuk9CbnDr8f1fCB/kC
         bECUmXNoQqNcE86csigc9RgQllI3oHlk3wOasI6CleEkjrHEgpbmjqyH9T/JH4b1QUb4
         Ft4NzuW5FzniyZNgk4M21/MlraOJWgQEelUQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ok3jEUCH7C6U/rWWLx1fx5n8cpqu+dEHYVayrJJDOZQ=;
        b=e2EkS1U9ana36Jlz/VapTYoEhKazgh1Uzy+fslWwHewTAgvgoOW/JVL5UfusGixHXb
         jTkRdHhJHOLiYTDgtJnMHtGRBeIjQSAp44lVCH5Z7YxyBCM0DVbC/f1xeA4ap48mLww2
         igAX4l+Wietz4d7I1HHcKc9oyHuJf7TeYMnI0zQKn0wMr9pKtgn1mNDmUuBpwElAwh3L
         1c4nQC38UkI1GGDJkTyb+laM7+wUzW01a5p+NT2VGwFBBka6GCSO0ZRZU86F51nXpJ+5
         qSK7EvGO971gk9WEjAP/AdhTMP+Q3crPdItzZqFA8jOOdJkzAmMOWxHcb8LKWc8FNKTz
         L2KA==
X-Gm-Message-State: ACgBeo36PeNeVoYygrNh+5qBKUoSe8AXJjT4phDe6Hydn7cqnaxXivx3
        J3g53g5DhssocILUvMS7zSYyeMGw4cM2MoB9
X-Google-Smtp-Source: AA6agR6RzMXTzUVQarXyJiJLw1gYRSrXd3ZeIQxyF2wPYep2MzsohIdDnGinb/SY+8sp1JKQPWgzzQ==
X-Received: by 2002:a17:906:6a02:b0:730:9f44:2bff with SMTP id qw2-20020a1709066a0200b007309f442bffmr6975991ejc.209.1659543992661;
        Wed, 03 Aug 2022 09:26:32 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906308500b0072b565507c5sm7365013ejv.203.2022.08.03.09.26.31
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 09:26:31 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id a18-20020a05600c349200b003a30de68697so2057425wmq.0
        for <linux-block@vger.kernel.org>; Wed, 03 Aug 2022 09:26:31 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed0:b0:3a3:3ef3:c8d1 with SMTP id
 g16-20020a05600c4ed000b003a33ef3c8d1mr3397559wmq.154.1659543990954; Wed, 03
 Aug 2022 09:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
 <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com>
 <YumYKVWYnoALoSBR@kbusch-mbp.dhcp.thefacebook.com> <74bb310b-b602-14eb-85f7-4b08327b0092@kernel.dk>
 <CAHk-=wgAeL8+BYsy4mnut+y7sBF_+LXmW5bjUfegBpg8SisBJQ@mail.gmail.com>
 <7d663c1a-67a2-159e-3f93-28ec18f3bd9d@kernel.dk> <CAHk-=wgALRccia0ouYywoDAH7RDCpi3rwfjwT0TZ7gV4O1+qaA@mail.gmail.com>
 <38164718-0f09-76e5-a21d-2122613cdf73@kernel.dk> <CAHk-=wii5SG2=P1kStBYJ9JiK97GYZcYdozy-JP15qNcfQXF3g@mail.gmail.com>
 <2ae97675-383b-c2c7-9bed-6a9a55ce64f1@kernel.dk> <CAHk-=wjQpMT+Z-=B4QzGT_BkSe0kuqDuK+hBvOq7YTXKmM2HEQ@mail.gmail.com>
 <c1b1b619-9142-9818-0536-ce4b97d3e979@kernel.dk> <3af4127a-f453-4cf7-f133-a181cce06f73@kernel.dk>
In-Reply-To: <3af4127a-f453-4cf7-f133-a181cce06f73@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 09:26:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whx-CA1QpFc_6587OmiJHb5+OYDR9aRQQh6=06oJWZG8Q@mail.gmail.com>
Message-ID: <CAHk-=whx-CA1QpFc_6587OmiJHb5+OYDR9aRQQh6=06oJWZG8Q@mail.gmail.com>
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
To:     Jens Axboe <axboe@kernel.dk>, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 3, 2022 at 8:16 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On the topic of warnings, on my new build box I get a lot of these:
>
> ld: warning: arch/x86/lib/putuser.o: missing .note.GNU-stack section implies executable stack
> ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
>
> which ends up polluting the output quite a bit.
>
> axboe@r7525 ~> ld --version
> GNU ld (GNU Binutils for Debian) 2.38.90.20220713

Ok, I have binutils 2.37, so it may be new to 2.38.

Some googling around seems to imply that we'd need to so something like this

   .section .note.GNU-stack,"",%progbits

in all our *.S files.

We do have some signs of that in our tooling, because apparently it
has hit user-space, but I wonder what has triggered the need on the
kernel side for you.

I'd hate to add that pointless line to every asm file, but maybe we
could so something like this

   #ifdef __ASSEMBLY_
   #ifdef OUTPUT_PROGBITS
      .section .note.GNU-stack,"",%progbits
      #undef OUTPUT_PROGBITS
   #endif
   #endif

and then change our 'AS' command line to do '-DOUTPUT_PROGBITS' in our
makefiles.

*Most* asm files should include <linux/linkage.h> just for all the
macros that declare variables externally, so that might catch the bulk
of it.

Somebody who knows the rules better than I would be a good idea.

I've added random people who have touched those linkage things in the
past to the participants, in the hope that somebody goes, "No, Linus,
just add flag XYZ to the linker script" or other and there's a clear
and obvious solution.

               Linus
