Return-Path: <SRS0=PBJN=RB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBBFC4360F
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 02:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4736F2184E
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 02:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/wP9VRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfBZCDT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Feb 2019 21:03:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42678 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfBZCDT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Feb 2019 21:03:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id r5so12092082wrg.9;
        Mon, 25 Feb 2019 18:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ECu9fxR/LXXmm4I43rFzUK2NRVuMJX+xarOIPWeQkt0=;
        b=K/wP9VRX3bVgiJUu6sFwrlqCFt2VU8O3AH/4Xeoi3n6N1upbOavhsn096OCxEUWHWV
         beISGsci+9Rdb1KCizBznt70dUiLMa/uceJhIH0HZe5AOVDxFGSbuJ6GxeCiVbKOsxhM
         0ihDpBuP72lc6GPrdrfpXNmcBS/N+nFkkRIkVcT9UFqxI8Mdko5KAnMRYN8e7s27uKYL
         NkYEtfiuE8FXMm/lKPwKCiQanTG+8Mp0HfWODVdmt6BaCu673a+ItXPwZKC6Ow7Maaqm
         exrisT1aLsj6iQZkK+r4baYKzhfqCPjPF6xCuFLm2hjdUgk4a/5TS2EbgppSNZWgCtqv
         Cxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECu9fxR/LXXmm4I43rFzUK2NRVuMJX+xarOIPWeQkt0=;
        b=oRgsPLMKLVLaH/THVjxGKTMZd4r0f5GU25q866TlHfQzqOyYV4zj8qcz8VI1lTA7XC
         sV2ydgLA1b+gNARh3L1h0oIkQ/XbPPJvxtXJhgMhjFkfq+mdyUkLhr5kKjwimXqbFi+R
         zG6HWHdDww3Y+9guYnHt4J2bPfm7d+wyqyYVfakU1c8yTRmI155loe9moYadhUezc0Re
         4NZRaLqVM/oeJqWN+ukKjmK6lF8gMYTxui3QphDyukuVjaTcNu/m/Jr6t6y9YK8agx40
         PQTzOE/X9CRBQoS5JeCpHuR5t04E8MSwbc8h+eTzeUkX4W8m1yWZniUrjFib399LDzYB
         TL5Q==
X-Gm-Message-State: AHQUAubNRsQrAf91GOf6Xr62w4TknkuSfukYdSzPWkq2s9QHBGBVskMH
        o5dlrV+4wY4hZ7JxIc4Q5ybGdrSuaZZ9td/yqC0=
X-Google-Smtp-Source: AHgI3IZZBcY/3rjAIKLnHFCrnouparyNOtZcLv3TPPr60+FDkyNgB/1y+bC3drGPrioJHGLtLDW5eslUSQhnbyyFeQI=
X-Received: by 2002:a5d:668b:: with SMTP id l11mr14219319wru.116.1551146596136;
 Mon, 25 Feb 2019 18:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20190222141311.24694-1-cmaiolino@redhat.com> <CACVXFVOBqTxXrMhqEAvQ8nMe9aYdrevj372_67aiZhXUFxjcgQ@mail.gmail.com>
 <20190225132642.aku3jqnd6bhqrvft@pegasus.maiolino.io>
In-Reply-To: <20190225132642.aku3jqnd6bhqrvft@pegasus.maiolino.io>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 26 Feb 2019 10:03:04 +0800
Message-ID: <CACVXFVOXN1DBMrzF+07xyjJXGG3+t70wiBB_Xfyp_bMoXaeNYg@mail.gmail.com>
Subject: Re: [PATCH] fs: fix guard_bio_eod to check for real EOD errors
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 25, 2019 at 9:26 PM Carlos Maiolino <cmaiolino@redhat.com> wrote:
>
> Hi,
>
> On Sat, Feb 23, 2019 at 07:33:21AM +0800, Ming Lei wrote:
> > Hi Carlos,
> >
> > Cc block list given it is related with interface between fs and block layer.
> >
> > On Fri, Feb 22, 2019 at 10:14 PM Carlos Maiolino <cmaiolino@redhat.com> wrote:
> > >
> > > guard_bio_eod() can truncate a segment in bio to allow it to do IO on
> > > odd last sectors of a device.
> > >
> > > It already checks if the IO starts past EOD, but it does not consider
> > > the possibility of an IO request starting within device boundaries can
> > > contain more than one segment past EOD.
> > >
> > > In such cases, truncated_bytes can be bigger than PAGE_SIZE, and will
> > > underflow bvec->bv_len.
> >
> > It can cause memory corruption even for < PAGE_SIZE, also it can be correct
> > to see > PAGE_SIZE truncated_bytes:
> >
> > - xfs is going to support big block size which may be 64k
> > - multi-page bvec patches have been in block tree, and it is planned to land
> > v5.1, so > PAGE_SIZE truncating may come because .bv_len can be much
> > bigger than PAGE_SIZE
> >
> > - suppose fs block size is 4k, bio sector is 1022 and size is 4k, and
> > disk size is
> > 1024, last bvec is (0, 1024), then 'truncated_bytes' will be 3k, so
> > the check can't
> > capture this case, and memory corruption still may be caused.
> >
> > >
> > > Fix this by checking if truncated_bytes is lower than PAGE_SIZE.
> > >
> > > This situation has been found on filesystems such as isofs and vfat,
> > > which doesn't check the device size before mount, if the device is
> > > smaller than the filesystem itself, a readahead on such filesystem,
> > > which spans EOD, can trigger this situation, leading a call to
> > > zero_user() with a wrong size possibly corrupting memory.
> > >
> > > I didn't see any crash, or didn't let the system run long enough to
> > > check if memory corruption will be hit somewhere, but adding
> > > instrumentation to guard_bio_end() to check truncated_bytes size, was
> > > enough to see the error.
> > >
> > > The following script can trigger the error.
> > >
> > > MNT=/mnt
> > > IMG=./DISK.img
> > > DEV=/dev/loop0
> > >
> > > mkfs.vfat $IMG
> > > mount $IMG $MNT
> > > cp -R /etc $MNT &> /dev/null
> > > umount $MNT
> > >
> > > losetup -D
> > >
> > > losetup --find --show --sizelimit 16247280 $IMG
> > > mount $DEV $MNT
> > >
> > > find $MNT -type f -exec cat {} + >/dev/null
> >
> > BTW, which kernel is  for this issue? Did you investigate why the bad bio
> > is made?
>
> The problem was reproduced, and the patch also wrote based on linux-next tree,
> tag next-20190207.
>
> The bad bio is made while attempting to read the end of a filesystem, which goes
> beyond EOD, as described in the patch description itself, it may happen for
> filesystems which doesn't check the device size before mounting.

OK.

>
> Despite the lack of validation of the block size from the filesystem part, the
> block layer should avoid and deny such invalid IO requests. The fact is, the
> block layer already validates such IO request via
> generic_make_request_checks()->bio_check_eod(), but, before the IO layer could
> reach there, guard_bio_eod() has already corrupted the bio.
>
> >
> > >
> > > Kudos to Eric Sandeen for coming up with the reproducer above
> > >
> > > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > > ---
> > >
> > > P.S. I'm not 100% proficient in bio internals, so I'm not sure if this is the
> > > right fix, so comments are much appreciated.
> > > Thanks
> > >
> > >  fs/buffer.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/fs/buffer.c b/fs/buffer.c
> > > index 784de3dbcf28..32dc5cd2f6ba 100644
> > > --- a/fs/buffer.c
> > > +++ b/fs/buffer.c
> > > @@ -3063,6 +3063,13 @@ void guard_bio_eod(int op, struct bio *bio)
> > >         /* Uhhuh. We've got a bio that straddles the device size! */
> > >         truncated_bytes = bio->bi_iter.bi_size - (maxsector << 9);
> > >
> > > +       /*
> > > +        * The bio contains more than one segment which spans EOD, just return
> > > +        * and let IO layer turn it into an EIO
> > > +        */
> > > +       if (truncated_bytes > PAGE_SIZE)
> > > +               return;
> > > +
> >
> > The correct check should be:
> >
> > +       if (truncated_bytes > bvec->bv_len)
> > +               return;
>
> Thanks, I'll test it.
>
> >
> > Also it should be helpful to warn on this bad bio, but it is fine to not do it
> > here cause block layer logs this bad bio too.
> >
> > BTW, this is just a workaround, not one real fix on the reported problem.
>
> A suggestion of what would be the real fix is much appreciated then.

Seems this issue can't be reproduced in ISO, maybe it is related with
the specific truncated size.

In theory, it is better to return failure during mounting because this fs image
is broken, or the fs code should check the bio during making the bio given
fs has the disk size info. However, maybe either one is hard to implement.

So I think this patch is good, if the check is fixed.

Thanks,
Ming Lei
