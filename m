Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B787DC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 15:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C5D20881
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 15:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NIWc1LMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfA2PjE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:39:04 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41968 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfA2PjD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 10:39:03 -0500
Received: by mail-oi1-f195.google.com with SMTP id j21so16465791oii.8
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 07:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v1kNZNna8iImPxLDF0OjMSD6LPq39L0c3zI6goHZAVM=;
        b=NIWc1LMCy/NSK+vHX/gJplofQMhq0V25sEOhJ/uji/fpq/P6OHeZiwx06njekx5vX5
         A/f6BxWjAA9zYKRoylxkjI7LTCz5CsPE71DkxW8LeS+PqADhOFHHmxX99JpHPNRmbdVE
         486UKmjUNl1784riBiPb1KUb0T/2VkACObmYrdPEkj60i8Bstsir69F+IHedjUynHe9d
         rMBxGHCwRZDCbJ/5ZwkGOWvGxZCWl1wFiBtIby1LeZmj0wosVfpaiycxz6uuKksG0tb6
         uWFheJuRBSmF2ouJK+56DEajSkHnL8/4yJzRa63PPUpYI+tfHEE9FVJPvXyaTimszc1C
         4u0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v1kNZNna8iImPxLDF0OjMSD6LPq39L0c3zI6goHZAVM=;
        b=WuWjXg3S5XvrOjL4okxAvLFOr3hV4xcI8QbYoMfjsN4qhEbzwZjNWcdvzhkXLs6VVt
         8bCXKUafwJwoBIuonUsKDNzhM2El+oRIgdBF2RO/tBUwObRTDsambXZCw8ghIgfRJw33
         TUN7T75UaweJ6ZnsiZui/Oq/6k7DCeQWpPbY/vaftQfpSGbE9OLBbvAPrEm1pK74T3rv
         wCLQtRS/pSqDMwDugflThDTqKMuO0/+2XWpIkmvfWws7OCE0gdopnwZsMEJ4pP32E8dH
         3Cqdhq9CPgu3yciRdnrsexkv/ZRl/NZBynzR3q2RRJ/HiP0vv3QsRDH9a9oh+ohRvm6y
         Oy0Q==
X-Gm-Message-State: AHQUAuY5t9UPJqtyuPxdDFrHGldMNpYVJNHNlSQk1jzA8vn11t9NyxyP
        HA5SrBorCEnOiA3K0XPNGqpffPiF1O941CBJ5ho8iA==
X-Google-Smtp-Source: ALg8bN6P4/rkbc+CYtS9XYwtZ8NqDGSq+jecYsYYxnBRF2sMoxH1rJbzb3vI/n5pjtvHyo/pRWqzCVgwlF/yShZtoQU=
X-Received: by 2002:aca:c43:: with SMTP id i3mr9910948oiy.157.1548776342973;
 Tue, 29 Jan 2019 07:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20190128213538.13486-1-axboe@kernel.dk> <20190128213538.13486-6-axboe@kernel.dk>
 <87tvhrpsqg.fsf@oldenburg2.str.redhat.com> <74fd3127-75f1-3a48-d3cb-a8f6c9bd0b74@kernel.dk>
In-Reply-To: <74fd3127-75f1-3a48-d3cb-a8f6c9bd0b74@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 29 Jan 2019 16:38:36 +0100
Message-ID: <CAG48ez0PPWP7GU5kinzejN1B3invrcxCZT2fkpnHxMK2F0pj6A@mail.gmail.com>
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Florian Weimer <fweimer@redhat.com>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        hch@lst.de, jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 29, 2019 at 2:35 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/29/19 5:12 AM, Florian Weimer wrote:
> > * Jens Axboe:
> >
> >> +#define IORING_MAX_ENTRIES  4096
> >
> > Where does this constant come from?  Should it really be exposed to
> > userspace?
>
> Seems pretty handy for the application to know what the limit is?

The running kernel version might be different from the kernel version
whose headers the userspace code was compiled with. So if this is a
limit that might change at some point in the future, and you think
userspace wants to know the limit, some other API might be better.
