Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1741D139
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785168377; cv=pass; b=Y0nQmyX0GGV8m8oFuc7DEePo2Ovbh6mQlKubZnL1R8kE3GWOAQ5ZkjfwRLdo3IVEnvTVHLaylT7jGGSKUML4CpRnX/8CmPVu3j2i7e7z6jCEYWqOomCWbSjJDQaHSu6pbb1zO3Nip4kBOrJhSLngmvEd+3eJxGe3YFIwtTE7A+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785168377; c=relaxed/simple;
	bh=HN7Dc3zRGfNtD+a7XKzCiycRtddeBkARfTvs9hvycEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEQGWaI+X1mfhJz5fdPa5z9dFUE3e1c+VnbATSZeQwXMGe6VgeLefoJkupWY04tkPiiquaImN7kOySUlKtrCD2ZCfBJt7sNMx6eANRk4DW3JvNeMoP/2f4mZZDDg3zbCALmxUp4l7LMOFnC2OZIppSsHZYnkj29oXj7Q8QGKErI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BW2WOicS; arc=pass smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BW2WOicS"
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c15de09d5c4so175884366b.1
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 09:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785168374; cv=none;
        d=google.com; s=arc-20260327;
        b=kUAOxN8/0M4193yr4vno6RVF4eOrJWsDhZ/VXJXaZpAKCDlyR7liupl4kMNFGzGvzq
         VN4yKay+pUTvX5ZkFZl4eTmkKzGIiB3h6h0JaQCWNXrXuAw0hpbZ6WERtVgiCEx/wEHG
         jyIf0C3jv3Kx3A/TdUx/8faJ39GgX/JUWqH2cD4F8nLrrzv8o2TM1LlrVMabqnx6qQqQ
         z2eQbYYY+MDtr8iOz4okhZiHkn8UvdCgb+zT1Zg+rj887fKqMz7wRG3BLVHfovwmFui4
         jC3OHF1OvXI4v5U9nyosZMhEisQy34v9Cu7pxVPKAAs2bFiE1/gjnNNTEhFsK7KBkm/b
         kyGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9Ou8rcZjXvbKv/FzjMh0VDBFSOdgcA6e8f8+Th0rM6c=;
        fh=cMRoR5iMxpNGaikAk694qFdZ9xTR0+fszC4MFwgcCic=;
        b=HDTDgtmMOi+3Y7upyggggUSFvWEMtl/9ejuJ4I/VAQOQ0tRv/3LnNevqHbemxkAGh3
         FVnOvS2cRSnh/tAf5TcbWPG0RRDhBsF2DgU/TCbK+CK9+a/Bp7HFisTv1CX/1lIk7h3M
         jLwUZ3W8ybeySyzaBtVoxS/yyW0GWTIW6aNMoplZFV2gZsG+0qXzMP6C8m4shVhngspw
         AMlX/snOHsLKUYL5rXdFoWtb2LDJ0uWdao6vXoqxUq64BYnt4+f0zv1IqO3PCzGiB0Ye
         ItGpmU/4iwX5wyLmL1VR4Tx+dvyxvJzWO2pAOo6J8GOMBHJqaAUqCMRr1aXHrkN2winR
         qlqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785168374; x=1785773174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9Ou8rcZjXvbKv/FzjMh0VDBFSOdgcA6e8f8+Th0rM6c=;
        b=BW2WOicS5BREBtqYhK4utHZ+Krgn9+2a3zZioOiuKHHe3xbb4ToKO5p5DYTRgTU0/S
         +HpojofrtaN1uWfZuxpKn6KrK4ISwgm7VUJp86u0UTbodJjY8F6xeFQwt0A3JsFG2NmB
         AVbNY510cRlxSVNI7CF9azyqRjIa2tZ8Mf10SAjfaqZ0HzDlc7jbqenqTH/B0XE2pzaD
         Vf0jnyHLqVsp66mUPF1J3WvYS5Xszq2kk+fsms6IeqY8LU+pbY4QBIOoFBsfw2fZeNgC
         99/2uoPlydtGtvt0CynTaHxWA93Wp6tTy2jp4i1d1iLSwIpw3dj6o4M6hqG4oOHl/9pg
         kK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785168374; x=1785773174;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Ou8rcZjXvbKv/FzjMh0VDBFSOdgcA6e8f8+Th0rM6c=;
        b=GXYkjl7Ksfklvv8yYBbg6GR6ajC4cedlD4sOm6F8OO+/xaE/0vmYL2qRwTh5VEix+z
         o8WUrqiaTO60Dw9OTZpmPb4GrJ30MWFkWXnlzuU4Dilz0TisSNuY+ergKaDAgl8J1wfi
         yhsAZJWXq5ZwfIey/I/inBlEEGtDa6VGnGAMgFAiDTvIr1sJZgg7n5p+FZ0M3BVdIWoN
         zehYFJZd0oJYFgrsiCovXDjuZHwboB9XmpY5m4dzrQV4iYiH+iBS5VJycNjo+Z2l2Mvu
         0dfJD9CKb4W3Lv3XvA2LLl6ceW8qVlOKHvaprVUvUjbQ1rNO7xbIs1TbL76WjdeVUEWE
         35Pg==
X-Forwarded-Encrypted: i=1; AHgh+RoYAIke9jGSBzeXZGfB6oTjHhf+j1ROzBCAR9WgwDrBXoU45qtdHolQ+AGIbRjEkd8/uu7wZNlQEfhvyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxG0o0FFApIu6GOSuq5Uz/idr8tOIeAaaDgrxj0dv2fqoFTVkJt
	fhAj30IhlJ/XuM/eYyc/aNOLwNxogLM81S2mXPoGOQ+dJwwxQQBiTk2N5YfCLGXTVDZtI8RyBHD
	FpenGh9kxVwWvchd+LFpdERvnUK6MUeY=
X-Gm-Gg: AR+sD134l5boLsuZ2whc/G4hp3l4aXlt/9UN+UvIFVjHmqdGUwN2xjG4PAqVWCGvxIi
	3C40oEg9UgAdbNwtXrjSu5emQAplZF2ELHkEex2rLBOtZhm0UihgYHqZULAs8tNPQZjXSAXiWF7
	LXl4fN5s3K9tPWyntGU4lW7HihwhF8MwYJA13bzPJUbByEbLollHQqXe905676jazaalZEUPWQg
	/iCUy4MdyLDSJBf2W4aS/ZFsOgoaJOhaFJmBeLn3w/xKbvIXFESC/pdlSqA/fg=
X-Received: by 2002:a17:907:1ca3:b0:c12:8b1c:454f with SMTP id
 a640c23a62f3a-c1f5ee662c3mr73259866b.2.1785168374013; Mon, 27 Jul 2026
 09:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627070216.13511-1-haoqinhuang7@gmail.com> <amL0Mb8NN4DhPgKm@google.com>
In-Reply-To: <amL0Mb8NN4DhPgKm@google.com>
From: haoqin huang <haoqinhuang7@gmail.com>
Date: Tue, 28 Jul 2026 00:06:02 +0800
X-Gm-Features: AUfX_mxPWpz4D9bLckWRiiI2XAEvYyTWN63QnzKkjRBNEQA2pZfirWw0fubLw_o
Message-ID: <CAEjiKSntJKSaEeQe8YbtNe=6574=kx-y4CXKph6u_F04O=3kFQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] zram: fix zstd dict use-after-free on per-CPU error path
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: minchan@kernel.org, axboe@kernel.dk, terrelln@fb.com, dsterba@suse.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, rongwei.wrw@gmail.com, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 1:17=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (26/06/27 15:02), Haoqin Huang wrote:
> > zstd_setup_params() creates global cdict and ddict stored in
> > params->drv_data, shared across all per-CPU contexts. When a
> > per-CPU zstd_create() failed, its error path called
> > zstd_release_params() which freed those shared objects while
> > other per-CPU contexts might already hold references to them.
>
> zstd_release_params() sets ->drv_data to NULL so we can free params
> only once.  In addition, "while other per-CPU contexts might
> already hold references to them" -- other CPUs cannot do anything
> with those params, the device is not setup and we cannot handle any
> IO requests, right?  There is no double-free nor UAF there as far
> as I can tell.
>

You're right.  On the init failure path, drv_data=3DNULL prevents a
double-free, no IO is ever submitted, and cpuhp_rollback_install()
properly tears down the per-CPU contexts that succeeded (which only
calls zstd_destroy(), never touching drv_data). So the system doesn't
crash or leak -- it just means the global cdict/ddict get released by
the per-CPU error path rather than by zcomp_init()'s cleanup label.
The original commit message was poorly worded, I'll fix it.

> > Remove the premature zstd_release_params() from the per-CPU
> > error path, the global cdict/ddict are properly released later
> > by zstd_release_params(), called from zcomp_init()'s cleanup
> > or from zcomp_destroy().
> >
> > Fixes: 6a559ecd6e7e ("zram: add dictionary support to zstd backend")
>
> What exactly does this fix?

It's more of a correctness / ownership fix than a crash fix.

The per-CPU zstd_create() should clean up only its own context
(zstd_destroy). The global cdict/ddict in params->drv_data are
created by zstd_setup_params() and are conceptually owned by the
compression lifecycle (zcomp_init / zcomp_destroy), not by individual
per-CPU callbacks.  Having a per-CPU error path call
zstd_release_params() is a layering violation -- it works today only
because the NULL guard happens to mask the double-release.

The one scenario where this could matter is CPU hotplug after the
device is already live: if a hot-added CPU's zstd_create() fails, the
old code would free the globally-shared cdict/ddict while worker
threads on other CPUs are actively using them. That's admittedly a
low-probability corner case, but fixing the ownership makes it go
away for free.

I'll update the commit message to reflect this more accurately.
Does that address your concern?
