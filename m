Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E64C282CD
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 00:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860342183F
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 00:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Syh7W1Vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfA2A7S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:59:18 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43818 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfA2A7S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 19:59:18 -0500
Received: by mail-ot1-f67.google.com with SMTP id a11so16415772otr.10
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 16:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mlmLWfdm+ta+Tsj+475uscAQeUk0GIsCvkn+0J5XS3k=;
        b=Syh7W1VsleoAuWRLk6ii+q3kE1faI96qZiY0/l9laodsJw8ESr5Pn2ZUu+8ewlvJzb
         Gy2w2HP7CWie0H42AMwAmWCE5gvPO2WKdbts7yXwegmrRpwDYz+zmK2J69AJjKudgk4V
         CXLtRSnYqnApKgdWgYztmUDXMfd6o3oZjY4skMRwBvtG2mUoBRS6vU75ZKR06fLR5D91
         7gI9wJaI+R7jSmSutcAW6vl1iWRZDys4Yd1urQI6xT2RcI9rFDrwpoVHDdBaZrvl2YBb
         jXiyQfuzaI87G+oXE9c3d/DEHhByI76S2AGmZbHhGJTlIs5NWxMvBOd388efPNT2nnBq
         jYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mlmLWfdm+ta+Tsj+475uscAQeUk0GIsCvkn+0J5XS3k=;
        b=EBjGVH+Jvn9SL6BI3JauBkCHYLHnfiK38Kvln8ojBIdS9xcQSN/HCZV88+MXCJU8vr
         UTl1dLlXiGpil1UKIk3j3nfJXRbNjore3KlG32gVipdb8la8yPbZ1xmoV0ldKOmoVdff
         LQ1gS8HGvw9a9NG/3yCczLQiCxJu/HvNUiyrKNHiZIn6YbZc/B8nipYFToJJt9L//VAX
         LZ4bhBIJIRl5V5LeD06j614DuKQ1JLJMlpytVyD5VrP7c2qTS8ESt+m8nGC63WMf4S8w
         oMS2ojHOxLOOSgkQW4H/ypNU2oSJe8f3LfAbgPjtwvwa89Wh49uZi3rmmLgHZ/+8UHIa
         32sw==
X-Gm-Message-State: AJcUukfAlkHaB5mUAiPIBDEwlZV3PSBKSx6LMGrw0mPjWI/O9+nO+QhL
        OAom8GoOMj59pgeS/ENu0KdUZe1n2e8j065En9Jy3Q==
X-Google-Smtp-Source: ALg8bN4iJiqUlxz5EgGbmC5bWQr30US1FFUxay6Eg9q39bePNfoS6WTJJUQEVjLrHT2ZKKl2xoDA7r+JU7/msTrM9o0=
X-Received: by 2002:a9d:4e06:: with SMTP id p6mr19153683otf.73.1548723557234;
 Mon, 28 Jan 2019 16:59:17 -0800 (PST)
MIME-Version: 1.0
References: <20190128213538.13486-1-axboe@kernel.dk> <20190128213538.13486-6-axboe@kernel.dk>
 <CAG48ez0vDqDH4ks7q4L3F+xt-4kVQrN1yw34QwFAmwQyy27FTw@mail.gmail.com>
 <e9326a77-54c5-e2b8-d9e5-663261462597@kernel.dk> <CAG48ez17NW0GJVRC6dFcHZTgQifFz5og1XCUbXkHKhr6f=j74Q@mail.gmail.com>
 <c20a1250-9f3f-a286-9baf-5b71db0c128f@kernel.dk> <51c759f4-7ce5-182b-98e8-2c0e99ca4f9a@kernel.dk>
 <CAG48ez3XGjFZbPiof4u4QGtoumBXXfCsFxOQ_2pGt=MnqqY7ZQ@mail.gmail.com> <a89d28dc-d0c4-d84e-b3f2-20d10c6f673e@kernel.dk>
In-Reply-To: <a89d28dc-d0c4-d84e-b3f2-20d10c6f673e@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 29 Jan 2019 01:58:51 +0100
Message-ID: <CAG48ez2dESJAg80N3+vgSWy_Pb+Est0S-jshhmZD2nnwgpuR3w@mail.gmail.com>
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 29, 2019 at 1:55 AM Jens Axboe <axboe@kernel.dk> wrote:
> On 1/28/19 5:34 PM, Jann Horn wrote:
> > On Tue, Jan 29, 2019 at 1:32 AM Jens Axboe <axboe@kernel.dk> wrote:
> >> On 1/28/19 5:03 PM, Jens Axboe wrote:
> >>>> But you only do that teardown on ->release, right? And ->release
> >>>> doesn't have much to do with the process lifetime.
> >>>
> >>> Yes, only on ->relase().
> >>
> >> OK, so I reworked the files struct to just grab it, then we ensure that
> >> doesn't go away. For mm, it's a bit more tricky. I think the best
> >> solution here is to add a fops->flush() and check for the process
> >> exiting its files. If it does, we quiesce the async contexts and prevent
> >> further use of that mm. We can't just keep holding a reference to the mm
> >> like we do with the files.
> >>
> >> That should solve both cases.
> >
> > You still have to hold a reference on the mm though, I think (for
> > example, because two tasks might be sharing the fd table without
> > sharing the mm).
>
> Yes good point, except we can't hold a reference to it.

Why not? kvm_create_vm() does it, too:

    mmgrab(current->mm);
    kvm->mm = current->mm;

> But I think
> we can get around this by using an mmu notifier instead. That eliminates
> the need for ->flush() as well.
