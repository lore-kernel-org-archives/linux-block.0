Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C14A381E83
	for <linux-block@vger.kernel.org>; Mon,  7 Sep 2026 20:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814023; cv=none; b=Xup8T6taqK06mk9h9cnu8dfNjKAy1yb8M6ItfBFC5E/ZLO7vxDwabsdmWSP1xw9cmsMOc27dXgIxEaiMTSCUzfYkXh477Fq0QO6c1vcCkgP/SUWPFrbO0AffgldhaCdrzf1/Y0sP6aboFRBOMw1g/HrZqky72LC2almM20UTE9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814023; c=relaxed/simple;
	bh=ivcPIgSJ38rCfVl/IfK35MRQwa+nO/MXoGkv6WS3B6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0ta9JBYFvaHktHRPW44tZ4fzqyxoUhQkDG09TiciD9z+7UmJgslObkqd2Ams0xNIb2/T0H5JkcnS5rIVWe2ZoTc/cyJGLxx+7YJC6Rj7cE3M+xKDSFATj6GEz//MgEQUnazzU2pO6l4s4dwN6HcfIhiCnyN3PMNV7QmaURnmCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS6bpa2R; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS6bpa2R"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so36892595e9.2
        for <linux-block@vger.kernel.org>; Mon, 07 Sep 2026 13:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788814020; x=1789418820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ivcPIgSJ38rCfVl/IfK35MRQwa+nO/MXoGkv6WS3B6g=;
        b=QS6bpa2Rcj4DFSfrAmu6OhQrqIWvCXGDwYo2dKzi6NTab/3cEnLLonoM9Uzi5yTz7k
         NlBE7/TBn9KPxUTPC4yi06OEtJh/ggpNNDTS9IJ+p21e8WkjYyxitlh1v3vag+z4KMss
         GY3lawBECo4zeusw+n11JQymwNZbCPjGJHRGtzCZZ8nlj/b9naI9ECp7dcDhLUD1vMCs
         lBsTeR+R1TRDFTllVIy2R3y0iXga1rJMGAhC0va+c16wrC3S2KFQXxDEQWtzWJHFXbaZ
         emaNgxzpLG2ymMzRU+kp/NKrpHgT2vnBE69VrrQ5IqsweNhReyNEM2fZtbNslRhvWH5z
         rCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788814020; x=1789418820;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ivcPIgSJ38rCfVl/IfK35MRQwa+nO/MXoGkv6WS3B6g=;
        b=L2Wg0zFe28+aNNPUwyvl4pYTJGMtEpkrgEnLYU4Mvw1kheublfjnM9GM/+yRnWQ9DI
         W33Uu/T7HiwskB1VwTzWqBIkCSNsoyQPlm2XXDbpg4c5vl0y3E3/dUJrA9OX3zmTYPnm
         AT58/j/ibQcj49K4QR65aP32oAK7Vh6vEyLhc1jB1Jd+kI9bp+CizVmL/un5ONozzF+F
         OspQdgbN53IkqO68b86/2cqfGk9yWkbaG+qpcQGcNtQol3XN7GUXK7Mq/yp7yiN8OBbY
         sFYqHjsNao4Q9geFLw9BudM+nyRxJO79oasD9gDWWMr+Z46+jIEvW4KQzIZKww2qRgov
         E9ew==
X-Gm-Message-State: AFuF++lxBztK0+e5MitEwwEq/p/C8jj2CFbyx/zpIxsKB1FLxgK+y/h5
	wZeSCCgMSRmuuoPOh2Y8XzeoMP/KDB/k14kUqenSSr3fIcn3fMuX99sg
X-Gm-Gg: AYBFou3joLYDuirlO7NFQ0vJqOqx27j8JFw37OSIXeOFmevezvLN7LGOENrB42+JDKx
	HOTuNjsaFz97y3Ounq37rj4GFqLvhIdYpV9Fq2DaflWp+YdBYWG87X7Qqzjjiopw7qLO/U5NZHf
	8x2tYtWIVvOV0VJvkZ6VPrgjj971c4SU93h1mEQ2SC3me9UljsQT5F20k5DQWdWKNjcgyTM55hB
	J0Nt8jWe2+S8oenqnAulnHECylz5a0lTompvOUD50dD+5D9h1/DqijPG5Cp7W7KSdFlsahxFI3B
	8x4ohgP+9lhum532KKh5Bu4eeiu9M4EVFzbK8syynAIi+anKEUUXPLtOklS/issJrncgVm9pPrH
	xvs6RUwgeSEtJonKh3E1FThAhRdWNUgTS883cX7rXy7S/xR6ky10CqATBWyTmlewHFbECKOv0Vc
	l387TLBuaXMhPQ0wZH0gLSdIfTyaFMc6UtWc743jViDMnUSkluJDLPVtf3bZxYwAN9zS4rVGrrG
	LvnqHYizCJkZTBPJ+VPS8YTVjfDBtKxoqfKJJ+I/7SfXRuoeHUlR08jPwAh0B8P3WZspXgvg77m
	6XlHCbQL+bbE0R4Ftff6L2ALbASp7zjzDUqVfXjL474C4q9PkOhT8AQb7jH6OpKNPbifs2e87Qq
	d+ZnnjIqXAHs=
X-Received: by 2002:a05:600c:350f:b0:499:b65d:124f with SMTP id 5b1f17b1804b1-49cf825d1dcmr245894785e9.11.1788814020009;
        Mon, 07 Sep 2026 13:47:00 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-b0c9-3601-cdce-ba4b-d0e3-dede.310.pool.telefonica.de. [2a02:3100:b0c9:3601:cdce:ba4b:d0e3:dede])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm886704135e9.0.2026.09.07.13.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:46:59 -0700 (PDT)
Date: Mon, 7 Sep 2026 22:46:57 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH] blk-crypto: Fix the num_prealloc_fallback_crypt_ctxs
 parameter description
Message-ID: <ap8gCoCnLk1QcPIT@gmail.com>
References: <20260906165952.2344-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906165952.2344-1-kmehltretter@gmail.com>

On Sun, Sep 06, 2026 at 06:59:52PM +0100, Karl Mehltretter wrote:
> The module parameter is num_prealloc_fallback_crypt_ctxs, but its
> MODULE_PARM_DESC() names num_prealloc_crypt_fallback_ctxs, so modinfo
> describes a parameter that does not exist and shows no description for
> the real one.

One correction to the changelog: BLK_INLINE_ENCRYPTION_FALLBACK is bool,
so this code is always built in and modinfo never shows it. The only
place the description ends up is modules.builtin.modinfo, where
module_param() and MODULE_PARM_DESC() produce one record each and name
different parameters.

I will wait a bit for other feedback, then send a v2 with the
changelog corrected.

Thanks,
Karl
