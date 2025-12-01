Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691153002DA
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764580240; cv=none; b=A/NokSWm2gBokOIGWRigni4AHT7TZeeJqSfU1fH12VwKSKIxhB4vjQ9Mi0K/9R79JDaZYlb/HFHUtA6QJbDup5+STWh77jcTfiVCm1tRD9SkRZwhoZ8HBbpw7Lo3oUA1QHI6xodxQQShUrBODMmrY4DC++/n03RAA+ohjahuLdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764580240; c=relaxed/simple;
	bh=vrkYxg4jrv0zJxao8OHdBZZZZF5agpkwIKLKOgwZfGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0wWnUGRBk9WD5YnDRvO0GjP4kxVMqG/y0VNmxQAPPNLV/kx16Bzx7PDh0+iJSgvpLtpxdZdOnQu3D7mK2rL6CU9rdto7CJav6r2jl4gF8zbqsPejsnoIfYzGUOs3DkKn6aF0eX1KgFRddSdWs46pudHfnordpH44j4B1sMXHWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TjtMRk04; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TjtMRk04"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2984dfae0acso62499815ad.0
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 01:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764580238; x=1765185038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/xH/xl4gTjMEdzE/YKcmGTPtK0Ad9BuJAHEgDFNDw3I=;
        b=TjtMRk04oO++KMwkdyKvt8wPe2EytlyYOnTW8drsVSroACtxl/6Zsbxy75/nc5xmt3
         QcUcMxRtaRNBCFQcKKDujsbYjkqy9j8TJ4DOmXfXoHfDBJ48B4jAv75mGEMdJbqp0xq6
         GrAJTr76JBKa60F9ub4kE2UUos+mRoe7glPWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764580238; x=1765185038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xH/xl4gTjMEdzE/YKcmGTPtK0Ad9BuJAHEgDFNDw3I=;
        b=fZJ+vqDHsNaUSbDZzfGTdkk22ZYzwh3ohZcWmVvcZJW+lBgkNNDP9AtI9/TtQUlxxu
         srOhjT0owWoCG7DFvJqB/yySAi2oTgFMUCAJ09sox5ktYvL9rSfpXrzzZrLJ1Y31FkcC
         ONSvqoDvZbAOBDynAf+aAFp+ZscSMd8MbqWFZcoICh0XPX6hpR1aXckWj2GmXFQ3yEy7
         tlc6Er+tnmISXkvohYVU6kYMjCqqW2V3COYQ/dO5hB4p8FDYP2WYy0HF+8ub/KP9rbXu
         kZMBcEC624cQCX1z6y4Dz30HrQzsqWmUKP4b2VeWdjNWU0G4j9lMoeDAa9KwGXNHF8eC
         Q3mg==
X-Forwarded-Encrypted: i=1; AJvYcCXCZwfwutgkHUIyF+r1x26nVYbZFHG+FmXGqb1S8ZiG4ASdnadQlx33aAUlcGeAWMh9Mt/ubEL63LV2Vw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Mv2ODaWPXw0uk4y70KzC4TNGNIdpybfHGwSAmQ3R3QE0Njjo
	HBDIeT53EItfZ+tmfGoL1Tg/scFsf6Ocy3WQ6EB4sK/K/uIS/rum5cHySc3L5ERFtA==
X-Gm-Gg: ASbGncvcTZIdzzxvpmoutLw6nEu9MHOq44qJL9DId3xGq0z0qG4TgKptE/3EIggBh1Y
	N2w2gxWEDpRJllYk1Z54TFoDrjauy+fmcQyoqqtlD8yTpOoj4s5aJ9LvmudtdHDt3oHpTtM5D8X
	t9j/2nkr/w24bSnuo6yVkf+gNZHh/NhEBUVk7zic3GsNU6M+mTMgZQP+yTt6r0NdOiX1j3j+/km
	HFNH6mw+aJ8yF2c4c0s3hLcB419sKsJ1hL0folPyJanqg1p/iy6hJ8mK4bwgf8bnJwi4js1nRxe
	Sjmxn9NnYd9XLiXv6cjIi4I6MU9Iw6xdY0r/Dir1EGfGr9xYQuBRPYE1qy0+uoEEil/EnKFqaOU
	HXSFJpZKIgzCWacGFjx99qHzHsHcuQrG26g+MHGa67edQpXVsi5O+N/imLLNoPd9eCXORh10lZj
	lfXb4+8bLSK3kzlnjYPga8AQH7mCzw6sa9cY3WKc9Nyp6/dvUtyHs=
X-Google-Smtp-Source: AGHT+IE0IPVwLtIcqmJPMQYCZMufINocvo6ueSZaKn00EQEiT6g2KuSYP5RewdIVgIypUPwe2Riu3w==
X-Received: by 2002:a17:903:1108:b0:295:8da5:c634 with SMTP id d9443c01a7336-29baae422b7mr220139295ad.9.1764580237703;
        Mon, 01 Dec 2025 01:10:37 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:943c:f651:f00f:2459])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce41afe1sm115517985ad.1.2025.12.01.01.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 01:10:37 -0800 (PST)
Date: Mon, 1 Dec 2025 18:10:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: kernel test robot <lkp@intel.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Richard Chang <richardycc@google.com>, 
	oe-kbuild-all@lists.linux.dev, Linux Memory Management List <linux-mm@kvack.org>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: introduce compressed data writeback
Message-ID: <tykowgjsd2gogsufmlz5vrh4eov4gnwsawrqx65ckf2s24cqwm@utqeq2m3cgw3>
References: <20251128170442.2988502-2-senozhatsky@chromium.org>
 <202511291628.NZif1jdx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511291628.NZif1jdx-lkp@intel.com>

On (25/11/29 17:07), kernel test robot wrote:
> Hi Sergey,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on next-20251128]
> [cannot apply to axboe/for-next linus/master v6.18-rc7]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Sergey-Senozhatsky/zram-introduce-compressed-data-writeback/20251129-010716
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20251128170442.2988502-2-senozhatsky%40chromium.org
> patch subject: [PATCH 1/2] zram: introduce compressed data writeback
> config: x86_64-randconfig-011-20251129 (https://download.01.org/0day-ci/archive/20251129/202511291628.NZif1jdx-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251129/202511291628.NZif1jdx-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511291628.NZif1jdx-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/block/zram/zram_drv.c:2099:12: warning: 'zram_read_from_zspool_raw' defined but not used [-Wunused-function]
>     2099 | static int zram_read_from_zspool_raw(struct zram *zram, struct page *page,
>          |            ^~~~~~~~~~~~~~~~~~~~~~~~~

Fixed in v2.  Thanks.
