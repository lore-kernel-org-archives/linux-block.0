Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556A5C6FD1D
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 17:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjC0RVY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 13:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjC0RVX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 13:21:23 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FC735A9
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 10:21:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l12so9560470wrm.10
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 10:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679937671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kW0nhN+MJjduSbj2eCKtTmFxk2OT8HS0PznhYbGtPTM=;
        b=jMycVUhHVftLtI83DVEutydlCn4Rnjy9Zw94fQ3pLh9v4gAJGWCoGi4SGiGmIwFKXk
         AILHsKgI4wZpR6OhN0kyNPL0nOGjZbIDSNFS8OIeHC/aB7fX4HelVmX9mhMnQOUr1ZoH
         3fgKsevg5QltWFRp2UeUU/YJpQxPVoNigZM66A4gNYoAMkspuiM+txRy/CqBOxe/MXVl
         BqbQ04AFVWwnKWnlqAbGme2wjb5oJbZyH6BgJgCqgVosWWM/G+/xEY32T4NUfeYW6eSC
         NRUcwrq+s1euMyOcgH4sdLjptVFLZxrhIWJEd9o/UvHTuVO+cAjN5qsK/1il92lFeHLl
         gmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679937671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kW0nhN+MJjduSbj2eCKtTmFxk2OT8HS0PznhYbGtPTM=;
        b=sf6t8dBV8+/JmaQ04ePIItyyI2A8VmTS2lF7IfiiXAPwVtv2zZKJOscI+S0/ZJCpc9
         whhm+tp/XHJFe7U2+jgGUZGKDCugRoOtnSRlDKcbpr7DlVSezFUyRr5t4gto88rEOuGQ
         MCOPDgWrbYPhFZ6vEcD4/jWE1Br++s13wNLYyOiJ+o1U14W+dk5Ww/RFbZ1P+6TlyDaS
         ///eOWs1cMZ2DQL7tu2V5ovdGPhSdaJU8JsN3aGRl2vm0vEbiuWRIdAzAocMc4NJKmP3
         3wsgClntHluZtQR6ouOHuMsfWHTXhaJEfCP5IKOAGsgTloB0l9ExN5NNJSSdZW0IKjHY
         tQgw==
X-Gm-Message-State: AAQBX9chZZ9Nf0elMv8S3zBbiQo1EZxktEl8JoSGg3bJn3ZlxKxW48On
        GTEvmP7KcW0NbxA5hf4TU1Da1sfgvFct6YrpkWQ=
X-Google-Smtp-Source: AKy350a4utJV1mHAd+//ciS/7jPRA+GMjsq8cxwf+CqIVJ08XiMWLibsFdiv8E24YJJYOsY0uLVUfAu06bJvj7678E4=
X-Received: by 2002:a5d:5691:0:b0:2cf:efad:9c23 with SMTP id
 f17-20020a5d5691000000b002cfefad9c23mr2029558wrv.14.1679937671209; Mon, 27
 Mar 2023 10:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230324212803.1837554-1-kbusch@meta.com> <CGME20230324213124epcas5p331ea3c2e2a05ec6a6825e719e47d2427@epcas5p3.samsung.com>
 <20230324212803.1837554-2-kbusch@meta.com> <20230327135810.GA8405@green5> <ZCG0O6RdlA/sUd7C@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZCG0O6RdlA/sUd7C@kbusch-mbp.dhcp.thefacebook.com>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Mon, 27 Mar 2023 22:50:47 +0530
Message-ID: <CA+1E3rK2h9gyy26v1NmwTFtUsCwMkc1DgkDsCFME+HjZJPn5Hg@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: use blk-mq polling for uring commands
To:     Keith Busch <kbusch@kernel.org>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@kernel.dk, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 27, 2023 at 8:59=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Mon, Mar 27, 2023 at 07:28:10PM +0530, Kanchan Joshi wrote:
> > > -   }
> > > +   if (blk_rq_is_poll(req))
> > > +           WRITE_ONCE(ioucmd->cookie, req);
> >
> > blk_rq_is_poll(req) warns for null "req->bio" and returns false if that
> > is the case. That defeats one of the purpose of the series i.e. poll on
> > no-payload commands such as flush/write-zeroes.
>
> Sorry, I'm sending out various patches piecemeal. This patch here depends=
 on
> this one sent out earlier:
>
>   https://lore.kernel.org/linux-block/3f670ca7-908d-db55-3da1-4090f116005=
d@nvidia.com/T/#mbc6174ce3f9dbae38ae2ca646518be4bf105f6e4

That clears it up, thanks.

> > >     rcu_read_lock();
> > > -   bio =3D READ_ONCE(ioucmd->cookie);
> > > -   ns =3D container_of(file_inode(ioucmd->file)->i_cdev,
> > > -                   struct nvme_ns, cdev);
> > > -   q =3D ns->queue;
> > > -   if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_=
bdev)
> > > -           ret =3D bio_poll(bio, iob, poll_flags);
> > > +   req =3D READ_ONCE(ioucmd->cookie);
> > > +   if (req) {
> >
> > This is risky. We are not sure if the cookie is actually "req" at this
> > moment.
>
> What else could it be? It's either a real request from a polled hctx tag,=
 or
> NULL at this point.

It can also be a function pointer that gets assigned on irq-driven completi=
on.
See the "struct io_uring_cmd" - we are tight on cacheline, so cookie
and task_work_cb share the storage.

> It's safe to check the cookie like this and rely on its contents.
Hence not safe. Please try running this without poll-queues (at nvme
level), you'll see failures.
