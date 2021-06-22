Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAA9C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 08:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4200060D07
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 08:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhFVIhe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 04:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhFVIhe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 04:37:34 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8047C061574
        for <linux-block@vger.kernel.org>; Tue, 22 Jun 2021 01:35:17 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id t32so4503857pfg.2
        for <linux-block@vger.kernel.org>; Tue, 22 Jun 2021 01:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=r4SeXLuKmPJHHSSIECPJPtaU6BaiXCnJ5/SGzfZMyX8=;
        b=HYnkVUgR6T+6yI7f8HX2PxHSe9jdw5HkQW4hLZ+85MlGk20trSyTfunE93SviHfJ9/
         /Lkt6PVgzlX2AF4RxhjT2M4rgwdhPj9x9DF8hB8qZTr5ZlKEKxrF5pL9UgObAYcjDhdW
         kDcuGaN1PZTMfmpU8xSnuwX+eO0uiX04suQa2ic11b2zNW13TqzQ+uCcSet4yxhvvn2+
         3BGN2Q08zE5xoizov7HjFgMsTriypmOxzY2ltX5j497bnDL0uwUwnyEYCi8wWLyULBwu
         2VR9EkC217aUcaQwtYiATDMG79emytFD5W7ClDdjicm7KK5A0sXo3bcO9s715QwJ7MsY
         H2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=r4SeXLuKmPJHHSSIECPJPtaU6BaiXCnJ5/SGzfZMyX8=;
        b=NxxB77cY8DPFhvB3tTDhrflmltmZMqRajYXb8Eh0B64pf9BxF6Hhaq/CmUFDocjOda
         0+n5B1BwuEqRjWvlVNKAVVXXRdoGt4JHbrsEiw2nUpDCAm0SDPAX/fd9tNfTZ8yyeKSS
         Ck3FvmJJPx2cpD6ny8/dBqLp+Wh8qNASLx6LxKBFNjDGNNa6zLh2iT0ZeJ2KVMYGUJ7C
         BhSWkSPyR/6orDgRe5grPqXo72Kqxue5UxCLJ1ACKs2BPwF3S0frb2JeL1mB0mhtrdAY
         x0ERI6SDLn4MI+Y9qFP6qt+rEghJxm93rUxAxSHEex1zNgVEJ8GX5fQ19xAQXFP5C87o
         nEIA==
X-Gm-Message-State: AOAM530D0zpr0wIaT1TRSJc8QEltQNB6M+J7qzCr141KX2tVXSlGsCum
        3amLwFAePCdycC49QlR6DgM=
X-Google-Smtp-Source: ABdhPJwFB7Z1V4ra+NhnRFIHmrcz/ZDrnNJg+8OQvtvTB5jbshNc0RKvEOUKlOAF8IWzpe+tB5z4Qw==
X-Received: by 2002:a63:4c5e:: with SMTP id m30mr2690212pgl.153.1624350917380;
        Tue, 22 Jun 2021 01:35:17 -0700 (PDT)
Received: from [10.7.3.1] ([133.130.111.179])
        by smtp.gmail.com with ESMTPSA id f28sm19290841pgb.12.2021.06.22.01.35.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jun 2021 01:35:16 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.6\))
Subject: Re: [PATCH 2/2] block: support bio merge for multi-range discard
From:   Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <20210622065511.GB29691@lst.de>
Date:   Tue, 22 Jun 2021 16:35:11 +0800
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB477D73-2867-4907-8CEC-6EE85A4AAC21@gmail.com>
References: <20210609004556.46928-1-ming.lei@redhat.com>
 <20210609004556.46928-3-ming.lei@redhat.com> <20210622065511.GB29691@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3608.120.23.2.6)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> 2021=E5=B9=B406=E6=9C=8822=E6=97=A5 14:55=EF=BC=8CChristoph Hellwig =
<hch@lst.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Jun 09, 2021 at 08:45:56AM +0800, Ming Lei wrote:
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index bcdff1879c34..65210e9a8efa 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -724,10 +724,10 @@ static inline bool blk_discard_mergable(struct =
request *req)
>> static enum elv_merge blk_try_req_merge(struct request *req,
>> 					struct request *next)
>> {
>> -	if (blk_discard_mergable(req))
>> -		return ELEVATOR_DISCARD_MERGE;
>> -	else if (blk_rq_pos(req) + blk_rq_sectors(req) =3D=3D =
blk_rq_pos(next))
>> +	if (blk_rq_pos(req) + blk_rq_sectors(req) =3D=3D =
blk_rq_pos(next))
>> 		return ELEVATOR_BACK_MERGE;
>=20
> Oh well, this breaks my previous suggestions.
>=20
>> +		struct req_discard_range r;
>> +
>> +		rq_for_each_discard_range(r, req) {
>=20
> ... and I can't say I like this rather complex iterator.
>=20
> What is the problem of just fixing the raid code to not submit =
stupidly
> small discard requests instead?

Yes, raid code should indeed be fixed. However, the way discard
requests are getting merged is not correct.=20

I understand your concern about complex iterator. I believe it is =
because
the difference between discard requests and normal read/write requests.=20=

Discard requests are without data and allowed to be non-contiguous, =
while
normal requests, which blk-merge was originally dealing with, are with=20=

data buffers and should be contiguous. Actually, correct me if wrong, =
the=20
current request struct lacks the ability to express non-contiguous =
bio's.
Ming's patch, by introducing the rq_for_each_discard_range iterator,=20
partially enables the request struct to express non-contiguous bio's.

Cheers,=20

Miao Wang=
