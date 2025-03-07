Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EA115746E;
	Fri,  7 Mar 2025 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741389205; cv=none; b=TapXQtOcJz8mlBajMHlL26Pma/TjEgSZdFpvmpHagROGm/ypA/TngBlJfM7+q5RNuvqyGV++TLVFD73jQfeW6h4akvncyRZlwKGhKj9YWMnmmYOTqTuCqutFHOgYoD+hDgHXBdtXqBT2KuC31CUF0uAcSqlEQEmGFiGbAN5aMp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741389205; c=relaxed/simple;
	bh=G63d06X8W9arXCJggGOHT2w3cbPycEOHJ8wMoqYNgPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s04pM0MQdDzeMG1EZ4GHemxfLB+XjKXvU/itLymCsslivj488RAButgwn4+jLNA+TWR1s107yGogXQCQc7BbBbUQBm8qDnoBFwCBpL/6DJ7Cz5oGa+tPMw6FK//Odjx+ImtEBEzpVXI5zaIxdnUPO1X04YQkYKYVRZ+3+yZuhXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZGCpVhd; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZGCpVhd"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8ec399427so15986606d6.2;
        Fri, 07 Mar 2025 15:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741389203; x=1741994003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqomUUPjRLiQmonoip8f3BCduAZxVjsjo6bLnE0yfxE=;
        b=YZGCpVhdVwnMccQG60h1+BC2fxJTiY3QuFIhTMj95lWP3gTatd/PqhzHcBh1Whomtl
         73sMldiapnqKss05dMeJe7znRKJdGitHzw6XGzTzC/wNCzXIbjI5DnKUavfhSztyrJLR
         wBYVDMqmnnHvxtpJ9MYVf8mMBs0n3WSEMcm55SpjwsWHV04Cbl4ewS3w5+BOwmmNMuIw
         P437SgkE95NTAM1X99/au8k0UlMxoPzSs8WCjB2mkHuzax+jWw7rVx+lpXm6SQLLpH9y
         B4nKqN5myU6jOLB7Z12e1MHBpiDsDIRkmmtcTZm+DFsndFbl5Sa9gLe+l10nJje+4fFu
         Kt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741389203; x=1741994003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqomUUPjRLiQmonoip8f3BCduAZxVjsjo6bLnE0yfxE=;
        b=Gz1RQm78nFbF90NtTd8z+sTQ9N1aZDsOFRbbN0dfvklSReZz7Q9dpUBCv6tSpr996a
         ZCSMRdTM9f4+zqaRmuWY5uWvAxLc7sWKWOhFJSI/sxnXaoQlfR6UIpMXzAXb15SWomdF
         KnsVmOVAjC9Lgc7yFJagMo6QxHkLP3ednShr3YUaLqdWVwfb4eDmYxxqUFOck5NDRL1v
         TQG+d2qoDPrPtwh+yIMKWV2wF8ssv5xMMUPUuo/8D1DKGdHWSM8zZMwdeiuLpIiJnFmZ
         zSfhZvkw7lvE71vF931V/vpuxPaIZ/W5pORwzQwQQ6cS1J9YuOfGXMNNZ52WoUiOd4op
         bYvg==
X-Forwarded-Encrypted: i=1; AJvYcCW5zbY3L/NY+HBATLN/Sufdb8TvKZJVvuc69OmKLDCTlY3z5EDMxgS/U5seGChCSLLy6k91sIqoG1tiEg==@vger.kernel.org, AJvYcCXBCSTdkV2SHWjNjlOiHcfugwfnNliu0V37eAwpuZFJeU7b2rA9tAh8RbM/Vk1liBKMPQRa960/PrsLUxtc@vger.kernel.org
X-Gm-Message-State: AOJu0YzBXlX8JHhtBK8LcuJcqqXmP0E6TbSCEu0GkfMUvMB8SIdU/nqp
	SmZ2oQbMhEb9v+WfQoNwKLvRVh59EdkZIB+OVT0rnBj2x/7pqoGwlE2LY7IJh+7xHIFam+N7I6E
	XQEzguKei1ABczOfUpiJN6sQo0Oo=
X-Gm-Gg: ASbGncv+xob802HwJFdex2i2k9Ye+qR3rvRCEX/3ydTO6ZS6Z7th4imLtr82OAmuT9g
	F63LYWARkvBB0dK3ds+C7oqRQ0oW2s5heHwpohXpPq0x2rGMvHM49Gw6ibRW6PeMaQr3J3m+Y3d
	CTfBuM/yNQlLiW5650RnOkyBt3oikLzI5HYuC+9V/ysA==
X-Google-Smtp-Source: AGHT+IGgO4waxliJRJEjcjUATYM+tLYXbT7o9vAllgT5zmhdZvJYwca7AqrIUigw62PVDCYdl3bzS0BOeN1gV1tcJBc=
X-Received: by 2002:a05:6214:21a6:b0:6e4:2dd7:5c88 with SMTP id
 6a1803df08f44-6e90068196dmr70464496d6.38.1741389203258; Fri, 07 Mar 2025
 15:13:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
 <20250307120141.1566673-3-qun-wei.lin@mediatek.com> <CAGsJ_4xtp9iGPQinu5DOi3R2B47X9o=wS94GdhdY-0JUATf5hw@mail.gmail.com>
In-Reply-To: <CAGsJ_4xtp9iGPQinu5DOi3R2B47X9o=wS94GdhdY-0JUATf5hw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 7 Mar 2025 15:13:12 -0800
X-Gm-Features: AQ5f1JooOtTd4HVR7CCnLuHoQkyIFVDhrvbdPzpgk1fPg8et0mZMLZfSKYeQ1OE
Message-ID: <CAKEwX=OP9PJ9YeUvy3ZMQPByH7ELHLDfeLuuYKvPy3aCQCAJwQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kcompressd: Add Kcompressd for accelerated zram compression
To: Barry Song <21cnbao@gmail.com>
Cc: Qun-Wei Lin <qun-wei.lin@mediatek.com>, Jens Axboe <axboe@kernel.dk>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Casper Li <casper.li@mediatek.com>, Chinwen Chang <chinwen.chang@mediatek.com>, 
	Andrew Yang <andrew.yang@mediatek.com>, James Hsu <james.hsu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 11:41=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Sat, Mar 8, 2025 at 1:02=E2=80=AFAM Qun-Wei Lin <qun-wei.lin@mediatek.=
com> wrote:
> >
> > Introduced Kcompressd to offload zram page compression, improving
> > system efficiency by handling compression separately from memory
> > reclaiming. Added necessary configurations and dependencies.
> >
> > Signed-off-by: Qun-Wei Lin <qun-wei.lin@mediatek.com>
> > ---
> >  drivers/block/zram/Kconfig      |  11 ++
> >  drivers/block/zram/Makefile     |   3 +-
> >  drivers/block/zram/kcompressd.c | 340 ++++++++++++++++++++++++++++++++
> >  drivers/block/zram/kcompressd.h |  25 +++
> >  drivers/block/zram/zram_drv.c   |  22 ++-
> >  5 files changed, 397 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/block/zram/kcompressd.c
> >  create mode 100644 drivers/block/zram/kcompressd.h
> >
> > diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
> > index 402b7b175863..f0a1b574f770 100644
> > --- a/drivers/block/zram/Kconfig
> > +++ b/drivers/block/zram/Kconfig
> > @@ -145,3 +145,14 @@ config ZRAM_MULTI_COMP
> >           re-compress pages using a potentially slower but more effecti=
ve
> >           compression algorithm. Note, that IDLE page recompression
> >           requires ZRAM_TRACK_ENTRY_ACTIME.
> > +
> > +config KCOMPRESSD
> > +       tristate "Kcompressd: Accelerated zram compression"
> > +       depends on ZRAM
> > +       help
> > +         Kcompressd creates multiple daemons to accelerate the compres=
sion of pages
> > +         in zram, offloading this time-consuming task from the zram dr=
iver.
> > +
> > +         This approach improves system efficiency by handling page com=
pression separately,
> > +         which was originally done by kswapd or direct reclaim.
>
> For direct reclaim, we were previously able to compress using multiple CP=
Us
> with multi-threading.
> After your patch, it seems that only a single thread/CPU is used for comp=
ression
> so it won't necessarily improve direct reclaim performance?
>
> Even for kswapd, we used to have multiple threads like [kswapd0], [kswapd=
1],
> and [kswapd2] for different nodes. Now, are we also limited to just one t=
hread?
> I also wonder if this could be handled at the vmscan level instead of the=
 zram
> level. then it might potentially help other sync devices or even zswap la=
ter.

Agree. A shared solution would be much appreciated. We can keep the
kcompressd idea, but have it accept IO work from multiple sources
(zram, zswap, whatever) through a shared API.

Otherwise we would need to reinvent the wheel multiple times :)
