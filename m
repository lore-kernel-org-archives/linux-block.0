Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149DDC19F2C
	for <linux-block@archiver.kernel.org>; Wed,  3 Aug 2022 18:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiHCSGg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Aug 2022 14:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbiHCSGd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Aug 2022 14:06:33 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9642C491C8
        for <linux-block@vger.kernel.org>; Wed,  3 Aug 2022 11:06:31 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t22so27560919lfg.1
        for <linux-block@vger.kernel.org>; Wed, 03 Aug 2022 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A1n1Bq8CdodDpQBbrmMNPijVEFHqC9yamuOp6H0S1uk=;
        b=p5uWqY08+EZf2sBZm33JVMn0gAiWjMCMZTJiVk/w55JBsJoKJ5IzjG86BWPCS+R4BD
         WNQns/11XsXGbHlQtcYS/W2rX6piJFLif4XZ89ZyXMU7BaouGA4bmqI0Nuk7h1JFueXa
         Yj3Xeyl4TwDk496vwO33R07sP1kawoHQC6bwTr1lrVtfmcAmKjxBxp3RNBg/speH8qXE
         M4OMHZc/aejzDN/3LTULOXuSMutISS6D3NwcD6pTWUTfLqgq1HTzOb9+1rQTjWBrM48K
         6rX30BrfayG9EjoeKAIPTwbG29Bp/TgH1rz9tP+MhiMg/gkBPPhx6P/GeoNUDXIwmyBT
         5G8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A1n1Bq8CdodDpQBbrmMNPijVEFHqC9yamuOp6H0S1uk=;
        b=bP3/vz/EHnqxB3UN+NMp9ifbarVfyNDcFc2TqfdIFMGA478kRlft7dopyIcDb5UVwy
         wXK2A0zRTrJSz9VZ5HHwXs920iAJgbOaQBew3HEoaC4CYzgpk+NCnkNVrw9eZs93EH/z
         Jg1l7P1Bg/WXzhRbttaD5/XFCMl650kBmw5Wt1m6K0Zg+0DEouEpgL6tApVm79Pr0lkB
         Sdd4i5oyrwTaCOHVLqao/PdWz/8sW+TuFSFIB025e7eGPzmuPJ9c7bViOzFoD49BwP2D
         XHhx4ZJhoQvy5rx6lZwl5CQwek8rUItBXOK36Gs6rmibpGGTkw9HZE+Dr79CugMVk/k4
         2Wzg==
X-Gm-Message-State: ACgBeo0Qrt6QTDAyIxAim0YyXdjZB/4htR3KL5r2kErk/l4Z2N2tKb9k
        Yk1jIQrzHyWMpLTuu20CA12z3wjIhCVn3RwkfNFWXQ==
X-Google-Smtp-Source: AA6agR6Y2dm6U6UoJw9aZjVndxE8V2hhBL+GGq/vj7CVcu4Fg5IC1Z4fvHtlxTisvj/9PMjeZhqb24BWYCZ2hAcSjz8=
X-Received: by 2002:ac2:4d4a:0:b0:48b:1f80:a93d with SMTP id
 10-20020ac24d4a000000b0048b1f80a93dmr1436411lfp.403.1659549989607; Wed, 03
 Aug 2022 11:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
 <YumYKVWYnoALoSBR@kbusch-mbp.dhcp.thefacebook.com> <74bb310b-b602-14eb-85f7-4b08327b0092@kernel.dk>
 <CAHk-=wgAeL8+BYsy4mnut+y7sBF_+LXmW5bjUfegBpg8SisBJQ@mail.gmail.com>
 <7d663c1a-67a2-159e-3f93-28ec18f3bd9d@kernel.dk> <CAHk-=wgALRccia0ouYywoDAH7RDCpi3rwfjwT0TZ7gV4O1+qaA@mail.gmail.com>
 <38164718-0f09-76e5-a21d-2122613cdf73@kernel.dk> <CAHk-=wii5SG2=P1kStBYJ9JiK97GYZcYdozy-JP15qNcfQXF3g@mail.gmail.com>
 <2ae97675-383b-c2c7-9bed-6a9a55ce64f1@kernel.dk> <CAHk-=wjQpMT+Z-=B4QzGT_BkSe0kuqDuK+hBvOq7YTXKmM2HEQ@mail.gmail.com>
 <c1b1b619-9142-9818-0536-ce4b97d3e979@kernel.dk> <3af4127a-f453-4cf7-f133-a181cce06f73@kernel.dk>
 <CAHk-=whx-CA1QpFc_6587OmiJHb5+OYDR9aRQQh6=06oJWZG8Q@mail.gmail.com>
 <CAKwvOdkpNRvD0kDe-j8N0Gkq+1Fdhd6=z-9ROm3gc12Sf0k-Kg@mail.gmail.com>
 <552201a1-2248-b16e-1118-54373531a158@kernel.dk> <CAKwvOdm3RE14sNrKX9OS-2YrSjEgmq2VqZwXjRQ+yTUXR1FzNQ@mail.gmail.com>
 <65d2a122-ef68-a6bc-44e8-bb21ad7b9255@kernel.dk>
In-Reply-To: <65d2a122-ef68-a6bc-44e8-bb21ad7b9255@kernel.dk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 3 Aug 2022 11:06:18 -0700
Message-ID: <CAKwvOdmD10yK0r1H-M2PcnZgy3M0aA9gdkY0BErDOQ+KpBRxVQ@mail.gmail.com>
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
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

+ Linux Toolchains, Nick Clifton (author of
https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=ba951afb99912da01a6e8434126b8fac7aa75107)
https://lore.kernel.org/linux-block/CAKwvOdkpNRvD0kDe-j8N0Gkq+1Fdhd6=z-9ROm3gc12Sf0k-Kg@mail.gmail.com/
is the thread for context.

On Wed, Aug 3, 2022 at 10:45 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> I ran with the below and it silences the linker warning mentioned. I do
> also see the below with my build (which aren't new with the option added
> obviously, but not visible since I don't get the other noise):
>
> axboe@r7525 ~/gi/linux-block (test)> time make -j256 -s                      1.886s
> ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
> ld: warning: .tmp_vmlinux.kallsyms2 has a LOAD segment with RWX permissions
> ld: warning: vmlinux has a LOAD segment with RWX permissions

Not sure yet about these.  Looks like there's linker flags to disable
warnings...but I don't recommend those.
https://github.com/systemd/systemd/commit/b0e5bf0451a6bc94e6e7b2a1de668b75c63f38c8
I wonder if they go away by fixing the boot issues described below?

Otherwise, I think we need to find which section is the problematic
one; I suspect the segment flagged as LOAD is composed of many
sections, with possibly only one or a few that needs permissions
adjusted.

> ld: warning: arch/x86/boot/compressed/efi_thunk_64.o: missing .note.GNU-stack section implies executable stack
> ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker

Right, arch/x86/boot/compressed (and arch/x86/boot/) discard/reset
KBUILD_AFLAGS (via the := assignment operator).

So arch/x86/boot/Makefile and arch/x86/boot/compressed/Makefile also
will need changes similar to the one you did below.

Finally, if those parts of the code actually expect the stack to be
executable (probably depends on some inline asm), I suspect we might
get some kind of fault at runtime (though I don't know how the kernel
handles segment permissions or even uses ELF segments).  Point being
that -Wa,--noexecstack is somewhat a promise that we wont try to
execute data on the stack as if it were code.  -Wa,--execstack is
useful if we need to be able to do so, but we should be careful to
limit that to individual translation units if they really truly need
that.  The linker warning is more so about the current ambiguity since
if the implicit default changes in the future, that could break code.
Better for us to be explicit here, and disable executable stack unless
strictly necessary and only as necessary IMO.  Personally, I think the
current implicit default is wrong, but pragmatically I recognize that
people have been used to the status quo for years, and changing it
could break existing codebases.

If you send the below diff with the two other additions I suggest to
the x86 ML, the x86 maintainers might be able to comment if they're
familiar with any possible cases where the stack is expected to be
executable.

> ld: warning: arch/x86/boot/compressed/vmlinux has a LOAD segment with RWX permissions
> ld: warning: arch/x86/boot/pmjump.o: missing .note.GNU-stack section implies executable stack
> ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker

^ See above.

> ld: warning: arch/x86/boot/setup.elf has a LOAD segment with RWX permissions
>
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 7854685c5f25..51824528a026 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -123,6 +123,7 @@ else
>          CHECKFLAGS += -D__x86_64__
>
>          KBUILD_AFLAGS += -m64
> +        KBUILD_AFLAGS += -Wa,--noexecstack
>          KBUILD_CFLAGS += -m64
>
>          # Align jump targets to 1 byte, not the default 16 bytes:
>
> --
> Jens Axboe
>


-- 
Thanks,
~Nick Desaulniers
