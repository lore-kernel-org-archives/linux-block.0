Return-Path: <SRS0=+obT=ZO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B205FC432C3
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 11:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858392075B
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 11:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I5/ELjKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfKVL61 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:58:27 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45002 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfKVL60 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 06:58:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so8241398wrn.11
        for <linux-block@vger.kernel.org>; Fri, 22 Nov 2019 03:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nSBM2hHrNopMs6NCdtJq3fEHutyVsCDd5ikpjIopX/w=;
        b=I5/ELjKv+SNRVTrgeJxhE4BjBAbGtX/Hwc8wWD1Pohdq3jDj1HPn6h2XcREDZ0gJ4b
         YC4TtB+CZcjj0vOhBbnWj8EwL39hxWUjYuBG1ZxYOJ6tZch1KCiNnsBv/BGGUWFau7lG
         GLhxJk4kflvg+kuq+lxH5YnVM/n1OKS7LEkYl+PwHadFWEbd9WKw7bERzBMdVd1yC1Qg
         6HAZaoeB7dK8k1uxpTqUDetyvkzCeZi339fzbKf1BZpTB0PfY5U4qsLRwAgmEjIIaOBP
         mgorPPWonQRWe1b4BGNSwIeMRoVwvjW4XEElXJJrnJPV0/iYnDLCWXJ08brijxCIiJXM
         nioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nSBM2hHrNopMs6NCdtJq3fEHutyVsCDd5ikpjIopX/w=;
        b=IAlxX84r+Y6APq9kNocXvwzqJCfFmxZ2fhz/keby8bnkiYDjwJTjhHYGMDwbjjPaym
         dOFlI3e/KlZE1c1ZM4DR42sYWZx/olZvtZWOPmTIYUVpc02AwpzqUGntfWh0K6q8wSFe
         Ch99a0zvsweykfa2DvvdP6CiOpD/yMzDCqnVdE66Vf7c3w1pLNgtoBntFh/EzvA4s9jt
         iaZRJsGXRw+lIzI9uQOHVvCzUDu6Xrk79SZsy4JwfBh3oPAvXvHoKQP1xUIC/uPRy6/y
         U/tJxOh6xrLBH4Tb+/fRKfogslUAySrdCRnmUzkQIybvrFd8CjsL/q3N1PxTNNzBeK0B
         nYoA==
X-Gm-Message-State: APjAAAUuWTco2WMlcP+AnfseN6muMmgiEKIJIN23skamq+JEb8NYOJ4g
        c8MOJK+2vbpIIOOqHW0lanAvImDM/fNypM0zH4TVxg==
X-Google-Smtp-Source: APXvYqwZn2tu2T7UjYIn/S/2R+X13Jhp/ohKrDEFYRor6MGTymVt9qTYBs5sbb9g21iF3V/pVVpRU6AwEoyiYOJQCXY=
X-Received: by 2002:a05:6000:18c:: with SMTP id p12mr17147636wrx.154.1574423903879;
 Fri, 22 Nov 2019 03:58:23 -0800 (PST)
MIME-Version: 1.0
References: <CAG_fn=VBHmBgqLi35tD27NRLH2tEZLH=Y+rTfZ3rKNz9ipG+jQ@mail.gmail.com>
 <d204a9d7-3722-5e55-d6cc-3018e366981e@kernel.dk>
In-Reply-To: <d204a9d7-3722-5e55-d6cc-3018e366981e@kernel.dk>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 22 Nov 2019 12:58:11 +0100
Message-ID: <CAG_fn=XXsjDsA0_MoTF3XfjSuLCc+6wRaOCY_ZDt661P_rSmOg@mail.gmail.com>
Subject: Re: null_handle_cmd() doesn't initialize data when reading
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 21, 2019 at 3:00 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/15/19 3:16 AM, Alexander Potapenko wrote:
> > Hi Jens,
> >
> > I'm debugging an issue in nullb driver reported by KMSAN at QEMU startu=
p.
> > There are numerous reports like the one below when checking nullb for
> > different partition types.
> > Basically, read_dev_sector() allocates a cache page which is then
> > wrapped into a bio and passed to the device driver, but never
> > initialized.
> >
> > I've tracked the problem down to a call to null_handle_cmd(cmd,
> > /*sector*/0, /*nr_sectors*/8, /*op*/0).
> > Turns out all the if-branches in this function are skipped, so neither
> > of null_handle_throttled(), null_handle_flush(),
> > null_handle_badblocks(), null_handle_memory_backed(),
> > null_handle_zoned() is executed, and we proceed directly to
> > nullb_complete_cmd().
> >
> > As a result, the pages read from the nullb device are never
> > initialized, at least at boot time.
> > How can we fix this?
> >
> > This bug may also have something to do with
> > https://groups.google.com/d/topic/syzkaller-bugs/d0fmiL9Vi9k/discussion=
.
>
> Probably just want to have the read path actually memset() them to
> zero, or something like that.

I'm using the following patch in KMSAN tree to suppress these bugs:

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 0e7da5015ccd5..9e8e99bdc0db3 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1235,8 +1235,16 @@ static blk_status_t null_handle_cmd(struct
nullb_cmd *cmd, sector_t sector,
        if (dev->memory_backed)
                cmd->error =3D null_handle_memory_backed(cmd, op);

-       if (!cmd->error && dev->zoned)
+       if (!cmd->error && dev->zoned) {
                cmd->error =3D null_handle_zoned(cmd, op, sector, nr_sector=
s);
+       } else if (dev->queue_mode !=3D NULL_Q_BIO) {
+               /*
+                * TODO(glider): this is a hack to suppress bugs in nullb
+                * driver. I have no idea what I'm doing, better wait for a
+                * proper fix from Jens Axboe.
+                */
+               cmd->error =3D null_handle_rq(cmd);
+       }

It appears to fix the problem, but I'm not really sure this is the
right thing to do (e.g. whether it covers all invocations of
null_handle_cmd(), probably not)
I don't see an easy way to memset() the pages being read, as there're
no pages at this point.

> --
> Jens Axboe
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
