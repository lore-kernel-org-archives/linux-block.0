Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C03E231A2D;
	Mon, 10 Mar 2025 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626326; cv=none; b=UYna1ER8vrv9+adb3coarPyKOMRZNDC+mr094wAEuxHFR/32T2MWcPrYUcEd49WOnLUbXlvVKSTzyJtGmKFY3Fk9/sI4f9hINLEvAcYIz6hpVt2xlhxKnc5tlBhd5lYXR3FuwuVWtfHDHWIvq83IjJlPi6RBtaZC5nvFXWaq3Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626326; c=relaxed/simple;
	bh=zU9J6Uelg3E0m0JOwnGynjWuNU4lkeTgew4U9lN434I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyH/x7XNsCJM0X1efjb0IXbf2X0TtVPuR4QDSENM1fepPQHdatP9El6e4sqbm85OKUc0P4ILc0sXwq7NLEwtYbXwQSVP11EXAR8Xw6Zg8KAaSl/zqWK4jTwuXjQ9evxhdTjS3H6Eoox25BU89PW67OzwxgLcEnZlmkycHDuBD6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YePaIuqK; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YePaIuqK"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7272f9d216dso2611461a34.3;
        Mon, 10 Mar 2025 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741626324; x=1742231124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZRKJKZ9nlIeWSuKxcLT+2RQaSrxw/L262gLI4l/W7Y=;
        b=YePaIuqKufW0AneCw6KHbCDSOXK2hAszQJQr0NnLtVF4j7OufGRd2mxSwlysXUYCZf
         lpKWmAG3Mbfjfx6Q9TYQiPkfTAIakUQdcbQzU/2TArktYRmdaDRJlOoyw4hTawwRBGX4
         1NSkU+eikVRVwQW7iQOoI906EQpbzHMGiaRf8bYbsf2ZrYWpe9vrOPj0ykZd9lqznv92
         10aprX7yDbYy3NevuTqwsmNmYz2WS5OCdHG5x8kGzhj6bLZnAUcScHF42d2LIIQNDFW7
         RWwAEzFCxijAQpYnFXpENvzU1ZOiVYLpWsJnYdhTAyy7JOgFsXlXkggrU5w8qs2PW83u
         0ReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626324; x=1742231124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZRKJKZ9nlIeWSuKxcLT+2RQaSrxw/L262gLI4l/W7Y=;
        b=s7Fiy9Xs3vnPEJ1p1rUvmE8X7gU+cQuMav7TGEHXsNtY2x1r1z3c29HEbDsAovCCdK
         u+ixJhxGNdAiw2kPILfpc1L3UPXf27kccBKIENwaimZbk+S6rrS2IM8ijqOq3hvm4NNU
         McCktVOrxFRxrWc6QSet3SVNzSPR53t7JSyv7i2542lSPbiEAGeecdlxa5sPla0nP6zR
         9JAe1rbXRH+cIIGnA8ATzdP6P2b/qNKXG+Ulcf/4yaT4FbYvogWGnEJzgiTE1QxCahU9
         XXx3VutJUE3SBJ5F/7XpjeFvGilD+WnGGlndC5nB5B4x2y27NVn9ODpkfOk0cM624rH9
         pp9w==
X-Forwarded-Encrypted: i=1; AJvYcCUJitKk2KezDU8md5jcxT4+B4nEyO+yFUSl85USqM7bxQX6kk1CQe389IHwY51vPSkoD33xYEeVPdzFAh3n@vger.kernel.org, AJvYcCVD2A8MEYbpNeOYNtTZT1YNUdpspg2IA+GJthMit9VoB9HUSlzMQhnt8UCh+Stki9PR3oprQt/5ofzhzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt5G8z27UZX9CJw9x5eeWzk0gFFtPvWiiGjpn+5TXfbS7gi4iF
	/SorxiSHX5VlIx/j0aPuXU7/x8jcxy6fyFETCVnC3oadsHdb8elnBfBBs5crE0yX+NuDhzo5cSE
	rdqWu1DOEb8gaOBoGIvEh65AZOyyyFZqKAtM=
X-Gm-Gg: ASbGnctq7iVsF3My5EpWdBBSWOBKcVlA4cFcDjZAFcRPiPggfAQFHCb6Uqe/wuytr7n
	gJZDr7zJP+oYiugaB9qEFY398hJvnGAju35UhzQQTYgUoSyAT3yX0tJ4xqIBYxlkcXpVdDkXqX+
	aAb9yMLJGtqwav3CpgjCtp1cAkDCCQjNuvnuw/omCjqNGsCxjUiBj3Nr11hQ==
X-Google-Smtp-Source: AGHT+IGLgqTmt1SDyAD0npx1AoBzMAH3/wL78InRxx9wcGrHh376yvWmApG86TD6jVVvmno+Mrl+M1sPXtYY48F+++4=
X-Received: by 2002:a05:6214:268b:b0:6e8:9e9c:d212 with SMTP id
 6a1803df08f44-6e9004f8506mr237299696d6.0.1741625894265; Mon, 10 Mar 2025
 09:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
 <CAKEwX=NfKrisQL-DBcNxBwK2ErK-u=MSzHNpETcuWWNBh9s9Bg@mail.gmail.com>
 <CAGsJ_4ysL1xV=902oNM3vBfianF6F_iqDgyck6DGzFrZCtOprw@mail.gmail.com> <52896654fa07a685707b11cfcc141b038a13b649.camel@mediatek.com>
In-Reply-To: <52896654fa07a685707b11cfcc141b038a13b649.camel@mediatek.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 10 Mar 2025 09:58:03 -0700
X-Gm-Features: AQ5f1JoVlbRC8ML7j1bVCk8yzJp1pkIWgzfAiwocC8Jva43BmjLh8eyu6rj7o_I
Message-ID: <CAKEwX=PNHik8O6swwRPsuDovtCNLxXRQUsiXZSSq8ZbzFvJV0w@mail.gmail.com>
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

On Mon, Mar 10, 2025 at 6:22=E2=80=AFAM Qun-wei Lin (=E6=9E=97=E7=BE=A4=E5=
=B4=B4)
<Qun-wei.Lin@mediatek.com> wrote:
>
>
> Thank you for your explanation. Compared to the original single kswapd,
> we expect t1 to have a slight increase in re-scan time. However, since
> our kcompressd can focus on compression tasks and we can have multiple
> kcompressd instances (kcompressd0, kcompressd1, ...) running in
> parallel, we anticipate that the number of times a folio needs be re-
> scanned will not be too many.
>
> In our experiments, we fixed the CPU and DRAM at a certain frequency.
> We created a high memory pressure enviroment using a memory eater and
> recorded the increase in pgsteal_anon per second, which was around 300,
> 000. Then we applied our patch and measured again, that pgsteal_anon/s
> increased to over 800,000.
>
> > >
> > > >
> > > > Problem:
> > > >  In the current system, the kswapd thread is responsible for both
> > > >  scanning the LRU pages and compressing pages into the ZRAM. This
> > > >  combined responsibility can lead to significant performance
> > > > bottlenecks,
> > >
> > > What bottleneck are we talking about? Is one stage slower than the
> > > other?
> > >
> > > >  especially under high memory pressure. The kswapd thread becomes
> > > > a
> > > >  single point of contention, causing delays in memory reclaiming
> > > > and
> > > >  overall system performance degradation.
> > > >
> > > > Target:
> > > >  The target of this invention is to improve the efficiency of
> > > > memory
> > > >  reclaiming. By separating the tasks of page scanning and page
> > > >  compression into distinct processes or threads, the system can
> > > > handle
> > > >  memory pressure more effectively.
> > >
> > > I'm not a zram maintainer, so I'm definitely not trying to stop
> > > this
> > > patch. But whatever problem zram is facing will likely occur with
> > > zswap too, so I'd like to learn more :)
> >
> > Right, this is likely something that could be addressed more
> > generally
> > for zswap and zram.
> >
>
> Yes, we also hope to extend this to other swap devices, but currently,
> we have only modified zram. We are not very familiar with zswap and
> would like to ask if anyone has any suggestions for modifications?
>

My understanding is right now schedule_bio_write is the work
submission API right? We can make it generic, having it accept a
callback and a generic untyped pointer which can be casted into a
backend-specific context struct. For zram it would contain struct zram
and the bio. For zswap, depending on at which point do you want to
begin offloading the work - it could simply be just the folio itself
if we offload early, or a more complicated scheme.



> > Thanks
> > Barry
>
> Best Regards,
> Qun-wei
>
>
