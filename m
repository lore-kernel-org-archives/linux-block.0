Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E33C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 00:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9296B208A3
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 00:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K5T1eLqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9296B208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbeKOK3N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 05:29:13 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35704 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOK3N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 05:29:13 -0500
Received: by mail-yw1-f65.google.com with SMTP id h32so1950338ywk.2
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 16:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7MK+JaGhft5lEJgK5deW0LadJzaBKyOi7BCpoy4b/HU=;
        b=K5T1eLqWug45nzvbXEKwyD4dgXzThyUs/NjKnc2zNhWVorwcv8hLNwktYz1sNOmBMF
         IfPS2E+GED0LHtLp9RSSHzNjNwvD4fbm6h/fK+SuyV3jJtv9xKad+wKM7KODWxqrYJYr
         niP+FXL3dg5MEPMbtwT86WcrbEp9av5PlVnVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7MK+JaGhft5lEJgK5deW0LadJzaBKyOi7BCpoy4b/HU=;
        b=bAzwW7LHDvEl4ztZyJH2cHX8IMTppAl52ePLmUkIDrJL1hD2sfXBUJLPBl2qxHgoPB
         PPvn+Q/513OskBT8NlDHwBCZE58pE2tkG/UuPatVnE+6kL0UQ20yk3pyXasjQ3qZNmJN
         t8UgHUCn06UT+DayepbHPoI7jBuudbU3ztKHkpOy+v1h6DO1y1lcko/OvriO1XcaOtVU
         vw2fiRy0ldIJUWfNaw7w7oBcnNqq8jpz4idmNkFh8yI7vx198RdjPPjoyUnsnHXCOHMj
         C1pWzxuLzk9WEw9JSmBS2KKwtcjThepUqLAZ2VCzcuIqXcYRaqb9GgIpaeQj9rmbR6/p
         lWsA==
X-Gm-Message-State: AGRZ1gLG18lxm1HfKZAdhYJ2zKO1D8HmCUz02qWR4WAdkEDoHeSCu9Vu
        VhhrL6G7Zeb8Bq02Rma+C3+3xFjQXwJFCA==
X-Google-Smtp-Source: AJdET5c/KcnhYxemsdNqJKlDs1f6zMchKdb1vLwNp8UHMr+aH1jGuhvdYgQpvlAV8Dx/Pmt+HJpqMQ==
X-Received: by 2002:a81:85c5:: with SMTP id v188mr46864ywf.51.1542241419998;
        Wed, 14 Nov 2018 16:23:39 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id z188-v6sm1330776ywa.10.2018.11.14.16.23.38
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 16:23:39 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 131-v6so7658731ybe.12
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 16:23:38 -0800 (PST)
X-Received: by 2002:a25:7643:: with SMTP id r64-v6mr3892887ybc.403.1542241417797;
 Wed, 14 Nov 2018 16:23:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Wed, 14 Nov 2018 16:23:37
 -0800 (PST)
In-Reply-To: <20181115000603.GA2313@vader>
References: <DLM1_HbVqIgDqe7g8efFag9FGTUn_GGAPNdzoZltene_ba7lQ7_WUPLeR55uE-ufyn0HcMtfeGGQX8PlekpAayPCf0UVont1YWqHWEU2Tms=@protonmail.ch>
 <CAGXu5jLyRY0jgiNhTBB71nPxXscACA7fRBXv_Q_bkzoE-6Bj7A@mail.gmail.com> <20181115000603.GA2313@vader>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 14 Nov 2018 18:23:37 -0600
X-Gmail-Original-Message-ID: <CAGXu5j+S2BYnASoqdkwNGVuiCOGbiwOYpAM6j9wp8eKtVCrX6A@mail.gmail.com>
Message-ID: <CAGXu5j+S2BYnASoqdkwNGVuiCOGbiwOYpAM6j9wp8eKtVCrX6A@mail.gmail.com>
Subject: Re: "kyber: add tracepoints" causes write beyond size of object
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Jordan Glover <Golden_Miller83@protonmail.ch>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        Daniel Micay <danielmicay@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 6:06 PM, Omar Sandoval <osandov@osandov.com> wrote:
> On Wed, Nov 14, 2018 at 05:23:06PM -0600, Kees Cook wrote:
>> On Sat, Nov 10, 2018 at 8:15 AM, Jordan Glover
>> <Golden_Miller83@protonmail.ch> wrote:
>> > Hello,
>> >
>> > Commit 6c3b7af1c975b87b86dcb2af233d1ae21eb05107 ("kyber: add tracepoin=
ts")[1] causes write beyond size of object. This was detected by "FORTIFY_S=
OURCE intra-object overflow checking"[2] feature which is part of linux-har=
dened out-of-tree patchset designed to catch such errors.
>> >
>> > The specific error is:
>> >
>> > In file included from ./include/linux/bitmap.h:9,
>> >                  from ./include/linux/cpumask.h:12,
>> >                  from ./arch/x86/include/asm/cpumask.h:5,
>> >                  from ./arch/x86/include/asm/msr.h:11,
>> >                  from ./arch/x86/include/asm/processor.h:21,
>> >                  from ./arch/x86/include/asm/cpufeature.h:8,
>> >                  from ./arch/x86/include/asm/thread_info.h:53,
>> >                  from ./include/linux/thread_info.h:38,
>> >                  from ./arch/x86/include/asm/preempt.h:7,
>> >                  from ./include/linux/preempt.h:81,
>> >                  from ./include/linux/rcupdate.h:40,
>> >                  from ./include/linux/rculist.h:11,
>> >                  from ./include/linux/pid.h:5,
>> >                  from ./include/linux/sched.h:14,
>> >                  from ./include/linux/blkdev.h:5,
>> >                  from block/kyber-iosched.c:21:
>> > In function =E2=80=98strlcpy=E2=80=99,
>> >     inlined from =E2=80=98perf_trace_kyber_latency=E2=80=99 at ./inclu=
de/trace/events/kyber.h:14:1:
>> > ./include/linux/string.h:310:4: error: call to =E2=80=98__write_overfl=
ow=E2=80=99 declared with attribute error: detected write beyond size of ob=
ject passed as 1st parameter
>> >     __write_overflow();
>> >     ^~~~~~~~~~~~~~~~~~
>> > In function =E2=80=98strlcpy=E2=80=99,
>> >     inlined from =E2=80=98trace_event_raw_event_kyber_latency=E2=80=99=
 at ./include/trace/events/kyber.h:14:1:
>> > ./include/linux/string.h:310:4: error: call to =E2=80=98__write_overfl=
ow=E2=80=99 declared with attribute error: detected write beyond size of ob=
ject passed as 1st parameter
>> >     __write_overflow();
>> >     ^~~~~~~~~~~~~~~~~~
>> > make[1]: *** [scripts/Makefile.build:293: block/kyber-iosched.o] Error=
 1
>> > make: *** [Makefile:1063: block] Error 2
>> > make: *** Waiting for unfinished jobs....
>> >
>> > Using 'strlcpy' function is generally not recommended[3][4].
>>
>> Due to the macros, this was a little tricky to find, but it looks like
>> a cut/paste typo:
>>
>> #define DOMAIN_LEN              16
>> #define LATENCY_TYPE_LEN        8
>>
>>                 strlcpy(__entry->domain, domain, DOMAIN_LEN);
>>                 strlcpy(__entry->type, type, DOMAIN_LEN);
>>
>> This should use strscpy() regardless, and should use sizeof(dst)
>> instead of separate literals. The primary bug is using DOMAIN_LEN for
>> __entry->type when it is actually LATENCY_TYPE_LEN bytes.
>>
>> Can you build a patch for this? I'm happy to review.
>>
>> Thanks for finding this!
>
> Sorry, I forgot to reply to this thread, but Jens queued up a fix for
> this already:
>
> http://git.kernel.dk/cgit/linux-block/commit/?h=3Dfor-linus&id=3D18e962ac=
0781bcb70d433de3b2a325ff792b4288

Ah! Perfect. Thanks! :) I should be late to threads more often. ;)

-kees

--=20
Kees Cook
