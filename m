Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDE424887E;
	Fri,  7 Mar 2025 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376082; cv=none; b=OVO+LjWl2L72QoKqpS40mikqnGK9xmjTH6W2UIXhKOp25sLyVdNEQTv32qZTg6THnDr7qkRH9mts3a+Mq9m6xmmmBm+HYQFHWP4MFEZ0wl2s0I+zzWDbaS19XmP0zSNqBcNImoRGs0p02sXmqe9r4MwoejCyqtv/W5sKDmwJ4ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376082; c=relaxed/simple;
	bh=NS3+qwkRqQGih47wxvEpGp/XIBdosnSvkbSWoPDoXqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odnSkTxffa95aFu8bKTG3M5Mv/WFxp8HqClQZiaOMAl3cs+uRxH54yfi/WPfL/03LuRdbN0LLrRVvOXi5SnxmuA621wypmURBEawH7Fa+T+ZWoxdzE+x0c1/htqmOB99YY7asrRb15UZpsPHTlR5VmKoth4FuM2mQLnjjU/vXIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HH0DCZ/2; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HH0DCZ/2"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-520847ad493so1928690e0c.1;
        Fri, 07 Mar 2025 11:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741376080; x=1741980880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsLIF0KuSa0+9gIStTKUSkGySCuhFSqgeXthFQ3bTsE=;
        b=HH0DCZ/23Tgjotrc8xGOFdSeAKOZxIfSYRxB1l+v4Kpn4zoguud6TOlXLopRgmztj/
         L4CLINNRNQsFOFwRUNW3eBCZAU9TPCLSSiIOWaf+SBTvI6RJ+Mv7Y1KNKhq1DSdX3o/A
         sVmtZDPVnwYNvMA3n1Ge/VLXJk2KayjT/bsLLZPdaI/UTVGV4AEMkyDgMir1P/a+kKeb
         1BLNYXfN4FR3AZsj6jEBnWsjatrHXUdFGpDxKxiGOHvwNAOLBQI+Q2EXX3/8hf3xzfAe
         r9Wf6B2Ndwq5q1r0+D7IN+EJzTXMw9BwFutujNzNCMKgUU/9y2Kg9WrMTLoXzB1VT3pb
         ZWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741376080; x=1741980880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsLIF0KuSa0+9gIStTKUSkGySCuhFSqgeXthFQ3bTsE=;
        b=nYzPbxUcNSL8+t5gdEm4i/0C2++lMBa3vf6Sp6Dg1qoif9nEHHEJWvzaYVx+ZHzB2u
         gQAV4GCb16v30Je2RPY3rgPcXpGGKLgKKFOXHHR8NSndGSPKZ3BnMUR+8pBCPYHM2tm1
         q+mdHhItcduze6eXIrPcm7ioDvxIGtmqr8z/AHm/O9yf38gtYMKCRxjnDeO8F/BtpZxX
         TSomc1+YKCcVzvfeuONnkuJErYhdf0G3yIWd9i1Z0Hy5ad2ben2m9L9m/xPQM0hwNr/r
         2Sx6SUvY91DUDSbgHlGOrrNDrr/qtfHMy+slXpGpOirjJ9tO/3yyA2hp8PPeMdGN7B27
         OPDg==
X-Forwarded-Encrypted: i=1; AJvYcCVEbIIYMfMGnJCJkV2oOXsRJw1+GorlVvPg2VHiJGJTWFNuvUIa0e5xpFHaCD/azIx3uW065Dqp1vsTAg==@vger.kernel.org, AJvYcCXFdwNyjpFr4XJqIF3ky2ooevg14qj8v1/h+8MAwBwNrPipOoKAZ0KVgD1R/Zydu2WgDB4AZI0/NpjK5jmp@vger.kernel.org
X-Gm-Message-State: AOJu0YwNxLnVUv3wSOslU3Lc9fcRkvtJFQak2j9TNrGjIvvbtg6cWhrD
	qV+7+I+xfJ/M8hYsnhi2VKaXDwYS2y3wa6L4pJZdZSRfS/45KhuyLvVlSK+HRrOyVo0klrLrdH9
	f4e77PyWh8JYGzdCgziEXX2/J/dgkwLbbYMg=
X-Gm-Gg: ASbGncu9OUuT5dWFNrDDcLW0WWa2bcH6ruc/MeyXZw0wfIvP/j+JBxRv7dFjmYwjQ+A
	iAhGB5bC+vjZnxnN0tJ57hzcnXipnmTdbkyFVGbFQqs+NizWj2ETLAqaR9kdiCTedN10yZllXf1
	+zqJLI9eCA1ixNusYPX8PlXZ58Og==
X-Google-Smtp-Source: AGHT+IFgqqDqQofofV/JVROxQO86oLW8odJwAWvtAGFI3OGLPlYXWCYP7AEGD+cKOelEyOiLNufTRKzO83KiF2eNeL0=
X-Received: by 2002:a05:6102:cd3:b0:4bb:e1c9:80b4 with SMTP id
 ada2fe7eead31-4c30a36790dmr4084956137.0.1741376069586; Fri, 07 Mar 2025
 11:34:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
In-Reply-To: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 8 Mar 2025 08:34:17 +1300
X-Gm-Features: AQ5f1JpJm8Pz4qzzGj-4qBmXe9E99kwhewd_E_rbXmfvrZ8eGN5IKtbpRd0ER-s
Message-ID: <CAGsJ_4z4yKRQiqMtGRr2bjvgVY6mmujdqyKyVgid=RUXr_9TbQ@mail.gmail.com>
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
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Casper Li <casper.li@mediatek.com>, Chinwen Chang <chinwen.chang@mediatek.com>, 
	Andrew Yang <andrew.yang@mediatek.com>, James Hsu <james.hsu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 1:02=E2=80=AFAM Qun-Wei Lin <qun-wei.lin@mediatek.co=
m> wrote:
>
> This patch series introduces a new mechanism called kcompressd to
> improve the efficiency of memory reclaiming in the operating system. The
> main goal is to separate the tasks of page scanning and page compression
> into distinct processes or threads, thereby reducing the load on the
> kswapd thread and enhancing overall system performance under high memory
> pressure conditions.
>
> Problem:
>  In the current system, the kswapd thread is responsible for both
>  scanning the LRU pages and compressing pages into the ZRAM. This
>  combined responsibility can lead to significant performance bottlenecks,
>  especially under high memory pressure. The kswapd thread becomes a
>  single point of contention, causing delays in memory reclaiming and
>  overall system performance degradation.
>
> Target:
>  The target of this invention is to improve the efficiency of memory
>  reclaiming. By separating the tasks of page scanning and page
>  compression into distinct processes or threads, the system can handle
>  memory pressure more effectively.

Sounds great. However, we also have a time window where folios under
writeback are kept, whereas previously, writeback was done synchronously
without your patch. This may temporarily increase memory usage until the
kept folios are re-scanned.

So, you=E2=80=99ve observed that folio_rotate_reclaimable() runs shortly wh=
ile the
async thread completes compression? Then the kept folios are shortly
re-scanned?

>
> Patch 1:
> - Introduces 2 new feature flags, BLK_FEAT_READ_SYNCHRONOUS and
>   SWP_READ_SYNCHRONOUS_IO.
>
> Patch 2:
> - Implemented the core functionality of Kcompressd and made necessary
>   modifications to the zram driver to support it.
>
> In our handheld devices, we found that applying this mechanism under high
> memory pressure scenarios can increase the rate of pgsteal_anon per secon=
d
> by over 260% compared to the situation with only kswapd.

Sounds really great.

What compression algorithm is being used? I assume that after switching to =
a
different compression algorithms, the benefits will change significantly. F=
or
example, Zstd might not show as much improvement.
How was the CPU usage ratio between page scan/unmap and compression
observed before applying this patch?

>
> Qun-Wei Lin (2):
>   mm: Split BLK_FEAT_SYNCHRONOUS and SWP_SYNCHRONOUS_IO into separate
>     read and write flags
>   kcompressd: Add Kcompressd for accelerated zram compression
>
>  drivers/block/brd.c             |   3 +-
>  drivers/block/zram/Kconfig      |  11 ++
>  drivers/block/zram/Makefile     |   3 +-
>  drivers/block/zram/kcompressd.c | 340 ++++++++++++++++++++++++++++++++
>  drivers/block/zram/kcompressd.h |  25 +++
>  drivers/block/zram/zram_drv.c   |  21 +-
>  drivers/nvdimm/btt.c            |   3 +-
>  drivers/nvdimm/pmem.c           |   5 +-
>  include/linux/blkdev.h          |  24 ++-
>  include/linux/swap.h            |  31 +--
>  mm/memory.c                     |   4 +-
>  mm/page_io.c                    |   6 +-
>  mm/swapfile.c                   |   7 +-
>  13 files changed, 446 insertions(+), 37 deletions(-)
>  create mode 100644 drivers/block/zram/kcompressd.c
>  create mode 100644 drivers/block/zram/kcompressd.h
>
> --
> 2.45.2
>

Thanks
Barry
