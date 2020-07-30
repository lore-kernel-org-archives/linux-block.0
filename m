Return-Path: <SRS0=0pY0=BJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C252C433E0
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 08:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2475F20809
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 08:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgG3IQH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:16:07 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:42273 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbgG3IL1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 04:11:27 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MXpQA-1kHgrQ2420-00Y9g6; Thu, 30 Jul 2020 10:11:24 +0200
Received: by mail-qt1-f173.google.com with SMTP id o22so19471336qtt.13;
        Thu, 30 Jul 2020 01:11:24 -0700 (PDT)
X-Gm-Message-State: AOAM53112YMrI1YItF6CAgt8WRH188Rba8WbZL8hhaq7oMHDM2b2KoD8
        B28X5U6AwJylWSO5Cx6+RN/f/WA2+NzN4ZjAbEA=
X-Google-Smtp-Source: ABdhPJyi8EKI+AIaFPt4gm4DpxtwBsJeU20bhkDhmCW6PRTBeUF30Hz/fPEst/ZpzIRbEjFkzYHg8KIN+OaDxrvgq9w=
X-Received: by 2002:aed:2946:: with SMTP id s64mr1820401qtd.204.1596096683269;
 Thu, 30 Jul 2020 01:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200728141946.426245-1-yepeilin.cs@gmail.com>
 <20200729115157.8519-1-yepeilin.cs@gmail.com> <20200729125820.GB1840@kadam> <f2cf6137-987a-ab41-d88a-6828d46c255f@linux.com>
In-Reply-To: <f2cf6137-987a-ab41-d88a-6828d46c255f@linux.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 30 Jul 2020 10:11:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a20SEoYCrp3jOK32oZc9OkiPv+1KTjNZ2GxLbHpY4WexQ@mail.gmail.com>
Message-ID: <CAK8P3a20SEoYCrp3jOK32oZc9OkiPv+1KTjNZ2GxLbHpY4WexQ@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] [PATCH v2] block/floppy: Prevent
 kernel-infoleak in raw_cmd_copyout()
To:     Denis Efremov <efremov@linux.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:WKfzjuFnGRw3OvhrL5U3oP+zdQSICdJwRT+YAQE6KeBvZrjXHix
 GK55VGH5GiV0guHajImKtAU5Fcp96pvBWq6WT9ecv259t9+hK5fpZV0xw1DXDl4Aw9CXMeQ
 vSi69vNoiAhaDQem+U6bZWtED9yTgTY8Dcg1phuGKq549XeTrPp9pRNxIj2YDUwwtHd8siD
 DskXfhI6XFiAE6LfrvMQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h4zwwkv9Zb4=:bjifiEJFF+2dRDosiT4ZYQ
 uSNW93BZu9jkT+VY/8nHNZ5gwgaRUI8LahdvzdoCaQ7jsIDqe6h9Q8RfujPWwZqFx4mMredwF
 TJ27Oega4jL3cA9i9JP+CwFOL6Jo6xkFiR8HsI0Y9TQW6/K4/y+cwhN3R5nK0AJWOTnSL1ifG
 BrKcIAJaPAwYiySOTGySxLd/5q8+bxtOwqapgOg5wM3VTtlQnPYT9znZ5ggxmPmPvXbvSHFKk
 tXPuCFVquhJidlGVnDTtUbhwO9Sz+ydrRaYTQ3f49UFJ1uX/3y3TrpCIKnFFD6mUSrC1EuY0Z
 cf8egNpV6OCpZdXWjocSQW6y3vJ4yAdEMqkwGgcyrNAlhCJ46/HxXStHRrkQZqWixjmTk9lG3
 ycnAQzFQgp3w8NT17U8rz5YsvoUzpDo4UhLtQm/x8vT42fkHGgMTEUhFT8+ho3h9cFFNPvgcZ
 8Cibx531qNTpi2qNW1q+jJLxWXt2VQYUyC/TKxMFhiTi18c1+zPoCwsazrPgzwPeQfSGCtdwO
 Q5/J/o6EEzLGz6kQkQcFIRKsSVxbUg5caeqYCjQLy61XkJPMNDxlkyPTtZBCBnGBnlkSVUtey
 XoQhu0hV6BlslSuJA5gv3KT10c85GDSeU8MCQGbCLxcrdCHF13zxGqO+GabOrvP+0iMhQ1z2r
 VTUT28txlY7esGHZ1iZIFB0wce1aHV+QqLfwjQBbTjBaRFB3MpNTUQNBaIwavXk8+RkFl8Mrj
 eL3UfxSTDx8xwyMEqulRdbvI6cKD3wfQxWGZA8v6spx6O+lgE2apB/9XVR5cXxu2LBogXMqjn
 44DPp92fy4huvriFZDaPXUHkLP+2Bwb8bwZdqkT2OVgFnfNu/7xV2EynxWM4YSpKgdQWVUvPP
 AV8V4+gfWGCd8TN3Eb/5CMYwk75MKwPrWb6F6mOF+MJJUawSzEkf6+dpjw/zqYV0T+3zqrFLd
 GaqOFA1VdpZ3vvRXuq9U7EXgEQarzihhFtbarxFKm8gvy5BHzhNrg
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Wed, Jul 29, 2020 at 3:22 PM Denis Efremov <efremov@linux.com> wrote:

> And checked for leaks on x86_64 with the script test.sh
> $ cat test.sh
> #!/bin/bash
>
> for i in 4.8 5 6 7 8 9 10
> do
> ./run_container.sh gcc-$i $(pwd)/src $(pwd)/out bash -c 'gcc test.c; ./a.out'
> ./run_container.sh gcc-$i $(pwd)/src $(pwd)/out bash -c 'gcc -O2 test.c; ./a.out'
> ./run_container.sh gcc-$i $(pwd)/src $(pwd)/out bash -c 'gcc -O3 test.c; ./a.out'
> done
>
> No leaks reported. Is it really possible this this kind of init, i.e. cmd = *ptr?

The problem is that the behavior is dependent not just on the compiler
version but
also optimization flags, target architecture and specific structure
layouts. Most
of the time, both gcc and clang will initialize the whole structure
rather than just
the individual members, but you still can't be sure that this is true
for all configurations
that this code runs on, except by using CONFIG_GCC_PLUGIN_STRUCTLEAK.

Kees pointed me to the lib/test_stackinit.c file in the kernel in which he has
collected a number of combinations that are known to trigger the problem.

What I see there though are only cases of struct initializers like

  struct test_big_hole var = { .one = arg->one, .two=arg->two, .three
= arg->three, .four = arg->four };

but not the syntax used in the floppy driver:

   struct test_big_hole var = *arg;

or the a constructor like

  struct test_big_hole var;
  var = (struct test_big_hole){ .one = arg->one, .two=arg->two, .three
= arg->three, .four = arg->four };

Kees, do you know whether those two would behave differently?
Would it make sense to also check for those, or am I perhaps
misreading your code and it already gets checked?

      Arnd
