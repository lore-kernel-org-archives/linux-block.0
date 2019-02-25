Return-Path: <SRS0=QdhR=RA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65068C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Feb 2019 13:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6B3213A2
	for <linux-block@archiver.kernel.org>; Mon, 25 Feb 2019 13:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfBYN0x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:26:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50537 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfBYN0x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Feb 2019 08:26:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id x7so8064636wmj.0
        for <linux-block@vger.kernel.org>; Mon, 25 Feb 2019 05:26:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eEV/eSGqdYj9vts+xd/3vZZiNWhPhKocT1NF1aoU+jI=;
        b=XRhDVhk1mU7Si+3fwJuJM9ff0hAw5c6I4jaWJLJU2gsFzX/jWKP0Oo9WUwKpN4l1pU
         hFNME0oKgQskGGJtR9tkq2zZp+ccYVcH69J8Lbr+qAJET1ZxbFLzD0C9FmGzwgXX92/v
         dgzuOtMcALGg9Gx7l0WQXZ0uDmi7rtp/x8zoKm/H06a+3zeT5vn537UhjJd7/hsQTgiR
         zdtHbCOpYkE56Y76qG++NyTp3UX7CvuOGK/2rw7mPN0zZkTxt+eO1Yaj9i3wyWJO4DG1
         jteiBFnPCOSNA7RgLT3Zmq2rswgaYFGiY4Mgikm3CcM89wMaXNuFo2sTbLvh4C0OlJBf
         t73g==
X-Gm-Message-State: AHQUAuaHs46jk4yM4Ue6mNABX8MQ99EwPZ9MzHoxhFbnyrMEZoCIsg4i
        hIHCF0pvwqyCURWDY3szzPUTbA==
X-Google-Smtp-Source: AHgI3IZhh25RQyZ/4X2Fu/aUycm0c/hzR/CIHl4zAhdwXtyp+LGOYxTeX6lsoFKhNsCOWexTkNGRiA==
X-Received: by 2002:a1c:4d6:: with SMTP id 205mr11296593wme.66.1551101210887;
        Mon, 25 Feb 2019 05:26:50 -0800 (PST)
Received: from pegasus.maiolino.io (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id y20sm11344054wmi.34.2019.02.25.05.26.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Feb 2019 05:26:49 -0800 (PST)
Date:   Mon, 25 Feb 2019 14:26:42 +0100
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] fs: fix guard_bio_eod to check for real EOD errors
Message-ID: <20190225132642.aku3jqnd6bhqrvft@pegasus.maiolino.io>
References: <20190222141311.24694-1-cmaiolino@redhat.com>
 <CACVXFVOBqTxXrMhqEAvQ8nMe9aYdrevj372_67aiZhXUFxjcgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVXFVOBqTxXrMhqEAvQ8nMe9aYdrevj372_67aiZhXUFxjcgQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Sat, Feb 23, 2019 at 07:33:21AM +0800, Ming Lei wrote:
> Hi Carlos,
> 
> Cc block list given it is related with interface between fs and block layer.
> 
> On Fri, Feb 22, 2019 at 10:14 PM Carlos Maiolino <cmaiolino@redhat.com> wrote:
> >
> > guard_bio_eod() can truncate a segment in bio to allow it to do IO on
> > odd last sectors of a device.
> >
> > It already checks if the IO starts past EOD, but it does not consider
> > the possibility of an IO request starting within device boundaries can
> > contain more than one segment past EOD.
> >
> > In such cases, truncated_bytes can be bigger than PAGE_SIZE, and will
> > underflow bvec->bv_len.
> 
> It can cause memory corruption even for < PAGE_SIZE, also it can be correct
> to see > PAGE_SIZE truncated_bytes:
> 
> - xfs is going to support big block size which may be 64k
> - multi-page bvec patches have been in block tree, and it is planned to land
> v5.1, so > PAGE_SIZE truncating may come because .bv_len can be much
> bigger than PAGE_SIZE
> 
> - suppose fs block size is 4k, bio sector is 1022 and size is 4k, and
> disk size is
> 1024, last bvec is (0, 1024), then 'truncated_bytes' will be 3k, so
> the check can't
> capture this case, and memory corruption still may be caused.
> 
> >
> > Fix this by checking if truncated_bytes is lower than PAGE_SIZE.
> >
> > This situation has been found on filesystems such as isofs and vfat,
> > which doesn't check the device size before mount, if the device is
> > smaller than the filesystem itself, a readahead on such filesystem,
> > which spans EOD, can trigger this situation, leading a call to
> > zero_user() with a wrong size possibly corrupting memory.
> >
> > I didn't see any crash, or didn't let the system run long enough to
> > check if memory corruption will be hit somewhere, but adding
> > instrumentation to guard_bio_end() to check truncated_bytes size, was
> > enough to see the error.
> >
> > The following script can trigger the error.
> >
> > MNT=/mnt
> > IMG=./DISK.img
> > DEV=/dev/loop0
> >
> > mkfs.vfat $IMG
> > mount $IMG $MNT
> > cp -R /etc $MNT &> /dev/null
> > umount $MNT
> >
> > losetup -D
> >
> > losetup --find --show --sizelimit 16247280 $IMG
> > mount $DEV $MNT
> >
> > find $MNT -type f -exec cat {} + >/dev/null
> 
> BTW, which kernel is  for this issue? Did you investigate why the bad bio
> is made?

The problem was reproduced, and the patch also wrote based on linux-next tree,
tag next-20190207.

The bad bio is made while attempting to read the end of a filesystem, which goes
beyond EOD, as described in the patch description itself, it may happen for
filesystems which doesn't check the device size before mounting.

Despite the lack of validation of the block size from the filesystem part, the
block layer should avoid and deny such invalid IO requests. The fact is, the
block layer already validates such IO request via
generic_make_request_checks()->bio_check_eod(), but, before the IO layer could
reach there, guard_bio_eod() has already corrupted the bio.

> 
> >
> > Kudos to Eric Sandeen for coming up with the reproducer above
> >
> > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > ---
> >
> > P.S. I'm not 100% proficient in bio internals, so I'm not sure if this is the
> > right fix, so comments are much appreciated.
> > Thanks
> >
> >  fs/buffer.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index 784de3dbcf28..32dc5cd2f6ba 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -3063,6 +3063,13 @@ void guard_bio_eod(int op, struct bio *bio)
> >         /* Uhhuh. We've got a bio that straddles the device size! */
> >         truncated_bytes = bio->bi_iter.bi_size - (maxsector << 9);
> >
> > +       /*
> > +        * The bio contains more than one segment which spans EOD, just return
> > +        * and let IO layer turn it into an EIO
> > +        */
> > +       if (truncated_bytes > PAGE_SIZE)
> > +               return;
> > +
> 
> The correct check should be:
> 
> +       if (truncated_bytes > bvec->bv_len)
> +               return;

Thanks, I'll test it.

> 
> Also it should be helpful to warn on this bad bio, but it is fine to not do it
> here cause block layer logs this bad bio too.
> 
> BTW, this is just a workaround, not one real fix on the reported problem.

A suggestion of what would be the real fix is much appreciated then.

Cheers

> 
> Thanks,
> Ming Lei

-- 
Carlos
