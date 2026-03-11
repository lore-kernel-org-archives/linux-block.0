Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC12C38E109
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773260259; cv=none; b=nm6Zr5zGFsENyedY4PkOwLTUrYj/+brdpLf4QUlvLIGBwYAb/X/Rj52TzTf76ErjmOhvdRJbSPHCJ4sqrldK50YqMvWv+dKGJKJr3xQVicwUfpD1lsQudJ19MDvfpBNH/3RIwaP71ge9CCXcUsk6zS79XzjrUIRDs6wU8RYzocc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773260259; c=relaxed/simple;
	bh=WXYYVKaATB7EgYT0+fSTJV+LvLY1BPrM7tATQPPKDZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0PDPmPbVMx08CS56nIaVz3ZNEABuDTRy0bZcuJGjTxsKSQs+/4N5krX2vtHclWBVnIvJRvHHs3WS3NsRs14UEcRHdyZH2+AJvIjJYBbIrN1wFpixSuyvFdBO4QoxNBdaJaLO6bGmo7b/Hc8ELczs0DGWGNfF6PiqbJ+U8jPOU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTtW+vwL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTtW+vwL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA9CC2BCB1
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 20:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773260259;
	bh=WXYYVKaATB7EgYT0+fSTJV+LvLY1BPrM7tATQPPKDZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XTtW+vwLjLXDtKmJRnCKTGKZ0DrF7rzPirrWtH4Um/ZsoulwP1C5w7mxvV3YOsJbS
	 6IHC38Pp+/OdF9KhkDgM/7Us4QYr/Ljdk49T73RDrBeMXciP8VtDsxVpuo30Wv85d7
	 s6DVDxCkwIrvn3Vw4/5gujfrdP7AJuHyxOr52z36DOQk11FA/FIbEyMQFG8AftYjfv
	 S58UBcz22n1PQ/zhsbwCyIIzWeSSTV8aVOWGXlgBos87n5LfFTAQAi3c3O824ikvQO
	 BZV5Aj9v9vTk/EUZIC67Bt7WaqkMhPrgDxCULYSgtv/MU/8mTv+tVES/9xBF/eNDQZ
	 PYVW3gw6cRGwQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b96da7b2e2eso31407766b.2
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 13:17:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU11mmWpX02VBmuJF22u17adrGkFlqgLSY/oQMGznJwmebgpD7OLjo65aU7cazV1PVuJ6x7m/Mo/ccfaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx1oc/VFa8+DM7W9ZIlgtJ25WH3WBs30unIBgdx78AQq+nMvYE
	B6hn9Pi7xIzhfRxOjK4jMYgkfiHZKiUtrtFs6MkWDDOd1B3m2PrRiUsJJ6y0mD6XZ+Ece5+KUsE
	GLabuBIytSErODfTkWZlTAgWep+UvNEk=
X-Received: by 2002:a17:907:7faa:b0:b8f:848b:4456 with SMTP id
 a640c23a62f3a-b972e1a15eemr223917566b.13.1773260258414; Wed, 11 Mar 2026
 13:17:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311195153.4013476-1-joshua.hahnjy@gmail.com> <20260311195153.4013476-6-joshua.hahnjy@gmail.com>
In-Reply-To: <20260311195153.4013476-6-joshua.hahnjy@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 11 Mar 2026 13:17:26 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMRwFTbv4jWWNf2sEc+SkUawxPtnvOc7LKsJr5R3vkZjQ@mail.gmail.com>
X-Gm-Features: AaiRm51t-DxCOty0kWu7756NpX-7MJWzFYoqmoDH49tZNQ6_AS6ejACehZM_JVY
Message-ID: <CAO9r8zMRwFTbv4jWWNf2sEc+SkUawxPtnvOc7LKsJr5R3vkZjQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] mm/zsmalloc: Store obj_cgroup pointer in zspage
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jens Axboe <axboe@kernel.dk>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Nhat Pham <hoangnhat.pham@linux.dev>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

[..]
> @@ -1216,6 +1216,11 @@ void zs_obj_write(struct zs_pool *pool, unsigned long handle,
>         class = zspage_class(pool, zspage);
>         off = offset_in_page(class->size * obj_idx);
>
> +       if (objcg) {
> +               WARN_ON_ONCE(!pool->memcg_aware);
> +               zspage->objcgs[obj_idx] = objcg;
> +       }

If pool->memcg_aware is not set the warning will fire, but the
following line will write to uninitialized memory and probably crash.
We should avoid the write if the warning fires.

Maybe:

if (objcg && !WARN_ON_ONCE(!pool->memcg_aware))
       zspage->objcgs[obj_idx] = objcg;

Not pretty, but the same pattern is followed in many places in the kernel.

> +
>         if (!ZsHugePage(zspage))
>                 off += ZS_HANDLE_SIZE;
>
