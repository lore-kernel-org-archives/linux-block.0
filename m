Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09C3C43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 17:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA58F22527
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 17:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfLLRYV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:24:21 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:48667 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730088AbfLLRYV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 12:24:21 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MelWf-1i7lLC1jK1-00ajot; Thu, 12 Dec 2019 18:24:19 +0100
Received: by mail-qt1-f170.google.com with SMTP id z15so2928614qts.5;
        Thu, 12 Dec 2019 09:24:19 -0800 (PST)
X-Gm-Message-State: APjAAAXNWJFoxW/3tG6uf0rvrj4UOj2AjOBthaY846LAZtPfFfbsV9Ya
        BLuQD1pdUBYdlih8AQlpdp2c+0Ltv9GDqQOSBxs=
X-Google-Smtp-Source: APXvYqxMSJA4eBINe6o8hxIPSZVoK8eZjs+5+YHcQGDQGqHQfVK1aISujBwoLy+oLB3DI9HdriLYUBFB0Xa25dGmSeY=
X-Received: by 2002:ac8:768d:: with SMTP id g13mr8425301qtr.7.1576171458282;
 Thu, 12 Dec 2019 09:24:18 -0800 (PST)
MIME-Version: 1.0
References: <20191211204306.1207817-1-arnd@arndb.de> <20191211204306.1207817-22-arnd@arndb.de>
 <20191212163040.GD27991@infradead.org>
In-Reply-To: <20191212163040.GD27991@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Dec 2019 18:24:02 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2SCr52MZ7Ch769e0bPA=tjSXj1EXkqr_MDyeioJjnk9w@mail.gmail.com>
Message-ID: <CAK8P3a2SCr52MZ7Ch769e0bPA=tjSXj1EXkqr_MDyeioJjnk9w@mail.gmail.com>
Subject: Re: [PATCH 21/24] compat_ioctl: block: move blkdev_compat_ioctl()
 into ioctl.c
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:E21Utq8Tf2FKFAEeK7tVY7mrXvi63QpJXdoHEjACfdsYe2uh3Tv
 BNwmaOVEPdBz8Z2dFwERTity36sVh/j9qF/OHVYb/uOEJL6yHJNgh0vbeMYIcSv5cekYZ/S
 1wAVA2zpEM5G5O3Rk1xBpej1yIUAp4ctyULPA5BTN+SiPFRNZO3TEfuKLnNF+iCICzjz40P
 02fSwhAZ7iTfWzbApQ0OQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6ZkvHzLdRZw=:k7NDFh/lmPU/ghBQE0XHuT
 xtdKOb+/OLzQifrlp/2LnjPgsbfgI5RGhvuUWZfp5q4udZvmhU+CqYbV2P6DvSJEwqSCdMJwT
 n3eh/hIw89N1OBR7KzRcYmB2kDxTDgOsA/FXhLX2Ln51W2sIgn9mL+LYQixMHfb7R3UCyzGzP
 8n5/3C+FVZUpjQ/UDHDGVtaOdn7E8AUxUEABwJOyhpECXiEN25T8ol95cL4ZzbrdPOXlOGOQB
 O01+IoQEW52UyKGXgfU5Dw4dKl4cVhltco78IPmZvq51VmnwAJgIKpjdHw0dH1XI/yVKJ5ZyT
 YGx84kjH8+UYQNhqvENnmWCUOgQBhyRvcZowJYvbK+RqbHKfZzzL2uUNUTIc6m39j6+NTBezH
 udqlhaW7ATvk69Jif+NPRmgxhp4s2DV5Hi2IZcAyequa0OhziJbqebb7etuMZ29lo8O4Z/Bnh
 fIzuq1jVG9DDWRu6tOZzGfI12VTIf6Aa8hqX0+zxnl9s/Rv/EQ5jph25KS0QRsKZjmBPvxF61
 zRfaUwpoUtxgljaG70dnRavYkFZqMrGGOYxuiLkmFZ73F6M2bLk8i/u79vPngpyTBs3mU+kQf
 xK5ZSkQXnnRV+K6dpCydNcMKhmE604esgn+Ds0Ou9adJyIcg1kalLaJUe832zV92XQEeaSGi0
 DmsMvBqMKTsV1BrbFi0Y6VZNAewx0Sgd8KAcF3eCneQfblHvD9Ezc2/+bHUbpHXkO9OghTQY2
 b8ChC5xVVDJNnoEwPclWj1RdX4o+vMo+7lNzJijT+oH0JiRi3UBjb8rFuTJbjjBKTQ3H+ovFe
 7jahyPVLotn61vpUzBH9BAl6wJN+U8zcpDNe1VKvwK68XkFIo6V4ndd0f9XzH9vwyoQg7npdf
 TWuwkPZNZu0Flst6huNg==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 12, 2019 at 5:30 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +#ifdef CONFIG_COMPAT
> > +static int compat_put_ushort(unsigned long arg, unsigned short val)
> > +{
> > +     return put_user(val, (unsigned short __user *)compat_ptr(arg));
> > +}
> > +
> > +static int compat_put_int(unsigned long arg, int val)
> > +{
> > +     return put_user(val, (compat_int_t __user *)compat_ptr(arg));
> > +}
> > +
> > +static int compat_put_uint(unsigned long arg, unsigned int val)
> > +{
> > +     return put_user(val, (compat_uint_t __user *)compat_ptr(arg));
> > +}
> > +
> > +static int compat_put_long(unsigned long arg, long val)
> > +{
> > +     return put_user(val, (compat_long_t __user *)compat_ptr(arg));
> > +}
> > +
> > +static int compat_put_ulong(unsigned long arg, compat_ulong_t val)
> > +{
> > +     return put_user(val, (compat_ulong_t __user *)compat_ptr(arg));
> > +}
> > +
> > +static int compat_put_u64(unsigned long arg, u64 val)
> > +{
> > +     return put_user(val, (compat_u64 __user *)compat_ptr(arg));
> > +}
> > +#endif
>
> Can we lift these helpers to compat.h instead?

Nothing else uses them, and it's usually more readable to just
use put_user directly.

Note that the next patch removes most of them anyway, but
we could have another cleanup that removes the
put_int()/put_long()/etc from block/ioctl.c altogether.

       Arnd
