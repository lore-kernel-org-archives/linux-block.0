Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5C41EDA03;
	Tue, 11 Mar 2025 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741677923; cv=none; b=H3HMVAp63CWNL1H3xfNfBPnagWhul7Ug3Odd3Uv1wvuy7yUzUEF8gWw6+niRTSLLzMz6oGSaSYIxUBJFCg/lIPbKKaVND5S9NfDzFXEnz1lrlOqP1Xda8PcPzo6vWXszdtxuaGDMVMpF+d8+8FmydKThip8XCPPm87w+01ajkGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741677923; c=relaxed/simple;
	bh=eZEIIBt1kffWaB7xQ1NYDHiMf8e1m7zNRLt0RhBlNzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p81+uKpS5ogXzlUSsghQSHxXmt+fMHDiDNC4s5QJMJ5tqWX65bIBohCYkHJ0RNm2AIcGm0R63jqR0WavPIw9M+RtoUArbUUyuEpGueb8q1PQ7zxbikvPeyPe/r7QjmsDT6z2+l8LBhGVyvN77F2tR5RTRaN/XUq8hiIc6oS+MYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jlz2Fpgc; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jlz2Fpgc"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-523de538206so1834206e0c.2;
        Tue, 11 Mar 2025 00:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741677920; x=1742282720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14J+e5VuAf8KWTYGvfdl7Up5l3cKOJfv7HHosoMS/QI=;
        b=Jlz2Fpgc7x2wvUcQaaoN7iP8XxmBPY6GBtfJadXwpe+TuVfhsO74kIFfL6BD1yajAi
         kkEjKeoTPzMVHT23lQRDg1JSz5otNVUPyE9kaPZc6UY3QKUh5CshNT9l9djLQ2VgnKka
         TBnOwu/HwrBRo/YGp5cK2sJ1jmkQoNLGo0LP+ZmwQNHYFG6mEij1udtkrkPdorqP16b7
         qzWpbj+oqlDPkf+DEO4hUyjf2truTLNSSQVcJJa9FzeOAsVuMbK3r6OHgpHVpAbpr5I6
         bYSo/fTPn83xSCPpunJXvl/KVdKOt2iSspRuhV3sbskbVmVUbtLzrtCVWt18ZS2kir6f
         TNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741677920; x=1742282720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14J+e5VuAf8KWTYGvfdl7Up5l3cKOJfv7HHosoMS/QI=;
        b=Jsait/zfFP8vqJdvw6GTbPY17nIEDT/H2Vcs8QfyjvHijIcko68iNymfMaPp0+A7Us
         PcSdcBoXTzNiLo4s1bJ1/AUcT/JlXrpx1HSP4kpDeArahgClO8XEvi3T/cU6eO8Xe39a
         fTE3J2BhGEN9H4C+oM5n/DjbUrOobEzYTNjR08wikCp3Xg2BfRe4I6rwv8njByknv9pk
         3wh9uT6QhA+6rhYbjuykj9ks1IDAosZ1+AvXbVeZJ8BblU+oXp/Xzptb3le2dCmtWX79
         w/tHnKANOTmdMoMGUChAIpkOKtJDFeVnKjhzzvXX31hwymF2AFZbI4kGj3X5a8TpRcUv
         7M1w==
X-Forwarded-Encrypted: i=1; AJvYcCWRBDxfgqPOpEcCqRdG+iVPn6EcCFQXs+DVJPOfbfVxZ09rmizqQ1ZMgjQE1gsFTPe5oEMwKwnsyPQiuOm3@vger.kernel.org, AJvYcCXHCNKCG6YVTd38Ufl1MRRJMLRbOT9KO9qZMXA3ZJCawxxGJOJ2lKFTlOX6eAUIN/zwdNthIdPbpnJSuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlqglqbxRJBoHMaDA+312odinNeJni7OWHx+h5UzggoBUFOiPj
	QOAOyK0lzXR9JUx9yHBE+QgaLl4oFWnkk7WYvLnaEYAxw4/eH+QbSBVA+XF3neb7MCyWp0EuMsn
	RUE1I9vUS/7brUYonfRfdACye4jU=
X-Gm-Gg: ASbGnctCja+7TAsmHaDq8Qpxfc6eau4FmSLZdQ2DrN0tNlh/BnuZD7GaYT2RqAbyijE
	SNcJB+fdIU0ADWSBm1cf6vxA8jS+8Yn9B6dyUrZhw5lzbu4Uz9zefbU9pALh6KgpeY7RXL0Hv0J
	vkB+zUJJ1ESFhyKnwk0K0s2brlNvr4NW1H9yWl
X-Google-Smtp-Source: AGHT+IFsyBlzqjw152fKM+F/V/k1af7P7Im6Vh9k8Vu1jHuGXnkPe4wU95quHjQWRTZpr4F4NdrxAPjlRVLxhAwp+VQ=
X-Received: by 2002:a05:6122:2189:b0:520:5a87:6708 with SMTP id
 71dfb90a1353d-523e3d9bfbfmr8599088e0c.0.1741677920409; Tue, 11 Mar 2025
 00:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
 <20250307120141.1566673-3-qun-wei.lin@mediatek.com> <CAGsJ_4xtp9iGPQinu5DOi3R2B47X9o=wS94GdhdY-0JUATf5hw@mail.gmail.com>
 <7938f840136165be1c50050feb39fb14ee37721b.camel@mediatek.com> <CAGsJ_4zzZdjbr2DbRybHYDmL2EuUBohOP1=ho7fjx1XWoKDDGw@mail.gmail.com>
In-Reply-To: <CAGsJ_4zzZdjbr2DbRybHYDmL2EuUBohOP1=ho7fjx1XWoKDDGw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 11 Mar 2025 20:25:09 +1300
X-Gm-Features: AQ5f1JpKxaLImM0wsAF8CYe72YVs87H6q9d9biQ7imNBdrvywmaFTR6ikJ3uks4
Message-ID: <CAGsJ_4yuyJc_-Ods-um_jtAgFFJ_qJi1=b8Kf-_ngU0UHjMQYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kcompressd: Add Kcompressd for accelerated zram compression
To: =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>
Cc: =?UTF-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?= <Andrew.Yang@mediatek.com>, 
	=?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>, 
	"chrisl@kernel.org" <chrisl@kernel.org>, =?UTF-8?B?SmFtZXMgSHN1ICjlvpDmhbbolrAp?= <James.Hsu@mediatek.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"dave.jiang@intel.com" <dave.jiang@intel.com>, 
	"schatzberg.dan@gmail.com" <schatzberg.dan@gmail.com>, 
	=?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= <chinwen.chang@mediatek.com>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"minchan@kernel.org" <minchan@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "kasong@tencent.com" <kasong@tencent.com>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"ying.huang@intel.com" <ying.huang@intel.com>, 
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>, 
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 8:05=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Mar 11, 2025 at 2:26=E2=80=AFAM Qun-wei Lin (=E6=9E=97=E7=BE=A4=
=E5=B4=B4)
> <Qun-wei.Lin@mediatek.com> wrote:
> >
> > On Sat, 2025-03-08 at 08:41 +1300, Barry Song wrote:
> > >
> > > External email : Please do not click links or open attachments until
> > > you have verified the sender or the content.
> > >
> > >
> > > On Sat, Mar 8, 2025 at 1:02=E2=80=AFAM Qun-Wei Lin <qun-wei.lin@media=
tek.com>
> > > wrote:
> > > >
> > > > Introduced Kcompressd to offload zram page compression, improving
> > > > system efficiency by handling compression separately from memory
> > > > reclaiming. Added necessary configurations and dependencies.
> > > >
> > > > Signed-off-by: Qun-Wei Lin <qun-wei.lin@mediatek.com>
> > > > ---
> > > >  drivers/block/zram/Kconfig      |  11 ++
> > > >  drivers/block/zram/Makefile     |   3 +-
> > > >  drivers/block/zram/kcompressd.c | 340
> > > > ++++++++++++++++++++++++++++++++
> > > >  drivers/block/zram/kcompressd.h |  25 +++
> > > >  drivers/block/zram/zram_drv.c   |  22 ++-
> > > >  5 files changed, 397 insertions(+), 4 deletions(-)
> > > >  create mode 100644 drivers/block/zram/kcompressd.c
> > > >  create mode 100644 drivers/block/zram/kcompressd.h
> > > >
> > > > diff --git a/drivers/block/zram/Kconfig
> > > > b/drivers/block/zram/Kconfig
> > > > index 402b7b175863..f0a1b574f770 100644
> > > > --- a/drivers/block/zram/Kconfig
> > > > +++ b/drivers/block/zram/Kconfig
> > > > @@ -145,3 +145,14 @@ config ZRAM_MULTI_COMP
> > > >           re-compress pages using a potentially slower but more
> > > > effective
> > > >           compression algorithm. Note, that IDLE page recompression
> > > >           requires ZRAM_TRACK_ENTRY_ACTIME.
> > > > +
> > > > +config KCOMPRESSD
> > > > +       tristate "Kcompressd: Accelerated zram compression"
> > > > +       depends on ZRAM
> > > > +       help
> > > > +         Kcompressd creates multiple daemons to accelerate the
> > > > compression of pages
> > > > +         in zram, offloading this time-consuming task from the
> > > > zram driver.
> > > > +
> > > > +         This approach improves system efficiency by handling page
> > > > compression separately,
> > > > +         which was originally done by kswapd or direct reclaim.
> > >
> > > For direct reclaim, we were previously able to compress using
> > > multiple CPUs
> > > with multi-threading.
> > > After your patch, it seems that only a single thread/CPU is used for
> > > compression
> > > so it won't necessarily improve direct reclaim performance?
> > >
> >
> > Our patch only splits the context of kswapd. When direct reclaim is
> > occurred, it is bypassed, so direct reclaim remains unchanged, with
> > each thread that needs memory directly reclaiming it.
>
> Qun-wei, I=E2=80=99m getting a bit confused. Looking at the code in page_=
io.c,
> you always call swap_writepage_bdev_async() no matter if it is kswapd
> or direct reclaim:
>
> - else if (data_race(sis->flags & SWP_SYNCHRONOUS_IO))
> + else if (data_race(sis->flags & SWP_WRITE_SYNCHRONOUS_IO))
>            swap_writepage_bdev_sync(folio, wbc, sis);
>   else
>             swap_writepage_bdev_async(folio, wbc, sis);
>
> In zram, I notice you are bypassing kcompressd by:
>
> + if (!nr_kcompressd || !current_is_kswapd())
> +        return -EBUSY;
>
> How will this work if no one is calling __end_swap_bio_write(&bio),
> which is present in swap_writepage_bdev_sync()?
> Am I missing something? Or is it done by zram_bio_write() ?
>
> On the other hand, zram is a generic block device, and coupling its
> code with kswapd/direct reclaim somehow violates layering
> principles :-)
>
> >
> > > Even for kswapd, we used to have multiple threads like [kswapd0],
> > > [kswapd1],
> > > and [kswapd2] for different nodes. Now, are we also limited to just
> > > one thread?
> >
> > We only considered a single kswapd here and didn't account for multiple
> > instances. Since I use kfifo to collect the bios, if there are multiple
> > kswapds, we need to add a lock to protect the bio queue. I can revise
> > this in the 2nd version, or do you have any other suggested approaches?
>
> I'm wondering if we can move the code to vmscan/page_io instead
> of zram. If we're using a sync I/O swap device or have enabled zswap,
> we could run reclamation in this separate thread, which should also be

Sorry for the typo:
s/reclamation/__swap_writepage/g

> NUMA-aware.
>
> I would definitely be interested in prototyping it when I have the time.
>

Thanks
Barry
