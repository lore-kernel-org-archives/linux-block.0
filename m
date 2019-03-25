Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B8DC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700D52083D
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfCYQMK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:12:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41416 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfCYQMK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 12:12:10 -0400
Received: by mail-qt1-f194.google.com with SMTP id w30so10916820qta.8;
        Mon, 25 Mar 2019 09:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2v+nseKEWXfRLDncZfQd6dsrneZmghTnCjmrBpyewVo=;
        b=o5Ct/pHv1rATybGrmIAPma1SeJHPuJpwrHkTFd6hm/NCcdUyy9B2+R1fPgz03Vmvgc
         fGfYadZC7tGImGyB5NtjNm9uCdkl5tsITaXm7uUQ95ulHuabX+HcnqLqkabwa0f5CXKM
         Sj8CQNsy362FIiWWuR8r7Rw+87KQSqNK2Ag9n0IQTnSKIVQ1r7OFPR9WiCtPbIixV5rQ
         fzrhspUx+QRCf9iApE7UmODha1ozw4JjydIUC7hELi/4uDOzWMahAh4k57Mx+HgN2LBZ
         Fdf6+n0USzRCtheyQACmxMPEIgNb/FVl21dURgIupuTo/hNEs5MWsTzlMNvG/vIkiYHW
         c3Vg==
X-Gm-Message-State: APjAAAXU45imZl6FEFOwT/MwRs6srG5im973kdPy3UWL519J9+OCa6X0
        uaTS19+MVOoJRhX0iRCnGfnwGO5ixrm22Bm6glg=
X-Google-Smtp-Source: APXvYqyz/9FaNDscQbTl3GH0T08Q5bfZHRR7Epq9ybOvAWf03beutHWMFG+edO9SkgwZD7twKWhFWMSrYFAC5XABt6k=
X-Received: by 2002:a0c:af02:: with SMTP id i2mr20472975qvc.40.1553530329632;
 Mon, 25 Mar 2019 09:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190325143521.34928-1-arnd@arndb.de> <a29338b9-60ad-a4da-da9d-a0c522a5b9df@kernel.dk>
In-Reply-To: <a29338b9-60ad-a4da-da9d-a0c522a5b9df@kernel.dk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Mar 2019 17:11:53 +0100
Message-ID: <CAK8P3a2SpydaLZijzUXxCzMKSEv3ymfpOCO4xSZOVfz2cwFxAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] io_uring: fix big-endian compat signal mask handling
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hannes Reinecke <hare@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 25, 2019 at 5:05 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 3/25/19 8:34 AM, Arnd Bergmann wrote:
> > On big-endian architectures, the signal masks are differnet
> > between 32-bit and 64-bit tasks, so we have to use a different
> > function for reading them from user space.
> >
> > io_cqring_wait() initially got this wrong, and always interprets
> > this as a native structure. This is ok on x86 and most arm64,
> > but not on s390, ppc64be, mips64be, sparc64 and parisc.
>
> Thanks Arnd, applied.
>
> Was there a 2/2 patch? I only received this one, 1/2.

Sorry I missed you on Cc:
https://lore.kernel.org/lkml/20190325144737.703921-1-arnd@arndb.de/T/#u

This one went out to all the affected arch maintainers.

    Arnd
