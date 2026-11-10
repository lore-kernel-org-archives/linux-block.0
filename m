Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289763;
	b=3lA9u2jO2cGu89d5szDN1NSffZ5V7F7DG9L2gm0L3it5xNAPKm/4c0cuXIM2ljzo868Y
	 +eWkQzGN698vhGYsgPTZkRN6SbTPK9HDxy5VtJ8MouMvddkm8E2A68sPmXc+qiJPeYr4t
	 D173GJEuFhh5kwqNvkki9lbaLxr/NsvtRIPX2BgLQ98nesGpPJt/pzg68mtuzQQ26wgNP
	 Q4tJ2uEalCLNVnC7/FAONEZ6v2SFvT+TQWHS2TQ2LkYI4OPCV5b5dKFuG+jDeSap0oGt8
	 NuOyrlY5Bv7cipbtZobJxEDcy2DTNQJ7rdjtZHT+ABlBbHGm1T0OUy3QphVGkCkdTUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=e1CwuUVsSjZnbMobjwr4r9fMJTFxCCqI+vgT8IsHHyE=;
	b=BR81BK8OPqrzozxfkJdGuvpD+S33lt3xDjs7iEyHRCb7hTOVtUw/xfdbl/vfvq1rZz+k
	 VtQBPLdeKmdT6gLgfeCBYrob9UA1mfDGBRC4A2Hm4H8oOS5fWWsoEApIg5HShoTQD/MWP
	 4ctUDHECGZK9Hskkj3BsIa4y147iUjn+MQsOc+dSyBmVgy8oxofyJmffKEvggdrpoyLBx
	 0GUeCn/8uHuS9y5FYW7TG5DCftYR8Z4iuyXBL1RmrRMUdMBMD1m5N4cY2zimKPDYku7TB
	 EjHbs8wNwHmwxmavGA7rWmKXe0BduUZufns2unYo8wZ2YcNsmbA/MURRqyYegiyBGzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Ntx8of9R;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914160A260E
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 05:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C914160A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Ntx8of9R
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b5e5e64494so834090b3a.1
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 21:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794289762; x=1794894562; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e1CwuUVsSjZnbMobjwr4r9fMJTFxCCqI+vgT8IsHHyE=;
        b=Ntx8of9RtWT7VWFP+8UI2qGvxb7QsA9xAcmmQncetK5YIWQYal5uEtY/rivndaRZjy
         rU0cwPplqFhBTIjuGAnTrn/domD/um+/F8BvTxnHmvYwK/K4HXYNZ0PzZWE+2pk3xLhB
         8PbiiK6C6Lt2RBs1QMNH6sTgfIVwKTef1OQOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794289762; x=1794894562;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e1CwuUVsSjZnbMobjwr4r9fMJTFxCCqI+vgT8IsHHyE=;
        b=KJkuFIPYY6jdfORhaE+EsvbW6S+XZtFt+D7lSkcgIIeDZG8uIADEI/0h+MFkmb1Sr4
         NNI1DTilRn1LNPSy7jL1RpkucBtG+RjxVSffelFbdWxqa3kd8K7EMOBlgUoic3LyOOXY
         Jz3U5bVw3fAc/MVUaM1QHGpezhyRNCKxjAKzZfce29gAztHbplPFB3Gg9wMXGrsokQGw
         QvZ74nZ8rXKpj8x/MKXHP+r+R78Tr/7F5/Rs9xqHR28yk641MtELBnM07U2qcjsIHYoq
         ubFKGmJlTi51WDpX/ZRg9ndRJxfUnx21F7WUc982OzSXvf4o1b6LtFSVZUks0SSuDI7R
         g6Mw==
X-Forwarded-Encrypted: i=1; AL+hErGvyG33P7q+Ib6xb2eohnjunVI8vI7XR9moD9J6UcEW0LPqoMgfekFgzS7umKt3z0QnqZqOvnPGaDmQ9g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/5hZRb6VplmpyODnRHv8gc6knf4e/h0CQbquNySdSIjtQsP6SO
	fBc46/u0maOIoJ5CvhrMGlAP6rugkrVCpEd2wpKudQvNOHcD1spUit3+WnncT6NLiQ==
X-Gm-Gg: AYBFou1yNGhPzHuBPyHoK8IO78E28F9Pg9Sp4LwtfLhO12A8b+hsPP0rERMyQOfIInU
	Os+ldB01H7+x4avbaV0RBsntdsRck76EUu86av1yp0vOzTBTd3O8tnoPmCWq3SQCmCrL3K3pwnl
	MLpd9kgCGaZC9NmLupAmpbogoi448x0KrcO6VSjnnP8dsUijz8T8yroOxWIp72uP0cAzw9R8c3s
	4wZ4LGYFA5cy4rxHXnJbad8IQTsPDFm4NPIs3/38nAjPu9MyxTY4tlZ24WAEiSRZv9lIp7SekVA
	YemfDEaHQwAMdGoqW5Y4dkOTlgqTSpp7AxOEwkUSpRwsCZ1LcFufo5/HE/edGlYi0i+RGgdw+S8
	LvTPls7Zz1fwc8IpEXtF/vTBgdsWspwmnZfUP+lXoMc609Dmltp5Nrqp+9hffAU/6nfk7UuVoZL
	Gzs4fM8eM+JZad8z6apfmEvDU/zkJQqNfvvxHYcey6De+AmwlJG1cW4xYfLyUrhDVXxZpKFR3w7
	xltEb6ZgHxUkpLO5W24MlqYZO5TjE2bZZ/8pt26SomyMOKzkAJmlm6I9RlM3yNXIjDG6bZ7v/FR
	vanWv9u8DAuufDHexuVl6b+K7I03hrkLhGZSJpKvR22lax6atmFTrifRAdktgAfC5ZQBrA==
X-Received: by 2002:a17:903:2a84:b0:2e5:e1de:9c3c with SMTP id d9443c01a7336-2edb91d9bfamr13050805ad.47.1794289762137;
        Mon, 09 Nov 2026 21:49:22 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d7e1c0sm4971905ad.34.2026.11.09.21.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 21:49:21 -0800 (PST)
Date: Tue, 10 Nov 2026 14:49:16 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry@kernel.org>, Nhat Pham <nphamcs@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/7] zsmalloc: redesign object alloc API
Message-ID: <avKwQ4IEOVfYm-8J@google.com>
References: <20261105044752.1997895-1-senozhatsky@chromium.org>
 <auy9UfB30AlYabV8@google.com>
 <CAKEwX=Nao4jWtY04FXEjxiHUNUhJU2A6nCZLqhRRm-dPBZTmcw@mail.gmail.com>
 <CAO9r8zP_K0NF0gt71Emh+2dXmUh+C27uiu5TsyBcGUdLbCus1Q@mail.gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO9r8zP_K0NF0gt71Emh+2dXmUh+C27uiu5TsyBcGUdLbCus1Q@mail.gmail.com>

On (26/11/05 09:39), Yosry Ahmed wrote:
> On Thu, Nov 5, 2026 at 9:37 AM Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > On Thu, Nov 5, 2026 at 10:31 AM Yosry Ahmed <yosry@kernel.org> wrote:
> > >
> > > On Thu, Nov 05, 2026 at 01:47:30PM +0900, Sergey Senozhatsky wrote:
> > > > Both zram and zswap already have per-entry structures that store zsmalloc
> > > > handles, so allocating a separate handle_cachep object per stored page is
> > > > redundant.  This series embeds struct zs_handle directly into zram and
> > > > zswap entries and drops handle_cachep, saving 8 bytes and a slab
> > > > alloc/free per stored object (2MB per 1GB of swapped out 4K pages).
> > >
> > > I always hated that extra layer of indirection, thanks for doing this!
> >
> > +1.
> >
> > The mental load saving excites me more than the memory saving :)
> 
> Oh I am 100% supporting this just for my own mental wellbeing, the
> memory saving is the icing on the cake.

Thank you guys!
