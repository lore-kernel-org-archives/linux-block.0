Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F88C49ED7
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 14:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FC12067B
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 14:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="S5eRfVJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbfIPO52 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:57:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33262 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfIPO52 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 10:57:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id b9so5656968wrs.0
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2019 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FjoybZxqlhO6j7YUJJKcSzxvlQi+UbRquVjBeqmyC2c=;
        b=S5eRfVJOWhP5W1QSvt4g1gkUmyEWabYd9Mn/cu8wMEteZNREzuMn1X00jsW4RdoTlq
         eX0VLKOP72egm8OnxhBumEK3Oj1tQqUJ0qgx0IBGihRdcLfl5AnuGpconHCKCRkGyTWx
         zeAGU5WFv1TLArbVx87SCMAQVwVTDu4g/1+a0kcxrEG2psiYiWQIRxNhrFAssJrrjW6/
         AWyh7Gsc/WokE1t7Y+30Xyo0oJEQODEv9bGb06IUewXjAWARGSC21xONVmXGwutLgTmb
         xgBkTb2ZsPoXWO+evcuum3AT9UtA9Zn0xXYx20zo8EaiC55l3dUiiAQfikM9xF8o7vbR
         8njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FjoybZxqlhO6j7YUJJKcSzxvlQi+UbRquVjBeqmyC2c=;
        b=WY7UH2RtjWf0nZ6N2o2wUmBFcqGjlQPNdGRr4q06UjzaRAxR9VbdVi/zSszugWY4Cx
         Ln69XtlW8LMFWUGlac6WoSDZOkWGv6EvEe/uRetfqnf4Zjz7KaEspfm/t9vW+oUvOK0K
         kWKoDBNvQyoN3vbcwLvTOoonzlVJRR1xr/41T4vX8yqYokGdDGqaXvxC6a+zCv3amRTy
         TMYkgdXkYHmWiibu6hnGQMxoUcBgJb1Rfc5jddos4fgJ6eOhNb3w4XY8zCUyB/PNYwVd
         NvGlC5STLFG7R8GatAt5ghuXpM94e6L7FvsMvhQ1Gm7MkLMGEEv3TmJnlV4liKqefxV+
         c/hQ==
X-Gm-Message-State: APjAAAW9ECmsJ/L41SxxeG91BzITP0YrFOAq9JaAQxuMQExkknsslBjP
        ZKo07UuBnaGTV8s8SLSHFqUprcsBlD/7qcTZG9YC8TFs2ug=
X-Google-Smtp-Source: APXvYqzw+p99VUGvMgaRQPud63PDoqaKWLR+7eNkDR13nQz/3Sa0fvN5CR2Oz4v7draPRAWxmuSdZRWgISnjRONDB9U=
X-Received: by 2002:adf:8444:: with SMTP id 62mr190185wrf.202.1568645845836;
 Mon, 16 Sep 2019 07:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-16-jinpuwang@gmail.com>
 <4fbad80b-f551-131e-9a5c-a24f1fa98fea@acm.org> <CAMGffEnVFHpmDCiazHFX1jwi4=p401T9goSkes3j1AttV0t1Ng@mail.gmail.com>
In-Reply-To: <CAMGffEnVFHpmDCiazHFX1jwi4=p401T9goSkes3j1AttV0t1Ng@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 16 Sep 2019 16:57:15 +0200
Message-ID: <CAMGffEmnTG4ixN1Hfy7oY93TgG3qQtF9TkpGzi=BxWm5a2i3Eg@mail.gmail.com>
Subject: Re: [PATCH v4 15/25] ibnbd: private headers with IBNBD protocol
 structs and helpers
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > > +#define _IBNBD_FILEIO  0
> > > +#define _IBNBD_BLOCKIO 1
> > > +#define _IBNBD_AUTOIO  2
> >  >
> > > +enum ibnbd_io_mode {
> > > +     IBNBD_FILEIO = _IBNBD_FILEIO,
> > > +     IBNBD_BLOCKIO = _IBNBD_BLOCKIO,
> > > +     IBNBD_AUTOIO = _IBNBD_AUTOIO,
> > > +};
> >
> > Since the IBNBD_* and _IBNBD_* constants have the same numerical value,
> > are the former constants really necessary?
> Seems we can remove _IBNBD_*.
Sorry, checked again,  we defined _IBNBD_* constants to show the right
value for def_io_mode description.
If we remove the _IBNBD_*, then the modinfo shows:
def_io_mode:By default, export devices in blockio(IBNBD_BLOCKIO) or
fileio(IBNBD_FILEIO) mode. (default: IBNBD_BLOCKIO (blockio))
instead of:
parm:           def_io_mode:By default, export devices in blockio(1)
or fileio(0) mode. (default: 1 (blockio))


> > > +/**
> > > + * struct ibnbd_msg_io_old - message for I/O read/write for
> > > + * ver < IBNBD_PROTO_VER_MAJOR
> > > + * This structure is there only to know the size of the "old" message format
> > > + * @hdr:     message header
> > > + * @device_id:       device_id on server side to find the right device
> > > + * @sector:  bi_sector attribute from struct bio
> > > + * @rw:              bitmask, valid values are defined in enum ibnbd_io_flags
> > > + * @bi_size:    number of bytes for I/O read/write
> > > + * @prio:       priority
> > > + */
> > > +struct ibnbd_msg_io_old {
> > > +     struct ibnbd_msg_hdr hdr;
> > > +     __le32          device_id;
> > > +     __le64          sector;
> > > +     __le32          rw;
> > > +     __le32          bi_size;
> > > +};
> >
> > Since this is the first version of IBNBD that is being sent upstream, I
> > think that ibnbd_msg_io_old should be left out.
After discuss with Danil, we will remove the ibnbd_msg_io_old next round.

Regards,

--
Jack Wang
Linux Kernel Developer
Platform Engineering Compute (IONOS Cloud)
