Return-Path: <SRS0=ntoj=XG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5D4C49ED6
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 09:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BE92075C
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 09:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+FubhSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfIKJ4v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:56:51 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34472 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfIKJ4v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 05:56:51 -0400
Received: by mail-qk1-f194.google.com with SMTP id q203so20198639qke.1;
        Wed, 11 Sep 2019 02:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbOJQdjzyccaSb6mfd+E5KOchM3Q8NLZ/FNshUuA6q4=;
        b=s+FubhSIf3tOMGNDgXOMZWXr98x8fyiHUQsmu3h8v+9+SJgo5khMS0IlpMWR04/iZR
         4sQmy5V5Hd6D/qegn1mayzJYc7x09OG4ABCm8G0A9sX75h8JLszaGvQAThXs+5MyGXcg
         Eu92hjIbSNMZjCfpayb4lgXaXeNUVC3JoWoiuRKRSLaLfRC/BPch0BpS4cibqxQodW5K
         TO3MhEtL0j8ihjy+xZ8aJqYhBDaytB1pC/SuKWTGGM8qj/OSYfK7NgKPPO2254Ktxjbs
         Zqrb3jQZKlOJAaeUhu/fw2BjlbrLXY2UFPVuQohAdsQGmwv3fdw5d+cv5HPxYpKirZQZ
         nf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbOJQdjzyccaSb6mfd+E5KOchM3Q8NLZ/FNshUuA6q4=;
        b=EWVyyVIEhnXMakIpsszqNvqNIIVCK76nGfOO9osq2J3mTXHgZYqIh/FY+UQLPdB6rg
         +berzdUwo4lddSB0/3FbJUVgE9me8U7lcrv2hHpX7UXzwPK3uRDIHP/V5xXdVbO8/M/t
         Tto6cXdW+0wXnsCTzsqk+G7yPF3rqJAjLAGBYyQAYBW8AC4xPr7ncP66CQCvp5dTCFFM
         Qg7+T5t1a9r+QkUS1/MhD/tRo9kskbcbhXXSix4QgmC1qgb+8ARVENnQmxKe+RCLAZNl
         YpwEy4Vnnno8igrmOT6NX9mP66jSEMkqU7ByaMHaKfIWG+dGMxhxkG9Ck2Vso2kANnO0
         DxQA==
X-Gm-Message-State: APjAAAVzipa5x7M9lXfXCebfCk9msCcDGnJSKvIvObGXZfA4Qrri2hbH
        12EHA7McxXwdpq7yDobySkI6EcGd/33H4V98xe4=
X-Google-Smtp-Source: APXvYqy495AoitoVWFQXwZRElfdaaJVf/Xgn2Xz0X9IENf3ngd7rGaiycbhywm0HBEFVWGJdvcrS9lZ0YqoR5kbf1nE=
X-Received: by 2002:a37:4c9:: with SMTP id 192mr35467011qke.177.1568195809535;
 Wed, 11 Sep 2019 02:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <10ca59ff-f1ba-1464-030a-0d73ff25d2de@suse.de> <87blwghhq7.fsf@notabene.neil.brown.name>
 <FBF1B443-64C9-472A-9F41-5303738C0DC7@fb.com> <f3c41c4b-5b1d-bd2f-ad2d-9aa5108ad798@suse.de>
 <9008538C-A2BE-429C-A90E-18FBB91E7B34@fb.com> <bede41a5-45c5-0ea0-25af-964bb854a94c@suse.de>
 <87pnkaardl.fsf@notabene.neil.brown.name> <242E3FBD-C969-44E1-8DC7-BFE9E7CBE7FD@fb.com>
 <87ftl5avtx.fsf@notabene.neil.brown.name> <33AD3B45-E20D-4019-91FA-CA90B9B3C3A9@fb.com>
 <58722139-ebc0-f49f-424a-c3b1aa455dd8@cloud.ionos.com> <877e6fbvh2.fsf@notabene.neil.brown.name>
In-Reply-To: <877e6fbvh2.fsf@notabene.neil.brown.name>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 11 Sep 2019 10:56:37 +0100
Message-ID: <CAPhsuW6obHkwKdYU=dt2x0t4kPK=eMfXO6S3a79i4PnMgskcqg@mail.gmail.com>
Subject: Re: [PATCH] md/raid0: avoid RAID0 data corruption due to layout confusion.
To:     NeilBrown <neilb@suse.de>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <songliubraving@fb.com>,
        Guoqing Jiang <jgq516@gmail.com>, Coly Li <colyli@suse.de>,
        NeilBrown <neilb@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 11, 2019 at 12:10 AM NeilBrown <neilb@suse.de> wrote:
>
> On Tue, Sep 10 2019, Guoqing Jiang wrote:
>
> > On 9/10/19 5:45 PM, Song Liu wrote:
> >>
> >>
> >>> On Sep 10, 2019, at 12:33 AM, NeilBrown <neilb@suse.de> wrote:
> >>>
> >>> On Mon, Sep 09 2019, Song Liu wrote:
> >>>
> >>>> Hi Neil,
> >>>>
> >>>>> On Sep 9, 2019, at 7:57 AM, NeilBrown <neilb@suse.de> wrote:
> >>>>>
> >>>>>
> >>>>> If the drives in a RAID0 are not all the same size, the array is
> >>>>> divided into zones.
> >>>>> The first zone covers all drives, to the size of the smallest.
> >>>>> The second zone covers all drives larger than the smallest, up to
> >>>>> the size of the second smallest - etc.
> >>>>>
> >>>>> A change in Linux 3.14 unintentionally changed the layout for the
> >>>>> second and subsequent zones.  All the correct data is still stored, but
> >>>>> each chunk may be assigned to a different device than in pre-3.14 kernels.
> >>>>> This can lead to data corruption.
> >>>>>
> >>>>> It is not possible to determine what layout to use - it depends which
> >>>>> kernel the data was written by.
> >>>>> So we add a module parameter to allow the old (0) or new (1) layout to be
> >>>>> specified, and refused to assemble an affected array if that parameter is
> >>>>> not set.
> >>>>>
> >>>>> Fixes: 20d0189b1012 ("block: Introduce new bio_split()")
> >>>>> cc: stable@vger.kernel.org (3.14+)
> >>>>> Signed-off-by: NeilBrown <neilb@suse.de>
> >>>>
> >>>> Thanks for the patches. They look great. However, I am having problem
> >>>> apply them (not sure whether it is a problem on my side). Could you
> >>>> please push it somewhere so I can use cherry-pick instead?
> >>>
> >>> I rebased them on block/for-next, fixed the problems that Guoqing found,
> >>> and pushed them to
> >>>   https://github.com/neilbrown/linux md/raid0
> >>>
> >>> NeilBrown
> >>
> >> Thanks Neil!
> >
> > Thanks for the explanation about set the flag.
> >
> >>
> >> Guoqing, if this looks good, please reply with your Reviewed-by
> >> or Acked-by.
> >
> > No more comments from my side, but I am not sure if it is better/possible to use one
> > sysfs node to control the behavior instead of module parameter, then we can support
> > different raid0 layout dynamically.
>
> A strength of module parameters is that you can set them in
>   /etc/modprobe.d/00-local.conf
> and then they are automatically set on boot.
> For sysfs, you need some tool to set them.
>
> >
> > Anyway, Acked-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> >

I am adding the following change to the 1/2. Please let me know if it doesn't
make sense.

Thanks,
Song

diff --git i/drivers/md/raid0.c w/drivers/md/raid0.c
index a9fcff50bbfc..54d0064787a8 100644
--- i/drivers/md/raid0.c
+++ w/drivers/md/raid0.c
@@ -615,6 +615,10 @@ static bool raid0_make_request(struct mddev
*mddev, struct bio *bio)
        case RAID0_ALT_MULTIZONE_LAYOUT:
                tmp_dev = map_sector(mddev, zone, sector, &sector);
                break;
+       default:
+               WARN("md/raid0:%s: Invalid layout\n", mdname(mddev));
+               bio_io_error(bio);
+               return true;
        }

        if (unlikely(is_mddev_broken(tmp_dev, "raid0"))) {
