Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA552931DB
	for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 01:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785201591; cv=none; b=dniAxIBiMIOaWUXco1Q/fCOnHXShqQrO2BqHfdL8aIg9Km4BNlylFThpRzkk2i7b4DCOJFJMP91eGXnJViQA5wKVA9kIY69Ojmk2PWOKwEkrEQOP5Le7DiTpdJ5ag68gyA/43CO13lWe9UM+W+5qV4iT78ixdYGXp+GcllDiFxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785201591; c=relaxed/simple;
	bh=kFHJTUVvEE/uP8i2yFWYp1IcFU3L7GkLV7gw8MZJixY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icWuQ2+V0vRPl+0G+xufDWCeqpVwbBsZDbno7UBdSkfJjv+o8vk/y2iperYSUEQkDzgzQphaE7rUuMdoRJuFw+ONGuD/Ksvzxj9ZtIIU5UulgjplEKZTHNn8myecdW3HCtLWajjyGBz2sMrm/95v8Cj4U2jh+pF832Sl6V2NNz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hzujmP4E; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hzujmP4E"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cab973140bso44561615ad.3
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 18:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785201589; x=1785806389; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9EtjCXe6kHul7yZNnrYvGTEf90lw7uffdRpbms4sKAo=;
        b=hzujmP4ETQGq75XfiXCOyokfLrts72svnRvhUPiTMysIbeO3w5AEz/V7TzL/BsKK2W
         9Ce+dWEBDOZdZsF5uypUGi37tV6bet51eIIbVeRizxRFeVu0uuG5AukbWj89dYd6fwxI
         1byB15fCvsXplp/F3NjfaSm1UGz4M8ABKAPpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785201589; x=1785806389;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9EtjCXe6kHul7yZNnrYvGTEf90lw7uffdRpbms4sKAo=;
        b=W6qHd06fAyU/3NzbRQOq4XjlHJvIutWDMTMbCeFnWku3i5RGsCPDiJ0+omrUYawkEx
         dQRg4HrU5D1wuEu+n8/GbqDy9s2RDyCCBWugmFmE7KUv9xv45XYCQOSy/vyeBmko8kbq
         U7jbzP0LkV1ALxCz15dI/e/FwzM7TL7ocG6pV3UAZVI8Tw8SUje6Gsymjia80ua78jaf
         XERLkMO3vRNQRvRK/Pr0wMd6+ta+qvdkr5nf0qsvGv/kWeEjMEyI3eEhdrwirdAIyP9s
         f+LbASFbukwKNusAiF0dJo/HnRi7ifQhBQ+piDBiyrebFKLECYJbfOKqCSZpK8xFn55p
         uh6A==
X-Forwarded-Encrypted: i=1; AHgh+RqkmIwvcqpcRDO5UrYmRULrzonUac5onPJrMfUH+Td0885tU4exTiHjhbzF2+CnSIRqjQPEW1rUFCU6NQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhlMUcfZpJKUBFCU1nAVRwBm4V3lN7UzML7FNGUIwSf2qq0KxJ
	oASoxcFUYv9HnnHGcA4VzUWfL0hZ4MXnjU5FwsLkl9xCCox+nkvskWrJRwCRnj00Hg==
X-Gm-Gg: AR+sD10Ti978KEi9aiUcLzofDb3e2Wfy76xuMSeaRLiZNBZT/Ir3+YBuQHYe24qR2qV
	isSi6WQGJRYdIegWZR67tB/6Ent4/bnApGHhJLd13+jDJzIKM3FrOW3IwE44QezWq01HthLYWGV
	gp/ABMFqGSjHrNDbsJaQdnFm8y9kWCHnN3WCJ2TvNbUqBrtYkvkurhYr5tC5387wFaFSbWzYS0t
	XsWpE2B/h6/RuwTbD5NNJSOnoG9lMHhaZGRdjm5FUBHkbcVgBGJBf2pxceVG2mFkhtMHaFn/uOj
	nnmilt9bSINjaVC1kwD1tL24ate7kzgTuIT410wdrzWEYnZlZutM/r4HQGrA26Z8i2Of07NblG0
	ytnOm8kB9t7An85n3K730EMb1FpruF4IRX1mYWW2BWy1xLATYnn4sBcXaeDk0RHu/6WbxbrVHMd
	7CbtAvuTwAtCrJZPDUlqGWsoJ/LChEzmGsye21xcnAoVDMOO3O27yT
X-Received: by 2002:a17:903:388d:b0:2c9:e69f:8b0f with SMTP id d9443c01a7336-2d015d01806mr2748285ad.17.1785201589498;
        Mon, 27 Jul 2026 18:19:49 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:f891:e0e8:e2c3:fb20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81dcb3sm42696255ad.82.2026.07.27.18.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 18:19:48 -0700 (PDT)
Date: Tue, 28 Jul 2026 10:19:44 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: haoqin huang <haoqinhuang7@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, minchan@kernel.org, 
	axboe@kernel.dk, terrelln@fb.com, dsterba@suse.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, rongwei.wrw@gmail.com, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH 2/3] zram: add per-backend capability flags and validate
 parameters early
Message-ID: <amgB3pPhKEmFkMEQ@google.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260627070216.13511-2-haoqinhuang7@gmail.com>
 <amL1-Q-HGLJj16rG@google.com>
 <CAEjiKSknejc9biofmnJu_3xamZj8kuvbxiPuKp6phQJdGwQPCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjiKSknejc9biofmnJu_3xamZj8kuvbxiPuKp6phQJdGwQPCQ@mail.gmail.com>

On (26/07/28 00:50), haoqin huang wrote:
> On Fri, Jul 24, 2026 at 1:28 PM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (26/06/27 15:02), Haoqin Huang wrote:
> > > Writing dict or level parameters for algorithms that don't support
> > > them was silently accepted but had no effect.  Out-of-range levels
> > > were silently clamped by the underlying library.  Dict read failures
> > > always lost the real error from kernel_read_file_from_path().
> > >
> > > Add caps, level_min and level_max to zcomp_ops and validate
> > > user-supplied parameters in algorithm_params_store() before storing,
> > > giving immediate error feedback. Also fix comp_params_store() to
> > > read the new dict into a temporary buffer before resetting old
> > > parameters, making the update atomic.
> >
> > I probably would prefer not to add this.  Again, zram setup is almost
> > always automated, you figure out what you need to put into your init
> > script once and you never touch it again.
> >
> 
> That's a fair point. The sysfs validation is admittedly defensive.
> 
> My thinking was just that without any feedback, a misconfiguration can
> be hard to notice. For instance:
> 
>  algo=lzo dict=/data/dict    -> setup_params() silently discards it
>  algo=deflate dict=/data/dict -> same, silently ignored
>  algo=zstd level=999         -> silently clamped to 22 by the library
> 
> All of these succeed without a peep -- not a crash, but also no
> indication that anything was wrong.

We were thinking about moving from zcomp to crypto API acomp.  So I'm
not sure if we want to invest a lot of time into zcomp.  If you want
to have it then I'd ask to split caps and kernel_read_file_from_path()
zero i_size check into separate patches.  We also probably want some
pr_err() on failed validation, because just returning -EINVAL doesn't
explain the error and doesn't help the (supposedly) clueless user
who attempts to configure zram by throwing random numbers at it.

> > The 0 i_size for CD-dict is something that simply should not happen.
> > If you insist on handling that then we can replace "sz < 0" with "sz <= 0",
> > but that 0 len dictionary case is something purely theoretical.
> 
> That's fine, I'll use sz <= 0 in v2.
> 
> Anyway, let me split the original patch so the non-controversial part
> stands on its own:
> 
>   [2/3] zram: make dict update in comp_params_store() atomic
> 
>     Move comp_params_reset() after kernel_read_file_from_path(), so an
>     I/O error doesn't leave the old dict freed with nothing to replace
>     it.  Also preserve the actual error code.
> 
>   [3/3] zram: add per-backend caps and validate parameters early
> 
>     Optional -- happy to drop if you still feel it's unnecessary.

Sounds good.
