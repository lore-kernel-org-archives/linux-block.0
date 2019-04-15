Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1D9C10F13
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 02:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7C720645
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 02:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIk09Vik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfDOCLN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Apr 2019 22:11:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34471 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfDOCLN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Apr 2019 22:11:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so19734773wrq.1;
        Sun, 14 Apr 2019 19:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1A3oTY0lnlCX0MTy8AOB8pjWhSkIzrEqLzQ/FZzlIfo=;
        b=pIk09VikjsrFv8YfsCf8UncPfH6o1SHtGCRL6KSYtwlDfr5JrU+h02nlzoxm+1RMgK
         l0GlKxxp1xKVxqX6ZOwWSyt0N+UspCRD6rICLwYCFJXhXnYR8fYCITf6dgzO2dI3Sg7/
         a9NqeZi02QyT1SPJaaA48dgO1cQnV3zRtNSoWq/itstyFDDkSeOOhnU91PcG5C93RCL0
         Y2bvcWeLZNUP4kccqb/SpRYSMGHlZHOuqAO6YapYVYBGb2tHazJp9XOVs1xh4cL4KRjR
         DODW7lNw49ZeD1IEHZZExFYQc0rJTwU3aTBoc5eJYJmaVe7d06AI5KZEbZ2/VO9YVfin
         Hccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1A3oTY0lnlCX0MTy8AOB8pjWhSkIzrEqLzQ/FZzlIfo=;
        b=rj7FOjs3fBXLCZZDwJuS66RHlLWPvDIId4g55eojj1q5b5XwUKcfp0+mui38LTNHUx
         e4ueudxiPN4FjC7HbozSSviQGibYER3qWkCXGJIdYPkYGx1dqT1vNT1fJoNIi5BWIWJ3
         MGCzPF3cV6iextHY9ryM4tm6e8vJNvVeYyqmbE/1wsjxRIz+qLetE/DT/2KdIibTiWe9
         tSd+lxyNk9kFUtszzN0zTMbb2qeT3El6S1AYfm8gG91MbX3wEHkP+KN8xeyLcHLwJc4z
         WSwCBL9BOQvExZ6APFd46MBKW6ksNr65gR6mwR8ITW0C4NuKorFICKUSl9HeUCDuo3P9
         7NWg==
X-Gm-Message-State: APjAAAXixd6kLQmKvYBPd6s6mb7bSbxOfvfy7NU+JgBCdsYNZBYDKMG5
        ed1nIGolnqoHOuQ4YrEBejXP0kUrjiW8SW9M06Q=
X-Google-Smtp-Source: APXvYqyI099XNwT5Joq3H6JnswYUOknBZLtbf/OzhlVm8Q7SH9pOgCxlA730mdrNwJymJJXfQhaib4fblGNYvXPVhVs=
X-Received: by 2002:adf:ef0c:: with SMTP id e12mr43970517wro.170.1555294270985;
 Sun, 14 Apr 2019 19:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190415012229.20689-1-ming.lei@redhat.com> <SN6PR04MB4527DD7C84A15184AE5F7947862B0@SN6PR04MB4527.namprd04.prod.outlook.com>
In-Reply-To: <SN6PR04MB4527DD7C84A15184AE5F7947862B0@SN6PR04MB4527.namprd04.prod.outlook.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 15 Apr 2019 10:10:59 +0800
Message-ID: <CACVXFVMa1Zvqm=GYf=4_oB+wTuoKMGaStfsKSTGBbVKACGvGQQ@mail.gmail.com>
Subject: Re: [PATCH] nvme/012 & 013: avoid extremely slow xfs IO
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 15, 2019 at 10:02 AM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> Thanks for the patch Ming. Couple of comments below.
> On 4/14/19 6:22 PM, Ming Lei wrote:
> > It is observed that nvme/012 may take ~17 minutes to complete on aarch64,
> > even worse it may trigger IO timeout on nvme-loop.
> >
> > Eric and Dave replied that it is because of too small log size on small
> > disk.
> >
> > So pass '-l size=32m' to avoid the issue.
> >
> > With this patch, nvme/012 can be completed in one minute.
> >
> Then we should set the QUICK=1 if its taking shorter time.

That should have been a QUICK test, it is fine to set it, but it shouldn't
belong to this patch.

>
> > Cc: Eric Sandeen <esandeen@redhat.com>
> > Cc: Dave Chinner <dchinner@redhat.com>
> > Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> > Cc: linux-xfs@vger.kernel.org
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   tests/nvme/012 | 2 +-
> >   tests/nvme/013 | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/nvme/012 b/tests/nvme/012
> > index 9a6801511df7..d7a8751ec752 100755
> > --- a/tests/nvme/012
> > +++ b/tests/nvme/012
> > @@ -46,7 +46,7 @@ test() {
> >
> >       umount ${mount_dir} > /dev/null 2>&1
> >
> > -     mkfs.xfs -f /dev/"${nvmedev}n1" > /dev/null 2>&1
> > +     mkfs.xfs -l size=32m -f /dev/"${nvmedev}n1" > /dev/null 2>&1
> >
> As a part of this series lets move this to the helper mkfs in the
> nvme/rc and use that call in all the file-backed ns related testcases.
> Let me know if you want me to do that or you would like to do that as a
> part of this series. I'm okay with anything.

I am fine with either way.

Thanks,
Ming Lei
