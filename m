Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610A8C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 23:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FA0218A2
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 23:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dt6c/Lac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeLRXsz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:48:55 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43144 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeLRXsz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 18:48:55 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so13622566lff.10
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 15:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6JNUe+1KLYLDTG9gz5ximEZyypROrOAcH4v0ek4GHg=;
        b=dt6c/Lacdpa2VAMKL0GcIIXXKYdFSegEE2UDcOcgLDUrluu4NLaljm2n/TtDCGyn6H
         oAkrWXlAB3DKKxX3naIhVaPNpH3XcfIlFms438jUDsv2Z0BVvSbYLGbeZ7OKAt/LyNnx
         gqyoDz27NZrDuvhefxPPfaaYLKE8CCley64rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6JNUe+1KLYLDTG9gz5ximEZyypROrOAcH4v0ek4GHg=;
        b=ugRRITJjwLiSUkgckrbNEALJ2OqCxO0GmF1YOsLIyvhONhO4FtZOt3++WolK2sdFpU
         gY0bHhvbwit9N9SuPyU1Y22U01VSkCy9Ocs0HOuFtCFoOQkbtZJUfTFL6/075+bNMxZl
         BssQ3ChF0ZXXaAq8IYBFsAaYNvkiP1aUwfcTLpXhSg1Rv37C41Ot9DAuQV8u/pbMmiik
         O54glLLZsMigcYQK1RO5uzqrluLuIgZW7tA0GKPG8xMEQQHspIPkmJdHpG8VVCSV22Tk
         910WuJ9uo1Ywrgn0VgWLTw8dhgJs+O0c6q+C1CpJY0w8FBNueoeasGNxst0EdSQbP9hq
         YIjg==
X-Gm-Message-State: AA+aEWZtBIhSNU8mhGqXX4m9j5y1L5FbswSjOBlCSRpZ5NqhCUotodFl
        YrMYxQY/iGfAyvA7WHnQot9Ag6zDZxI=
X-Google-Smtp-Source: AFSGD/Wri2xh9b6JHy8d1hSTdBMnevMF/qi+9EIdFxYb3Tuph2VqcM1Ouogt8QKw+Z4sCzyRaHqlDQ==
X-Received: by 2002:a19:5e5d:: with SMTP id z29mr10741785lfi.105.1545176933179;
        Tue, 18 Dec 2018 15:48:53 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id q2sm3656915lfa.63.2018.12.18.15.48.52
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 15:48:52 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id p6so13644727lfc.1
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 15:48:52 -0800 (PST)
X-Received: by 2002:a19:1cb:: with SMTP id 194mr10918031lfb.61.1545176931758;
 Tue, 18 Dec 2018 15:48:51 -0800 (PST)
MIME-Version: 1.0
References: <20181030230624.61834-1-evgreen@chromium.org> <20181030230624.61834-3-evgreen@chromium.org>
 <20181128012624.GB11128@ming.t460p> <CAE=gft7Fyq+Jb3ZG3PSTR=C0Wjt3uu57+H2bshM6Gu=_0W0YQw@mail.gmail.com>
 <20181205011059.GA17845@ming.t460p> <CAE=gft7K2OrN93c8TQ5ozOpXzXf5ZD-PNnVHWP9SbZXZqp2dHw@mail.gmail.com>
 <yq1va47pcqp.fsf@oracle.com> <CAE=gft7ymeVu0chvCYWn8tw9ss_pZgyUHt=5sSdxfRenDD46Xw@mail.gmail.com>
In-Reply-To: <CAE=gft7ymeVu0chvCYWn8tw9ss_pZgyUHt=5sSdxfRenDD46Xw@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 18 Dec 2018 15:48:15 -0800
X-Gmail-Original-Message-ID: <CAE=gft7X2D-wiikFUqTpdCi40dP_4h74Z=CX=+917_XuhYWvNA@mail.gmail.com>
Message-ID: <CAE=gft7X2D-wiikFUqTpdCi40dP_4h74Z=CX=+917_XuhYWvNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] loop: Better discard support for block devices
To:     martin.petersen@oracle.com
Cc:     ming.lei@redhat.com, axboe@kernel.dk,
        Gwendal Grignou <gwendal@chromium.org>, asavery@chromium.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 10, 2018 at 9:31 AM Evan Green <evgreen@chromium.org> wrote:
>
> On Wed, Dec 5, 2018 at 7:15 PM Martin K. Petersen
> <martin.petersen@oracle.com> wrote:
> >
> >
> > Evan,
> >
> > > Ah, I see. But I think it's useful to reflect max_discard_sectors,
> > > max_write_zeroes_sectors, discard_granularity, and discard_alignment
> > > from the block device to the loop device. With the exception of
> > > discard_alignment, these parameters are visible via sysfs,
> >
> > discard_alignment is visible in sysfs, just not in the queue directory
> > since alignment can be different on a per-partition basis. So there is
> > one discard_alignment at the root of each /sys/block/foo directory and
> > one for each partition subdirectory. This mirrors the alignment_offset
> > variable which indicates a partitions alignment wrt. the underlying
> > physical block size.
> >
> > That said, there are not many devices that actually report a non-zero
> > discard alignment so it's not as useful as the device manufacturers
> > (that were looking for an implementation shortcut) envisioned.
>
> Ah ok, thanks.
>
> >
> > > I'm not totally sure about discard_alignment, that seems to be useful
> > > in cases of merging blk requests. So I can stop mirroring that one if
> > > it's harmful or not helpful. But unless it's a nak, I'd really love to
> > > keep most of the mirroring. In which case the bool doesn't do a whole
> > > lot of simplifying.
> >
> > I think it's fine to export these. The block device topology was
> > explicitly designed to be stackable like this.
>
> Yeah, it seemed to fall in pretty naturally, which is why I was hoping
> it might not be so controversial. Thanks Martin.

Any other thoughts about this series?

Ming, I did go back and experiment a little. The pseudocode you had
proposed earlier would work, and solve the error prints I was seeing.
But I still would like to keep the reflection of the block device
properties, since that allows discard to be used on block devices that
do support it.
-Evan
