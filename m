Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DEC13B584
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 04:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779943279; cv=none; b=am8N73fuwHMaUqZjHAXq9KugytWB9/Tyxlt9Pk1vUBZe45wBF08/dDDdbENfucK18wn29aZQEUaPgbNOVNdkSIdk5aDHUtiUhisBwtnWvmLz6i1B7z60P2HkNdO3FMiwfcuZZoww/t/bAUJZMoHeeom4+EfMjgXbvlcsSwPl5pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779943279; c=relaxed/simple;
	bh=7vt9Dx769oaUdo/bwZA0p41FbBu63/h0lAHrddyItqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=SOs5G9tF+wcwcRb2c4gP529iVDNkrP8mNazp1K88EMPf3UoV1Vp4GFex3K9CeZWD5LrIiU+WTNGw4KIah0TLX9NDkG86pU57pQoEcdlNfqbXmBSp8mTnEBI/txqNRPQNrMEqg29/CW+Mw4HWQw3uWoGBdxJWCuDtBse11bpG7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ir80Vd7K; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ir80Vd7K"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so5656713b3a.1
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 21:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779943278; x=1780548078; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:references:in-reply-to:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=du8cY++I/mag/xwhX2GLm0MJj99dlckXgLQrAUks2z0=;
        b=ir80Vd7KMRszgD6KxF5PflIhy6Lf8qjnyWHtUvkJMwMXbfO9MOPXcni6oNfQS2wFaa
         /GdtEBVrVPpxDgOuJXu5g+m44I5JfM62wZYfbbRoTnly0N5R8s9kT5maMDcORRAMaSqc
         LW4pMBTrdl6QrtnC4G9fvF/WkGrK6W3WB77UjGW0lJDkrP2AUFzYUahI97MGfpyHMqH2
         LiqH/6UWasIr0wgtyrdcI1i09/mQOWRioVHDd0poxy7eu3FsnQX440xmDHjJ1ZkCXfGu
         y1FyO4Rn7qZjDbxCUUMDxqXtOY6Y6noxGeWWrZQkW7IHr6Wa7KY3ho91oaCP8UM9fYp5
         MHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779943278; x=1780548078;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:references:in-reply-to:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=du8cY++I/mag/xwhX2GLm0MJj99dlckXgLQrAUks2z0=;
        b=ZnXrqT1oERdnVu20ZdKJuaAZgvzwdE5EQ+jch9k7z1ialMS3Wff/am9hk9qSQIMPc7
         62BVx/Xza8dCLDQLc31WPD2C83J04TyNGVxw/+QuXLDrLqQDeDaFYhD+ek0gsgmIkiEt
         LbeMi7FuhrZei4hu4Kiu5FHSiVOa45qEkGfb4Zlyej40H5flf5cxW3kF38bEBs3cn+/5
         /F2Ln1ldwoyrzeQP9Dizv2+A8e2w2GCM7MSTPMPIznq+P3ycbZQujra3iwkUWX8ZVT7V
         0mjOof5LytmUkKyxXW9XVPDR6QY6ST64kpqR9VRnoqnlyFDMX1gjmdl3VQJdE7dRiCRA
         95GA==
X-Forwarded-Encrypted: i=1; AFNElJ8cSJ968Iks2sD6FaEhUwQLA92jSVoG9CX45feSg0Donxcmvhp8GrUGa2cbA7m+ZXzaVhKatIomeIuyxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOn/F4nUKt6TOp3N9ndYM+iXE2KjEhJsXQ0lRfVowZhZyXXnhm
	sN8qQpCVgNbAK7Qr2FGUI5kwqnyagINUGMox1soGzxBZYsnUtZCYqCcn
X-Gm-Gg: Acq92OHcnFfU6AbKmSRPkyZlm43cgnlqGwWIViGkANCfUV4VEY/xvBGsTXdnuU2tjPJ
	Ow0LrLbEo+iqGar4Bt/WkgLNM/U9c/uxS0xTbj6GJsXIYYejHimoTZv7PKK0Hz0JoCm6KuCY51v
	VAKk4KweLOifjnjE5sGgzuQZ/voS/TbNqtWgi2IuT+XDvcJNVdn7BoUBSPbmc56+O5oFiHi1+mi
	SpOeD/4mPCakQRP4E/ZC5TVua9iPojb6PKaV1hv+O6UurN+arwnlkNwWaJ3hZjMknukPakFbBin
	j+PlcPDwwMIGJbzIXgPfMaAwVLdxOwwYHgVTtUQ95zz5XHDacoa5o+fhevzY7NdCmAFHZmABcHH
	rNIbOUYzj7CfxgRD70dAuxmmlOlqjCld0y9iSHsDhdANH4wyR/It6TUyVk7zy3ml5DbY1PIXihP
	OsDpTd9ZBs9QqamL/ENvPiHz5T2HxzYMQkSJyyHaStu2pkDSA=
X-Received: by 2002:a05:6a00:1c9e:b0:823:9b7:9c0e with SMTP id d2e1a72fcca58-8415f35c689mr23241583b3a.34.1779943277978;
        Wed, 27 May 2026 21:41:17 -0700 (PDT)
Received: from localhost.localdomain ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841f3cbcddbsm586596b3a.4.2026.05.27.21.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 21:41:17 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yisheng Xie <xieyisheng1@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/2] zram: fix UAF in zram_bvec_write_partial() and drop dead bio plumbing
Date: Thu, 28 May 2026 12:41:11 +0800
Message-Id: <ahfHZs0j2Zzpp/aq@debian>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260528-zram-v3-0-cab86eef8764@gmail.com>
References: <20260528-zram-v3-0-cab86eef8764@gmail.com>
Mail-Followup-To: Cunlong Li <shenxiaogll@gmail.com>, Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, Yisheng Xie <xieyisheng1@huawei.com>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, May 28, 2026 at 10:48:43AM +0800, Cunlong Li wrote:
> Patch 1 fixes a use-after-free in zram_bvec_write_partial() that
> happens on PAGE_SIZE > 4K configurations when a partial write hits a
> ZRAM_WB slot.
> 
> Patch 2 is a follow-up cleanup that drops the now-unused bio parameter
> from zram_bvec_write_partial() and zram_bvec_write(), no functional
> change.
> 
> Patch 1 is tagged for stable; patch 2 is not.
> 
> Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
> ---
> Changes in v3:
> - Update Fixes: tag to 8e654f8fbff5 ("zram: read page from backing
>   device") per Christoph.
> - Link to v2: https://lore.kernel.org/r/20260527-zram-v2-0-2fb84b054b5c@gmail.com
> 
> Changes in v2:
> - Add patch 2: drop the now-unused bio parameter from
>   zram_bvec_write_partial() and zram_bvec_write(), per Sergey's
>   suggestion on v1.
> - Link to v1: https://lore.kernel.org/r/20260527-zram-v1-1-ce1acb2bfaf9@gmail.com
> 
> ---
> Cunlong Li (2):
>       zram: fix use-after-free in zram_bvec_write_partial()
>       zram: drop unused bio parameter from write helpers
> 
>  drivers/block/zram/zram_drv.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> ---
> base-commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7
> change-id: 20260526-zram-b01425b7e6c6
> 
> Best regards,
> -- 
> Cunlong Li <shenxiaogll@gmail.com>
> 

Test results for reference:

Tested on arm64 16K-page QEMU (Apple M4, HVF) with KASAN enabled,
kernel v7.1-rc5 (base-commit e8c2f9fdadee).  zram0 backed by a loop
file on ext4, fio bs=4k randrw (4 jobs, 120s) against ext4-on-zram0
with a parallel loop triggering idle writeback.

Without the fix, KASAN fires within seconds:

  BUG: KASAN: use-after-free in copy_folio_from_iter_atomic+0x830/0x18e8
  Read of size 16384 at addr ffff8000d1168000 by task kworker/u16:4/321

  Workqueue: loop0 loop_rootcg_workfn
  Call trace:
   memcpy+0x3c/0x9c
   copy_folio_from_iter_atomic+0x830/0x18e8
   generic_perform_write+0x308/0x558
   ext4_buffered_write_iter+0x140/0x438
   ext4_file_write_iter+0x868/0x1004
   lo_rw_aio.isra.0+0x838/0xc94
   loop_process_work+0x2f8/0xdf0
   loop_rootcg_workfn+0x20/0x2c
   process_one_work+0x560/0xc10

  page: refcount:0 mapcount:0

The async backing-device read bio still references the page after
zram_bvec_write_partial() freed it; the loop worker then writes
into freed memory.

With the series applied, the same workload runs clean for two
minutes with no KASAN reports.

