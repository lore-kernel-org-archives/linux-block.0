Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2457F3AB29A
	for <linux-block@vger.kernel.org>; Tue,  7 Jul 2026 07:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408782; cv=none; b=erfSJP7lh3npJbk+2MBbl5g222Wqo2WJVUEhc0gOMXqLnb8ZmMl9lJn4MIb9BQX+NtQqIsnD45Jg9AFCbA5DJpLZ6ifFM5be1Xhkp5LF5SatQmjcpoo6l3XPbagfG/GohB7FrewgBvEXUytB2ogkFPlvb6E6hVHxskX5OVtUNYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408782; c=relaxed/simple;
	bh=q0ypKI3CahFXV1rXg4t2iuvquTiyFI33qRFdaSZZjcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrxQ3W3LPlmFgu2aUnOpuzgn9FUec6Q2lSIOf46jdVSiedqGZeD5vAGnLfhVQNq9HQIC1XSB50hKHYX/Kzw7s8JZQcHgHE8XyVkUsGf5+ir8uZG4kWgzRq/hJXXtmhBTNtkz3cSDca+r23KXpzOw4mHFLNvnyyqxX98QK4/dh5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q09ori1B; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q09ori1B"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-847a52edeb2so2965455b3a.0
        for <linux-block@vger.kernel.org>; Tue, 07 Jul 2026 00:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783408773; x=1784013573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wgh/p0t9TWjURNEJcqUkzP0rZOfYFyjQ3wAwE0PR3nw=;
        b=Q09ori1BFxjUHCyGxM4932WNblIIlt7xM4UyWYgDGv/vfKPHgqXOZk9leVcOILV6rM
         mFq4puxGrw5r1XO4Txrjzm6UcPHjHk1b0D9eJIuKlQNKFZddgNPg4kpXrctAh+7Mpsyp
         MGa3Ntr9MeCIzO73RWM5+fsmzJSW+s93aa9LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783408773; x=1784013573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wgh/p0t9TWjURNEJcqUkzP0rZOfYFyjQ3wAwE0PR3nw=;
        b=hjom9a9QlJVxY5P80959vXN6MOmkch6MEHtrpOOnX4CUiz8IYrj8rZqb70KKnZQkmM
         v6wrJ65Amud7QCt6pxdCiziwKrIAyV+jCFxnBjYKrt0X/zb6v0K+gzj4JlOB/ZcfsrSh
         rXlw/P5Rl8pob/0GNFaybcTjpd3NRLQRsmd0n9oy8tbBdbY00mVUuTAQIYf6iwT/yQLD
         PQoXHmQznljzjM9m4cNkfqF8Mzak0XnI410taGDfko6pDlNzy+TQitVsqD0N/mHCSDdv
         PIqaKflpbax3N1yl1UV64X/7qxTebburwZWt0WucFZ8S3l5wGL9D13su3/zByVXUjQf4
         ZUFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrvlk/sTWMkSbd86lOtN1vc8nM85HjQa02GuPdWbPA+sdZ84cQGIREaVKYO1tBXSsxDPC5ZbhhMA14ehg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz3XI7ZHmlYmg1SFnRIOUOp6rwRiWZDd6PS8HmKhibK6VRDA1H
	WSnyKwIQ/DuHLIWZEenG7xxqpG5c/sNwZ0TZaZMpYy5mIvyf56iaIprABTWC2E9jdg==
X-Gm-Gg: AfdE7cmiUjLG0SIL3Vz5ZdoEWFwvM7mXY+CiK2n4hL4OPvgJZOHYs5GTri7Oxi3LSKj
	TFsMDZokazG+D7FScoYZcFguAe8JHQRCJex6dzpkHqtZ7qIOLkiwCxMENvTa2jNJJk47Fb3cgA+
	8sfhvY8gmESKpKfWm+Ov2TXb8FpdZp+YUtJQGJ6a8a+kydx5wtowdrIpKAhXue4WG5LJ8Su923h
	OBehtEOfPC46QNKEO6rVLREy9Dw5TbsqUADedO/bIA7wmLykolvc8SDpTkqSh1yllA+jqaC+Mzk
	4Bko2+IzhXVRymnD5wAlwa6AVuKGwe2tO9yRIqbyuQ9BlOxNFIQWe8LiEthtV0gGMPaEowIIr84
	nK6P1bn6kPEbR8pjzWQqX2IMmEYSxByhYYv2i147uRc7tIkcEIdCfbt6n9Zc4jwqb7qPNbTElQm
	xrXrviGH78TnGTpyTDoskM0o7psnbGvDjSVPJn7TAH3oxaA5faif96
X-Received: by 2002:a05:6a00:348b:b0:846:7507:4e07 with SMTP id d2e1a72fcca58-84826df3cbcmr3846597b3a.39.1783408773293;
        Tue, 07 Jul 2026 00:19:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:d4f4:6328:49c0:b912])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b9b389sm5003551b3a.13.2026.07.07.00.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 00:19:32 -0700 (PDT)
Date: Tue, 7 Jul 2026 16:19:28 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk, 
	terrelln@fb.com, dsterba@suse.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, rongwei.wrw@gmail.com, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH 1/3] zram: fix zstd dict use-after-free on per-CPU error
 path
Message-ID: <akyoVzlF7a0wpaNZ@google.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627070216.13511-1-haoqinhuang7@gmail.com>

On (26/06/27 15:02), Haoqin Huang wrote:
> zstd_setup_params() creates global cdict and ddict stored in
> params->drv_data, shared across all per-CPU contexts. When a
> per-CPU zstd_create() failed, its error path called
> zstd_release_params() which freed those shared objects while
> other per-CPU contexts might already hold references to them.
> 
> Remove the premature zstd_release_params() from the per-CPU
> error path, the global cdict/ddict are properly released later
> by zstd_release_params(), called from zcomp_init()'s cleanup
> or from zcomp_destroy().
> 
> Fixes: 6a559ecd6e7e ("zram: add dictionary support to zstd backend")
> Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
> Reviewed-by: Rongwei Wang <zigiwang@tencent.com>

Apologies for the delay, I'm catching up on emails and will
look into it in the coming days.
