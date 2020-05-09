Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9CDC28CBC
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 19:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F57820A8B
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 19:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589053247;
	bh=3LrG5ttxQPpX9Lg06Xgdo9wtFd1r8H3LF+BE2amdvsg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HG1xKFeKUryeje0J57hr7d0Pc40ztbc61VRvxp+UyqBtASNnD/Mv9/kllKk8XKTN9
	 eFMlnscIxYofyiqYpVplMF9+RzBMuVowXfNVEF6o/CafUzmwUykg8O0cHviNXIaXEW
	 v+7izd4gNA+u9X8wHHKEJfcjEcVdhKMPQm3r/XmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgEITkq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 May 2020 15:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727938AbgEITkq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 9 May 2020 15:40:46 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F73AC061A0C
        for <linux-block@vger.kernel.org>; Sat,  9 May 2020 12:40:44 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h4so5226523ljg.12
        for <linux-block@vger.kernel.org>; Sat, 09 May 2020 12:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pZai2SKOng/9EApNn8+XKAR8PEHqYwO2AyY0NfsdHro=;
        b=fjH/s+7HAOhXhL+hb2Rmjw1QvhngmISpA7ykZcYURyoxcZjb+plPCwtGU6BaRI7/Md
         N4FP+SO8SM2YhwxKJ420cGgVu38YoziHOTH+hWAQybIlGbAkHNFVHdjnslDVtAMK2Pk/
         qD0rr4CnsL9CpaDwZKzD/WVPDtL9iHYlmEWsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pZai2SKOng/9EApNn8+XKAR8PEHqYwO2AyY0NfsdHro=;
        b=M8LT4u1mGCg+ntHEbwiYcyjbuZ66N6CIs7Eju1cwZSlVWh2flpALMq4Jc6t0ojD/OR
         Yg1N8MgSdXOwYCD7UkXVdaeZ8g5PIvvsLCZsCl8CoCuPpQQsdcz6txq1EaMpSkSaWXLQ
         B7yUkYPDCluoiwLZtnKwWZFzPt+xFwUgKahH9fXZXFNcAPY5SHF0cCYXdojFvp6rIkvt
         trwqvhss5vlQO6nY5uerClPJrWxGLRSsqO+bNNCvKtZ0Nni7sI+kS3RytxBTNKjOxA4f
         UhaSvW7SLP+MHvIXyozpungp0qeddRKKwC2Sz0JvZ8w0CRRoYHy5/7f6B3cIflbPFFtc
         VxQg==
X-Gm-Message-State: AOAM533FrbnhuCZdLJGPrVAgiWKdU5d1AYLRPo3LmT859ABnxButaELl
        SUL3XFfdUJHIkXGyweXTsiDXIHDz2+o=
X-Google-Smtp-Source: ABdhPJxFu2pi0weoHA+p/OSB6I+mMjwTk7ciTHS/H5FAA2NxVs/SAXvFVLQu4xa4ere11pNpKN62sA==
X-Received: by 2002:a2e:9018:: with SMTP id h24mr5411292ljg.217.1589053242274;
        Sat, 09 May 2020 12:40:42 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id v4sm4512011ljj.104.2020.05.09.12.40.40
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 12:40:41 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id a21so5213608ljj.11
        for <linux-block@vger.kernel.org>; Sat, 09 May 2020 12:40:40 -0700 (PDT)
X-Received: by 2002:a2e:87d9:: with SMTP id v25mr5393567ljj.241.1589053240311;
 Sat, 09 May 2020 12:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <cc854168-7859-49f9-63f7-dbaaff8fbb3d@kernel.dk>
In-Reply-To: <cc854168-7859-49f9-63f7-dbaaff8fbb3d@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 May 2020 12:40:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiaK+pETqCN6vMvU_wfpe-aUy1NkZADx4cV7tCcmDA=UA@mail.gmail.com>
Message-ID: <CAHk-=wiaK+pETqCN6vMvU_wfpe-aUy1NkZADx4cV7tCcmDA=UA@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 5.7-rc5
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 8, 2020 at 8:17 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> A few fixes that should go into this series:

Jens, wtf?

This doesn't even build. Commit 0f6438fca125 ("bdi: use bdi_dev_name()
to get device name") results in

  In file included from ./include/linux/kernel.h:15,
                   from ./include/linux/list.h:9,
                   from ./include/linux/module.h:12,
                   from block/bfq-iosched.c:116:
  block/bfq-iosched.c: In function =E2=80=98bfq_set_next_ioprio_data=E2=80=
=99:
  block/bfq-iosched.c:4980:5: error: implicit declaration of function
=E2=80=98bdi_dev_name=E2=80=99; did you mean =E2=80=98blkg_dev_name=E2=80=
=99?
[-Werror=3Dimplicit-function-declaration]
   4980 |     bdi_dev_name(bfqq->bfqd->queue->backing_dev_info),
        |     ^~~~~~~~~~~~
  ./include/linux/printk.h:299:33: note: in definition of macro =E2=80=98pr=
_err=E2=80=99
    299 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
        |                                 ^~~~~~~~~~~
  In file included from ./include/linux/printk.h:7,
                   from ./include/linux/kernel.h:15,
                   from ./include/linux/list.h:9,
                   from ./include/linux/module.h:12,
                   from block/bfq-iosched.c:116:
  ./include/linux/kern_levels.h:5:18: warning: format =E2=80=98%s=E2=80=99 =
expects
argument of type =E2=80=98char *=E2=80=99, but argument 2 has type =E2=80=
=98int=E2=80=99 [-Wformat=3D]
      5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
        |                  ^~~~~~
  ./include/linux/kern_levels.h:11:18: note: in expansion of macro =E2=80=
=98KERN_SOH=E2=80=99
     11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
        |                  ^~~~~~~~
  ./include/linux/printk.h:299:9: note: in expansion of macro =E2=80=98KERN=
_ERR=E2=80=99
    299 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
        |         ^~~~~~~~
  block/bfq-iosched.c:4979:3: note: in expansion of macro =E2=80=98pr_err=
=E2=80=99
   4979 |   pr_err("bdi %s: bfq: bad prio class %d\n",
        |   ^~~~~~
  cc1: some warnings being treated as errors
  make[1]: *** [scripts/Makefile.build:267: block/bfq-iosched.o] Error 1
  make: *** [Makefile:1722: block] Error 2

and no, it's not a merge error - at least not one by me. I tested the
tip-of-tree that you sent me, at commit ded3148fc653.

So that build error exists in your branch.

Unpulled. Get testing, and don't send me garbage.

              Linus
