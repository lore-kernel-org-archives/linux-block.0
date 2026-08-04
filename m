Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86143ACA68
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837213; cv=none; b=mkexbQEhZ4vCoodxtDBInVlgMJjvcz0Y/H1p7zQTRBcJAVA/GfHeVuoiMYdpmbroCZKrYA3GzoBBkhv8xwyKUizfev8xtrKku4fKD0Br6Camu3YE1lba+H0e6afOX45QHC2InberoQiO82BjcXsBt2nlJRp0ynmGejHKHfchqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837213; c=relaxed/simple;
	bh=CcMCdPBSDgbLDGGlL7AIiBX4whoy2+vE/FApkeH95bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gbz7koYjV+ZKy5AH1s5ZVondV7+dxSCCHNVO6MlmhQIw68IT661AUqtBRrTsPWNRlaDGveCDV7TWvftI6p06DP7t3Kg8oL8EJ/t5Ua1PbnmKdnFHvDFziMABbdHKTYNtgOSsrgAg+txMzX4OhmYjRXv3tUL0tvJmeRVeLRPCLHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l8GOOqFh; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l8GOOqFh"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso5231874b3a.2
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 02:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785837211; x=1786442011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dDjsT2wG7owV0ZB7Il5NY4YqbWtuxqu2JnwZR2JRqSU=;
        b=l8GOOqFh32YnIcaRPND7vMd8KeO5huOc2+I9FMgosIY5PFc0StMwW60lhFWXEmPhxp
         K6U127U7Iz5siR76VzsEWohS8qo3tzZYqXCAS4M/B2dMGkRlGB6wbnEmirlb0oknjR7V
         bX5UICwLGMB1acNejLahgfsNVOAh54OvXIUFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785837211; x=1786442011;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dDjsT2wG7owV0ZB7Il5NY4YqbWtuxqu2JnwZR2JRqSU=;
        b=Mvp2wV1kEI4ZRQZWGrGuA33m7SD3peM29C076pC13bcyNXT3lZOmu7G3ct5X5F4L6P
         Ki6sYOpfD1pLGoJw6qY+nAWbVAJWmE1U/lN42ts+LfpBx9dbUDypVk+o16ZWU26IgC3E
         3q4+ekD/qNDptIfPV/V79iJ46AWy39m/HpBdxM9QlYFTJiVjX6oTpQJ+z11P2M21Y2FK
         UZhPynS/Xs+V6PwoUmFdgg/YUQfGczFPt15QgWFF93evGxGcJlprFSCwvFwMMw4x+Q2F
         uxmJ0GAb9Tr362dTqMeR86XSMIs/2ltZuQaqJNZ+ipLOWld++nkkID+jqk38K0bLBe4L
         DrCQ==
X-Forwarded-Encrypted: i=1; AHgh+RrMwbE7Tu/BtyK8A7KObN2t092AX+DSewYonlE7OMtPlAgMxFxDH8JZI/6BMczkOEmYrF91Qo0/LR95Tw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxri3Qks0eVVpURCzAYTuBsIcRsXvZeBMdzh0eTLwNwv/uD8vC1
	oFZPYInh0D62sR8Wg+eDx1Eql6qf93zkI+FPzze4yqVthwCaTfZJv6YSZLrdmWc7LZsQBKiYOrO
	TX8s=
X-Gm-Gg: AR+sD10wyYCv91AcajeyOi5qua6EjFUn4JT27a8VrjuwrPBpKViJGJLDwC9IHgZq0m1
	J3vkbBGKRLWLe16pHs8xDuGAmrQvQ0/atz72jMkY5ixeiNV0zHiGsQIntEV6OBIh2j6zvEr0tom
	e6iAM7w9UNSIyI9pbgRCMZfr7n/SJcd8MzC206dJI1VaoY9dtwA/nzm+GLbWo0FoKcRG5rI0u9k
	LyfolSRJC8NsAX3hUZ2f/hBI6CDcZA4rBwLg6hoCFHQ8IinyItxaCBiDo3AWaT8Dcq/DTTuifW7
	/EF4d7UEcTUo1MqHZju+5cKq3MJAPOjkOVBk+FlgVwKuP47YFAnlwFrnH+zNJIo97w5ODVF/X1C
	dk7rtbhDiaIS6xe+0bb7ZuuMaGf5VAEWxI501OzwZtRACvAIDc7tg7g0HbW1mSgrIdoSYAQF6zk
	ug4CnerSVOvn2TGiWL6whhgt2PDg92kYaoIZqKEye+9nat0/Aw9mSIhjcAdcsQsTV+rKk1nvSAo
	tLKMXSE80lCNig+lzOgOBt0AyaKEx+nX9SVJrc=
X-Received: by 2002:a05:6a00:9290:b0:84e:17ef:5460 with SMTP id d2e1a72fcca58-84ee4899c34mr12512541b3a.40.1785837211380;
        Tue, 04 Aug 2026 02:53:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:32eb:b46b:e9eb:65c5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d45afsm4874167b3a.41.2026.08.04.02.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 02:53:30 -0700 (PDT)
Date: Tue, 4 Aug 2026 18:53:25 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	Haoqin Huang <haoqinhuang7@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>
Subject: Re: [PATCH v6 0/5] zram: fix zstd error paths and add parameter
 validation
Message-ID: <anG0liocTV6U2VV5@google.com>
References: <20260803141256.60599-1-haoqinhuang7@gmail.com>
 <20260804093841.67920-1-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804093841.67920-1-haoqinhuang7@gmail.com>

On (26/08/04 17:38), Haoqin Huang wrote:
> From: Haoqin Huang <haoqinhuang@tencent.com>
> 
> Patch 1 removes zstd_release_params() from both zstd_create() and
> zstd_setup_params() error paths -- the former is a layering violation
> in a per-CPU callback, the latter is redundant as zcomp_init() already
> calls release_params() on setup failure.
> 
> Patch 2 rejects zero-size dictionaries and prints distinct error
> messages for sz < 0 (returns the original error code) and sz == 0
> ("empty file"). Currently errors are silently swallowed.
> 
> Patch 3 adds pr_fmt to each backend file so that pr_err() messages
> are auto-prefixed with the algorithm name.
> 
> Patch 4 validates dict and level parameters in each backend's
> .setup_params(), rejecting unsupported combinations and out-of-range
> levels.
> 
> Patch 5 resets per-priority params on algorithm change before init.
> 
> Changes since v5:
>   - Patch 2: split pr_err into sz < 0 and sz == 0 branches
>   - New patch 3: add pr_fmt to all backends; tweak winbits message;
>     add missing SPDX headers to lz4 and lz4hc
>   - Patch 4: removed inline algo-name prefixes (now handled by pr_fmt);
>     added comment for lz4hc < 1 lower bound; added braces to if
>     branches for consistency

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
