Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C92BC433EF
	for <linux-block@archiver.kernel.org>; Wed,  8 Sep 2021 16:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F4C61157
	for <linux-block@archiver.kernel.org>; Wed,  8 Sep 2021 16:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349999AbhIHQ6H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Sep 2021 12:58:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235666AbhIHQ6G (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Sep 2021 12:58:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67C8B61100;
        Wed,  8 Sep 2021 16:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631120218;
        bh=PqcBl1KQZaLj2UYPjvgmgug1mUEXiPMNAK6+xOcOsHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mbVliIBERcN/usqu1zlgBACEyAyoxT96QZVlh+NQ4n+dZT9LU53SPEyDE4/PZaiPs
         ISkbyKheF5/z3ylZtrBXdmRDKmC68UVoa85j4A+Z8PkHr+LwNH1u2JBeyGHhw6Z3OZ
         gq2bsdUdxPDGB4n8WVNVGoYvHHgCZRd6wKPDiOUnX8ZM/pA7FmaAUb+jyy1RJaJ7ZI
         2s1WadrJOT4gtCdepAKPlewRE7CWbaLEP+DqCRSTAofjuNfBYafdHPKkpsBglRgCfl
         uYSj0ettDYJZFkWs001XHq/zhCg80vyn5Y+Q1hYJ5IKf7U3+qkdPdLB2eaI7cSxKiN
         GGEKX+Xs2mhOg==
Date:   Wed, 8 Sep 2021 09:56:53 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>, nbd@other.debian.org,
        open list <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, lkft-triage@lists.linaro.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev
Subject: Re: ERROR: modpost: __mulodi4 [drivers/block/nbd.ko] undefined!
Message-ID: <YTjrVWaTIA5ZZumW@archlinux-ax161>
References: <CA+G9fYvThAuTu1-Tg+7BaFofxfBkvBuTAnycuws-U4p473MeZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvThAuTu1-Tg+7BaFofxfBkvBuTAnycuws-U4p473MeZQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Naresh,

On Wed, Sep 08, 2021 at 04:58:11PM +0530, Naresh Kamboju wrote:
> Following build warnings/ errors noticed while building linux next
> master branch with clang-13 for arm architecture with following configs.
>   - footbridge_defconfig
>   - mini2440_defconfig
>   - s3c2410_defconfig
> 
> ERROR: modpost: __mulodi4 [drivers/block/nbd.ko] undefined!
> make[2]: *** [/builds/linux/scripts/Makefile.modpost:134:
> modules-only.symvers] Error 1
> make[2]: *** Deleting file 'modules-only.symvers'
> make[2]: Target '__modpost' not remade because of errors.
> make[1]: *** [/builds/linux/Makefile:1952: modules] Error 2
> make[1]: Target '__all' not remade because of errors.
> make: *** [Makefile:226: __sub-make] Error 2
> make: Target '__all' not remade because of errors.

Thanks for the report. This is a known issue that we have been tracking
and it is now resolved in LLVM 14:

https://github.com/ClangBuiltLinux/linux/issues/1438

Nick said he should have a kernel patch to work around this in the
kernel for older versions of LLVM soon.

By the way, can you use our new mailing list and my kernel.org address
for future reports (llvm@lists.linux.devi, nathan@kernel.org)? It will
make it easier to find these reports in the archives in the future and
my filters will catch this better.

Cheers,
Nathan
