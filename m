Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9A0C433EF
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 18:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9DC461052
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 18:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhJXSNm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Oct 2021 14:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhJXSNm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Oct 2021 14:13:42 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B907C061745
        for <linux-block@vger.kernel.org>; Sun, 24 Oct 2021 11:11:21 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id w10-20020a4a274a000000b002b6e972caa1so2875289oow.11
        for <linux-block@vger.kernel.org>; Sun, 24 Oct 2021 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=XT3DGlq8VaPrZSJNKmiyYWtU0LhJBDbnzidK5QYIUvo=;
        b=jiJM97w7wL8bVvxiqHS/1rpBptX4/EBR2gmhAtRBWradvk38rGjtZ6GblQ4Q4fgScr
         IarS3Cqo9V9m6sG9YR6Ys59TmKw7ZdZol854dKspBi0GB1ImHRXhvk3dpj06i95fRWCL
         fHn06E0MWCS1kHU1fgO2G6efXaNdiVWov3zHQIS37OSr7URBTniYN2BUjQMmH47aF1Rb
         uf78MOaVi54Xu8JrouSxlLU4qTXlx57G3zXByGXpfZJw+fXbDSYlyiJrAzw4W+ys4OmT
         Uara+JHXR6GzQ2Gf3iiCylnJhm6Oz1oAq+80eEotllnwAWgFHICvfiMPEoVoc3bG2iyQ
         7oCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=XT3DGlq8VaPrZSJNKmiyYWtU0LhJBDbnzidK5QYIUvo=;
        b=b3TNGQAicTCnTR+cYgkBPi2r8Hqwq9SzIY+Ft7w26PoGiJxnc7GOvnxGQlrWVM2iWH
         snwnuMBkzg+DFt7xFX4Lw23fJN1/To1RkLnH74bKt2PkjDeMPawG934Jf0vAwo3hkoTg
         hVP3Bg0RfFp9o5wHazFNVjRU3q03ZiuQViNG92n5+0GHYU/wry4NcXJ7lJjnfovtZ40A
         4ua2hSr534ScPtnD7CO0VKouL25HcaC49ukE7t4aDpxQRU4guUKpFseRIiMFDZW0xto4
         EjupeNyzo5pWpenpksTD9TzFv42HKGYAt0iM+MtxAyacwBJT4Epo28X6iUfA5Ix9ud5v
         n9Sw==
X-Gm-Message-State: AOAM532m/ccEQg/blwGNa7RLQ1j8sIuE9MlO/RzjiiaAo/cZYsjseNkv
        RvWnfQZOaTbff4wLGzE11E6u0A==
X-Google-Smtp-Source: ABdhPJzRb5YcmlR8Y336UYDbNykQ+dh3Blmpe0xceeUf6iAefJoSbXwZNOuD1tfsaJv7TAuuxh13iQ==
X-Received: by 2002:a4a:4548:: with SMTP id y69mr8840509ooa.52.1635099080493;
        Sun, 24 Oct 2021 11:11:20 -0700 (PDT)
Received: from smtpclient.apple ([2600:380:601d:9ab7:99b1:faa9:2042:2f87])
        by smtp.gmail.com with ESMTPSA id c24sm1540603oih.41.2021.10.24.11.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 11:11:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Jens Axboe <axboe@kernel.dk>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 4/5] block: kill unused polling bits in __blkdev_direct_IO()
Date:   Sun, 24 Oct 2021 13:11:13 -0500
Message-Id: <9981D045-BAB1-4361-9A27-5D28195E739A@kernel.dk>
References: <92d445d3-9905-525c-945f-33074ff49fa2@gmail.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
In-Reply-To: <92d445d3-9905-525c-945f-33074ff49fa2@gmail.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
X-Mailer: iPhone Mail (19A404)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 24, 2021, at 12:18 PM, Pavel Begunkov <asml.silence@gmail.com> wrote:=

>=20
> =EF=BB=BFOn 10/24/21 16:09, Jens Axboe wrote:
>>> On 10/23/21 10:46 AM, Pavel Begunkov wrote:
>>> On 10/23/21 17:21, Pavel Begunkov wrote:
>>>> With addition of __blkdev_direct_IO_async(), __blkdev_direct_IO() now
>>>> serves only multio-bio I/O, which we don't poll. Now we can remove
>>>> anything related to I/O polling from it.
>>>>=20
>>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>>> ---
>>>>   block/fops.c | 20 +++-----------------
>>>>   1 file changed, 3 insertions(+), 17 deletions(-)
>>>>=20
>>>> diff --git a/block/fops.c b/block/fops.c
>>>> index 8800b0ad5c29..997904963a9d 100644
>>>> --- a/block/fops.c
>>>> +++ b/block/fops.c
>>>> @@ -190,7 +190,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *ioc=
b, struct iov_iter *iter,
>>>>       struct blk_plug plug;
>>>>       struct blkdev_dio *dio;
>>>>       struct bio *bio;
>>>> -    bool do_poll =3D (iocb->ki_flags & IOCB_HIPRI);
>>>>       bool is_read =3D (iov_iter_rw(iter) =3D=3D READ), is_sync;
>>>>       loff_t pos =3D iocb->ki_pos;
>>>>       int ret =3D 0;
>>>> @@ -216,12 +215,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *io=
cb, struct iov_iter *iter,
>>>>       if (is_read && iter_is_iovec(iter))
>>>>           dio->flags |=3D DIO_SHOULD_DIRTY;
>>>>   -    /*
>>>> -     * Don't plug for HIPRI/polled IO, as those should go straight
>>>> -     * to issue
>>>> -     */
>>>> -    if (!(iocb->ki_flags & IOCB_HIPRI))
>>>> -        blk_start_plug(&plug);
>>>=20
>>> I'm not sure, do we want to leave it conditional here?
>> For async polled there's only one user and that user plug already...
>=20
> It's __blkdev_direct_IO() though, covers both sync and async

Pointless to plug for sync, though.=20


