Return-Path: <SRS0=4Sb2=2K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF862C43603
	for <linux-block@archiver.kernel.org>; Fri, 20 Dec 2019 18:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FF220866
	for <linux-block@archiver.kernel.org>; Fri, 20 Dec 2019 18:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576867796;
	bh=hPkgxJQURHg0bW5pTeythxzljecyI1zeOsaIyFiqsoM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fVgCH/x83N/agpEYsbISfROhCjDdvXZnzU9Lxp7xyJcqmzJUN4X55esQ1XbrP3H9q
	 t1F84H981i1qAzAScFsfrXeRw56TTTKPWRiAQuuaFFKQfL2jxwYht8m/5ikQpAtQ/L
	 1NlI2WFdITeMFVApHnRxIm/Xu5PcC8BMKfnI9+dc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfLTSt4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:49:56 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39522 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfLTSt4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Dec 2019 13:49:56 -0500
Received: by mail-lf1-f66.google.com with SMTP id y1so7788015lfb.6
        for <linux-block@vger.kernel.org>; Fri, 20 Dec 2019 10:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XJ7MardmkrfNuKzw7uFHYQMT5xca/rCmB8d1jLpQiNg=;
        b=Pf0X1UIl2PzRXRLlzBrXglWCKJlvauIfyzEiHgHwjGRiPJyZE0DAQzW+XttIXBA6+Q
         eWh8GE6+o9AW8ijyv5E5ybRioyOtQnUTmaoTZyzpW/14SU6kLE8dpFXwx4UCqK51zNy1
         ASkILRhyJmJH356bPScea7WaNe536JlAQ9Hqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XJ7MardmkrfNuKzw7uFHYQMT5xca/rCmB8d1jLpQiNg=;
        b=BVgvW5xMi1pTR7m5xuifZT1yf6CfLHltuSBFwcdJUpvK3Woy0f7ao+pDJcVmAtojRR
         AvGU6TgmgEduWRAukf/sPPJXcD6gvMySeK/1Mt09I/dqlSOlheGTvRyKRkjk8zo2RJeF
         wfZNVHt2Lt3qD0ZGrKT/8jiHOGQcZbknJIoVwz5Q18UVLKRaB0H5yxN5lBc+sd9dL3Vx
         8ESuicGgtWG+AJFibMdtYrmne77q4WGrpj4QGLVrGGS7lE+HlewpzjeHf2D22Q4XqnE2
         lB4P1e/mlKeIkCX2/ueHHUh/3qRUWBN1JDbrfubnZ6gBbj8WwmUkypbhWKndn8SUG41s
         GG9A==
X-Gm-Message-State: APjAAAUXULpIVJxgx60YIuAOlIV9PJ7CLYeHLrHyUfgbx+kgFXQL4P3Y
        LU2KC0HB5HIah901CtfkR1Kh147dCi0=
X-Google-Smtp-Source: APXvYqzXD5s0fAE51DlkY+jqzLOfKqdhPrOigGKhP168QQPhotIOnoc+3OmBS86wd5ROOL7F6e6VLg==
X-Received: by 2002:a19:c1c1:: with SMTP id r184mr10019516lff.128.1576867792832;
        Fri, 20 Dec 2019 10:49:52 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id f11sm5434751lfa.9.2019.12.20.10.49.51
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:49:52 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 15so7816851lfr.2
        for <linux-block@vger.kernel.org>; Fri, 20 Dec 2019 10:49:51 -0800 (PST)
X-Received: by 2002:ac2:4946:: with SMTP id o6mr9885918lfi.170.1576867791633;
 Fri, 20 Dec 2019 10:49:51 -0800 (PST)
MIME-Version: 1.0
References: <b596cdab-4a73-39c6-1d35-4804794cf8f4@kernel.dk>
In-Reply-To: <b596cdab-4a73-39c6-1d35-4804794cf8f4@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Dec 2019 10:49:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgd+TGrrzews6PWH0LzftBs+KpsUnPWHd=SUKwuMWKnJQ@mail.gmail.com>
Message-ID: <CAHk-=wgd+TGrrzews6PWH0LzftBs+KpsUnPWHd=SUKwuMWKnJQ@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 5.5-rc3
To:     Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 20, 2019 at 9:51 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Here's a set of block changes that should go into this release.

No can do.

> - Series from Arnd with compat_ioctl fixes

This doesn't even build:

  block/compat_ioctl.c: In function =E2=80=98compat_blkdev_ioctl=E2=80=99:
  block/compat_ioctl.c:411:7: error: =E2=80=98IOC_PR_REGISTER=E2=80=99 unde=
clared
(first use in this function)
    411 |  case IOC_PR_REGISTER:
        |       ^~~~~~~~~~~~~~~

with several other related errors (IOC_PR_RESERVE, IOC_PR_RELEASE,
IOC_PR_PREEMPT, IOC_PR_PREEMPT_ABORT, IOC_PR_CLEAR)

             Linus
