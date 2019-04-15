Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AABBC10F0E
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 05:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93C9206B7
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 05:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gzyn2dfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbfDOFMY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 01:12:24 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:45690 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfDOFMX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 01:12:23 -0400
Received: by mail-pg1-f169.google.com with SMTP id y3so7955149pgk.12
        for <linux-block@vger.kernel.org>; Sun, 14 Apr 2019 22:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L4K4aU5HNMhjFN7wQ9nJ6vruHadfXU7OdAvtrW4T+uo=;
        b=Gzyn2dfZxclgs3jm1/GJPKhM0YaXIiwFg8myjO1eI3UjOO0nUhjFlSM8v0nlr1CNkm
         VekkDHsXq7yteHtO2GCywH0oS0AfStyRsq/QcQF/+uImzH01T36K31a0GHXbbXwMjhdd
         nExD7duYpcScZJ3IPPjbKFutK8Bc2nyUZ1sd1Dn0r6ckPuL6NIuilp5zmCMYQ4RDW/am
         MXiyxPunEQKQdpwHSTJZAZYR/lHFUIV0W9xJazo/n4kBzjSgTz2wutD3uAKOMwrak8Yx
         ajLObrnxCBwhlPLDeASkYE8U5vYLDM7bkwOjjLJhi5NE0Vf2U+bySTDJ79bHfG7ELhYW
         XuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L4K4aU5HNMhjFN7wQ9nJ6vruHadfXU7OdAvtrW4T+uo=;
        b=P0uh2JaWB+V6QVB7L9xfVrldc0O2eEt+lKX8+dC2P57pA0rzyBbiRMZjMCkVyPehzt
         rzHceq7Sw7fOgi3ZnZUkFRFgLujoji97d0mIPy4FLzKABgE3cwKUD0I7DOUG1ttdGp4M
         uxXwKnr3uamct/thagItb5NsoeCY0uSDbwtTnllC0dvg/AmIGfM4rezL9EQunQ2d2LKR
         PBMGciMJyyFdSL8dsXIYIwjsrdawVrvAa6N0h6RYcC6Mc84BjgHvI5mlVlU+dJxpm4uK
         NYPiZuSGpyPkcpD3LvO/PACVZDaBchSGDUPtvocpESW7GaThx/6fhDEZ7wBAYnlFZ/Nz
         qyeg==
X-Gm-Message-State: APjAAAVlk9DyXICu6LaUbg93lQ/qit4qiN/E7CRJS3fM9WPfniFODbXW
        qZcIeBu7Kiym6dyYvTYZzGqDClGXVT0LVtFCWj8=
X-Google-Smtp-Source: APXvYqyCQhxJU3TXXktn10+SuOavcVvM01E3lapfwAP+dQO3AtcYVFPxR7RukjWdlsR3vyPvTGat7cMa+++cC7RokVk=
X-Received: by 2002:a65:44c6:: with SMTP id g6mr17065797pgs.157.1555305143151;
 Sun, 14 Apr 2019 22:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAEK8JBAGxbVan-zsQDmu4upOVzp91fwbCU6cVtXi9D4TUs1p=A@mail.gmail.com>
 <f1e9e648-9321-d4b1-6a25-ea1b611719a8@oracle.com>
In-Reply-To: <f1e9e648-9321-d4b1-6a25-ea1b611719a8@oracle.com>
From:   Feng Li <lifeng1519@gmail.com>
Date:   Mon, 15 Apr 2019 13:11:56 +0800
Message-ID: <CAEK8JBDijX4bnsBUK01PnW0b2zaKQLUaPkV=mFW4FCougc9O7g@mail.gmail.com>
Subject: Re: io_uring is zero copy or not?
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi DongLi,

Thanks for your response.

The 'copy' means the data from userspace buffer could be direct to be
written to the device.
The kernel doesn't need to allocate a new buffer and copy the data in it.
Copy data is a wast for performance.

I don't know the block layer need to allocate a new buffer or not.
From the io_uring.c code, the kernel directly grab the pages of
userspace data buffer through the `get_user_pages`.

Dongli Zhang <dongli.zhang@oracle.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=8815=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8811:21=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
>
> On 4/15/19 11:09 AM, Feng Li wrote:
> > Hi Jens,
> >
> > I'm interested in the io_uring, and have a doubt about it.
> > If I setup io_uring with IORING_REGISTER_BUFFERS,
> > the kernel doesn't need copy data from user space to the kernel, right?
> > Does it mean this is a zero-copy feature?
>
> Doesn't it depends on the definition of 'copy'?
>
> There is still a copy from original userspace pages to the registered buf=
fer?
>
> Dongli Zhang
>
> >
> > From the code, kernel directly get the userspace virtual address's
> > pages and store them:
> >
> > 2475 pret =3D get_user_pages_longterm(ubuf, nr_pages, FOLL_WRITE,
> > 2476 pages, vmas);
> >
> >
> >



--=20
Thanks and Best Regards,
Feng Li(Alex)
