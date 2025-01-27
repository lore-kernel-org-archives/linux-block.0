Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEF05227
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737987557; cv=none; b=hLb8QQ63jCKFRy7dVvUt0Cs2cj9gLHmgAxvyxl2liqb05lydj9Ep2/nmDprqJ09I4XojzeooaA2TBYgDyXQJjXoMgUTTYv6+cn8zw4kJF1nkj+PXfKkOu+RBZ2YtUAuAvJQMNgZjclcIc3Er80gBKzBMCWRnsDAOMfH2ZMU+1os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737987557; c=relaxed/simple;
	bh=TtVETOkjVQNiuB6BExHpYfE5R9ivpefpJx1OeZeUvfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDf/xJdqeTITPdja6P0yw1wV6AVO6u9n5krdz72OWKTCMxEiAiky7D9G8vBkXQI6Fyf5mDjFU7uVsAm2XI2UYe/uIkvk8XqeTqGI/5ade+6efW+nbtLCBcmBRzcIZR9bs8+C2CNJPY1vHp8pKvh/ozp8Eo/izIiwHzvYptkFu9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com; spf=none smtp.mailfrom=owltronix.com; dkim=pass (2048-bit key) header.d=owltronix-com.20230601.gappssmtp.com header.i=@owltronix-com.20230601.gappssmtp.com header.b=K+kSSmz5; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=owltronix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20230601.gappssmtp.com header.i=@owltronix-com.20230601.gappssmtp.com header.b="K+kSSmz5"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dc052246e3so9168106a12.2
        for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 06:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20230601.gappssmtp.com; s=20230601; t=1737987554; x=1738592354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8JswBiIDdf2ONRiHmThNOEcSiIxwep3mEKDcXVvDhg=;
        b=K+kSSmz5JXbiYRdFHWoUT/GTI33nFlJLx2v/Tny3l2RW6NWEVUfBCk6G2ZpcSQkt8a
         A7NXf2l4jv4FCBb4FVCRYw1rBBNTIvKISAt7ukh9bOy6AfBYn/bZY2zQDfGi/5Fm8XKf
         wdzyzkk1+p97o0v3JQN/1HfxiOwDguadMcCYHFzrWJQX5kpI8LvpQc7Vl7A8+9AWDnb2
         Vq9KLRYUru/p5uifgjySjnoCXhUWzXY/qvyUmZsK3ISRQe65CXXl8kd0r3MD5ZNIH4AY
         brLdCgOEVomNMdjYAOhnOrQJhh7LpPN0H4zm/C0ZLt1/g8jsZpeRJtGCQPHVcqfMF10B
         hSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737987554; x=1738592354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8JswBiIDdf2ONRiHmThNOEcSiIxwep3mEKDcXVvDhg=;
        b=NOyHSGLFEz2ZgZos61AUghOVWa4534wgnYQHUgmErajYnJwGGYLPRLMO/R+QIYCsCZ
         nRPBjHzPArX1DgTgs8wR1EcU0DGvXD0gSAjSuDgOQf2exLqI4JoYmGbJg1eRu7D6arLU
         Fh9BU+mQpJ18Y1Qjfy9sIp2iJFbdcbSxBPRpLP83nyBVUM/bxBuiYM/SH4VFxlYoiazD
         cQlkakqAENAayAC0Lpis9BCp/cj61wOmAS2lq88A2hfawQSsoP42g8CupZcqiui+t2DM
         pgsNdG2IWc0ATSDQl5jlWH65g7PnaHNuak7j0VtS9ZCx7G514Syeg+MCbyoLTElSennN
         wZTw==
X-Forwarded-Encrypted: i=1; AJvYcCWgM7I0FMTjcoimA3jKM+uviAenW9615uKLBc2Wx//NAaKYhqdkrr2w38a74XRdZDrs9V64p5YJGihyIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi7FsHzUV/KUWm1rPIc1q+BOaTAC5xyHZ45ULEwVHHq6ZDhjHo
	NpWoAWs0dVqXMO4bscwWL3iUIaDYEdpJ0tq43ccS/D/BYxBSagyGDYdnbSN7gEheeqyj5amF0K8
	lsOwICeId/3onz/JHn/V/5g0Up4zpldf00xwlSA==
X-Gm-Gg: ASbGncu+U4maHAnLi5uuAhSx5P58FwYxyCAIgasiJn6w89Z8DRDe7Gfn7LeKYYUskSY
	RKDcf/6zWgMao9JVmMoJQA/C360WwkHJq0AB1Hqn4PvHl0Yofk310zR8PLEOfIA==
X-Google-Smtp-Source: AGHT+IFmjLjtSeQweT/B8NnjDuPyAyhFDziYdB83b9RBPOIrw2k6Ie/OQhH8/CkRofqsGpFdSHhX1dCfEx+TUXlFbMk=
X-Received: by 2002:a05:6402:3510:b0:5d6:37e5:792a with SMTP id
 4fb4d7f45d1cf-5db7d2e86dbmr30843583a12.2.1737987553422; Mon, 27 Jan 2025
 06:19:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123202455.11338-1-slava@dubeyko.com> <fd012640-5107-4d44-9572-4dffb2fd4665@wdc.com>
 <f44878932fd26bb273c7948710b23b0e2768852a.camel@ibm.com>
In-Reply-To: <f44878932fd26bb273c7948710b23b0e2768852a.camel@ibm.com>
From: Hans Holmberg <hans@owltronix.com>
Date: Mon, 27 Jan 2025 15:19:02 +0100
X-Gm-Features: AWEUYZkxwsj25lAi_rBwrHrcO_R9W5CYKte7_bNZJPfH0--0TQoSa8h8ZA0z488
Message-ID: <CANr-nt2+Yk5fVVjU2zs+F1ZrLZGBBy3HwNOuYOK9smDeoZV9Rg@mail.gmail.com>
Subject: Re: [RFC PATCH] Introduce generalized data temperature estimation framework
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "Johannes.Thumshirn@wdc.com" <Johannes.Thumshirn@wdc.com>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"javier.gonz@samsung.com" <javier.gonz@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 10:03=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Fri, 2025-01-24 at 08:19 +0000, Johannes Thumshirn wrote:
> > On 23.01.25 21:30, Viacheslav Dubeyko wrote:
> > > [PROBLEM DECLARATION]
> > > Efficient data placement policy is a Holy Grail for data
> > > storage and file system engineers. Achieving this goal is
> > > equally important and really hard. Multiple data storage
> > > and file system technologies have been invented to manage
> > > the data placement policy (for example, COW, ZNS, FDP, etc).
> > > But these technologies still require the hints related to
> > > nature of data from application side.
> > >
> > > [DATA "TEMPERATURE" CONCEPT]
> > > One of the widely used and intuitively clear idea of data
> > > nature definition is data "temperature" (cold, warm,
> > > hot data). However, data "temperature" is as intuitively
> > > sound as illusive definition of data nature. Generally
> > > speaking, thermodynamics defines temperature as a way
> > > to estimate the average kinetic energy of vibrating
> > > atoms in a substance. But we cannot see a direct analogy
> > > between data "temperature" and temperature in physics
> > > because data is not something that has kinetic energy.
> > >
> > > [WHAT IS GENERALIZED DATA "TEMPERATURE" ESTIMATION]
> > > We usually imply that if some data is updated more
> > > frequently, then such data is more hot than other one.
> > > But, it is possible to see several problems here:
> > > (1) How can we estimate the data "hotness" in
> > > quantitative way? (2) We can state that data is "hot"
> > > after some number of updates. It means that this
> > > definition implies state of the data in the past.
> > > Will this data continue to be "hot" in the future?
> > > Generally speaking, the crucial problem is how to define
> > > the data nature or data "temperature" in the future.
> > > Because, this knowledge is the fundamental basis for
> > > elaboration an efficient data placement policy.
> > > Generalized data "temperature" estimation framework
> > > suggests the way to define a future state of the data
> > > and the basis for quantitative measurement of data
> > > "temperature".
> > >
> > > [ARCHITECTURE OF FRAMEWORK]
> > > Usually, file system has a page cache for every inode. And
> > > initially memory pages become dirty in page cache. Finally,
> > > dirty pages will be sent to storage device. Technically
> > > speaking, the number of dirty pages in a particular page
> > > cache is the quantitative measurement of current "hotness"
> > > of a file. But number of dirty pages is still not stable
> > > basis for quantitative measurement of data "temperature".
> > > It is possible to suggest of using the total number of
> > > logical blocks in a file as a unit of one degree of data
> > > "temperature". As a result, if the whole file was updated
> > > several times, then "temperature" of the file has been
> > > increased for several degrees. And if the file is under
> > > continous updates, then the file "temperature" is growing.
> > >
> > > We need to keep not only current number of dirty pages,
> > > but also the number of updated pages in the near past
> > > for accumulating the total "temperature" of a file.
> > > Generally speaking, total number of updated pages in the
> > > nearest past defines the aggregated "temperature" of file.
> > > And number of dirty pages defines the delta of
> > > "temperature" growth for current update operation.
> > > This approach defines the mechanism of "temperature" growth.
> > >
> > > But if we have no more updates for the file, then
> > > "temperature" needs to decrease. Starting and ending
> > > timestamps of update operation can work as a basis for
> > > decreasing "temperature" of a file. If we know the number
> > > of updated logical blocks of the file, then we can divide
> > > the duration of update operation on number of updated
> > > logical blocks. As a result, this is the way to define
> > > a time duration per one logical block. By means of
> > > multiplying this value (time duration per one logical
> > > block) on total number of logical blocks in file, we
> > > can calculate the time duration of "temperature"
> > > decreasing for one degree. Finally, the operation of
> > > division the time range (between end of last update
> > > operation and begin of new update operation) on
> > > the time duration of "temperature" decreasing for
> > > one degree provides the way to define how many
> > > degrees should be subtracted from current "temperature"
> > > of the file.
> > >
> > > [HOW TO USE THE APPROACH]
> > > The lifetime of data "temperature" value for a file
> > > can be explained by steps: (1) iget() method sets
> > > the data "temperature" object; (2) folio_account_dirtied()
> > > method accounts the number of dirty memory pages and
> > > tries to estimate the current temperature of the file;
> > > (3) folio_clear_dirty_for_io() decrease number of dirty
> > > memory pages and increases number of updated pages;
> > > (4) folio_account_dirtied() also decreases file's
> > > "temperature" if updates hasn't happened some time;
> > > (5) file system can get file's temperature and
> > > to share the hint with block layer; (6) inode
> > > eviction method removes and free the data "temperature"
> > > object.
> >
> > I don't want to pour gasoline on old flame wars, but what is the
> > advantage of this auto-magic data temperature framework vs the existing
> > framework?
> >
>
> There is no magic in this framework. :) It's simple and compact framework=
.
>
> >  'enum rw_hint' has temperature in the range of none, short,
> > medium, long and extreme (what ever that means), can be set by an
> > application via an fcntl() and is plumbed down all the way to the bio
> > level by most FSes that care.
>
> I see your point. But the 'enum rw_hint' defines qualitative grades again=
:
>
> enum rw_hint {
>         WRITE_LIFE_NOT_SET      =3D RWH_WRITE_LIFE_NOT_SET,
>         WRITE_LIFE_NONE         =3D RWH_WRITE_LIFE_NONE,
>         WRITE_LIFE_SHORT        =3D RWH_WRITE_LIFE_SHORT,  <-- HOT data
>         WRITE_LIFE_MEDIUM       =3D RWH_WRITE_LIFE_MEDIUM, <-- WARM data
>         WRITE_LIFE_LONG         =3D RWH_WRITE_LIFE_LONG,   <-- COLD data
>         WRITE_LIFE_EXTREME      =3D RWH_WRITE_LIFE_EXTREME,
> } __packed;
>
> First of all, again, it's hard to compare the hotness of different files
> on such qualitative basis. Secondly, who decides what is hotness of a par=
ticular
> data? People can only guess or assume the nature of data based on
> experience in the past. But workloads are changing and evolving
> continuously and in real-time manner. Technically speaking, application c=
an
> try to estimate the hotness of data, but, again, file system can receive
> requests from multiple threads and multiple applications. So, application
> can guess about real nature of data too. Especially, nobody would like
> to implement dedicated logic in application for data hotness estimation.
>
> This framework is inode based and it tries to estimate file's
> "temperature" on quantitative basis. Advantages of this framework:
> (1) we don't need to guess about data hotness, temperature will be
> calculated quantitatively; (2) quantitative basis gives opportunity
> for fair comparison of different files' temperature; (3) file's temperatu=
re
> will change with workload(s) changing in real-time; (4) file's
> temperature will be correctly accounted under the load from multiple
> applications. I believe these are advantages of the suggested framework.
>

While I think the general idea(using file-overwrite-rates as a
parameter when doing data placement) could be useful, it could not
replace the user space hinting we already have.

Applications(e.g. RocksDB) doing sequential writes to files that are
immutable until deleted(no overwrites) would not benefit. We need user
space help to estimate data lifetime for those workloads and the
relative write lifetime hints are useful for that.

So what I am asking myself is if this framework is added, who would
benefit? Without any benchmark results it's a bit hard to tell :)

Also, is there a good reason for only supporting buffered io? Direct
IO could benefit in the same way, right?

Thanks,
Hans
