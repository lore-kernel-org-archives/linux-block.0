Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15C3C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 23:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB2722419
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 23:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MwHR/In/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB2722419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeKOJ2c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:28:32 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35071 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOJ2c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 04:28:32 -0500
Received: by mail-yb1-f195.google.com with SMTP id z2-v6so7656080ybj.2
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 15:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vnY/Ml8hsYeREjt5GLVBMNmLRMX4rgUx+ARwfBd6T3o=;
        b=MwHR/In/dnH044Qh22p+tj3ADNeqCXfOlegzRx8z0E05716ATtnB+WMwO+rVqkqTLF
         gGFim/o/wkJQT/IwpaJZC+GQ4lZpSUQg2Dr/+751kMimfH8Cnme3x1vcB5h8b2065l1/
         JcyjRH9h99MxxVkOKbn0E0VkpEq5ScMk3sFuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vnY/Ml8hsYeREjt5GLVBMNmLRMX4rgUx+ARwfBd6T3o=;
        b=dDKAxjS1+HkKxCKlNIIiB3y4ntAChxlTU2iAYl7ES2g0l7qLUYLfqATl4esv9bB/T6
         Y67GFsPBoWw44eyhBDWLc3X2DXrUGhQvZN4vd+JEt8/v2b4YE8KiUYliDQK7Q9SDHbnG
         2NMXprCq7xiVzt9tDMagvIMv2puBx9bSTUMN5ojJgI3YB1VPNRnPUtFYDiHH5Fwo8Wc6
         GJT3KsppXiY2Aw6PGaPlWgskahGSf2794rsINKdx8/7COqFrbfGdySFcQnSoWyksTbjN
         R35rB2bD7z3sNc52dvDgFJwEHBsiZEmVbOs2ulFZ6nOCHTRbIja43HuSiULC6+HcJSqy
         6RNA==
X-Gm-Message-State: AGRZ1gLUPPVX7zGLpKdpEesY8ncUsZseisdWodK/AmMh1pCBDozcaiap
        yZbeKyYLmpmjBOadPmLuOOd+o8DtYNk=
X-Google-Smtp-Source: AJdET5f4GCbv6N5Wn8rTBpK8gRRmY1lowSp0pF6fts9Ds6zecVMDpTvVHnnqmFvkDDI1SZLTfk37Sg==
X-Received: by 2002:a25:1a03:: with SMTP id a3-v6mr3663458yba.425.1542237790056;
        Wed, 14 Nov 2018 15:23:10 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id a127-v6sm2062305ywg.46.2018.11.14.15.23.08
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 15:23:09 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id o204-v6so7620553yba.9
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 15:23:08 -0800 (PST)
X-Received: by 2002:a25:3588:: with SMTP id c130-v6mr3731202yba.410.1542237788298;
 Wed, 14 Nov 2018 15:23:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Wed, 14 Nov 2018 15:23:06
 -0800 (PST)
In-Reply-To: <DLM1_HbVqIgDqe7g8efFag9FGTUn_GGAPNdzoZltene_ba7lQ7_WUPLeR55uE-ufyn0HcMtfeGGQX8PlekpAayPCf0UVont1YWqHWEU2Tms=@protonmail.ch>
References: <DLM1_HbVqIgDqe7g8efFag9FGTUn_GGAPNdzoZltene_ba7lQ7_WUPLeR55uE-ufyn0HcMtfeGGQX8PlekpAayPCf0UVont1YWqHWEU2Tms=@protonmail.ch>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 14 Nov 2018 17:23:06 -0600
X-Gmail-Original-Message-ID: <CAGXu5jLyRY0jgiNhTBB71nPxXscACA7fRBXv_Q_bkzoE-6Bj7A@mail.gmail.com>
Message-ID: <CAGXu5jLyRY0jgiNhTBB71nPxXscACA7fRBXv_Q_bkzoE-6Bj7A@mail.gmail.com>
Subject: Re: "kyber: add tracepoints" causes write beyond size of object
To:     Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        Daniel Micay <danielmicay@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 10, 2018 at 8:15 AM, Jordan Glover
<Golden_Miller83@protonmail.ch> wrote:
> Hello,
>
> Commit 6c3b7af1c975b87b86dcb2af233d1ae21eb05107 ("kyber: add tracepoints"=
)[1] causes write beyond size of object. This was detected by "FORTIFY_SOUR=
CE intra-object overflow checking"[2] feature which is part of linux-harden=
ed out-of-tree patchset designed to catch such errors.
>
> The specific error is:
>
> In file included from ./include/linux/bitmap.h:9,
>                  from ./include/linux/cpumask.h:12,
>                  from ./arch/x86/include/asm/cpumask.h:5,
>                  from ./arch/x86/include/asm/msr.h:11,
>                  from ./arch/x86/include/asm/processor.h:21,
>                  from ./arch/x86/include/asm/cpufeature.h:8,
>                  from ./arch/x86/include/asm/thread_info.h:53,
>                  from ./include/linux/thread_info.h:38,
>                  from ./arch/x86/include/asm/preempt.h:7,
>                  from ./include/linux/preempt.h:81,
>                  from ./include/linux/rcupdate.h:40,
>                  from ./include/linux/rculist.h:11,
>                  from ./include/linux/pid.h:5,
>                  from ./include/linux/sched.h:14,
>                  from ./include/linux/blkdev.h:5,
>                  from block/kyber-iosched.c:21:
> In function =E2=80=98strlcpy=E2=80=99,
>     inlined from =E2=80=98perf_trace_kyber_latency=E2=80=99 at ./include/=
trace/events/kyber.h:14:1:
> ./include/linux/string.h:310:4: error: call to =E2=80=98__write_overflow=
=E2=80=99 declared with attribute error: detected write beyond size of obje=
ct passed as 1st parameter
>     __write_overflow();
>     ^~~~~~~~~~~~~~~~~~
> In function =E2=80=98strlcpy=E2=80=99,
>     inlined from =E2=80=98trace_event_raw_event_kyber_latency=E2=80=99 at=
 ./include/trace/events/kyber.h:14:1:
> ./include/linux/string.h:310:4: error: call to =E2=80=98__write_overflow=
=E2=80=99 declared with attribute error: detected write beyond size of obje=
ct passed as 1st parameter
>     __write_overflow();
>     ^~~~~~~~~~~~~~~~~~
> make[1]: *** [scripts/Makefile.build:293: block/kyber-iosched.o] Error 1
> make: *** [Makefile:1063: block] Error 2
> make: *** Waiting for unfinished jobs....
>
> Using 'strlcpy' function is generally not recommended[3][4].

Due to the macros, this was a little tricky to find, but it looks like
a cut/paste typo:

#define DOMAIN_LEN              16
#define LATENCY_TYPE_LEN        8

                strlcpy(__entry->domain, domain, DOMAIN_LEN);
                strlcpy(__entry->type, type, DOMAIN_LEN);

This should use strscpy() regardless, and should use sizeof(dst)
instead of separate literals. The primary bug is using DOMAIN_LEN for
__entry->type when it is actually LATENCY_TYPE_LEN bytes.

Can you build a patch for this? I'm happy to review.

Thanks for finding this!

-Kees

>
> Jordan
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?h=3Dv4.20-rc1&id=3D6c3b7af1c975b87b86dcb2af233d1ae21eb05107
>
> [2] https://github.com/anthraxx/linux-hardened/commit/9460692de8eb53fd62d=
59f564eba215e7c03a34b
>
> [3] https://lwn.net/Articles/763641/
>
> [4] https://outflux.net/slides/2018/lss/danger.pdf



--=20
Kees Cook
