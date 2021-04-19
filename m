Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759C9C433ED
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 05:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5355C61057
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 05:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhDSFwn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 01:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhDSFwk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 01:52:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAE1C061760
        for <linux-block@vger.kernel.org>; Sun, 18 Apr 2021 22:52:11 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z5so2645545edr.11
        for <linux-block@vger.kernel.org>; Sun, 18 Apr 2021 22:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9Kqj0SIpbacTSWIXobu2nBH/kGtCvihRV1cPJE/Vhw=;
        b=QBDkM/uCbw/Sddq7WI5eixja8rBNgQfAmRCVg+iKFYjxdqDsebb3ZDYogtzJSsPe0V
         DjpV4oACrzDr8/DOn+u/xcSxKTWCe7f3ch24ucKIWxgEh5Nf52vtWzGzLWKPSnZtGJZx
         ou8KtY9GVOm+BargoLpWHBmfcjV38mmHkAdVBaldezkZk2oYU1S0ybf2HRhZwgsKHC9N
         MeNr3q6USSoJQzRrZRJfYPiOWu7nE0QqpbyRuuzig/rcJgB4SDF86K/+IvXrQgblsDP3
         3zTiXONqiZGMRZT07QikoHUHv8ttvXgIP5UpzNTiv37RJZ7ESKVcAxNnR6FQI3MK0zWM
         TZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9Kqj0SIpbacTSWIXobu2nBH/kGtCvihRV1cPJE/Vhw=;
        b=gJUOzIvbcfOq8TDvNoaPyDPRgsAaXqjdCkDCW3yi20c7IjjrQJ2Y1cpi0UUMmtfrMv
         /APhC61JPgxwJnJT9kQOVisIj0/fZJNwO8VAtGbXb712h2jAWKq/POg/0CwtPTE74AYR
         HGsKTCPmx92Ev7gJNwx3smd3Xi7LVwE8V7Srl1/NKAYJrzNu0SHdr6B4kbkdZh6u7xDY
         IV5QfDSstX8SHFsomoWPO5lfSnRRDJrIDpSIwdiyU8sjhs/3v4scghf4PSXEt88wKfQd
         QDdk2HFF8ijZo0bDmajw7DRbwqj9z8SsjAkxOFjnuUJPh9p09X20TgO+Z0O0dzldCvsZ
         hk+A==
X-Gm-Message-State: AOAM530IiTgD0+iCRBIIiJIo7zZ0feHUdP8Guvmwvq5ZuoXQ6w2naqdL
        b2G33YI0STXTfjfi4oxdSEb4OWAvfG1XftJKdf8Hcw==
X-Google-Smtp-Source: ABdhPJwhaoDuCZGIzPayEcPrlmHJmQ9nskuWBGNrC7P9Gp88PJkramqkokFGYx9VlBV7Rw2+3DTz4OQWOU5R1F/+uqc=
X-Received: by 2002:a05:6402:1d3b:: with SMTP id dh27mr4089846edb.220.1618811529672;
 Sun, 18 Apr 2021 22:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210414122402.203388-1-gi-oh.kim@ionos.com> <20210414122402.203388-14-gi-oh.kim@ionos.com>
 <YHvvdskHgQe9gX09@unreal> <CAJX1YtaN3TmwdOE_8UrRuUU=3cCvtQRBX+DmwvU0Tj3nw-knyg@mail.gmail.com>
 <YH0TBlXxU5cq2eO4@unreal>
In-Reply-To: <YH0TBlXxU5cq2eO4@unreal>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Mon, 19 Apr 2021 07:51:34 +0200
Message-ID: <CAJX1Ytb=nFvfy4KNgHDxHaSp+4z3_Wh5EHXXVgg-dcNU39LAwQ@mail.gmail.com>
Subject: Re: [PATCHv4 for-next 13/19] block/rnbd-clt: Support polling mode for
 IO latency optimization
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        hch@infradead.org, sagi@grimberg.me,
        Bart Van Assche <bvanassche@acm.org>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 19, 2021 at 7:46 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Apr 19, 2021 at 07:12:09AM +0200, Gioh Kim wrote:
> > On Sun, Apr 18, 2021 at 10:36 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Wed, Apr 14, 2021 at 02:23:56PM +0200, Gioh Kim wrote:
> > > > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > > >
> > > > RNBD can make double-queues for irq-mode and poll-mode.
> > > > For example, on 4-CPU system 8 request-queues are created,
> > > > 4 for irq-mode and 4 for poll-mode.
> > > > If the IO has HIPRI flag, the block-layer will call .poll function
> > > > of RNBD. Then IO is sent to the poll-mode queue.
> > > > Add optional nr_poll_queues argument for map_devices interface.
> > > >
> > > > To support polling of RNBD, RTRS client creates connections
> > > > for both of irq-mode and direct-poll-mode.
> > > >
> > > > For example, on 4-CPU system it could've create 5 connections:
> > > > con[0] => user message (softirq cq)
> > > > con[1:4] => softirq cq
> > > >
> > > > After this patch, it can create 9 connections:
> > > > con[0] => user message (softirq cq)
> > > > con[1:4] => softirq cq
> > > > con[5:8] => DIRECT-POLL cq
>
> <...>

I am sorry that I don't understand exactly.
Do I need to change them to "con<5..8>"?


>
> > > > +int rtrs_clt_rdma_cq_direct(struct rtrs_clt *clt, unsigned int index)
> > > > +{
> > > > +     int cnt;
> > > > +     struct rtrs_con *con;
> > > > +     struct rtrs_clt_sess *sess;
> > > > +     struct path_it it;
> > > > +
> > > > +     rcu_read_lock();
> > > > +     for (path_it_init(&it, clt);
> > > > +          (sess = it.next_path(&it)) && it.i < it.clt->paths_num; it.i++) {
> > > > +             if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
> > >
> > > We talked about useless likely/unlikely in your workloads.
> >
> > Right, I've made a patch to remove all likely/unlikely
> > and will send with the next patch set.
>
> This specific line is "brand new". We don't add code that will be
> removed in next patch.

Ah, ok. So you mean,
1. remove unlikely from that line
2. send a patch to remove all likely/unlikely for next round

Am I right?
