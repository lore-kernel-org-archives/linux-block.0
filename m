Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F48C4360F
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 12:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C8E20882
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 12:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3uKVLRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfDBMn5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:43:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50739 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbfDBMn5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 08:43:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so3273067wmi.0
        for <linux-block@vger.kernel.org>; Tue, 02 Apr 2019 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0ng6k6UZ8JjYVIQVov8orNraBs/ietiVSIfTuzkRdQk=;
        b=R3uKVLRPtx9mlQHQQWWWsIW26PUs/hreLrWyvgp4c6lmS8l/14g7cSOKUFtyGKTKJL
         QkMgHH1amvnestE4DnX2p97HGWUe2j/ip0McF0MDmqw7nqu3X/m3Jvly3GEUbpgXLv+2
         8+rJYZrwj3cZyMwucRrXm5ShSoaiaoQUmXNtl/OGjn5eKayCSoJ96anrZJv3c4KBhMxz
         hUumAm/t907/ps1KbuHXkt1oOcn3dphRCIKI5LB+pLAuiunbD4aKtHGX5oayQHdC5uYn
         UBsnFhOkl7epBLIOoKSVRszb010OKZ/VsWhAZQnaUEZLuoVINlityeMyjr0s5sBYa4N8
         4qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0ng6k6UZ8JjYVIQVov8orNraBs/ietiVSIfTuzkRdQk=;
        b=immJU1j/DhNYk2i6G9Z/pWQ3wV4KYAuTRgIfwfm5/6FDrcR/sebGk1JqXxTcjQhYFA
         /UsrIJAAzLH5b5DsHEDvP2cW1UEgBfpr7E48wYjAaMaT+BIjSgOs9tw3vyWs+wwEauBF
         9QCjxZhzhI60hgnEKbOeQRi2c4/JZ3f7Rp/w6wcfam1keBYF6Q1jTeaFmzGNpUHTm170
         tcZrqgTPV8yV8xMhSoVGJMbM/LRoV9lq9SmNffOkSBKOfbyzRe8onQiy4R/7eAfmxKJL
         MsCS0zLRbDRAciuqh7h9wJCOktdJE7h/gSEfSaBThI8mDNaeYIcB8Nc8bY+/MP9Br6nU
         URWw==
X-Gm-Message-State: APjAAAWLlS5xoYe2CxCvQui0+b8BbVhIJEZ2Xm9fTfcjcKwFUiqauNo5
        J4qsc3aCeIUAXqtvya+uUiK34IRl5zsKsE/Nalc=
X-Google-Smtp-Source: APXvYqxOGGy++/wz/eIQSa+5agUkcQeP3EKMsNBKyWp1pufg0dNVd3Ru/42jLkB5/2DZ+9CwaxdTTxCDqm+dL6ax6GU=
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr3789396wmi.57.1554209035570;
 Tue, 02 Apr 2019 05:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190107125215.GA5039@192.168.3.9> <1546995460.83374.37.camel@acm.org>
 <20190331152824.GA29577@192.168.3.9> <1554158415.118779.126.camel@acm.org>
In-Reply-To: <1554158415.118779.126.camel@acm.org>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Tue, 2 Apr 2019 20:43:42 +0800
Message-ID: <CAA70yB4dFGrObZpiw9tatMB543jnp3uXhS_M7oJWbZfga1GaJA@mail.gmail.com>
Subject: Re: [PATCH] block: don't show io_timeout if driver has no timeout handler
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     weiping zhang <zhangweiping@didichuxing.com>,
        Weiping Zhang <zhangweiping@didiglobal.com>,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bart Van Assche <bvanassche@acm.org> =E4=BA=8E2019=E5=B9=B44=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=886:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, 2019-03-31 at 23:28 +0800, weiping zhang wrote:
> > On Tue, Jan 08, 2019 at 04:57:40PM -0800, Bart Van Assche wrote:
> > > > @@ -942,6 +961,14 @@ int blk_register_queue(struct gendisk *disk)
> > > >           goto unlock;
> > > >   }
> > > >
> > > > + ret =3D sysfs_create_group(&q->kobj, &queue_attr_group);
> > > > + if (ret) {
> > > > +         kobject_del(&q->kobj);
> > > > +         blk_trace_remove_sysfs(dev);
> > > > +         kobject_put(&dev->kobj);
> > > > +         goto unlock;
> > > > + }
> > >
> > > Are you sure the "goto unlock" is OK here? Shouldn't kobject_del() be=
 called
> > > to undo the kobject_add() call if sysfs_create_group() fails?
> >
> > Sorry, can you tell me why it's may be not safe, if goto unlock here,
> > if failed to call sysfs_create_group, I think we should call
> > kobject_del.
>
> Can you address the other comments and repost your patch? I may have misr=
ead
> your patch when I wrote the above comment.
>
Thanks Bart, I post v2 later.
> Thanks,
>
> Bart.
