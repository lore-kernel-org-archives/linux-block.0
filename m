Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D511E495
	for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105696; cv=none; b=Rw+cNTuL9bWR5MfvQwTWxhPn+dTLodN+Y3FebtPxQbK8W42W7SbkrwZyfEwf7G5QyVSrUdJhh9d13h5c5vqTeA6TEQ6EwYroHrhIPFZ9GqU2wFozpEj5nS3ays4aLt7TUIsoTr1doMSYKO3pImCEQ9Ivs8Ngqnl+v0YhXDvzw9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105696; c=relaxed/simple;
	bh=HUTUtAJwOnQMmP4ReaCRv34dR7cQveXCjOS0OPc85O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6fegwUx5E9ilUUrmZb0qTqj/lraZTu4KSglbKpWLTyAKe4JOHcHnfx17HsKt8fZy5a77/0vcPAc1CvPgeRKUseLGwsl/IRxXhcNloUgOZS/vC7KsrlemjOrwdQiP4rIYTg2Svcf4VhlX7e78tDOlPZItlq1utKafprPvwlkzpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J50WwPI7; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J50WwPI7"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7d50e865b7aso3672527a12.0
        for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 08:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727105694; x=1727710494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=htTo4bA6hokXxaD54zIm5oQaYvd0c7+2dVU7JGOsPAg=;
        b=J50WwPI7dLLVNT82rD/g0CuuOnpT2eXDfqqtol1FU/h+cHp7WwfgotmIdVCThEOQLt
         V/1bS2f0wxf8RdpHyyCjY67EtfdPUlc4kwyCqbUnDp9w2Ir+HK4WbMfukDr1FqzShuCz
         NpIWXAPVt1FjeLeinjVy3tvsqcBqHyezO3xm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727105694; x=1727710494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htTo4bA6hokXxaD54zIm5oQaYvd0c7+2dVU7JGOsPAg=;
        b=R8uR6+8k3YNvWHB7//IezUy7/jFTOJ9bTSs9XasMr4utdxPs0lW6ZgVZwaKAPWdx4j
         FnIiqE+VnJaNwR/jTfb6Q8ZGcJLfd1Jr92Fyfu6X/ug8V8NZg4QZBPnViX+EewM++WGK
         YrW5H1MuIDMP7UgWv29KWnGlgv4fhVM2grzhAzXinvjtZCjcEHbSQt9eRmxc7n3g1MOE
         YD10CGh+/lV86WuWTeeUxQO/UyULWLK6cOJBwfPyYIpjTUtqgzhbr2HOedZteN3vc5PK
         anParkmB0f81999lhfcj3pz+JrGgPjUeEwgOIvUpIyOmtwIbP0gPy+fayBjl1AzZ94MJ
         yDgA==
X-Forwarded-Encrypted: i=1; AJvYcCXoaKL2NPPk9LA47vUcCGLJHatEr6AWKeVCtAsvG69D82zRMF/5uEd91CDNSHsBwAPOMENTf1Tea/Vl7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0BM80TseBec+gpvQyt0xF9kDqEpWYM8zVvR5kc+muByOIVnw2
	aiHxACykf3gHf/jGHgeJcOuXOlzZHXijmwq0b8ugL00SP2CpztG9eldag6dEyw==
X-Google-Smtp-Source: AGHT+IFMxCxBJJJxHj41XbzXl9Q6OwJp+/r0/ziCqyj2dh0P3QlbMT2L4a82gbq0YFQeekc/ifKulg==
X-Received: by 2002:a17:90b:5344:b0:2da:61e1:1597 with SMTP id 98e67ed59e1d1-2dd80cd73b4mr15760979a91.36.1727105693975;
        Mon, 23 Sep 2024 08:34:53 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fd63:e1cf:ea96:b4b0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef3c643sm9583520a91.37.2024.09.23.08.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 08:34:53 -0700 (PDT)
Date: Tue, 24 Sep 2024 00:34:49 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] zram: don't free statically defined names
Message-ID: <20240923153449.GC38742@google.com>
References: <20240923080211.820185-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923080211.820185-1-andrej.skvortzov@gmail.com>

On (24/09/23 11:02), Andrey Skvortsov wrote:
> The change is similar to that is used in comp_algorithm_set.
> This is detected by KASAN.
> 
> ==================================================================

---8<---

>  Unable to handle kernel paging request at virtual address ffffffffc1edc3c8
>  KASAN: maybe wild-memory-access in range
>  [0x0003fffe0f6e1e40-0x0003fffe0f6e1e47]
>  Mem abort info:
>    ESR = 0x0000000096000006
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x06: level 2 translation fault
>  Data abort info:
>    ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>  swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000427dc000
>  [ffffffffc1edc3c8] pgd=00000000430e7003, p4d=00000000430e7003,
>  pud=00000000430e8003, pmd=0000000000000000
>  Internal error: Oops: 0000000096000006 [#1] SMP
> 
>  Tainted: [W]=WARN, [C]=CRAP, [N]=TEST
>  Hardware name: Pine64 PinePhone (1.2) (DT)
>  pstate: a0000005 (NzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : kfree+0x60/0x3a0
>  lr : zram_destroy_comps+0x98/0x198 [zram]
>  sp : ffff800089b57450
>  x29: ffff800089b57460 x28: 0000000000000004 x27: ffff800082833010
>  x26: 1fffe00000c8039c x25: 1fffe00000ba5004 x24: ffff000005d28000
>  x23: ffff800082533178 x22: ffff80007b71eaa8 x21: ffff000006401ce8
>  x20: ffff80007b70f7a0 x19: ffffffffc1edc3c0 x18: 1ffff00010506d6b
>  x17: 0000000000000000 x16: 0000000000000000 x15: ffff8000808e85e4
>  x14: ffff8000808e8478 x13: ffff80008003fa50 x12: ffff80008003f87c
>  x11: ffff800080011550 x10: ffff800081ee63f0 x9 : ffff80007b71eaa8
>  x8 : ffff80008003fa50 x7 : ffff80008003f87c x6 : 00000018a10e2f30
>  x5 : 00ffffffffffffff x4 : ffff00000ec93200 x3 : ffff00000bbee6e0
>  x2 : 0000000000000000 x1 : 0000000000000000 x0 : fffffdffc0000000

---8<---

The above is not needed in the commit message (not even sure if the
backtrace below is relevant).

>  Call trace:
>   kfree+0x60/0x3a0
>   zram_destroy_comps+0x98/0x198 [zram]
>   zram_reset_device+0x22c/0x4a8 [zram]
>   reset_store+0x1bc/0x2d8 [zram]
>   dev_attr_store+0x44/0x80
>   sysfs_kf_write+0xfc/0x188
>   kernfs_fop_write_iter+0x28c/0x428
>   vfs_write+0x4dc/0x9b8
>   ksys_write+0x100/0x1f8
>   __arm64_sys_write+0x74/0xb8
>   invoke_syscall+0xd8/0x260
>   el0_svc_common.constprop.0+0xb4/0x240
>   do_el0_svc+0x48/0x68
>   el0_svc+0x40/0xc8
>   el0t_64_sync_handler+0x120/0x130
>   el0t_64_sync+0x190/0x198

[..]

> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index c3d245617083d..d9d2c36658f59 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -2116,7 +2116,9 @@ static void zram_destroy_comps(struct zram *zram)
>  	}
>  
>  	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> -		kfree(zram->comp_algs[prio]);
> +		/* Do not free statically defined compression algorithms */

We probably don't really need this comment.

> +		if (zram->comp_algs[prio] != default_compressor)
> +			kfree(zram->comp_algs[prio]);
>  		zram->comp_algs[prio] = NULL;
>  	}

OK, so... I wonder how do you get a `default_compressor` on a
non-ZRAM_PRIMARY_COMP prio.  May I ask what's your reproducer?

I didn't expect `default_compressor` on ZRAM_SECONDARY_COMP
and below.  As far as I can tell, we only do this:

	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);

in zram_reset_device() and zram_add().  So, how does it end up in
ZRAM_SECONDARY_COMP...
