Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF424689
	for <linux-block@vger.kernel.org>; Sat,  4 May 2024 07:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714806883; cv=none; b=ddHRnWJJEnxa8FVjEdzrALgH5YCSwifUIH1u0QB4Plpx/NJkYKrqIgSXqpyfpcDLhTWs+3LA79wlHtOU0PXCo77yf+2rwirGp1V1tYkbSt/VuESM8V1pnFAvVy9seaptBW8vKxvlcmcIenInVsSFq00LaSKN7EiCxQ1pq/McWF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714806883; c=relaxed/simple;
	bh=JPi5SPuiU0SL02Qqqpcf1D/xtRrzm+mxaCVNvt4+a+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpwDAWS+eAkWx0v2Yl3z7n6p4JRpTg3URi3i5AiL58kwn4rdlNsJpCKMKJsFc9+hNSAyFfj4gajpKe4ZVIyHRiWBn1O5Uq3mcx7hBDmbNR8C3D5hvvqxmrrUYhfxfev3VeJWdpeXH5f4rXMV3ctDptrgGgQxslAlFEtgVJ7XkWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=izxKtOKL; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="izxKtOKL"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f453d2c5a1so414088b3a.2
        for <linux-block@vger.kernel.org>; Sat, 04 May 2024 00:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714806881; x=1715411681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A4N1i5Pm2LxhMxIRBzRCWAdKMXxb3hPvU+8V8CPs4HE=;
        b=izxKtOKLOYYO40Npj8wt59QNYqm6xkHahwaDxdmIlmScIGuQxq/y1xmL8ZC7nv78IN
         WftIbMa1U1XC5ytIUldx+lyvjTRrRW6wp4/G0+1tdh2zW5qgc5bx0QMZhxZjtgKYwpBr
         +PfKt1UaJAW2bHZ9HoRJQuDjZC5oOY0B6Qzz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714806881; x=1715411681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4N1i5Pm2LxhMxIRBzRCWAdKMXxb3hPvU+8V8CPs4HE=;
        b=POTeuPTJgioX3TVKiMF8MSB4Lel0Xn05vk97AHd8nZDm53LQknV8fbLLx3CKxjxpO1
         S8cKAKbg9gJV55sqIQ3sU/1ycrXUMX5BlQ3oTSz06pzqbFmnaOtjmUyA3umTfUdHl0Ty
         Y1458O56v7xtkFgIAaNgZZB/iSXvSY0f16q2SBZge5NLT426yfi0OJVqW97vhhATrJ7f
         ksqhw0OuOSXDl5cNyZJhpOD9eW44jUSmH0kuMLRJ5oSnP6LBOCeLzI3BOxZGmeW7VH1F
         hFcgP14DP3cgg2gT+4I97pBWOCl1lVUVPv6C74t7OIFnEyJoC2lFBWeFBR2+BmZKGtNu
         8udA==
X-Forwarded-Encrypted: i=1; AJvYcCXC9bCoNW6ee7b2fKNLF8Bj208BDqO+AUIJC4hJXAUf6Gf3nT7AvfoRVRv7HpWblyc3qdluZJkAYHwxs08AeNbg1SnWbRd/FdGC/0I=
X-Gm-Message-State: AOJu0YyT4x6ErySg4cb9S00CP/cmrkcDxqzm3hLj3Dope2CrLNr4GNYz
	WOKAlk+wBzzYCnDKwJKDWPEJgYbl3OZymIsdItA676458r2NxQKCQvqzcb573soWYyOL2SYNn4E
	=
X-Google-Smtp-Source: AGHT+IFn79avCXCi7TK4D20lbbR6FREI9JMpMXrAyAVwamxmEgAFymvNjriz4FhRmJ0iOLvNa3EtUQ==
X-Received: by 2002:a05:6a20:7f84:b0:1a9:c28e:bc17 with SMTP id d4-20020a056a207f8400b001a9c28ebc17mr5550146pzj.45.1714806861314;
        Sat, 04 May 2024 00:14:21 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:a616:7211:d0ce:9ad9])
        by smtp.gmail.com with ESMTPSA id b185-20020a6334c2000000b0061f42afa8d0sm1391585pga.6.2024.05.04.00.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 00:14:20 -0700 (PDT)
Date: Sat, 4 May 2024 16:14:16 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: kernel test robot <lkp@intel.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 08/14] zram: check that backends array has at least one
 backend
Message-ID: <20240504071416.GH14947@google.com>
References: <20240503091823.3616962-9-senozhatsky@chromium.org>
 <202405041440.UTBQZAaf-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405041440.UTBQZAaf-lkp@intel.com>

On (24/05/04 14:54), kernel test robot wrote:
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/block/zram/zcomp.c:214:2: error: call to '__compiletime_assert_285' declared with 'error' attribute: BUILD_BUG_ON failed: ARRAY_SIZE(backends) <= 1
>      214 |         BUILD_BUG_ON(ARRAY_SIZE(backends) <= 1);
>          |         ^

So this is what that BUILD_BUG_ON() is supposed to catch. You don't
have any backends selected in your .config:

# CONFIG_ZRAM_BACKEND_LZO is not set
# CONFIG_ZRAM_BACKEND_LZ4 is not set
# CONFIG_ZRAM_BACKEND_LZ4HC is not set
# CONFIG_ZRAM_BACKEND_ZSTD is not set
# CONFIG_ZRAM_BACKEND_DEFLATE is not set
CONFIG_ZRAM_DEF_COMP="unset-value"

Which is invalid configuration because it means that zram has no
compression enabled.
