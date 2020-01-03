Return-Path: <SRS0=4w+H=2Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89845C2D0CE
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 12:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603992253D
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 12:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Ruh2Euoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgACMbU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jan 2020 07:31:20 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36967 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbgACMbU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jan 2020 07:31:20 -0500
Received: by mail-io1-f65.google.com with SMTP id k24so10854787ioc.4
        for <linux-block@vger.kernel.org>; Fri, 03 Jan 2020 04:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8NFqG/iQr/riL4obmy1p2wa1Hmnb75Lus5pO/+Zthrs=;
        b=Ruh2EuoaewyPvyU41AQeIFQYvExW8pJJaaR02aFtBtQztfA1I/hQsiuxaFgeYM7SOv
         XILNu/Z6a9tOfbnjv8cbMg5mJ/DBafj5Wye9m5+ZUv+8DN2Rb8Joe4rH5qq9sNSui691
         AP3QeoLwY+34BEnbpqpswuCpWYaKVQnPAS45iYQrvN8VPY7G5iXD/OAs0eh128pFRc78
         TYtjYL7t2bnTgAQ1LgjiY2LKb0bv3oWYDU575a81DxQcbkvP16RevB3sp6abkZVoUMnN
         +s68T7tWD6+B8CgCC2fL9s9toVLT6I7ZpU7QGPKyFrgovIXy0Ab6IR6Tj3R55mexDF0z
         bNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NFqG/iQr/riL4obmy1p2wa1Hmnb75Lus5pO/+Zthrs=;
        b=JGR/NorM5HVK6JqYbGH7PHhkGCxRPa3x5kuKke7Ih77ql6KoEHygWVywMkofJ4ExdW
         k1JRACAOPUAtDG0I4EXThBaAr89xPiO72jLyUr0tBM5MNwm4rNjFIOz7ohKB5YqyhyIt
         S5G4GbRyluAwTEwBlI7OO72HzMxe8mydjfLxce0oNSp0dJDArKaMp6fr+AR6keB7oxgY
         a+RvxPbBXyzGR0IYSvF+8jN9MhUSwYBGtlhx5z18PaKh/4IgAmE8Bi/h6EoOWYODmwrH
         jnDd0OIF4i1zfEAOn+gH0qpyaHBS8eWz11r2YvB5ZFYtJAsRLGjvIRd3GYgFVlYVsHjt
         TUsw==
X-Gm-Message-State: APjAAAXwfe7DNAvX7n53VBihcRbSDf1GNGZykKyD7pGkHaC1aQihRN2L
        oGkL6gTE6Ric9p3iNNTXQP7Up8GNkD8jLefDbIB2yg==
X-Google-Smtp-Source: APXvYqyhkVZvSZo6HhOsxdPj6wwKc/pshsSv6FHg+6LnZGg+LxY6AQS3cgQwwHwdcDbBaeh02I/SjTA+bef3JG3wuPY=
X-Received: by 2002:a6b:6e02:: with SMTP id d2mr60291340ioh.22.1578054679297;
 Fri, 03 Jan 2020 04:31:19 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-4-jinpuwang@gmail.com>
 <b13eccdd-09a2-70d5-1c78-3c4dbf1aefe8@acm.org> <CAMGffEmC3T9M+RmeOXX4ecE3E01azjD8fz2Lz8kHC9Ff-Xx-Aw@mail.gmail.com>
 <51f2aec2-db24-ce7b-b3e8-68f9561a584b@acm.org> <20200102182653.GE9282@ziepe.ca>
In-Reply-To: <20200102182653.GE9282@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 3 Jan 2020 13:31:08 +0100
Message-ID: <CAMGffEmwcVU7OTKGbGWiuDV2wmZy6jZyffFyGC9cT=yVF3ky_Q@mail.gmail.com>
Subject: Re: [PATCH v6 03/25] rtrs: private headers with rtrs protocol structs
 and helpers
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 2, 2020 at 7:26 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Jan 02, 2020 at 09:00:53AM -0800, Bart Van Assche wrote:
>
> > > > > +/**
> > > > > + * struct rtrs_msg_conn_req - Client connection request to the server
> > > > > + * @magic:      RTRS magic
> > > > > + * @version:    RTRS protocol version
> > > > > + * @cid:        Current connection id
> > > > > + * @cid_num:    Number of connections per session
> > > > > + * @recon_cnt:          Reconnections counter
> > > > > + * @sess_uuid:          UUID of a session (path)
> > > > > + * @paths_uuid:         UUID of a group of sessions (paths)
> > > > > + *
> > > > > + * NOTE: max size 56 bytes, see man rdma_connect().
> > > > > + */
> > > > > +struct rtrs_msg_conn_req {
> > > > > +     u8              __cma_version; /* Is set to 0 by cma.c in case of
> > > > > +                                     * AF_IB, do not touch that.
> > > > > +                                     */
> > > > > +     u8              __ip_version;  /* On sender side that should be
> > > > > +                                     * set to 0, or cma_save_ip_info()
> > > > > +                                     * extract garbage and will fail.
> > > > > +                                     */
> > > >
> > > > The above two fields and the comments next to it look suspicious to me.
> > > > Does RTRS perhaps try to generate CMA-formatted messages without using
> > > > the CMA to format these messages?
> > > The problem is in cma_format_hdr over-writes the first byte for AF_IB
> > > https://www.spinics.net/lists/linux-rdma/msg22397.html
> > >
> > > No one fixes the problem since then.
> >
> > How about adding that URL to the comment block above struct
> > rtrs_msg_conn_req?
>
> Or just fixing whatever the problem is..
>
> Jason
I can do another try if no one else fix the problem, but I have plenty of to-do.

Thanks
