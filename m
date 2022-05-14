Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE440C433FE
	for <linux-block@archiver.kernel.org>; Sat, 14 May 2022 08:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiENIej (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 May 2022 04:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiENIeh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 May 2022 04:34:37 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1594BD9
        for <linux-block@vger.kernel.org>; Sat, 14 May 2022 01:34:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so5877036wmn.1
        for <linux-block@vger.kernel.org>; Sat, 14 May 2022 01:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wqqxn5+q5xmPpZtFRIbD60XulpYnUc5+LRYDs7jEaLY=;
        b=BRlzdhTV9zT8+bxHgq0iD5R/JhGL/k8jAR9b7CiU8hDeCgzVWFrrjTP0aHZq5tQ8XX
         3pYNl+Xbb81AWFyTev3K9GimQzlDxKm5/ng/W1WSUjRhKZN93OQN0hDCuANEnE1eNUL6
         +aUzBtR+QI4bADN71NUFlQC83QglUyIurXGuydMevh73G+uVG3TYo/sIvqErTRAzb58h
         nzGFgjXKmB/RG2aqyyKCKKFmMioLSkKXxX9GlafBjaZm1KrP7Lw/OTZCsI8ACoMpACYq
         Rphk6LNz2/OeuYMnsUUf1WipjrlSd1VS+CWBrGJUgfc8Muq8FPXmuSTbP+VZ/Q+iIMod
         U5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wqqxn5+q5xmPpZtFRIbD60XulpYnUc5+LRYDs7jEaLY=;
        b=3VJTLAXiwyEhphXAJvQoSnZaES92pey6hceogBYUVp1XP7tI9Ijc+5bsVmvfNm8vZh
         +jB9d/SR9iHd3CzN0sbFzB/g+DVeLplbJa/YfuJ8S9QEVIgKKmlqWlbAqQ5dSRLLfqSQ
         Ou8yW/0P1mDMlzwIkSm/meiYXNgIFcn5w5+7zGPWQ74eUHTi7TiQ/BwHQDVwz54quSVh
         6W1PzuQoU3/AWLHk9VjHXZf9iIUGLQOc5RNVqHoO4jqshtf4HRGDmHu8bGnvvx4Z0J6C
         Jf9BMuGo7RckAp1riHQu5tQBRZSZYO24Y8TRY3/8usy7VqbCzATRMxkMdaXDJSuTuzch
         4R9A==
X-Gm-Message-State: AOAM533eSk9pTdV5V/5dfh2Ob83jXA6ucHjPjy5mP1o9xA8hyDYnWmnX
        W69e8C9BDBeoQrOtPTxEXxOoGPZQxPEyZHU7IfqdYw==
X-Google-Smtp-Source: ABdhPJw8xpJdudoWgJ+1Jx86Q9PASwEwAJPZhccKtWf1cQJ07oWyo0/CpzTe9bNFHE+Eixp2zZJuUPINfVgMRPZ/+Bw=
X-Received: by 2002:a05:600c:1d9f:b0:394:7a51:cb8b with SMTP id
 p31-20020a05600c1d9f00b003947a51cb8bmr8040011wms.163.1652517274539; Sat, 14
 May 2022 01:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220429043913.626647-1-davidgow@google.com> <20220513083212.3537869-3-davidgow@google.com>
 <Yn57d1e6k8uv2uQj@bombadil.infradead.org>
In-Reply-To: <Yn57d1e6k8uv2uQj@bombadil.infradead.org>
From:   David Gow <davidgow@google.com>
Date:   Sat, 14 May 2022 16:34:23 +0800
Message-ID: <CABVgOSkhr6xfgXZWW6UdbU4MpAvqsDOsqVP0THsH0gVB949HjA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selftest: Taint kernel when test module loaded
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 13, 2022 at 11:38 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, May 13, 2022 at 04:32:13PM +0800, David Gow wrote:
> > Make any kselftest test module (using the kselftest_module framework)
> > taint the kernel with TAINT_TEST on module load.
> >
> > Note that several selftests use kernel modules which are not based on
> > the kselftest_module framework, and so will not automatically taint the
> > kernel. These modules will have to be manually modified if they should
> > taint the kernel this way.
> >
> > Similarly, selftests which do not load modules into the kernel generally
> > should not taint the kernel (or possibly should only do so on failure),
> > as it's assumed that testing from user-space should be safe. Regardless,
> > they can write to /proc/sys/kernel/tainted if required.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Not all selftest modules use KSTM_MODULE_LOADERS() so I'd like to see a
> modpost target as well, otherwise this just covers a sliver of
> selftests.
>

My personal feeling is that the ideal way of solving this is actually
to port those modules which aren't using KSTM_MODULE_LOADERS() (or
KUnit, or some other system) to do so, or to otherwise manually tag
them as selftests and/or make them taint the kernel.

That being said, we can gain a bit my making the module-loading
helpers in kselftest/module.sh manually taint the kernel with
/proc/sys/kernel/tainted, which will catch quite a few of them (even
if tainting from userspace before they're loaded is suboptimal).

I've also started experimenting with a "test" MODULE_INFO field, which
modpost would add with the -t option. That still requires sprinkling
MODULE_INFO() everwhere, or the '-t' option to a bunch of makefiles,
or doing something more drastic to set it automatically for modules in
a given directory / makefile. Or the staging thing of checking the
directory / prefix in modpost.

I'll play around some more and have something to show in v4. (If we
have a MODULE_INFO field, we should use it for KUnit modules, but we'd
still have to taint the kernel manually for built-in tests anyway, so
it'd be redundant...)

-- David
