Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F1319006F;
	Fri,  7 Mar 2025 23:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741388628; cv=none; b=Kkj/D3rNrP0rWjDijtnrR0V4z/TejUYq+lFgSZy+MQl2YMwIRdA8jsWb/bppWMPeShgwIey1ZkBw3B8WeiXYUqyoez6nxLFl8Qrau7h1VGhQjc1Oh2apuXYqeR+BbJ5LgDHChQolthz9hYjWFbaNpKzJm5iZPhIUTNoQhCVleoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741388628; c=relaxed/simple;
	bh=Cg7tzJF/cbegOUZRx8dSKGVw+mp1jDxyJ6VHBTQ9Zg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCqT/DIM99x5UvxMs34jQ5glf6mHjpCibe8knipdGOvdtRaAc1Q3GbVZA1nzlcDFofijIuKoWSZwvNWLHoHUitl3fDUo7sorXGTzbW3YEiHc6q1uB8LZiKJxYgkpicPqLdQeqxQ6IG6sWXWxaB5HzP+XbLKVjYmFt8nPKLWTfgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjhZsWV2; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjhZsWV2"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e6c082eac0so20967606d6.0;
        Fri, 07 Mar 2025 15:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741388626; x=1741993426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTzXTB5/hI3k/tUV1QdjmWKVi1pI+jp0+a6jtCFIsMQ=;
        b=WjhZsWV2y1HFWmAQCe1WmiOHFfcnHIaDDSzotFlZM0Yl/i82aw/Ih9uyMAYAt3CECN
         es5OhClkCzuAC+gnqGD3XCuXj+D973TV5qLhz/8PmDFKGIRWIdV8n57A82l2ty/apc+C
         ynXhsaAC8+UzQFXXqUi/kmeq97Eq8HBkty56sNOECT6CeegUTNUGfhuo+TIRRYe2KVKj
         z3SrA+dZiEJ03XPycNIVtE5Otm30862MlazGdBHXD0eMdNRAChWdrmjuKgNZCh79of9V
         xeju6ATIPjstGojf9NjTZSgpjpxLp7MJ2Cr2BuvEcIXe49aHjaCPEKSdBd08gF3SuBLH
         x1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741388626; x=1741993426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTzXTB5/hI3k/tUV1QdjmWKVi1pI+jp0+a6jtCFIsMQ=;
        b=UO/oyxN8Ztsf8LRffzZyJ1rBWYPf3N1h//G5exbonNyoaOWeYD1D4bwJHU3GFBiL0P
         mX8sfg0j8iVt7Qsmr43wNjc+dmPTod1VdBMiTOiJbcYaWWRtkibCvi9YQ9R6/hyLg9e/
         V/97cVMCNclxoEYTDsPgLUqJlFKeEgkXfQNaSS2N/PkiShUxc/R6P1Y2L/kOdFuikWxj
         J9UsfD+1xa/7WQOgFJ/GYa0n96QsuBZ5MY9JlslUdvzHDzemJyy5Lp0Eeh4vi0+8Kar9
         cxN88kcGsVGKN0QfvPN5EIfRWf3MrphhBm6j/Od9GR/VsbPI7src7NCxYE1OInNILLUF
         HAYg==
X-Forwarded-Encrypted: i=1; AJvYcCUL6Y+clQBfCP2cUbwcL17QY9N8o7cNbbTSw5pLqiBr6RwoGYJSwlJhidv3fpBrwINNjoqJ3DMXxkw+Ug==@vger.kernel.org, AJvYcCVF28HNyzflLuFaL+Us1nak1IRAPR2tstVfLlMb3bdDwzjpG42JEdwXwaGyDHmk/A+BsLB8hi4fE91olvNo@vger.kernel.org
X-Gm-Message-State: AOJu0YyxLysVhPzE2+fymAUR4DV4cxlXe1/b/UkrsBNJy2wRWEO6faKs
	ywiCqydT2Oa9wi2iquQx7aNqTryw8RMYJUHwXUeoV9sUDsy9KeKh+nau4XCa9sUiAp7HcFbxAkZ
	s04IiaHTsfP81/Kzaj1llhw1PwII=
X-Gm-Gg: ASbGncu8o1dRhC1qZtAKcWyUV/JmBYd6JZUiKOklSfwdYrRbI4oAOGCHwSfJs3f64PD
	UCwzHXPWazSJ5J1BcyazBB8kD4Cl/1Hu3vMV0zG+Ij2S9xAn2Hj1gaxEUUNH9pZ5qEmgkhqJPp2
	sXqCsdxmko/EzVfzJiAeYHmsKspymurtfe6gDf1zv3ng==
X-Google-Smtp-Source: AGHT+IGuZ0NkG/KYo9Dv4g1oyD3XwK6X16DBM6QY/A6W3C/6eEhj7vqNq1AeDarxJvsQFObtM42FXnLLMg29Plyo2bk=
X-Received: by 2002:a05:6214:2aa7:b0:6e8:9e9c:d20f with SMTP id
 6a1803df08f44-6e900621afcmr58352476d6.21.1741388625281; Fri, 07 Mar 2025
 15:03:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
In-Reply-To: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 7 Mar 2025 15:03:34 -0800
X-Gm-Features: AQ5f1Jr_FBnz9qk1uNlckq4_7pHKTqldI029tYPnmq326QX8Uckh0mZErYX0PQo
Message-ID: <CAKEwX=NfKrisQL-DBcNxBwK2ErK-u=MSzHNpETcuWWNBh9s9Bg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Improve Zram by separating compression context from kswapd
To: Qun-Wei Lin <qun-wei.lin@mediatek.com>
Cc: Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Barry Song <baohua@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Casper Li <casper.li@mediatek.com>, Chinwen Chang <chinwen.chang@mediatek.com>, 
	Andrew Yang <andrew.yang@mediatek.com>, James Hsu <james.hsu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 4:02=E2=80=AFAM Qun-Wei Lin <qun-wei.lin@mediatek.co=
m> wrote:
>
> This patch series introduces a new mechanism called kcompressd to
> improve the efficiency of memory reclaiming in the operating system. The
> main goal is to separate the tasks of page scanning and page compression
> into distinct processes or threads, thereby reducing the load on the
> kswapd thread and enhancing overall system performance under high memory
> pressure conditions.

Please excuse my ignorance, but from your cover letter I still don't
quite get what is the problem here? And how would decouple compression
and scanning help?

>
> Problem:
>  In the current system, the kswapd thread is responsible for both
>  scanning the LRU pages and compressing pages into the ZRAM. This
>  combined responsibility can lead to significant performance bottlenecks,

What bottleneck are we talking about? Is one stage slower than the other?

>  especially under high memory pressure. The kswapd thread becomes a
>  single point of contention, causing delays in memory reclaiming and
>  overall system performance degradation.
>
> Target:
>  The target of this invention is to improve the efficiency of memory
>  reclaiming. By separating the tasks of page scanning and page
>  compression into distinct processes or threads, the system can handle
>  memory pressure more effectively.

I'm not a zram maintainer, so I'm definitely not trying to stop this
patch. But whatever problem zram is facing will likely occur with
zswap too, so I'd like to learn more :)
