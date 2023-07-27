Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B26C0015E
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 19:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjG0TG3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 15:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjG0TG3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 15:06:29 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7002126
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 12:06:28 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d16639e16e6so1155810276.3
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690484787; x=1691089587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNYthtO4coM06VkbXgx9FdQgyCEMdHOnZ22oxjM3Xjg=;
        b=a8IWofjDACYMVcn80SR2YyQCFsbM4e9NrjKSMVQggbZR3cEj+HXQn0H7BlYpfA5YGk
         Yr8njb/IG8EASJiEmUq/pS+S2hu+MFFu9TRQiQ+ctVH5lCHiExOP3YBNwoDpydyP2kyt
         rOAAPyBLzu85ONENaoe6cz6fRfoW1XDqQuxT4RrGSx6Xg/MQwX6KHqQWuz0XrBYWmX1r
         aMGoldpyaGjXt3mH7fACZzRyaDHppR8DhB5IR8fjvnIFvjREe+m/yw+/BVf5QohNaH/y
         LOzPHshU1bKTAIkeGvzsCmSPXl0zS6g9t3o72hqoheMBfqzGd49tvRfG6RoEfMQcN6Q/
         Zigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690484787; x=1691089587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNYthtO4coM06VkbXgx9FdQgyCEMdHOnZ22oxjM3Xjg=;
        b=QWnhaA3RQ5r9EXoYXT2JXLcStPx54AHTYUi7tThJI9Bb3aBOOvC/H8orwSp/ekJMKs
         J9MwlFyf0ctIeYyHEHXXI8UEw0vW4ZbzNk86JssqR+7DDSSpG/CWH1EG5RqMNyEXDyAf
         RlZ1YvqBEv5Y24zdV51LWWuojPda5C8qkI/i/1ZHliGIA7CYXb0f/GRZ/nqUhwcYUzIO
         DtEHSZr+6fj50mXNPz+tZ0PiqKtC6mWs6oU8pv4jNbBF4pmx7QiYJxTpgsEySjho4X9T
         /bImlVH6WjVwWx8T0omZS4A76ZOW8VB09em80KAQ3CVgaCY9V10J+CXgcO/e1o22JZoa
         z3QQ==
X-Gm-Message-State: ABy/qLa33gysn7LeP269UDzKOPNroi//risOeFnwwjrobAAQL0HWNPeO
        lGFdQRpyK7ewN+IYJ4Zlkh1noBzCV5i8KssggUA=
X-Google-Smtp-Source: APBJJlEdzetiUWH4bqS3KM5O1DtIEE6U9JhilLXxYz7rsM+b4iZR1CkAzuSffnKWT9pnMDnUFheWjfoa3k9j0iNy38o=
X-Received: by 2002:a25:234b:0:b0:d00:7d6d:4767 with SMTP id
 j72-20020a25234b000000b00d007d6d4767mr286102ybj.44.1690484787145; Thu, 27 Jul
 2023 12:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230726193440.1655149-1-bvanassche@acm.org> <20230726193440.1655149-2-bvanassche@acm.org>
 <CAOSviJ0uBynC9M16cRusttU1OaB4HJS8=xmjCGP7bUCMicmiOA@mail.gmail.com> <0880328d-f2ab-beca-a3d4-a7db04123edc@acm.org>
In-Reply-To: <0880328d-f2ab-beca-a3d4-a7db04123edc@acm.org>
From:   Nitesh Shetty <nitheshshetty@gmail.com>
Date:   Fri, 28 Jul 2023 00:36:15 +0530
Message-ID: <CAOSviJ06=avhG=Ww2E=LoNj+P56yuim_2i0sKkbRsCGj5ZYRKA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] block: Introduce the flag QUEUE_FLAG_NO_ZONE_WRITE_LOCK
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 27, 2023 at 8:13=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 7/27/23 03:59, Nitesh Shetty wrote:
> > On Thu, Jul 27, 2023 at 1:39=E2=80=AFAM Bart Van Assche <bvanassche@acm=
.org> wrote:
> >> + * Do not use the zone write lock for sequential writes for sequentia=
l write
> >> + * required zones.
> >> + */
> >> +#define QUEUE_FLAG_NO_ZONE_WRITE_LOCK 8
> >
> > Instead of QUEUE_FLAG_NO_ZONE_WRITE_LOCK I feel
> > QUEUE_FLAG_SKIP_ZONE_WRITE_LOCK is better.
>
> Hmm ... this patch series makes it possible to use an UFS storage
> controller and a zoned UFS device with no I/O scheduler attached. If no
> I/O scheduler is active, there is no zone write locking to skip so I
> think that the former name is better.

Okay, I missed no I/O scheduler.

Thanks,
Nitesh Shetty
