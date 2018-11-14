Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5695AC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 02:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114102089F
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 02:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU2swonN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114102089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeKNM6n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:58:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52156 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbeKNM6n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 07:58:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id w7-v6so13943348wmc.1;
        Tue, 13 Nov 2018 18:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6lWQsLswYNP3N3Z+sz4tSt6luf45YFtf5n8nSTdRdOw=;
        b=RU2swonNCbCeGiQ00zzVYG1emrhiMGCpl9PB8GqMwUmaVyAXY1x0rahJ3jknM2wqLZ
         aMvxCVrUU7K85wZ2PuQkrviz99mi5z7vQsmgybiruHtWLS4/rlzr7DNHWb8NydpqdECJ
         y8LQMZEUQmxnq9rb4NrPVpXSB7Ueo0/jWdJXQV70IYGzn3VgbGoBnFhjI/bfIgp4QjeH
         MCx6Hl5WGnn4VZJw/Qunue1UtLropKagaGvgD55CJb6yjf5s+jFIVYlPGDZ+tNHgN698
         ItyJylqAQB5LQQgl5Yi/p1CFPUBrO1cYYGXpk7blqp3zuWJ0tIHAySrtjcD2UEa0miuu
         RrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6lWQsLswYNP3N3Z+sz4tSt6luf45YFtf5n8nSTdRdOw=;
        b=gBgFcTcqnSpXb1UyYr74/qdhl2AxQOJ4zMOkVr8YVxCnuG1NDmSKv7uXW8oz5DU9qA
         lu4PLWVsSpu1s1vbwrySt95HwCBOYZqCAsr0dQv7v1jsF4nz33+sTjn7CgKapoxFNNIF
         hPMlHL8K0b78IGShNRrWNg8Y2m3J/N5n0jB2X8U++U0jCcQmRbgeKqsyw3duSkXKfjta
         Y7F9jsiluVyvXHBCnmo4mjSm1T2mRNb6yF2SaxkMxOGfA5wSd+Q+b6rHebKMy0MS3O2W
         r4JJFn2q5C4PWV8LDM8dx4pHgEp3qkbDna/IcfBFZzW6HGa6Lc6ydCpQuzcS3jtjj/nf
         A3TA==
X-Gm-Message-State: AGRZ1gJa/a+A/ZXmKTEAN736idsDR6aTbAm5w9Eh0J9H2CxU3ybs93hi
        7/JhTdYyUCsB0YholDHRuZGzsMLFxnCePdOn3Yc=
X-Google-Smtp-Source: AJdET5fYjvFk1uhzK+Gnjc8utjMWkBJiMety1dmnP+xOdvgTtNEqZjfuC7qmGmB+Ysa6EfRusZC2idTdkGLoJB3cgIo=
X-Received: by 2002:a1c:a747:: with SMTP id q68mr361826wme.22.1542164249031;
 Tue, 13 Nov 2018 18:57:29 -0800 (PST)
MIME-Version: 1.0
References: <20181113151505.15498-1-ming.lei@redhat.com> <20181114024455.GE6311@dastard>
In-Reply-To: <20181114024455.GE6311@dastard>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 14 Nov 2018 10:57:16 +0800
Message-ID: <CACVXFVMUzRZ3X7G_EGJ4+dg7F6qhHSF8RhYnkUT+U0b78Ws5xQ@mail.gmail.com>
Subject: Re: [PATCH V9 00/19] block: support multi-page bvec
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 10:46 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Nov 13, 2018 at 11:14:46PM +0800, Ming Lei wrote:
> > Hi,
> >
> > This patchset brings multi-page bvec into block layer:
> >
> > 1) what is multi-page bvec?
>
> Can you please cc this entire patchset to linux-fsdevel? I've only
> received 3-4 of the patches in this series and I can't make head or
> tail of them because I haven't received the rest of the patches.
>
> i.e. if you are going to send the patch 0 to a mailing list, the
> entire patchset should also be sent to that mailing list.

OK, I will do that next time.

If you need me to resend V9, I am fine too, just let me know.

Or you may see all these patches via linux-kernel or the github mentioned
in cover letter.

thanks,
Ming Lei
