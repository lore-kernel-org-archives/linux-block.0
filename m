Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C495C433DB
	for <linux-block@archiver.kernel.org>; Sun, 27 Dec 2020 13:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D95208A9
	for <linux-block@archiver.kernel.org>; Sun, 27 Dec 2020 13:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgL0NEl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Dec 2020 08:04:41 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:43117 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgL0NEk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Dec 2020 08:04:40 -0500
Received: by mail-ot1-f48.google.com with SMTP id q25so7035788otn.10;
        Sun, 27 Dec 2020 05:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7JIIREUedsXBU8wLe1N6dw8SI/CrmaQePow+ITP9G8=;
        b=qFGzb/OP7lAUMo8AU1aCBA851dvztC4EpPlLuHXj2HlQcMIbW7xdvYipS+kkzlhHyR
         WcB84Ke7EFWgNINmeQeJ8TrIc06SXCH/cA/Ku7Nx3rfSWgbhclsGq/i4M1cytFXKzRxu
         GYxI27mtCE1KaIu9vg5E/h8g94xMm1Uejq0sFqALWivNOSYV+YE0a4p1NzvQoZVlYCbg
         201/StPxnmq4dnVAFRhmywgU9oingKsPa3LYehQCQ8RSHGZTiAAL5aopYn5d2F2Ooslm
         X5iLDnRvjS4AcIhqW7lPi2KrPMGEMfXUtKyTOXdy8tKPcfLrYsemnfuT9gUvfSagy0VA
         M/mw==
X-Gm-Message-State: AOAM531UmkkC+ftaVjBlJC0fDeX1mcrzmWCJAlhZBHKR7tLa0dbB0C0o
        Ys9UV3obiNq0LfLI5SvkBPZNqpU4wqWA4dFOaC8=
X-Google-Smtp-Source: ABdhPJwhBwVR4dp2wAEuCBFuwKkQ9+Ag50alAD06AqBEGeNgh0HB4FdsfvFAMdOppCdXknzUKSscPbotlahSx8zpZ6k=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr30331904otc.145.1609074238537;
 Sun, 27 Dec 2020 05:03:58 -0800 (PST)
MIME-Version: 1.0
References: <20201227024446.17018-1-rdunlap@infradead.org>
In-Reply-To: <20201227024446.17018-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 27 Dec 2020 14:03:47 +0100
Message-ID: <CAMuHMdVJ4v7w1+TT0BEqz_x2UXbKcnjXikKucpgEtXU3h63rwQ@mail.gmail.com>
Subject: Re: [PATCH v2] local64.h: make <asm/local64.h> mandatory
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org, Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

CC Arnd

On Sun, Dec 27, 2020 at 3:48 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Make <asm-generic/local64.h> mandatory in include/asm-generic/Kbuild
> and remove all arch/*/include/asm/local64.h arch-specific files since
> they only #include <asm-generic/local64.h>.
>
> This fixes build errors on arch/c6x/ and arch/nios2/ for
> block/blk-iocost.c.
>
> Build-tested on 21 of 25 arch-es. (tools problems on the others)
>
> Yes, we could even rename <asm-generic/local64.h> to
> <linux/local64.h> and change all #includes to use
> <linux/local64.h> instead.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
> Cc: linux-c6x-dev@linux-c6x.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> Would some $maintainer please plan to apply/merge this.
>
> v2: instead of making local64.h a generic-y header file and adding it
> to the missing arch/ header locations, make it a mandotory-y header file
> and remove it from most arch/ header locations. (Christoph)
>
>  arch/alpha/include/asm/local64.h   |    1 -
>  arch/arc/include/asm/Kbuild        |    1 -
>  arch/arm/include/asm/Kbuild        |    1 -
>  arch/arm64/include/asm/Kbuild      |    1 -
>  arch/csky/include/asm/Kbuild       |    1 -
>  arch/h8300/include/asm/Kbuild      |    1 -
>  arch/hexagon/include/asm/Kbuild    |    1 -
>  arch/ia64/include/asm/local64.h    |    1 -
>  arch/m68k/include/asm/Kbuild       |    1 -
>  arch/microblaze/include/asm/Kbuild |    1 -
>  arch/mips/include/asm/Kbuild       |    1 -
>  arch/nds32/include/asm/Kbuild      |    1 -
>  arch/openrisc/include/asm/Kbuild   |    1 -
>  arch/parisc/include/asm/Kbuild     |    1 -
>  arch/powerpc/include/asm/Kbuild    |    1 -
>  arch/riscv/include/asm/Kbuild      |    1 -
>  arch/s390/include/asm/Kbuild       |    1 -
>  arch/sh/include/asm/Kbuild         |    1 -
>  arch/sparc/include/asm/Kbuild      |    1 -
>  arch/x86/include/asm/local64.h     |    1 -
>  arch/xtensa/include/asm/Kbuild     |    1 -
>  include/asm-generic/Kbuild         |    1 +
>  22 files changed, 1 insertion(+), 21 deletions(-)
>
> --- linux-next-20201209.orig/include/asm-generic/Kbuild
> +++ linux-next-20201209/include/asm-generic/Kbuild
> @@ -34,6 +34,7 @@ mandatory-y += kmap_size.h
>  mandatory-y += kprobes.h
>  mandatory-y += linkage.h
>  mandatory-y += local.h
> +mandatory-y += local64.h
>  mandatory-y += mm-arch-hooks.h
>  mandatory-y += mmiowb.h
>  mandatory-y += mmu.h
> --- linux-next-20201209.orig/arch/arc/include/asm/Kbuild
> +++ linux-next-20201209/arch/arc/include/asm/Kbuild
> @@ -1,7 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  generic-y += extable.h
>  generic-y += kvm_para.h
> -generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += parport.h
>  generic-y += user.h
> --- linux-next-20201209.orig/arch/arm64/include/asm/Kbuild
> +++ linux-next-20201209/arch/arm64/include/asm/Kbuild
> @@ -1,6 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  generic-y += early_ioremap.h
> -generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += qrwlock.h
>  generic-y += qspinlock.h
> --- linux-next-20201209.orig/arch/arm/include/asm/Kbuild
> +++ linux-next-20201209/arch/arm/include/asm/Kbuild
> @@ -2,7 +2,6 @@
>  generic-y += early_ioremap.h
>  generic-y += extable.h
>  generic-y += flat.h
> -generic-y += local64.h
>  generic-y += parport.h
>
>  generated-y += mach-types.h
> --- linux-next-20201209.orig/arch/csky/include/asm/Kbuild
> +++ linux-next-20201209/arch/csky/include/asm/Kbuild
> @@ -2,7 +2,6 @@
>  generic-y += asm-offsets.h
>  generic-y += gpio.h
>  generic-y += kvm_para.h
> -generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += qrwlock.h
>  generic-y += qspinlock.h
> --- linux-next-20201209.orig/arch/h8300/include/asm/Kbuild
> +++ linux-next-20201209/arch/h8300/include/asm/Kbuild
> @@ -2,7 +2,6 @@
>  generic-y += asm-offsets.h
>  generic-y += extable.h
>  generic-y += kvm_para.h
> -generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += parport.h
>  generic-y += spinlock.h
> --- linux-next-20201209.orig/arch/hexagon/include/asm/Kbuild
> +++ linux-next-20201209/arch/hexagon/include/asm/Kbuild
> @@ -2,5 +2,4 @@
>  generic-y += extable.h
>  generic-y += iomap.h
>  generic-y += kvm_para.h
> -generic-y += local64.h
>  generic-y += mcs_spinlock.h
> --- linux-next-20201209.orig/arch/m68k/include/asm/Kbuild
> +++ linux-next-20201209/arch/m68k/include/asm/Kbuild
> @@ -2,6 +2,5 @@
>  generated-y += syscall_table.h
>  generic-y += extable.h
>  generic-y += kvm_para.h
> -generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += spinlock.h
> --- linux-next-20201209.orig/arch/microblaze/include/asm/Kbuild
> +++ linux-next-20201209/arch/microblaze/include/asm/Kbuild
> @@ -2,7 +2,6 @@
>  generated-y += syscall_table.h
>  generic-y += extable.h
>  generic-y += kvm_para.h
> -generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += parport.h
>  generic-y += syscalls.h
> --- linux-next-20201209.orig/arch/mips/include/asm/Kbuild
> +++ linux-next-20201209/arch/mips/include/asm/Kbuild
> @@ -6,7 +6,6 @@ generated-y += syscall_table_64_n64.h
>  generated-y += syscall_table_64_o32.h
>  generic-y += export.h
>  generic-y += kvm_para.h
> -generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += parport.h
>  generic-y += qrwlock.h
> --- linux-next-20201209.orig/arch/nds32/include/asm/Kbuild
> +++ linux-next-20201209/arch/nds32/include/asm/Kbuild
> @@ -4,6 +4,5 @@ generic-y += cmpxchg.h
>  generic-y += export.h
>  generic-y += gpio.h
>  generic-y += kvm_para.h
> -generic-y += local64.h
>  generic-y += parport.h
>  generic-y += user.h
> --- linux-next-20201209.orig/arch/openrisc/include/asm/Kbuild
> +++ linux-next-20201209/arch/openrisc/include/asm/Kbuild
> @@ -1,7 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  generic-y += extable.h
>  generic-y += kvm_para.h
> -generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += qspinlock_types.h
>  generic-y += qspinlock.h
> --- linux-next-20201209.orig/arch/parisc/include/asm/Kbuild
> +++ linux-next-20201209/arch/parisc/include/asm/Kbuild
> @@ -3,6 +3,5 @@ generated-y += syscall_table_32.h
>  generated-y += syscall_table_64.h
>  generated-y += syscall_table_c32.h
>  generic-y += kvm_para.h
> -generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += user.h
> --- linux-next-20201209.orig/arch/powerpc/include/asm/Kbuild
> +++ linux-next-20201209/arch/powerpc/include/asm/Kbuild
> @@ -5,7 +5,6 @@ generated-y += syscall_table_c32.h
>  generated-y += syscall_table_spu.h
>  generic-y += export.h
>  generic-y += kvm_types.h
> -generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += qrwlock.h
>  generic-y += vtime.h
> --- linux-next-20201209.orig/arch/riscv/include/asm/Kbuild
> +++ linux-next-20201209/arch/riscv/include/asm/Kbuild
> @@ -3,6 +3,5 @@ generic-y += early_ioremap.h
>  generic-y += extable.h
>  generic-y += flat.h
>  generic-y += kvm_para.h
> -generic-y += local64.h
>  generic-y += user.h
>  generic-y += vmlinux.lds.h
> --- linux-next-20201209.orig/arch/s390/include/asm/Kbuild
> +++ linux-next-20201209/arch/s390/include/asm/Kbuild
> @@ -7,5 +7,4 @@ generated-y += unistd_nr.h
>  generic-y += asm-offsets.h
>  generic-y += export.h
>  generic-y += kvm_types.h
> -generic-y += local64.h
>  generic-y += mcs_spinlock.h
> --- linux-next-20201209.orig/arch/sh/include/asm/Kbuild
> +++ linux-next-20201209/arch/sh/include/asm/Kbuild
> @@ -1,6 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  generated-y += syscall_table.h
>  generic-y += kvm_para.h
> -generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += parport.h
> --- linux-next-20201209.orig/arch/sparc/include/asm/Kbuild
> +++ linux-next-20201209/arch/sparc/include/asm/Kbuild
> @@ -6,5 +6,4 @@ generated-y += syscall_table_64.h
>  generated-y += syscall_table_c32.h
>  generic-y += export.h
>  generic-y += kvm_para.h
> -generic-y += local64.h
>  generic-y += mcs_spinlock.h
> --- linux-next-20201209.orig/arch/xtensa/include/asm/Kbuild
> +++ linux-next-20201209/arch/xtensa/include/asm/Kbuild
> @@ -2,7 +2,6 @@
>  generated-y += syscall_table.h
>  generic-y += extable.h
>  generic-y += kvm_para.h
> -generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += param.h
>  generic-y += qrwlock.h
> --- linux-next-20201209.orig/arch/alpha/include/asm/local64.h
> +++ /dev/null
> @@ -1 +0,0 @@
> -#include <asm-generic/local64.h>
> --- linux-next-20201209.orig/arch/ia64/include/asm/local64.h
> +++ /dev/null
> @@ -1 +0,0 @@
> -#include <asm-generic/local64.h>
> --- linux-next-20201209.orig/arch/x86/include/asm/local64.h
> +++ /dev/null
> @@ -1 +0,0 @@
> -#include <asm-generic/local64.h>
