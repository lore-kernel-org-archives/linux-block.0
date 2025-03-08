Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE5D196;
	Sat,  8 Mar 2025 05:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741412507; cv=none; b=emd4fHodrZoeV45Dng/nJ/GFwP0cQCGXmHYJ74oKoPW9+VtGUoM9N/telqqzWNbBKcgOQtOFa5W+AniWljSOep8QlPbdXuU0fOA+s7P8AfuXjD13VsWWazLCbWit6jW2uW0OlD2gMwys1/xOH1sOs4O/OYzqYiE/jGjmLb/NexY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741412507; c=relaxed/simple;
	bh=vpj7oqHxRtgino/k70h8+Z75eRS1qaORviyYbtyKUSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBj4IvHlu3Koy9+WluhFUm4scm4+5ucACy/6k/GKNo9DkPxHNYKD9hyD6zf7A3/d7fieLQQXQ6ZIk9tqHrsUYxtJWW9WllXHyVeinrMw73Lo3sN+q8yYXyY1ccafScTkklAri7TmsfxUFsNnlsmlrBs4WxC/esHVCGJGgsIOhcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJZGHiVY; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJZGHiVY"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86b9b1def28so2275138241.3;
        Fri, 07 Mar 2025 21:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741412504; x=1742017304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJmfZfA0tNqTdg8bAfZWDeUCZMhc8ZXDtBpkPMyhAvk=;
        b=jJZGHiVYRzfiHPLDzHe5MaFX/aLJRVQ+iqfszM7wrju1+Z2GEvJhSWxSrbWaeGL9N3
         cKEwn6eVqTRRcC2XPer+Xyj9EWPNI6yqRsUn2vP5kvkWzhfXBAuUYL8FYQkUmRlgPJBn
         2uFPS2eggL5UCtIxCMGKvRjqbxVQPN7gEDt4n/2/I7uKMlNvSiTWtxfzZ4KJJfsGrfle
         Z021rN5T8OX8lzapp5AylXRc0GcktCSqVuqJ0Bu+LP5KDlPWEto0Uh2I2opB/fEBBZWM
         FQH6uzvieQv52IbKw28yz09atTj6jk1yLz3mmRfCn4nLprXFSl9vw3pRPQ7g9vlP5L7H
         e6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741412504; x=1742017304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJmfZfA0tNqTdg8bAfZWDeUCZMhc8ZXDtBpkPMyhAvk=;
        b=cxfJWjJMSOPJaC+mWCb4PmA6hKd7B/9yemj0YB1aIVl2tOIGLsUjB0GaaTd/CP4VUk
         a6WrA4+43U45iepT5JmtuPZc87FUFbQfZUQ8LawGx0zvlxEmOLdsBdc44QM2fbTMmN3z
         wcOgMQHHRiiAKQylGN06TK/7yiqMC8fz64HDu2TqNy4LM8PHuGxCnVf8Kheiqe3Cs8rj
         Fm1AiSvyHB0LChhCQFUby8Rn9qePBGvDLZNr7tv/Y3pwHcsAhFqee8sr6wGauNqjIJZ8
         E0R4hEsjpfzytrFSQt84Y8wnErjW1uIUfw8dXmkYAy29Z/GIFuPOWnJqSofpm7GlsZBJ
         amqg==
X-Forwarded-Encrypted: i=1; AJvYcCV01jjtBtTEh5myg1fA2E6W8gHc8MH6H7480wX1AmVme8m5kUnBD6AKBApi7ECRWlnb4WFy2Mm+00zt1g==@vger.kernel.org, AJvYcCVoUOdzDUC+hsLikxTsGxt7ZkTurHtKZGLzG6utNrEtmDgQDsyLeJT5I8tIgP2ulTWnI+f0cZwtncU4sY14@vger.kernel.org
X-Gm-Message-State: AOJu0YxSvTrYYRhGs9RDM8SaOsnf+VHQ5qQrD80j+nbZRMzIdT1qpFHU
	o8cRbRXGVXDA5v8LV2cQCX2tOOsGQ7D9N8D/t1HG5v5dn2Jkk3na7rzi2V/b3/iwlc3+LbjUhK3
	Ta0QOwIrR+ac/s5xEOzAL4d3O6i8=
X-Gm-Gg: ASbGncvl2JDk1oi/O3xr8kQHL3RnxXZ1kiUw84AwqOKV0OvUFyY9u/Zuun5wfGOKM4D
	jPEvcdJsH6LVgkBW3Un5QSsraDe0rzsGZK/n/PD2hI0bN/FpDVaikkPzmrIZcDWKreVEMt4n7Ck
	X1l6dShcXOAlwGJ2FNVGZ1ETeeUdkQVLA49Z2h
X-Google-Smtp-Source: AGHT+IHHggIPKrL5d8yR6LTugXbBrgtYx9QYjOVM0FXkszko5m8Bp+SYzJZbZ7yqbzdNsHG/XrgFTdExUecoVmk9yWY=
X-Received: by 2002:a05:6102:809c:b0:4bb:9b46:3f6f with SMTP id
 ada2fe7eead31-4c30a538979mr4607096137.1.1741412504595; Fri, 07 Mar 2025
 21:41:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com> <CAKEwX=NfKrisQL-DBcNxBwK2ErK-u=MSzHNpETcuWWNBh9s9Bg@mail.gmail.com>
In-Reply-To: <CAKEwX=NfKrisQL-DBcNxBwK2ErK-u=MSzHNpETcuWWNBh9s9Bg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 8 Mar 2025 18:41:33 +1300
X-Gm-Features: AQ5f1JoraQfrjgklIeJVnsPlZLYjnVJdWtNTlR00z_Bw9q9Ie66lMyjY9JB8lAo
Message-ID: <CAGsJ_4ysL1xV=902oNM3vBfianF6F_iqDgyck6DGzFrZCtOprw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Improve Zram by separating compression context from kswapd
To: Nhat Pham <nphamcs@gmail.com>
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

On Sat, Mar 8, 2025 at 12:03=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Fri, Mar 7, 2025 at 4:02=E2=80=AFAM Qun-Wei Lin <qun-wei.lin@mediatek.=
com> wrote:
> >
> > This patch series introduces a new mechanism called kcompressd to
> > improve the efficiency of memory reclaiming in the operating system. Th=
e
> > main goal is to separate the tasks of page scanning and page compressio=
n
> > into distinct processes or threads, thereby reducing the load on the
> > kswapd thread and enhancing overall system performance under high memor=
y
> > pressure conditions.
>
> Please excuse my ignorance, but from your cover letter I still don't
> quite get what is the problem here? And how would decouple compression
> and scanning help?

My understanding is as follows:

When kswapd attempts to reclaim M anonymous folios and N file folios,
the process involves the following steps:

* t1: Time to scan and unmap anonymous folios
* t2: Time to compress anonymous folios
* t3: Time to reclaim file folios

Currently, these steps are executed sequentially, meaning the total time
required to reclaim M + N folios is t1 + t2 + t3.

However, Qun-Wei's patch enables t1 + t3 and t2 to run in parallel,
reducing the total time to max(t1 + t3, t2). This likely improves the
reclamation speed, potentially reducing allocation stalls.

I don=E2=80=99t have concrete data on this. Does Qun-Wei have detailed
performance data?

>
> >
> > Problem:
> >  In the current system, the kswapd thread is responsible for both
> >  scanning the LRU pages and compressing pages into the ZRAM. This
> >  combined responsibility can lead to significant performance bottleneck=
s,
>
> What bottleneck are we talking about? Is one stage slower than the other?
>
> >  especially under high memory pressure. The kswapd thread becomes a
> >  single point of contention, causing delays in memory reclaiming and
> >  overall system performance degradation.
> >
> > Target:
> >  The target of this invention is to improve the efficiency of memory
> >  reclaiming. By separating the tasks of page scanning and page
> >  compression into distinct processes or threads, the system can handle
> >  memory pressure more effectively.
>
> I'm not a zram maintainer, so I'm definitely not trying to stop this
> patch. But whatever problem zram is facing will likely occur with
> zswap too, so I'd like to learn more :)

Right, this is likely something that could be addressed more generally
for zswap and zram.

Thanks
Barry
