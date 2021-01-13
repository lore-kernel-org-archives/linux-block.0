Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA16C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 02:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8580923123
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 02:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbhAMCnp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 21:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbhAMCno (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 21:43:44 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66599C061786
        for <linux-block@vger.kernel.org>; Tue, 12 Jan 2021 18:43:04 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id e20so316045vsr.12
        for <linux-block@vger.kernel.org>; Tue, 12 Jan 2021 18:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BjikdSxVJuWtDCApwFIqnQuJzIPxFoxDVd2b4oaxUSY=;
        b=JlI17E+sO+XTZR/W5kqKOp/sZhm4fCRtWa4+1tWhLkK9I+nRkvWiV50g8klS61ww+a
         WCNa95s0HnmRRvsEAVbFJuuo8/ReTZ9QnFPFt3QI50GasK7RXkWcZxvisTH03Sr8Uln6
         6k7Hbb/U9cbTjFL2GCcypUtTfp0B95qvZWR8xaSQFFI6wBZpqSwy6aPT6oh3/tibz1Iz
         x26TQs7eaxl24AYCUk8gnW4ZPFGwUok1W38Nn47kdI7I0qTtTDqGKwWSA36oajsriC9g
         B7RZuKwYye8y8a4So6MYggollLby2as0oixirrCT5FQt+qSYmIdxoq2dxSm5VFFzOZJX
         qMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BjikdSxVJuWtDCApwFIqnQuJzIPxFoxDVd2b4oaxUSY=;
        b=ExlDw76HhiPRvpvhH34Y3kYORxvN7vy+uWxtpKksZyk3/cFxaKe+enI8ov5fqPoH/K
         lcITbx93w2Q3HZy6FjHYhOoyCaA9aeCnTIKHhh4xw/js++P+4H9FSl9d2wvrhSLT5k13
         V0oRyLd24GHX7s5fu7ieHiyHEzKueMwwk7maF/VdLyrBHb2bfC9VBDx8qQj+m/uaUMUI
         CkmeYsK0LOrEkVCZ49uHufocS4L83DBEA7UPhgHmlTPKUbARuf8MuEwufldzngLURAx+
         Ac/1YNNHXoTMVG6WZUFL4OV5xQEaXvBklWxWT4XtuitGNk4iqMCc6OMMpagi8ZVnZWVK
         cHfw==
X-Gm-Message-State: AOAM531d117mLP2v4kZ88KMffjMNv81w+u00Rv0Cf2xx1JqpxbZrKOMm
        VtkCC9y+jK6LUl+URj95SBsYxXjAabP8KZhPGxptFw==
X-Google-Smtp-Source: ABdhPJz55y7jUqnw5KSt0bYT3CU8ooCCqrBfvwWtvPoJYQUcMVmWnxgLCkS8F1kcXG5H0qV7/lP3Ltvza0/hJImzI9A=
X-Received: by 2002:a67:2287:: with SMTP id i129mr93145vsi.15.1610505783440;
 Tue, 12 Jan 2021 18:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20210112152951.154024-1-fengli@smartx.com> <20210112155502.426331-1-fengli@smartx.com>
 <yq1v9c25bm1.fsf@ca-mkp.ca.oracle.com> <CAEK8JBALYE0_OzfhrppF38=dD7HKSn-U0ggPJTGgx5849Gfiiw@mail.gmail.com>
 <DM5PR0401MB3591FDAC44CD5665D6CEBDC39BAA0@DM5PR0401MB3591.namprd04.prod.outlook.com>
 <yq1pn2a59u3.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1pn2a59u3.fsf@ca-mkp.ca.oracle.com>
From:   Li Feng <fengli@smartx.com>
Date:   Wed, 13 Jan 2021 10:42:53 +0800
Message-ID: <CAHckoCwMz2Tqo4ZVkXAmAqfvY1APhqSHDkdS6OPXaqzOMUTh_w@mail.gmail.com>
Subject: Re: [PATCH v2] blk: avoid divide-by-zero with zero granularity
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Feng Li <lifeng1519@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yes, Reject the device is the right fix. I will try to send another fix.
By the way, I think this fix is good protection, maybe some other devices
violate this block size constraint.

Divide zero is unacceptable.

Thanks,
Feng Li

Martin K. Petersen <martin.petersen@oracle.com> =E4=BA=8E2021=E5=B9=B41=E6=
=9C=8813=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=881:48=E5=86=99=E9=81=
=93=EF=BC=9A
>
>
> Johannes,
>
> >> I use the nvme-tcp as the host, the target is spdk nvme-tcp target,
> >> and set a wrong block size(i.g. bs=3D8), then the host prints this oop=
s:
> >
> > I think the better fix here is to reject devices which report a block s=
ize
> > small than a sector.
>
> Yep, Linux doesn't support logical block sizes < 512 bytes.
>
> Also, the NVMe spec states:
>
>         "A value smaller than 9 (i.e., 512 bytes) is not supported."
>
> --
> Martin K. Petersen      Oracle Linux Engineering
