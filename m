Return-Path: <SRS0=aEt0=ZG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B0CC432C3
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 23:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD45206F0
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 23:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ev1bBGx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKNXTo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Nov 2019 18:19:44 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38499 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfKNXTo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 18:19:44 -0500
Received: by mail-lf1-f66.google.com with SMTP id q28so6473857lfa.5
        for <linux-block@vger.kernel.org>; Thu, 14 Nov 2019 15:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ICrO0QRstvenGdVeXDhZbaKDYu3NwTrJocm24+ZpLeM=;
        b=ev1bBGx7lLlrnl26b7rac/GdwfVDNkM6VDvIUf7VBtsxoiUazG/I7hXMGRVkH4s9Zr
         5n1Q/xO5/Ub03hzKELw/qorFGTCAcInMY/IBmyOxe45PHOoaJixrg1e5WMT5xWskDhnR
         F0c0xW4ygk84ZQZhlsONe5gHFlDxIFEJ6FKYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICrO0QRstvenGdVeXDhZbaKDYu3NwTrJocm24+ZpLeM=;
        b=BM8DGddQua1gqobWkWWhMlyiUipKVTmL+SwgwDcEQakY2C5XWusZ+YuKUWEG7hiokQ
         Ndl/BRnzwabpohWY5WaGRd6Oq8dqKdFecPHbMKlfNf40ghStHoJs48w/rXRr0aiNl8aD
         8BamVKeN6VZyhGLh3jkFmQvVAgTJXXphyc7hrgnFMWbY7Ge+beGkqF4kfoIqwEcEV5f6
         4vHJlNSfp1q/MEtTlwro2FBhHmKGIvlURwsB1YOJyvAVp/KTkyxWOJoBQrP7USU5ONWG
         dxtuGB6BEntaYr5uFWNarNazlPEL2OYnjgHRnOlDBdJ6YGNkfxYVPGM/ddpNz0Ccd0tj
         B9Ug==
X-Gm-Message-State: APjAAAUuSIxtI4Ocu2rQBd1fofZPob6g4/XIAjLCz72FVbbkt1nCy9Ny
        oa0Ech1mOOyRBFFvN9+61eM8Px90qZ0=
X-Google-Smtp-Source: APXvYqypeqYi5iM08EQ8iz8LFuXX6wotueILFMvwLwKEqhXj+9dufd+X3eJlAhHl3ZZmzCvpSrx1tg==
X-Received: by 2002:a19:895:: with SMTP id 143mr8733135lfi.158.1573773581645;
        Thu, 14 Nov 2019 15:19:41 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id n8sm3361160lfe.31.2019.11.14.15.19.40
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 15:19:40 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id j14so6454731lfb.8
        for <linux-block@vger.kernel.org>; Thu, 14 Nov 2019 15:19:40 -0800 (PST)
X-Received: by 2002:a05:6512:21c:: with SMTP id a28mr8857425lfo.79.1573773578349;
 Thu, 14 Nov 2019 15:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20191111185030.215451-1-evgreen@chromium.org> <20191111185030.215451-2-evgreen@chromium.org>
 <20191112083208.GA1848@infradead.org> <CAE=gft4=3ysHxWBVjfOsGVRHcORP3XcbSxd3hQ+YtJhMTPNgKg@mail.gmail.com>
In-Reply-To: <CAE=gft4=3ysHxWBVjfOsGVRHcORP3XcbSxd3hQ+YtJhMTPNgKg@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 14 Nov 2019 15:19:02 -0800
X-Gmail-Original-Message-ID: <CAE=gft6-dOUztUDHQUKDbw=ghdyXfbVD49nax5PiGJmWpAKhVg@mail.gmail.com>
Message-ID: <CAE=gft6-dOUztUDHQUKDbw=ghdyXfbVD49nax5PiGJmWpAKhVg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] loop: Report EOPNOTSUPP properly
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 12, 2019 at 11:09 AM Evan Green <evgreen@chromium.org> wrote:
>
> On Tue, Nov 12, 2019 at 12:32 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Nov 11, 2019 at 10:50:29AM -0800, Evan Green wrote:
> > > -             if (cmd->ret < 0)
> > > +             if (cmd->ret == -EOPNOTSUPP)
> > > +                     ret = BLK_STS_NOTSUPP;
> > > +             else if (cmd->ret < 0)
> > >                       ret = BLK_STS_IOERR;
> >
> > This really should use errno_to_blk_status.  Same for the other hunk.
>
> Seems reasonable, I can switch to that.

Oh wait, the other hunk doesn't deal with blk_status_t at all. Before,
it just translated any errno into -EIO. Now, it translates almost any
errno to -EIO (the almost being EOPNOTSUPP).

So I'll change just the first hunk you pointed out.
-Evan
