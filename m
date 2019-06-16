Return-Path: <SRS0=cIdD=UP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DACBC31E49
	for <linux-block@archiver.kernel.org>; Sun, 16 Jun 2019 10:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B92A2147A
	for <linux-block@archiver.kernel.org>; Sun, 16 Jun 2019 10:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="poa9HFE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfFPKXu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Jun 2019 06:23:50 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34939 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfFPKXu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Jun 2019 06:23:50 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so15204791ioo.2
        for <linux-block@vger.kernel.org>; Sun, 16 Jun 2019 03:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=s3k6GliP+JsBPn4B1PVzd3Sxp1rH0zTWIZuFXfA1ABk=;
        b=poa9HFE2cGZO0zSW+ys6g58RcOaeqp/1+BkR8NpiN0MbWycFh+M059PZG7IV/nL6Pr
         e/STFlM74gxW/HItPnr4KSFCTNw3oymWEFcNhffqgwHcEdg9wblZ28452WYyyP250uON
         2A+1WGAdIqrRWbcwrVfxbl2wMH57OZfjC/DC576jjA7prn37t2YQCpF9Xk3L/4fL+BF+
         yQaE+30/yySM2NvEihN7zQnrGghnoTxQ6R8VdapC9qgHpo2T/vr6xmiZgKJtKDW78Uvy
         sG9qs584Va9SxLcp+vXdBCKzjNQpDEq6eTESajzCrr4sdQXfqUEjFoOnZ7mSpxZBlXtf
         dFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=s3k6GliP+JsBPn4B1PVzd3Sxp1rH0zTWIZuFXfA1ABk=;
        b=BUGT5LgfGtJ9uk09q9B5f4DgvxQQwmHokV+rUdgm09J1lModlIwkOwDpJ2shCwri6Y
         HKIdd0O4+1o2TVKyJNpgiYlle0Z1iR98LYs5UYx+ezYg3/fgY6wbjdnYZb6CJqw/XIFW
         xX9fQrOXv9Z1zxpF9FtDULnmL6RHCKyZo5i1+/2yrbmHQXEraNvEshft1XpjjvMaTKEU
         2NH4SOnwAZtoda/m2iP7lSmgY0ZXhnKpYKVIzzVF2Ut4rW2EBjr9lIOqtSGECWUPttrD
         gETyfzGWrVQHyy/IN54vw6CC5dishrHhhkEHkrzEhG2TUtztQBKuniCFKSZHIqpLqiuv
         EOFw==
X-Gm-Message-State: APjAAAVVjt+UqN568XZ3OX3Vb/bVfwbBA3flXa1W58HFtvZA6CNa1ROq
        /1T8ob+/NT2d1U6ROtDN49MhkqrGYMEMOOvhUGzw1B9wx187yg==
X-Google-Smtp-Source: APXvYqwmZfP5SLaB8QLBKO+tmF93APMjYP75jnOs7UaNKBGzRUXc2So+LVluGFgTlA8/ZKyW3S3oAw9m7fuXQH15K4Q=
X-Received: by 2002:a6b:4101:: with SMTP id n1mr6494638ioa.138.1560680629345;
 Sun, 16 Jun 2019 03:23:49 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 16 Jun 2019 12:23:38 +0200
Message-ID: <CACT4Y+bgr4aC-DZuLCyhxpcES39mbEgLV_UWakmkOYEBPrOkwg@mail.gmail.com>
Subject: Re: [PATCH 0/2] bcache: two emergent fixes for Linux v5.2-rc5 (use-after-scope)
To:     kasan-dev <kasan-dev@googlegroups.com>,
        linux-block <linux-block@vger.kernel.org>,
        Coly Li <colyli@suse.de>, Rolf Fokkens <rolf@rolffokkens.nl>,
        Pierre JUHEN <pierre.juhen@orange.fr>,
        Shenghui Wang <shhuiw@foxmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Nix <nix@esperi.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This is regarding the subj patch:
https://bugzilla.kernel.org/show_bug.cgi?id=203573
https://www.spinics.net/lists/linux-bcache/msg07474.html
(don't see a way to reply to the patch)

This looks like a serious bug that would have been caught by
use-after-scope mode in KASAN given any coverage of the involved code
(i.e. any tests that executes the function once) if I am reading this
correctly.
But use-after-scope detection was removed in:
7771bdbbfd3d kasan: remove use after scope bugs detection.
because it does not catch enough bugs.
Hard to say if this bug is enough rationale to bring use-after-scope
back, but it is a data point. FWIW this bug would have been detected
during patch testing with no debugging required.
