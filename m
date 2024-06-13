Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6671A12CD8C
	for <linux-block@vger.kernel.org>; Thu, 13 Jun 2024 03:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718248657; cv=none; b=YVeawH9mnUDCxP3cz6z8f3EvZMwbWtMlefb+appu2bQmk7p6eU2hdVrJ1jFgeNEK/La4BQ+pVq7MTcjQVGHJPTMcFc+O3t8sC5AhjkhoD01RHbVia9OQJwdUmmw2h5wTrhHSSJAOiuOtyz/chnJKd2nWYgpC8Ol0WICspdCwDYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718248657; c=relaxed/simple;
	bh=g5LKTBJbDXBBBsk+gNF4SkC4JuoCOrTdF+f1wcT0Qk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivOVxXD+tFwUfs0OpGAmes+VbYFzPvNVfx0KD3wdlZFjlXWxCCrLcKZoDhKTJA/qPyqo1oj4NDqwDTjSyH+onhypF9REtYzRXzP9Arej8aCGM7V3+yVbdLctj67Nxp6gpTM3FLpnW4lTos3Eex0r2yQyzET+MDPVraooHckbG4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OikrwlJB; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OikrwlJB"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-254a9b89be2so293238fac.2
        for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 20:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718248655; x=1718853455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ROLErHw7VUqD2WU2YKLH94ZD3LchcNJP5CBQl9Yi/1U=;
        b=OikrwlJB+Bcx6Xt8iuJnfrIvdh9jiF/PO5uc9FKCUHpdNdUZODd3dMSTwd1VTOKytV
         3Flb2/LZLSfbVMBfZLRNheCpG00TvzMSpIir89wEBc+HMf/1wxbXgD4Zb5143mTq5XvS
         ejVjpB4PGwu10Ozl5tTHv0gxvpAW5HasBTqUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718248655; x=1718853455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROLErHw7VUqD2WU2YKLH94ZD3LchcNJP5CBQl9Yi/1U=;
        b=BLH4yl1VMqZojy/eiG9U5AbnoafmRaHBnpgR2WRkfe+RN8w5Rfv35uVgAU3cML88hy
         zREMztcViU1p1Phx9nKHyE6rexi7UYYYpQsfctJBnNBrYyEnRst7m5HIKQzmHWRqiAP8
         OGyMqtHsMgxpizF7pga6/PShmihpnidLT8KB4vqBUCdv667hx6fzY3J8k43WuOMZafwn
         7jhgKpdFWUH+Yt8qwvS8jzdOzjsn4q690vKXub5qvcyzoM5hmgKkUuXANBif0QK7/6wf
         CmP85wdXWXoSXu6tbjD8p9FWnsIOgwNGbv3GIfHMICdamLo/cJPFJl5l03/4bWKUYEeW
         eMNA==
X-Forwarded-Encrypted: i=1; AJvYcCWTPM+kFEYnrf1YVUWcn/YboJarGW3CTTkoCrbsfrdJz1OV4cbrMFlMWtKaSzTFMxfnISgeipNIkBHmn7FuJOLBmqKLQiaipLBj+QA=
X-Gm-Message-State: AOJu0YwELOSBrE+fXdvyI16JLAWGzjvoHaKJbhSgeo+qBaG5ae9dPZD7
	MEkxSHfdYU/USodcGM2GLbJwzx9nAdQuNaAOBkllOzIHS2bop59QMn8VSaf3Mw==
X-Google-Smtp-Source: AGHT+IHs3itDhz3VWLaxjs7UbF6V8hUm2TAB9ES2x41XOkhO7+NJPCpnU1dGRrKgY/M6steDMbePjw==
X-Received: by 2002:a05:6870:71d6:b0:24f:d9de:3bf9 with SMTP id 586e51a60fabf-25514e667f3mr4251183fac.47.1718248655468;
        Wed, 12 Jun 2024 20:17:35 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:821f:fc92:6ed8:f817])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc91e154sm311240b3a.44.2024.06.12.20.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:17:34 -0700 (PDT)
Date: Thu, 13 Jun 2024 12:17:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: use copy_page for full page copy
Message-ID: <20240613031731.GB479513@google.com>
References: <20240613000422.1918-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613000422.1918-1-jszhang@kernel.org>

On (24/06/13 08:04), Jisheng Zhang wrote:
> commit 42e99bd975fd ("zram: optimize memory operations with
> clear_page()/copy_page()") optimize page copy/clean operations, but
> then commit d72e9a7a93e4 ("zram: do not use copy_page with non-page
> aligned address") removes the optimization because there's memory
> corruption at that time, the reason was well explained. But after
> commit 1f7319c74275 ("zram: partial IO refactoring"), partial IO uses
> alloc_page() instead of kmalloc to allocate a page, so we can bring
> back the optimization.
> 
> commit 80ba4caf8ba9 ("zram: use copy_page for full page copy") brings
> back partial optimization, missed one point in zram_write_page().
> optimize the full page copying in zram_write_page() with copy_page()

Is copy_page() really more optimal than memcpy(PAGE_SIZE)?
