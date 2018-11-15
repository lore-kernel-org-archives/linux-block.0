Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D813DC43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 00:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9536220685
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 00:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="NeheEjxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9536220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbeKOKLg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 05:11:36 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51772 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOKLg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 05:11:36 -0500
Received: by mail-it1-f195.google.com with SMTP id f84-v6so5558571ita.1
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 16:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kxFbTaLZ1iFzhAUOorE3Rt2lgcD5SuwQfoPPBhJhXh4=;
        b=NeheEjxC9jghGyW8K/fSndONjEgCh2/k/07G2+S+LuAUVy9WUmHSNJs/yx6k347BxJ
         K2t4Ey+qi/kLFKl26NQVa10Fl9rn3JO7pQSaDDNjKYM5yq7NDK4VXO8BmEnnCfcy1cYe
         GEL5sbqx9ki3a3QMhEZJDpS+bO2Axx7dkLFOCSXlG39Iw45bRJ7bzoyPOzmQSjTmftn0
         HwmbzWYndyJRWRWgzfJIdSFzdcEV8ZL9LSRPSNoP+bG1BwFiyoYsUgx+2UIV5+kV6c/z
         BVDT2EfKvethUTJjSP3ITsQQSjCuVHTnaP7OnJV15nJoSxtusVfoZImicESIvWRoFMUm
         QUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kxFbTaLZ1iFzhAUOorE3Rt2lgcD5SuwQfoPPBhJhXh4=;
        b=Q22vNo+967o7jnRzQ/6wozju9D77KE4sZ5NHdoKAJsWcerRDajRh9rpYyBKCp4o69V
         M6f9Z+N08tvE63/2024KBLjX6GjTZHUPV0O7ADAJZr0JmMoJWK2huM99YupjAl5ICnk+
         z98SgdiEZjksSGKCb6CtHkykUzrPI2ey4M+FX02G0mRCzuKJEt9InTDSdLv83GvA+KyQ
         wu7A9YzTTKRbedjAOZSK+j+jNVbfWhqmFSVYBOy6gu1Gti2GMSJLJ/iCNoX67lnI8IUj
         UezgvnmyPsDVrf9ApWQqT8CqsCSXURCYZc0KzsihbeO0LQzXut18UJtR1y5fDLnhLLk7
         9u6A==
X-Gm-Message-State: AGRZ1gLou8K4N0LgwIZIjt0BcsJ3hSyvBWbKeBLrwxMWv2XxblVeAmT2
        Kne1cTeQuwLin8ZiuqOFuUkEHQ==
X-Google-Smtp-Source: AJdET5dfQh7h6+kEoUwtrg9PvY00uML3QElEhGmGaQBdQUTswAj0chfNjGxEzRYozsaL4+aZ6nvErg==
X-Received: by 2002:a24:24c5:: with SMTP id f188-v6mr4281765ita.49.1542240366226;
        Wed, 14 Nov 2018 16:06:06 -0800 (PST)
Received: from vader ([2620:10d:c090:180::1:a7c5])
        by smtp.gmail.com with ESMTPSA id j17-v6sm9248033itj.0.2018.11.14.16.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 16:06:05 -0800 (PST)
Date:   Wed, 14 Nov 2018 16:06:03 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jordan Glover <Golden_Miller83@protonmail.ch>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        Daniel Micay <danielmicay@gmail.com>
Subject: Re: "kyber: add tracepoints" causes write beyond size of object
Message-ID: <20181115000603.GA2313@vader>
References: <DLM1_HbVqIgDqe7g8efFag9FGTUn_GGAPNdzoZltene_ba7lQ7_WUPLeR55uE-ufyn0HcMtfeGGQX8PlekpAayPCf0UVont1YWqHWEU2Tms=@protonmail.ch>
 <CAGXu5jLyRY0jgiNhTBB71nPxXscACA7fRBXv_Q_bkzoE-6Bj7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXu5jLyRY0jgiNhTBB71nPxXscACA7fRBXv_Q_bkzoE-6Bj7A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 05:23:06PM -0600, Kees Cook wrote:
> On Sat, Nov 10, 2018 at 8:15 AM, Jordan Glover
> <Golden_Miller83@protonmail.ch> wrote:
> > Hello,
> >
> > Commit 6c3b7af1c975b87b86dcb2af233d1ae21eb05107 ("kyber: add tracepoints")[1] causes write beyond size of object. This was detected by "FORTIFY_SOURCE intra-object overflow checking"[2] feature which is part of linux-hardened out-of-tree patchset designed to catch such errors.
> >
> > The specific error is:
> >
> > In file included from ./include/linux/bitmap.h:9,
> >                  from ./include/linux/cpumask.h:12,
> >                  from ./arch/x86/include/asm/cpumask.h:5,
> >                  from ./arch/x86/include/asm/msr.h:11,
> >                  from ./arch/x86/include/asm/processor.h:21,
> >                  from ./arch/x86/include/asm/cpufeature.h:8,
> >                  from ./arch/x86/include/asm/thread_info.h:53,
> >                  from ./include/linux/thread_info.h:38,
> >                  from ./arch/x86/include/asm/preempt.h:7,
> >                  from ./include/linux/preempt.h:81,
> >                  from ./include/linux/rcupdate.h:40,
> >                  from ./include/linux/rculist.h:11,
> >                  from ./include/linux/pid.h:5,
> >                  from ./include/linux/sched.h:14,
> >                  from ./include/linux/blkdev.h:5,
> >                  from block/kyber-iosched.c:21:
> > In function ‘strlcpy’,
> >     inlined from ‘perf_trace_kyber_latency’ at ./include/trace/events/kyber.h:14:1:
> > ./include/linux/string.h:310:4: error: call to ‘__write_overflow’ declared with attribute error: detected write beyond size of object passed as 1st parameter
> >     __write_overflow();
> >     ^~~~~~~~~~~~~~~~~~
> > In function ‘strlcpy’,
> >     inlined from ‘trace_event_raw_event_kyber_latency’ at ./include/trace/events/kyber.h:14:1:
> > ./include/linux/string.h:310:4: error: call to ‘__write_overflow’ declared with attribute error: detected write beyond size of object passed as 1st parameter
> >     __write_overflow();
> >     ^~~~~~~~~~~~~~~~~~
> > make[1]: *** [scripts/Makefile.build:293: block/kyber-iosched.o] Error 1
> > make: *** [Makefile:1063: block] Error 2
> > make: *** Waiting for unfinished jobs....
> >
> > Using 'strlcpy' function is generally not recommended[3][4].
> 
> Due to the macros, this was a little tricky to find, but it looks like
> a cut/paste typo:
> 
> #define DOMAIN_LEN              16
> #define LATENCY_TYPE_LEN        8
> 
>                 strlcpy(__entry->domain, domain, DOMAIN_LEN);
>                 strlcpy(__entry->type, type, DOMAIN_LEN);
> 
> This should use strscpy() regardless, and should use sizeof(dst)
> instead of separate literals. The primary bug is using DOMAIN_LEN for
> __entry->type when it is actually LATENCY_TYPE_LEN bytes.
> 
> Can you build a patch for this? I'm happy to review.
> 
> Thanks for finding this!

Sorry, I forgot to reply to this thread, but Jens queued up a fix for
this already:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=18e962ac0781bcb70d433de3b2a325ff792b4288
