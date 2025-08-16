Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFDC1E0DFE;
	Sat, 16 Aug 2025 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755331546; cv=none; b=XULOmHNLYbbJ2z8M0OuRFgw0G3lzI5UDC0VrXIBSz2bTzqi/2Q8gCUSeHVCDXTfD/OCF9VqRC0EUh6WkAjbkGPK2X0mY2N1gg/mCFdPJZr/tJ+MeR+Eew6UG1+wb3mAnfzu1jMw9x6lm28w8Kcd4+8SUFbuhW8kwF6eF63PEbVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755331546; c=relaxed/simple;
	bh=U2SSg03nIGBIKqiglQlafM0Kg84PROIyCRyrsKXRUqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVdWDpSwoce+ptWSRj8jb9MpXAmTnH+85Tip+OOGhd3n6FIcXdJPzs/VhQNTtDIy3TKOMM88SN+JeLs+b31SQo4zdVMXt9iO6LO5hG452B1ZlJu6D1s5EGmqc+9mhyf80hzQ8LbnBQ6xpa0W2DP++4YyGN9MY5PSgJFCavTnnE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikfWdUZH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikfWdUZH"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-618b83e5b27so1161720a12.3;
        Sat, 16 Aug 2025 01:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755331543; x=1755936343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iu8qk67ZhGdQPwKrGPGRLnb5WCGC7UANE0lK3H9FyDI=;
        b=ikfWdUZHlttAbj2/9Qw5qmZQD19WxKP6pJT+563OEU6HjSFRNteJcNynsUhd+r8vE1
         TPhq2Kb3JCzWm+p3RDCfET3asts6fENH3cLfByg7To4oAYh+JKHrlxOJLh4pXMdiEAWK
         lIEUr7tlWPgLiPdMt9MbbBbsvOpd9I5lyxMA/Y1EZgDO/yEzJTd0dtjoN1mWZ20iqI/9
         B3XJLuZWwWPkPUjIqSTD4zE5mi/ui4WGG9GwpDo643OGSV5Dp4hGebY72KwZsC59j1lh
         Kmm2UB47kz43YY/HyzUK35RGoSkuRB6YCaCPsBBRyEOKTzvaDNBBBxGT7NFdgYi93RJe
         j1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755331543; x=1755936343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iu8qk67ZhGdQPwKrGPGRLnb5WCGC7UANE0lK3H9FyDI=;
        b=PDFwyGsPX2sx1jYNuSOurokH1mDulRWNFd4OlFQH5HHEzC6KmuK/ao7z1AAPgimw7z
         CKWSKSPCb7vi1j281WIK0/OqNgzzyn7bERDI3KC75NIsh7EIV2AHS6w8a0MPmkEC9jP1
         wPMy9F7I/j4FSToDu4g7b4Z3yXlznGCvkKCeytYJj/IHt3j7ybem8FA2SJu5nunh1Bfe
         bsTLDD5C8yLLmgbRAnW84Wb1WMMWbuGnYYCzLZd4PQ/bP0PWMH4nl6LybkMVK+d1lHw4
         thrjBuhkKp3kn6M0z7/MNNMHN8YclfcknC724Mbq2P2CKpb2XeRutQ1pRjh16R0lY1EQ
         QPKw==
X-Forwarded-Encrypted: i=1; AJvYcCVUse0bpMQtyEynPjpom2as930Poy0N2O863hBr+SYfdoM7ONXsndKmyUaFPs9Ub9erzWrNnvO/cToveQ==@vger.kernel.org, AJvYcCW0JL9NRc6jm0sNUFr2syvsjkepJ37h+bv1AybcQ9zMq54TV7EwahHgPaWdFudmA86rWKqu5Z2mBNoHv8aF@vger.kernel.org
X-Gm-Message-State: AOJu0YwR5TAjz138LgdNZ7mtKACcrEF8xxj1l0T83UdXAapCwNVqtN3P
	FITFP8MYaO2SfihC20t1T5aWNZL4lUL6ybyTXBfoALFJSuC8D+woeg4T+vpPSqf6j9W5kQrTKEX
	tRgsck1HQhOK1seAWbOFBi4F7nAvNIQkO/n+v24Vhng==
X-Gm-Gg: ASbGnct029XwH9UYLNyRScSMo0NBSLfpVKeQA6zpaGIFkz43+/OjwAgYJKLUObtBn14
	dsKyW3ATLOg1nlZcWqLA1EcPCqAMRziVIaBSrcckCEgSQJHFCdncHV6kmKKlsBEHazN3yvrw3CB
	c6C98NZsvxgqbwI+++6/JpLBjuaRkOTtMxUe2oN3tBc8gitz+bsGC81ccsLzZkriTuTuGX1lEyS
	xfzFKYpYkK1VCgF+g==
X-Google-Smtp-Source: AGHT+IFzd8xKXP7bDXIZU1nuy/Eby5dLIYrSTouaWv1oG/qsf/u1d+oiyF0QURCaJxNuj+dRHzEcCCBb9Vdzf3ArNQ0=
X-Received: by 2002:a05:6402:34ce:b0:615:793b:dbff with SMTP id
 4fb4d7f45d1cf-618b051c486mr3708870a12.13.1755331542438; Sat, 16 Aug 2025
 01:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815080216.410665-1-yukuai1@huaweicloud.com>
 <20250815080216.410665-9-yukuai1@huaweicloud.com> <c5e63966-e7f6-4d82-9d66-3a0abccc9d17@linux.ibm.com>
 <af40ef99-9b61-4725-ba77-c5d3741add99@kernel.org> <aKADe9hNz99dQTfy@fedora>
In-Reply-To: <aKADe9hNz99dQTfy@fedora>
From: =?UTF-8?B?5L2Z5b+r?= <yukuai1994@gmail.com>
Date: Sat, 16 Aug 2025 16:05:30 +0800
X-Gm-Features: Ac12FXzQrVaUH-b5nKOXfJDOP2e4IT8LOtgHbo2GjHVDidU-3EQ2YVM_5bzKmaY
Message-ID: <CAHW3DrjPEHX=XmPCQDBLJoXmnjz3GKsht33o-S6tH-tNb-_WQQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] blk-mq: fix blk_mq_tags double free while
 nr_requests grown
To: Ming Lei <ming.lei@redhat.com>
Cc: Yu Kuai <yukuai@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>, 
	Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, hare@suse.de, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2025=E5=B9=B48=E6=9C=8816=E6=97=A5=
=E5=91=A8=E5=85=AD 12:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Aug 16, 2025 at 10:57:23AM +0800, Yu Kuai wrote:
> > Hi,
> >
> > =E5=9C=A8 2025/8/16 3:30, Nilay Shroff =E5=86=99=E9=81=93:
> > >
> > > On 8/15/25 1:32 PM, Yu Kuai wrote:
> > > > From: Yu Kuai <yukuai3@huawei.com>
> > > >
> > > > In the case user trigger tags grow by queue sysfs attribute nr_requ=
ests,
> > > > hctx->sched_tags will be freed directly and replaced with a new
> > > > allocated tags, see blk_mq_tag_update_depth().
> > > >
> > > > The problem is that hctx->sched_tags is from elevator->et->tags, wh=
ile
> > > > et->tags is still the freed tags, hence later elevator exist will t=
ry to
> > > > free the tags again, causing kernel panic.
> > > >
> > > > Fix this problem by using new allocated elevator_tags, also convert
> > > > blk_mq_update_nr_requests to void since this helper will never fail=
 now.
> > > >
> > > > Meanwhile, there is a longterm problem can be fixed as well:
> > > >
> > > > If blk_mq_tag_update_depth() succeed for previous hctx, then bitmap=
 depth
> > > > is updated, however, if following hctx failed, q->nr_requests is no=
t
> > > > updated and the previous hctx->sched_tags endup bigger than q->nr_r=
equests.
> > > >
> > > > Fixes: f5a6604f7a44 ("block: fix lockdep warning caused by lock dep=
endency in elv_iosched_store")
> > > > Fixes: e3a2b3f931f5 ("blk-mq: allow changing of queue depth through=
 sysfs")
> > > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > > ---
> > > >   block/blk-mq.c    | 19 ++++++-------------
> > > >   block/blk-mq.h    |  4 +++-
> > > >   block/blk-sysfs.c | 21 ++++++++++++++-------
> > > >   3 files changed, 23 insertions(+), 21 deletions(-)
> > > >
> > > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > > index 11c8baebb9a0..e9f037a25fe3 100644
> > > > --- a/block/blk-mq.c
> > > > +++ b/block/blk-mq.c
> > > > @@ -4917,12 +4917,12 @@ void blk_mq_free_tag_set(struct blk_mq_tag_=
set *set)
> > > >   }
> > > >   EXPORT_SYMBOL(blk_mq_free_tag_set);
> > > > -int blk_mq_update_nr_requests(struct request_queue *q, unsigned in=
t nr)
> > > > +void blk_mq_update_nr_requests(struct request_queue *q,
> > > > +                        struct elevator_tags *et, unsigned int nr)
> > > >   {
> > > >           struct blk_mq_tag_set *set =3D q->tag_set;
> > > >           struct blk_mq_hw_ctx *hctx;
> > > >           unsigned long i;
> > > > - int ret =3D 0;
> > > >           blk_mq_quiesce_queue(q);
> > > > @@ -4946,24 +4946,17 @@ int blk_mq_update_nr_requests(struct reques=
t_queue *q, unsigned int nr)
> > > >                                   nr - hctx->sched_tags->nr_reserve=
d_tags);
> > > >                   }
> > > >           } else {
> > > > -         queue_for_each_hw_ctx(q, hctx, i) {
> > > > -                 if (!hctx->tags)
> > > > -                         continue;
> > > > -                 ret =3D blk_mq_tag_update_depth(hctx, &hctx->sche=
d_tags,
> > > > -                                               nr);
> > > > -                 if (ret)
> > > > -                         goto out;
> > > > -         }
> > > > +         blk_mq_free_sched_tags(q->elevator->et, set);
> > > I think you also need to ensure that elevator tags are freed after we=
 unfreeze
> > > queue and release ->elevator_lock otherwise we may get into the lockd=
ep splat
> > > for pcpu_lock dependency on ->freeze_lock and/or ->elevator_lock. Ple=
ase note
> > > that blk_mq_free_sched_tags internally invokes sbitmap_free which inv=
okes
> > > free_percpu which acquires pcpu_lock.
> >
> > Ok, thanks for the notice. However, as Ming suggested, we might fix thi=
s
> > problem
> >
> > in the next merge window.
>
> There are two issues involved:
>
> - blk_mq_tags double free, introduced recently
>
> - long-term lock issue in queue_requests_store()
>
> IMO, the former is a bit serious, because kernel panic can be triggered,
> so suggest to make it to v6.17. The latter looks less serious and has
> existed for long time, but may need code refactor to get clean fix.
>
> > I'll send one patch to fix this regression by
> > replace
> >
> > st->tags with reallocated new sched_tags as well.
>
> Patch 7 in this patchset and patch 8 in your 1st post looks enough to
> fix this double free issue.
>
But without previous refactor, this looks hard. Can we consider the followi=
ng
one line patch for this merge window? just fix the first double free
issue for now.

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index d880c50629d6..1e0ccf19295a 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -622,6 +622,7 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
                        return -ENOMEM;

                blk_mq_free_map_and_rqs(set, *tagsptr, hctx->queue_num);
+               hctx->queue->elevator->et->tags[hctx->queue_num]=3D new;
                *tagsptr =3D new;
        } else {
                /*

>
> Thanks,
> Ming
>
>
