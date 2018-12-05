Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB68C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 14:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D7420878
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 14:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWNzUdH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D7420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeLEOtz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:49:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32878 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeLEOty (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 09:49:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so19994793wrr.0
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 06:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y6NL1UoZTsfSJaKTTZyXqAcHTkWaKdS1wkbW8foVE8I=;
        b=nWNzUdH3r9f18By5X25AmFK3gmOcSREu94bot0BC+W/9yrkrpO37yFlJSAGEgU9RG2
         qcyXI5vEni9iOHDXlt11ChoY2a0ciE0nrKx14X3wSKjgEFjWJUjSkMVUECsK0vT0U+9n
         x1YpvciGC3poPpGRDSlRuY1j04bHRpbMGktGcnVt4vVVSserBKdhxhtuBcTFzWNTnMM6
         XKURSmA3LcDBv5O3DsQ96e8zywUJAwHUMdsyWtnavrhDkxij+C692BLawW7oI3ZCKDbj
         7FZLzphZoLAvPOTzZDeg9G7goVBLh0CcYy5TK4iEIChKqf1LVm2YyoV/PgYMBd0n9TF0
         N5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y6NL1UoZTsfSJaKTTZyXqAcHTkWaKdS1wkbW8foVE8I=;
        b=HmognZ32vqcPH6fEjEVSmdTi00fsFootZNynGIsMhlKRpWU/TS25Dh37WWV9HCHHDL
         w94XKEWG1I9l1ICKb6f4gESG0xuz8paHNDf0TzYcpmbKYRfsFT5x71ywzXIuQtPKf2Od
         4MVuU92WQS3e55CyHXoK9t+ie4gqK4g3pG4yPXGAUvgde8tEXXA7183ge50prcAHjm9/
         5vj2NYq9FrqLsqFShuYWNu9WzQzTVQL24n6SbSGcp9levxv+/G+4GPwnwA3YwdKwdiNT
         4kQwfQcdOF9x+nYxjNryIKQQ5dTeGEnQM8JLfyrGKyDkWXiK8GyC8JLjv/aEBB8xqbVk
         9ynA==
X-Gm-Message-State: AA+aEWYO8qHO5MZDoXp4mtTbxYmqoYHQ+rQSUJwiVNFd3QbR8n4AnMIS
        D+VwZWkksj+IZ5j9Q+B6FNJ6QwOEo5A59Z/wS74=
X-Google-Smtp-Source: AFSGD/X5QA9M7cLt4DGBUjYtWe6DaY6aw42rYl8SrrTrKfBKJzsv5aSf9j603O5AwB29NHZIdYoL6hSXoF4M4SnpLP8=
X-Received: by 2002:adf:9361:: with SMTP id 88mr21209409wro.204.1544021392835;
 Wed, 05 Dec 2018 06:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20181205141701.GA33910@192.168.3.9> <20181205144006.GA18123@infradead.org>
In-Reply-To: <20181205144006.GA18123@infradead.org>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Wed, 5 Dec 2018 22:49:40 +0800
Message-ID: <CAA70yB5WQPYzptck=miwiBrV7=uixvLKpJrzGEOP9zBU5Y2CwQ@mail.gmail.com>
Subject: Re: [PATCH v3] block: add documentation for io_timeout
To:     hch@infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>, bvanassche@acm.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2018=E5=B9=B412=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:40=E5=86=99=E9=81=93=EF=BC=9A
>
> Can you please also send a patch to not show this attribute for
> drivers without a timeout handler?  Thanks!
>
Do you means checking q->mq_ops->timeout is NULL or not ?

static void blk_mq_rq_timed_out(struct request *req, bool reserved)
{
        req->rq_flags |=3D RQF_TIMED_OUT;
If it's NULL, only re-start a timer for this request in blk_add_timer.
Is there some defect ? if show this attribute and the driver doesn't
support timeout handler =EF=BC=9F

        if (req->q->mq_ops->timeout) {
                enum blk_eh_timer_return ret;

                ret =3D req->q->mq_ops->timeout(req, reserved);
                if (ret =3D=3D BLK_EH_DONE)
                        return;
                WARN_ON_ONCE(ret !=3D BLK_EH_RESET_TIMER);
        }

        blk_add_timer(req);
}


> On Wed, Dec 05, 2018 at 10:17:06PM +0800, Weiping Zhang wrote:
> > Add documentation for /sys/block/<disk>/queue/io_timeout.
> >
> > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > ---
> >  Documentation/ABI/testing/sysfs-block | 10 ++++++++++
> >  Documentation/block/queue-sysfs.txt   |  7 +++++++
> >  2 files changed, 17 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/=
testing/sysfs-block
> > index dea212db9df3..f254a374710a 100644
> > --- a/Documentation/ABI/testing/sysfs-block
> > +++ b/Documentation/ABI/testing/sysfs-block
> > @@ -271,3 +271,13 @@ Description:
> >               size of 512B sectors of the zones of the device, with
> >               the eventual exception of the last zone of the device
> >               which may be smaller.
> > +
> > +What:                /sys/block/<disk>/queue/io_timeout
> > +Date:                November 2018
> > +Contact:     Weiping Zhang <zhangweiping@didiglobal.com>
> > +Description:
> > +             io_timeout is a request=E2=80=99s timeouts at block layer=
 in
> > +             milliseconds. When the underlying driver starts processin=
g
> > +             a request, the generic block layer will start a timer, if
> > +             this request cannot be completed in io_timeout millisecon=
ds,
> > +             a timeout event will occur.
> > diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/=
queue-sysfs.txt
> > index 2c1e67058fd3..f0c9bbce73fd 100644
> > --- a/Documentation/block/queue-sysfs.txt
> > +++ b/Documentation/block/queue-sysfs.txt
> > @@ -67,6 +67,13 @@ If set to a value larger than 0, the kernel will put=
 the process issuing
> >  IO to sleep for this amont of microseconds before entering classic
> >  polling.
> >
> > +io_timeout (RW)
> > +---------------
> > +This is a request=E2=80=99s timeouts at block layer in milliseconds. W=
hen the
> > +underlying driver starts processing a request, the generic block layer
> > +will start a timer, if this request cannot be completed in io_timeout
> > +milliseconds, a timeout event will occur.
> > +
> >  iostats (RW)
> >  -------------
> >  This file is used to control (on/off) the iostats accounting of the
> > --
> > 2.14.1
> >
> ---end quoted text---
