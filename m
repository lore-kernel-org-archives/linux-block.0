Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BA6C64EC7
	for <linux-block@archiver.kernel.org>; Wed, 15 Feb 2023 10:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjBOKgv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 05:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjBOKgu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 05:36:50 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0906C37F08
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 02:36:45 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id qw12so47116860ejc.2
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 02:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jM0FwoIIzEHG4m8zeaDUaO7Uvam61BltMptR0QqQfi8=;
        b=g10NP693SvvFXcmWRF8jugEf1fd0P1pWVWUmXSW+QT1vi5rZmh/Tp5whmTtenWD1ub
         xxUGAKnzhAefLbyB7PoHddpwNA1phJRDGS7cNxVnesT8/czbcfvwChVMOQEifqixnehd
         VYkM0S7GFtXgP2ob/07Hcxzpl7RUPcQtJwal4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jM0FwoIIzEHG4m8zeaDUaO7Uvam61BltMptR0QqQfi8=;
        b=TBlsf8mqY1mr8W/JYZ/9cYxQZVAsETr4osK2GGACF/wJHRysf5HulXZb11HA4MUysq
         Xb8GPjFCcYp4F8l/KHnk5yT4mQr/TIO1DA4cUEWn8e2tLbwKVI9q9XjpIIwJZiIxQEe5
         ThUXX4aV/EVt4n9f67lkCJtXPm1lfw0QXeCFM2eEYyK1l4QhcW7FdVbUb5RA45cStm4d
         0bh1cghyx4a2XehbHihSEM9pVI8hv7TxcpBBTGcExerX8VnOHkReP26djoRyLU96G6iB
         1tYJr2O5ksZZUUs3tO9Ku3NU9tPD2VderqqNbgfsy6n5QGn4JlgQQaUjXl0STcfT8xRv
         gL9w==
X-Gm-Message-State: AO0yUKUXu9QZCLvk4wlAYmGdt/AIy09GNQhaSTSyqHhzHyqo0eP6wm6F
        m45YgdDBAtx2we8KI7d/Vtaqp2cMFOqK5xDoFDfyFg==
X-Google-Smtp-Source: AK7set/bkHc0a756f/QlIvbRZtodwoFCU9VO07Oo08HkoJlbe19L4o3xLqNtmV85jzZ4Rw1THkuOEpBXU7a08gF46f8=
X-Received: by 2002:a17:906:e219:b0:8af:2e89:83df with SMTP id
 gf25-20020a170906e21900b008af2e8983dfmr1079578ejb.6.1676457403411; Wed, 15
 Feb 2023 02:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20230210153212.733006-1-ming.lei@redhat.com> <20230210153212.733006-2-ming.lei@redhat.com>
 <Y+e3b+Myg/30hlYk@T590> <CAHk-=wgTzLjvhzx-XGkgEQmXH6t=8OTFdQyhDgafGdC2n5gOfg@mail.gmail.com>
 <Y+hDQ1vL6AMFri1E@T590> <CAHk-=wgJsi7t7YYpuo6ewXGnHz2nmj67iWR6KPGoz5TBu34mWQ@mail.gmail.com>
 <CAJfpegtOetw46DvR1PeuX5L9-fe7Qk75mq5L4tGwpS_wuEz=1g@mail.gmail.com>
 <Y+ucLFG/ap8uqwPG@T590> <CAJfpeguGayE2fS2m9U7=Up4Eqa_89oTeR4xW-WbcfjJBRaYqHA@mail.gmail.com>
 <Y+wjGZO6rVw5W35T@T590>
In-Reply-To: <Y+wjGZO6rVw5W35T@T590>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 15 Feb 2023 11:36:32 +0100
Message-ID: <CAJfpeguQ3xn2-6svkkVXJ88tiVfcDd-eKi1evzzfvu305fMoyw@mail.gmail.com>
Subject: Re: [PATCH 1/4] fs/splice: enhance direct pipe & splice for moving
 pages in kernel
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 15 Feb 2023 at 01:11, Ming Lei <ming.lei@redhat.com> wrote:
>
> On Tue, Feb 14, 2023 at 04:39:01PM +0100, Miklos Szeredi wrote:
> > On Tue, 14 Feb 2023 at 15:35, Ming Lei <ming.lei@redhat.com> wrote:
> >
> > > I understand it isn't one issue from block device driver viewpoint at
> > > least, since the WRITE to buffer in sink end can be thought as DMA
> > > to buffer from device, and it is the upper layer(FS)'s responsibility
> > > for updating page flag. And block driver needn't to handle page
> > > status update.
> >
> > The block device still needs to know when the DMA is finished, right?
>
> Yeah, for normal in-kernel device driver, the completion is triggered by
> interrupt or io polling.
>
> For ublk, io handling is done by userspace, here we use io_uring to
> handle the IO in aio style. When the aio is completed, the userspace
> gets notified of the completion.

I think it might be better if the write completion was directly
signaled to the original pipe buffer.  There are several advantages:

 - the kernel can guarantee (modulo bugs) that the buffer was
initialized, this is important if the userspace server is unprivileged

 - the server process does not need to be woken up on I/O completion

 - there could be a chain of splices involving various entities, yet
the original pipe buffer should always get the completion

I'm not sure what a good implementation would look like.  When a pipe
buffer is split, things get complicated.  Maybe just disallow
splitting on such buffers...

Thanks,
Miklos
