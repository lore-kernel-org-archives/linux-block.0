Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6136FD0
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 00:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712796070; cv=none; b=Op+eg+ec8p8FM0bC/EQsLqNWWSG54dMpq81fdFp6eghbo7GX3qrcQbt/AZ8BQsXz/yK6uhldaAAV8unRScBcUPKIccjVUEzxRsMkgNIdnxIMDu/HzX01kxJyzfJeuLLitrOpvCuCSqtaZZzWEC4T0x2Bf0dcBXLoKsUCZACtQdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712796070; c=relaxed/simple;
	bh=e2yYELAoySVzl/I7Xz2PR35QLZU9nbW6o6Okx4SjDBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XE9DlG+DfQvECwvzFk9mOBy2zxzs7Q0HNWIhmvz9YLRU9qAvRNphpBfdQ9mBLHROrCxG8DxKmFwjKFwgoRxQlHflptYVLlh2/P6Jka07Vky1zr8/9Jp4GZ3Xv7q9n7lPFIJfGD9oT/TWKu8RkeMnjdsPMgYjDOBra4i8Ahr1kXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ic9D1GvN; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ic9D1GvN"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36aa0eb4adbso3258395ab.3
        for <linux-block@vger.kernel.org>; Wed, 10 Apr 2024 17:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712796065; x=1713400865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKgaWymCA7byQ3pP1Edxiucbtgpjbgswg4BKCEuveSs=;
        b=Ic9D1GvNT7C6A+onUwGFQciJM/gwe3p7RIdKuSbHW7+uETRgPQw0YTNqpYywn7Ek3W
         F0ziDZWfvh7aymidEt8w5ZtcVlNUvVE2frENUSPuYXnlbCoyxPUEolkCdYl7PAgxxGSZ
         E7SjfqPSB2BEemOu4Xe7/bKXK1CzMXDwLQPvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712796065; x=1713400865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKgaWymCA7byQ3pP1Edxiucbtgpjbgswg4BKCEuveSs=;
        b=P4HMyiXMISRP+C8GDm7CN2QqLtxya73sKJ/E+4vDQwvLQdRUlZMkrjQESXvSx0pN5E
         L/0NOHsTuSuCZ6T88DTw68aJ6SI+0kOLT4sXkAWx4wq8i9nynK7fQLnGV0Itua2gpmPp
         pte41K5hPeq+VviSjU5jDyAbdw96ooxp7TD6y0Zdt6vciiW5ZB6tdAyOp2mpXsNnUbKF
         ZooHUlyxgOvVdLaDYzLfDDcXu2Tgip8wJl7U33j626Ob6itkgtNT5ZN+PZeQ7Y2sGPCc
         4iMSrMCi3VfTi6+16h8kHf5rkwpRViHQV8GuHF/mGpwVLq6WTyfseBxv1SI3kFZ+322G
         w3yg==
X-Forwarded-Encrypted: i=1; AJvYcCVSGKoN3pCGU8E0jp6ItlldeCSqqkahbOwcd+EoEuKw//JYeKHBShkWmc/95KlucmsBDuCgQvrEoG3giefQPbcsln5iAM5WxDqPq+A=
X-Gm-Message-State: AOJu0YykRABextm4PBegLoFtYI05At1LIdJ8a2jibLWXScJGWCDH3zbY
	SdyUZyCq11NLJzNKYr2ns1nYbCuD6xBDMJuryw6hmZmhy6KKATBwUd7iTAZ6U8m9cGKn88jjDlw
	=
X-Google-Smtp-Source: AGHT+IGDAD7dL3LOOrzNCVQ59wj2g9+ChqDyJdjnBAxIhixl0Jwg4vsZhQeHbrM4t+hXEKkQFpikHw==
X-Received: by 2002:a05:6e02:1cac:b0:36a:1f88:d73a with SMTP id x12-20020a056e021cac00b0036a1f88d73amr5390406ill.15.1712796065348;
        Wed, 10 Apr 2024 17:41:05 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f30d:f29e:acb:4140])
        by smtp.gmail.com with ESMTPSA id o21-20020a639215000000b005e838955bc4sm149920pgd.58.2024.04.10.17.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:41:04 -0700 (PDT)
Date: Thu, 11 Apr 2024 09:40:57 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, senozhatsky@chromium.org,
	linux-block@vger.kernel.org, axboe@kernel.dk, linux-mm@kvack.org,
	terrelln@fb.com, chrisl@kernel.org, david@redhat.com,
	kasong@tencent.com, yuzhao@google.com, yosryahmed@google.com,
	nphamcs@gmail.com, willy@infradead.org, hannes@cmpxchg.org,
	ying.huang@intel.com, surenb@google.com, wajdi.k.feghali@intel.com,
	kanchana.p.sridhar@intel.com, corbet@lwn.net,
	zhouchengming@bytedance.com,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH RFC 2/2] zram: support compression at the granularity of
 multi-pages
Message-ID: <20240411004057.GA8743@google.com>
References: <20240327214816.31191-1-21cnbao@gmail.com>
 <20240327214816.31191-3-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327214816.31191-3-21cnbao@gmail.com>

On (24/03/28 10:48), Barry Song wrote:
[..]
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
> index 37bf29f34d26..8481271b3ceb 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -38,7 +38,14 @@
>   *
>   * We use BUILD_BUG_ON() to make sure that zram pageflags don't overflow.
>   */
> +
> +#ifdef CONFIG_ZRAM_MULTI_PAGES
> +#define ZRAM_FLAG_SHIFT (CONT_PTE_SHIFT + 1)

So this is ARM-only?
