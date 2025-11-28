Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9073307AEC
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764324021; cv=none; b=cbb5TH/fyGKN/dj7EYPr8AlFk/oHy8HClxuPlII+OD+qZ8VCVPN80rSaRa3s9R82EUlIEygR4gCayDceawieWrpi+8FsesUkzKtCLl4mbELyUWA0nBiRJuMozbFqcZXu0P+Pbcsg8+MCuiNMjMTcT+yN+eiycEkvB/h1MAWiT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764324021; c=relaxed/simple;
	bh=2eY3okpbAWxgQJFk8s0mpbu2ecKWAz/pM2xQ/tAn7n4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOsduSUqhSLa7gbF40fTfDyXH4oebZRXbFbY63t3kMrCZ5iyBATh+ZxW9v+pSE75JpDpCIiU96vQ2m7R4BwOx0VbRcWb8Q9TxAHbKYv/DfdvU1zkZNTB91MBzrz0e5nE8AT/Z+VT8VAv5W5VHOX1bni6ZVDvVvGsLWhg/tkJqtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mg38oUZJ; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mg38oUZJ"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-55b6a642a4cso1138447e0c.3
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 02:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764324019; x=1764928819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvIpd2OSL7OrAFOV8dFIVxO2cQM+mS0JnOJ3ZPdfBOo=;
        b=mg38oUZJ15Mjht3IvsmS05LSi3Y6BMLAM2D4blrbiJvQMxMPIhAOHK0XfaLLPfvfUk
         K2wMspwMSE7Ma115qXnYioZhDZFeoRlJy6GzvpCBrvlptjblQTcB1pASzujf8oTwdszQ
         AGWyEanL+P8Jr48jhHiFkva5uPhGTsAPgNOyFU7Qsm6lEpwwd5nlfbPxLaDwHCoY7mLQ
         ZdhIztAsXEgAclFlZ5VDMOAFeoGRPNeZKQciIbbfxUQgYN52MDculA35MydsLELDXh17
         3M2I9P57IOv9MM8dGlF5uwZo6sCm70g0i9X1BtQoiKVefI+a/wqZBr03uFVbA2yMq4Zx
         rPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764324019; x=1764928819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NvIpd2OSL7OrAFOV8dFIVxO2cQM+mS0JnOJ3ZPdfBOo=;
        b=dnKw5gZLPiGUnjGm+Oo392jyfBdMqwrBCjlAidYPbOyjpfHWChodToyFmI7wdW3LTW
         LIgNpCkAu7UIAPq2Ig/D9RxIM555qQJfmCfuJ7BcSzhbFenkpkFnRLRiLupuS/F06Ity
         wrLDuCaLdLPmVZc2XeNEdIq3QixeQ2EMGpeA87oN4qcDYy3vbKYVGZJ6s9/lwfwdp1Mb
         4i5h0nfH3G42GlYc6Os1uPApO7VBvJOxBvNpZcpmO0bidto2QTwNtIw8Euxfry0ufivx
         sEkggjznWQ/5l8axft5Q3QTdOwi8hft63mphdsvVQLg6D6T7DD9ADhDKpMoKiT/goPAI
         lafQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk8jQpyncku9Uj+nA+RuZFSsZmKdCfpAIWti1x3kd335d8sOUS6ngmX0aDLx13yaqNJ3ZspKNszVwr6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn7+6Mfe+Hw835cE0CoB/NaV1cDCe3u/joknDEpHvVqcOybBfB
	h0Zq0QHL4QlxMJF0b6dnpmwrgEE97H2wXmLfmzsbbfT8mAdPiftLj7Yqi1whCDwpGIPaHGXB50W
	ZSgbt9jlQILoSK/uj5icwieeQ8pQT0wE=
X-Gm-Gg: ASbGncvkQn6u/hwpNRmk4Yj0VfLXphJdD7SXVhYG3t/8UAJEClZxzyqyMb3YMBiEEzb
	es5Jol0k0PKKoAesd7rsitKpzsRR11ghvv3h+zzc5ih9naG2e3z4Lb5frV01nxSI8NHdKAN79Yn
	vwhMjxSzcWQT2x4LuRaWOxWBBZnr5mGpb0aKwuJ5zo5eXRcf6kXyr5H0KZO7Px1bQc9BxF6fcjx
	qkm4L0KKYfCk/36aifzMSZUHfwmrdCYkDkMj9g6qWFvyI2Ps9zPwP2R1JQOX8nzFqUzVOgp
X-Google-Smtp-Source: AGHT+IHFwsEjN6K+1b9MfYJ0yvGZG9IT3HAMbb98yGWAWsC7ORtaN8oOixFRwjnXB8J2Z5z2aF2iyW8KPc01wzmO1rU=
X-Received: by 2002:a05:6122:30d1:b0:55b:1ac6:6c70 with SMTP id
 71dfb90a1353d-55cd761fa00mr4229493e0c.2.1764324018657; Fri, 28 Nov 2025
 02:00:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128085314.8991-1-changfengnan@bytedance.com> <7dd622b2-b064-4209-a74f-9084ab835cac@fnnas.com>
In-Reply-To: <7dd622b2-b064-4209-a74f-9084ab835cac@fnnas.com>
From: fengnan chang <fengnanchang@gmail.com>
Date: Fri, 28 Nov 2025 18:00:07 +0800
X-Gm-Features: AWmQ_bludSNwTYE3Bu3FjzsXPUJNSAo-e71HcT3iffKHj5Znhoufdt9B3E0B_0w
Message-ID: <CALWNXx86ctj-360U4-a7DAKcNh2j3s9Rg-25i6bBH6RgUT-Dyg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] blk-mq: use array manage hctx map instead of xarray
To: yukuai@fnnas.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, ming.lei@redhat.com, 
	hare@suse.de, hch@lst.de, Fengnan Chang <changfengnan@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 5:55=E2=80=AFPM Yu Kuai <yukuai@fnnas.com> wrote:
>
> Hi,
>
> =E5=9C=A8 2025/11/28 16:53, Fengnan Chang =E5=86=99=E9=81=93:
> > After commit 4e5cc99e1e48 ("blk-mq: manage hctx map via xarray"), we us=
e
> > an xarray instead of array to store hctx, but in poll mode, each time
> > in blk_mq_poll, we need use xa_load to find corresponding hctx, this
> > introduce some costs. In my test, xa_load may cost 3.8% cpu.
> >
> > After revert previous change, eliminates the overhead of xa_load and ca=
n
> > result in a 3% performance improvement.
> >
> > potentital use-after-free on q->queue_hw_ctx can be fixed by use rcu to
> > avoid, same as Yu Kuai did in [1].
>
> Hope I'm not too late for the party. I'm not against for this set, just
> wonder have we considered changing to store hctx directly in bio for
> blk-mq devices, are we strongly against to increase bio size?

I've thought about that put the hctx in the bio, it's a better way, but
increasing the size of the bio, which is now exactly 128 bytes.

>
> >
> > [1] https://lore.kernel.org/all/20220225072053.2472431-1-yukuai3@huawei=
.com/
> >
> > v3:
> > fix build error and part sparse warnings, not all sparse warnings, beca=
use
> > the queue is freezed in __blk_mq_update_nr_hw_queues, only need protect
> > 'queue_hw_ctx' through rcu where it can be accessed without grabbing
> > 'q_usage_counter'.
> >
> > v2:
> > 1. modify synchronize_rcu() to synchronize_rcu_expedited()
> > 2. use rcu_dereference(q->queue_hw_ctx)[id] in queue_hctx to better rea=
d.
> >
> > Fengnan Chang (2):
> >    blk-mq: use array manage hctx map instead of xarray
> >    blk-mq: fix potential uaf for 'queue_hw_ctx'
> >
> >   block/blk-mq-tag.c     |  2 +-
> >   block/blk-mq.c         | 63 ++++++++++++++++++++++++++++-------------=
-
> >   block/blk-mq.h         |  2 +-
> >   include/linux/blk-mq.h | 14 +++++++++-
> >   include/linux/blkdev.h |  2 +-
> >   5 files changed, 58 insertions(+), 25 deletions(-)
> >
> >
> > base-commit: 4941a17751c99e17422be743c02c923ad706f888
>
> --
> Thanks,
> Kuai
