Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C3C233156;
	Mon, 10 Mar 2025 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627864; cv=none; b=E0JMPF6xNbpL5lCvW24gxbaYlb7zrGIaNOk4AUaI02Zs5Fw6HxRcXrvbsoG2imEwZmeH63JcNWFGsYbDooPmBuTO1MKNV+nYAu/lSQltnbaYGpQva+PnPJWwsNZmT80mx07/o+seeeVwSY8TzYsIR39BzBZmG0xXT3ulHrwBiNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627864; c=relaxed/simple;
	bh=hBQ6Jb0lIvYkY5YwdG9Lzpk3SfgbN4yRgpRLE9J874U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoiUHm6Iumx/ExFNaNtxgZie+1FEpN+NboYefz9P2IPLz3mBU+VC2uBA07HsZkic31VW4BKbdOQtStCoC6Vj4g2rRzA/mopk6cUa3NY9MoZ4kM4jqm3PrylDw295lBKGtlYeLB1rlr+tortUNU6Wb5ny7V/Lc2y03DE//3ddMLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9oswiZQ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9oswiZQ"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47690a4ec97so9086411cf.2;
        Mon, 10 Mar 2025 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741627861; x=1742232661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b78KlAfyXKoBfZcmMN7ECuBnSEo3W7UZ1w2TCHUTUXU=;
        b=Y9oswiZQFiifab+rw/nqZpMroR7IKnfmyZmz/DaIrvToFK5/Xn7EWIg886s3IPHIOB
         nIRUT1m2aogSB2VBCHRtd1lCf4zCaYz3aSlFADrG/nfw0bnHMgg4nvQb7eVgYrdbZ9BZ
         FUt4t32hKqKY2UlqvdGEBwglheiFkRUiHYoka/9PkK06H5HMJ85iI63PwA8Kf4wZsLd1
         3ewClJLCqFFp+x3ZqKE+myHtdhFgfH1Lfny8luqrL5iGpW8kEIuA7bgpJZJ49xZ25VWp
         kgigFfAvlh6Z7tKZ8QGWFIFnuUm9Kj8VCWnTzI4RwWSzgWiCWUC/cjlsTFeA2eKBG7ep
         lUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741627861; x=1742232661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b78KlAfyXKoBfZcmMN7ECuBnSEo3W7UZ1w2TCHUTUXU=;
        b=MgMbM0Z/uBLOCHDZ5+mbZYeu9ckRfdrTOwEB70G2i3e2gjnEZRVBK+SeqcNBDzS+so
         n/ws2SQIdurWkk7VnKUz/wKp9ZuGggtShySAl3RpZlcPodyrkm+800tNINvqaTBneXj7
         bhq8q1TMmBcMhkDg96ZZQJfG5mNISlvjdkjqovlfKRoJVAObY6qWE11MKfRjxfA5thPt
         ox/Lutebrj98tRJVl2tFFPG0Dj5LjeBVdNhb52uM3FAl9StG/Zq6s9wA0raOZz1NHuFS
         5brRni953CQPZ+Ka4nV1uBJW9EQIx5daSpwdkHlRjni9qZOW7IbhO1LqgzSvwdM/bx+T
         Hm1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUL91F9EVCSKK3MRBYtCo/KOllJ+6ZHjzBYj/P+k4nfG9rhBU8ProsUR+yRVjm+ao+59uwdvpc/RxLspap/@vger.kernel.org, AJvYcCWg7bYNI9A2+Ji8RgefWrSiOrZ+MQFDxBemnCNiWUxAXx5p+2IH+PcudRJvV3PaDNz34sqjLydfcgwR9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAxSbEYQDxuPZu8weszUzRl8zyJ0EJQ8+VmJDwxcCb3oUMZ9sK
	DJ/EdUtFkk0XHnydQ2o518Dxyy8MA4+7VthJ/HGXlJlhTj6wW33MIQjmWApZHGFPTxz8Na6CazN
	BW7VRnM57dESkUJD4IMVP+rKRV3U=
X-Gm-Gg: ASbGnctEeDwPcZ2cu6HXZ5eP9gHqPbLkOGp63uWEo7WTJS4UlId5gMe1VDyb28G1jP6
	A6nOjM6r+3adTduxzyy3DdBar4mMwYffwUKhrAEU/n7WMoCzcwVG/q5CMUX7KR6QbcaBpQnZb4t
	D5C4vkuSsD4b6sD/XFdKSpYS1she98d45eGD5EO9yyEvawYJskCX2Wt9Re1A==
X-Google-Smtp-Source: AGHT+IH1LLSAI/+s4Zi9zEGfRKSLEY80Xhq1yNJSxRKUtitCQBu1/cEDGmenPOC3lpC07sG6xvj89oLC5RUraLQQ57A=
X-Received: by 2002:ad4:5945:0:b0:6e8:feae:929c with SMTP id
 6a1803df08f44-6ea2dd25b7dmr6779506d6.21.1741627861048; Mon, 10 Mar 2025
 10:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
 <CAKEwX=NfKrisQL-DBcNxBwK2ErK-u=MSzHNpETcuWWNBh9s9Bg@mail.gmail.com>
 <CAGsJ_4ysL1xV=902oNM3vBfianF6F_iqDgyck6DGzFrZCtOprw@mail.gmail.com>
 <52896654fa07a685707b11cfcc141b038a13b649.camel@mediatek.com> <CAKEwX=PNHik8O6swwRPsuDovtCNLxXRQUsiXZSSq8ZbzFvJV0w@mail.gmail.com>
In-Reply-To: <CAKEwX=PNHik8O6swwRPsuDovtCNLxXRQUsiXZSSq8ZbzFvJV0w@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 10 Mar 2025 10:30:48 -0700
X-Gm-Features: AQ5f1JpRFqqTBM7MTZvYEz_bClOJNrcAPr9qIUA-7zONYB5oqdusO9tVlggAxPY
Message-ID: <CAKEwX=Onwhy7FkB97tw4JonN3POj=dDp3ixsfS14=_3x3=KvuA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Improve Zram by separating compression context from kswapd
To: =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>
Cc: "21cnbao@gmail.com" <21cnbao@gmail.com>, =?UTF-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?= <Andrew.Yang@mediatek.com>, 
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
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>, 
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 9:58=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Mon, Mar 10, 2025 at 6:22=E2=80=AFAM Qun-wei Lin (=E6=9E=97=E7=BE=A4=
=E5=B4=B4)
> <Qun-wei.Lin@mediatek.com> wrote:
> >
> >
> > Thank you for your explanation. Compared to the original single kswapd,
> > we expect t1 to have a slight increase in re-scan time. However, since
> > our kcompressd can focus on compression tasks and we can have multiple
> > kcompressd instances (kcompressd0, kcompressd1, ...) running in
> > parallel, we anticipate that the number of times a folio needs be re-
> > scanned will not be too many.
> >
> > In our experiments, we fixed the CPU and DRAM at a certain frequency.
> > We created a high memory pressure enviroment using a memory eater and
> > recorded the increase in pgsteal_anon per second, which was around 300,
> > 000. Then we applied our patch and measured again, that pgsteal_anon/s
> > increased to over 800,000.
> >
> > > >
> > > > >
> > > > > Problem:
> > > > >  In the current system, the kswapd thread is responsible for both
> > > > >  scanning the LRU pages and compressing pages into the ZRAM. This
> > > > >  combined responsibility can lead to significant performance
> > > > > bottlenecks,
> > > >
> > > > What bottleneck are we talking about? Is one stage slower than the
> > > > other?
> > > >
> > > > >  especially under high memory pressure. The kswapd thread becomes
> > > > > a
> > > > >  single point of contention, causing delays in memory reclaiming
> > > > > and
> > > > >  overall system performance degradation.
> > > > >
> > > > > Target:
> > > > >  The target of this invention is to improve the efficiency of
> > > > > memory
> > > > >  reclaiming. By separating the tasks of page scanning and page
> > > > >  compression into distinct processes or threads, the system can
> > > > > handle
> > > > >  memory pressure more effectively.
> > > >
> > > > I'm not a zram maintainer, so I'm definitely not trying to stop
> > > > this
> > > > patch. But whatever problem zram is facing will likely occur with
> > > > zswap too, so I'd like to learn more :)
> > >
> > > Right, this is likely something that could be addressed more
> > > generally
> > > for zswap and zram.
> > >
> >
> > Yes, we also hope to extend this to other swap devices, but currently,
> > we have only modified zram. We are not very familiar with zswap and
> > would like to ask if anyone has any suggestions for modifications?
> >
>
> My understanding is right now schedule_bio_write is the work
> submission API right? We can make it generic, having it accept a
> callback and a generic untyped pointer which can be casted into a
> backend-specific context struct. For zram it would contain struct zram
> and the bio. For zswap, depending on at which point do you want to
> begin offloading the work - it could simply be just the folio itself
> if we offload early, or a more complicated scheme.

To expand a bit - zswap_store() is where all the logic lives. It's
fairly straightforward: checking zswap cgroup limits, acquire the
zswap pool (a combination of compression algorithm and backend memory
allocator, which is just zsmalloc now), perform compression, then ask
for a slot from zsmalloc and store it there.

You can probably just offload the whole thing here, or perform some
steps of the sequence before offloading the rest :) One slight
complication is don't forget to fallback to disk swapping - unlike
zram, zswap is originally designed as a "cache" for underlying swap
files on disk, which we can fallback to if the compression attempt
fails. Everything should be fairly straightforward though :)

>
>
>
> > > Thanks
> > > Barry
> >
> > Best Regards,
> > Qun-wei
> >
> >
