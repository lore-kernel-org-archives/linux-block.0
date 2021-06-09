Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAD1C47095
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 06:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465D56124C
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 06:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhFIHAL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 03:00:11 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:46819 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbhFIHAL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 03:00:11 -0400
Received: by mail-pj1-f52.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso800055pjb.5
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 23:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3yMOb1xLxlt9vST7EDzu6ffoTa7Kaw/NvhGe5FwxTv8=;
        b=VKDq6Sza/SZfP8YK4iJ6QBXnnU3PgVSRcV/S+60nuBvVQiV9RGVYHKjim/ZdFKG9zh
         XkI3IOXUdXJ0Pud8aKqHr2i4U58ntNevz/Da9bPCxz1YNVxAFC0xwfpLSu9sds5UjIRk
         4d97dwK0mm+KKncnpGgq06zK3Ogz+b4aFzvul+m97o9p5WkERLhtsx0Wf+dSGew3mlY2
         VRwjhc7DimC221yzQc3A08+ETOmlQ/RH5cdtX3BzdAUqOy9k6nxUadsRsrNo6BlLJkcT
         HdM9xK1pX0lUdhRN1291sSA7ZlvIQiSdtcbfChrIGgE7HnBxBIf4b/X+mkBh1Cz0c/aw
         XQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3yMOb1xLxlt9vST7EDzu6ffoTa7Kaw/NvhGe5FwxTv8=;
        b=XAPPW4TZJMlPBZahQaeeu89tj3luEFMoSqtfVRPEqsu75gP5IrdF5QBFGhYQCxO3PJ
         Uo/3op98bGa+WdrBGMoioaDa+eOhc4HFE6oarBZFcSEC41/fk1pYTKcDMcHHcCFZZqtT
         2OyuiSwnJgpDO0WWL+tD7qvbBIlj/Suk+QAvE2ETTlbXCuoN84kgd3aywWbwx5+As8Ud
         EI7KLIHP5+VWA36Fqpbu2ZTnmFHi0xGKYWDok52aYPFUkIFCSEoSKk9QsKKtIbWrGVP1
         5vMK6PTu65TcoqHOE5Uy2wQ/wl7HtwLoWT94ZVUuKI3G9oFjqjPrG68kHmkJVEPDkbjL
         4mdA==
X-Gm-Message-State: AOAM531NcLHu2cJEms2VfcxeVIRTR3b+eIDxePafgFCUb1eq7hTJlcsh
        3PS+Knf379azqIZJQpa33+jDbirZnrg=
X-Google-Smtp-Source: ABdhPJxAM8aH7LOcdehqdJHoEya4BMCZq6QL/tbO/l7VWKWaITHu6Tys/I/f1Z7zS4HOYr8Anf6G6w==
X-Received: by 2002:a17:902:e550:b029:110:3074:e7cd with SMTP id n16-20020a170902e550b02901103074e7cdmr4069425plf.25.1623221837287;
        Tue, 08 Jun 2021 23:57:17 -0700 (PDT)
Received: from [10.7.3.1] ([133.130.111.179])
        by smtp.gmail.com with ESMTPSA id x20sm12158002pfu.205.2021.06.08.23.57.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 23:57:16 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.6\))
Subject: Re: [PATCH 2/2] block: support bio merge for multi-range discard
From:   Wang Shanker <shankerwangmiao@gmail.com>
In-Reply-To: <YMBb0E01P/nXq8fJ@T590>
Date:   Wed, 9 Jun 2021 14:57:11 +0800
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5D9A2192-E24F-4709-BA60-19219B6CEF55@gmail.com>
References: <20210609004556.46928-1-ming.lei@redhat.com>
 <20210609004556.46928-3-ming.lei@redhat.com>
 <AAAB68D1-3F92-4F88-B192-2A202F7CE53D@gmail.com> <YMBb0E01P/nXq8fJ@T590>
To:     Ming Lei <ming.lei@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.6)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> 2021=E5=B9=B406=E6=9C=8809=E6=97=A5 14:12=EF=BC=8CMing Lei =
<ming.lei@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Jun 09, 2021 at 11:05:59AM +0800, Wang Shanker wrote:
>>=20
>>=20
>>> 2021=E5=B9=B406=E6=9C=8809=E6=97=A5 08:45=EF=BC=8CMing Lei =
<ming.lei@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> So far multi-range discard treats each bio as one segment(range) of =
single
>>> discard request. This way becomes not efficient if lots of small =
sized
>>> discard bios are submitted, and one example is raid456.
>>>=20
>>> Support bio merge for multi-range discard for improving lots of =
small
>>> sized discard bios.
>>>=20
>>> Turns out it is easy to support it:
>>>=20
>>> 1) always try to merge bio first
>>>=20
>>> 2) run into multi-range discard only if bio merge can't be done
>>>=20
>>> 3) add rq_for_each_discard_range() for retrieving each =
range(segment)
>>> of discard request
>>>=20
>>> Reported-by: Wang Shanker <shankerwangmiao@gmail.com>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>> block/blk-merge.c          | 12 ++++-----
>>> drivers/block/virtio_blk.c |  9 ++++---
>>> drivers/nvme/host/core.c   |  8 +++---
>>> include/linux/blkdev.h     | 51 =
++++++++++++++++++++++++++++++++++++++
>>> 4 files changed, 66 insertions(+), 14 deletions(-)
>>>=20
>>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>>> index bcdff1879c34..65210e9a8efa 100644
>>> --- a/block/blk-merge.c
>>> +++ b/block/blk-merge.c
>>> @@ -724,10 +724,10 @@ static inline bool blk_discard_mergable(struct =
request *req)
>>> static enum elv_merge blk_try_req_merge(struct request *req,
>>> 					struct request *next)
>>> {
>>> -	if (blk_discard_mergable(req))
>>> -		return ELEVATOR_DISCARD_MERGE;
>>> -	else if (blk_rq_pos(req) + blk_rq_sectors(req) =3D=3D =
blk_rq_pos(next))
>>> +	if (blk_rq_pos(req) + blk_rq_sectors(req) =3D=3D =
blk_rq_pos(next))
>>> 		return ELEVATOR_BACK_MERGE;
>>> +	else if (blk_discard_mergable(req))
>>=20
>> Shall we adjust how req->nr_phys_segments is calculated in=20
>> bio_attempt_discard_merge() so that multiple contiguous bio's can
>> be seen as one segment?
>=20
> I think it isn't necessary, because we try to merge discard IOs first
> just like plain IO. So when bio_attempt_discard_merge() is reached, it
> means that IOs can't be merged, so req->nr_phys_segments should be
> increased by 1.

You are right. And by applying the series, I can confirm contiguous =
bio's
are getting merged into ~20M requests. It's much better than before. I=20=

guess it might be the scheduler that prevents further merging. So it=20
seems that the root solution for raid456 is required since bio merging =
cannot
solve all the problem.

Thanks again for your work.

Cheers,

Miao Wang

