Return-Path: <SRS0=i0oD=EB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4017AC56201
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 22:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00BD020878
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 22:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="JQw5fA5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394907AbgJZWz3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Oct 2020 18:55:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41719 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394909AbgJZWz2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Oct 2020 18:55:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id l24so11450341edj.8
        for <linux-block@vger.kernel.org>; Mon, 26 Oct 2020 15:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=J/+n1x0TPOHJCTfSVoXlG/q+OLrGnnNxrysZ0ZyIy+Y=;
        b=JQw5fA5cqXZCTLCd2xkURV07bnYrA8gTT/8l9H7r6P+PgM37GQ7tblZcETghImepsU
         AcI0oUILLNpw7+Lob5wOxm8oxXKZgdxlvk1iOdkoLk31eLVc1crb3sEhxCSb6bD2V31l
         b7OGa6zHv0zDl28Z8OMcIxY0WvmVK7pWJSrW3Zs4sWifuxNiQ2iEW7pkdOAgHIEek3Fp
         L3yESbOX+0gb8ueK46K6rtDj34b55Vtmz8U4fPoQ/Dv2vqBsFOJNMTpbG7mznOfR5TaL
         kpOlREDICaBo0Xi3+x/a4pHYfGgO73EI5dQFmBZNKgKh2ry9/Y+FL54IAgbsbpnA0Xzm
         BeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=J/+n1x0TPOHJCTfSVoXlG/q+OLrGnnNxrysZ0ZyIy+Y=;
        b=hVEm1UHWvUplCNS0ILJgxliv/ohRj9mqYHVvwwng4q2vlKY4dOl7Y+EUXwsEGwRTWY
         9pKt0ekOX+LnBknhAh5mJhmbmqkHQm/q0iidT1ioM+5ynA7tUaDXvB3Ljzvzh76aQIDP
         G9fQcSOXI2Fv2/MNknGNhm/H7H7k0v42AWkX6ov7KPpKr2VYV39+/DUAA8cdxOaHXRoq
         +WZnPo/0Xqg515rmOHlhorTIbzPhyqyPNVnbwHuCKpJ7wDM++5JSqs2H2kqQ27SOH0nT
         EWfIg9bTt/Ni0k3+CXq4UUbH7LeZx8kDEQpbGPR1wjJcSki8pZPeqccytsGKgGoQ54h8
         HA+A==
X-Gm-Message-State: AOAM531fOpK07K8yFk6UKsxHjNbTeaBazIed5vVAghriaVWT0ReyfO5M
        G42vR1zQxnvItPCnD0z7Ywp64W2vc3BccuG1Jwou1Q==
X-Google-Smtp-Source: ABdhPJyAci+5cM2zXs7C2dh5O8VDIKXSp+LVa6rVM/MPlgy6tZLvyXi43c6iWM9w5BW9l3CIsdr5O5Od75OK4rN9ByQ=
X-Received: by 2002:aa7:d9ce:: with SMTP id v14mr12828586eds.203.1603752924617;
 Mon, 26 Oct 2020 15:55:24 -0700 (PDT)
MIME-Version: 1.0
From:   Kyle Huey <me@kylehuey.com>
Date:   Mon, 26 Oct 2020 15:55:13 -0700
Message-ID: <CAP045Aqrsb=CXHDHx4nS-pgg+MUDj14r-kN8_Jcbn-NAUziVag@mail.gmail.com>
Subject: [REGRESSION] mm: process_vm_readv testcase no longer works after
 compat_prcoess_vm_readv removed
To:     open list <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     "Robert O'Callahan" <robert@ocallahan.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org,
        io-uring@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A test program from the rr[0] test suite, vm_readv_writev[1], no
longer works on 5.10-rc1 when compiled as a 32 bit binary and executed
on a 64 bit kernel. The first process_vm_readv call (on line 35) now
fails with EFAULT. I have bisected this to
c3973b401ef2b0b8005f8074a10e96e3ea093823.

It should be fairly straightforward to extract the test case from our
repository into a standalone program.

- Kyle

[0] https://rr-project.org/
[1] https://github.com/mozilla/rr/blob/master/src/test/vm_readv_writev.c
