Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B157D2D876B
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785893301; cv=none; b=CICctFUJlAXTQToVYBWRjzVdZWPBZl/hHSpUon3ki3zeCFyFKaTRBBHsvfYYbIzZvDL4zFhv9y33Su+qYysXmpX6VQvN+EJDoYM6JY44iD8LK/gYbejkP7BUQXW50H431D8s/d3qNcz6DFgcDuA38piK/Qkym8M49+xHJKnM3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785893301; c=relaxed/simple;
	bh=LP/CPsWWk7JdhdkRUgVX64RFY6Mb6ULuSPlD2yzQEHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyPWjKPvxuIXj/VmJ3rGBDz9BMeYmimzxpbTLQFjMyz1oQZhg9k9TzdAB88ZkM92zxD3itoJA08Zip35OXnHqLriwymBbHl0fqTs00vmz2N7BKTJxbHwxv9H6hb7NnBnLmQJKS9LvB5KEJtKVFmTJVfXvGsjN1PWrmCq5zLKNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hvADBIN7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hvADBIN7"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cad8076b01so5589965ad.2
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 18:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785893299; x=1786498099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hDRA8RaOryE0v7n4VH+L8tqsdWogJTvOgNRaAuqsLwI=;
        b=hvADBIN7rloNVJUcjZwSAi9T70JUdSa0z/QU4PX57XNrGiSXe/61ezs7CjBU5JwkcO
         KIpJUfnjj7UaaYLaJAf7f2zqFLKhLAwmMXknBvLrVtybaF6d4WEoL1Y4AvyQhnMCQxdB
         uQ4DbY182uXwI+CJAzKyJ1javMr2Es1Aeo2AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785893299; x=1786498099;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hDRA8RaOryE0v7n4VH+L8tqsdWogJTvOgNRaAuqsLwI=;
        b=BO6PBt9R8SU1L9kKp9/YogCEqXHspMxe7tJlgtyplT5kwwTEU2h51Cqv4+h4dMTRYM
         oanMLwy+TbslQ5jRFO+R2Zdh8G4jEKDfAg1nZzZyeQKLIEGMI2/XVKQRcpzgqaDDCuEW
         XUC+1Bq4Ex140cjoblG3/RzJgtaMaZLAZcG4q5rX6f8yRq7EXK+IN2B0SVz15ZtUMoQ2
         oaVMGuZt18OFuhDyF2QsW5p40m33xNV/sYBWodZDYtSd6kcaB+nVbgaSXJa9Krb3Og4S
         rL/ZD5PAIQv1iSXjOgTYROQHbVs1igPAXBltWZmA61FBheAEjKiK2m8oBY2j0MQ1xeGt
         q7lg==
X-Forwarded-Encrypted: i=1; AHgh+Ro+BA7dNIZD7sjoxOAoS57grydgvOYVwz/gX3Vi3qT0AEYTQR2J7ieY5G2Js+o0XcrjD/tsmO8bhdwBJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY6RnLfVcuMqAySoWcoiD0mIqYDOwTKi0qwC1sPfcGA/xEY9wK
	Hc/nFb1QePU/NsWxp1zw5fEYdTIEF9tbqBpw4+JML2/+ZzaAsoHedKr4YO5FHbXB7A==
X-Gm-Gg: AR+sD13aVrLpjms+kWc1B4Lu8tLG7V4PbqWhdz8Hx6CTFL6ue4Z4hnGlBz9ro+go42O
	N9Sr8aM0+npEjnOvK8oJlP70dkCFXRtbsPnmspLbDYkn7TRjAYa/FoPIDhjYx4MXAdSNbqKkBjV
	DbBJhdSoZAsW4GSylrPObUYKJ/giYcwH3K7sXcfIlEWOPYSPAX3n1gnq3iyZVvcwGlo8sf6MjRc
	zrMrjiPuo2sLDFvYR6yhlAklkuUy/cjnt8b3eGNINLUkxIkJ0faXjclRDRTJizE41e4T2lpZlWv
	hOTz0ebKwAbhoEYujT6dKrtjztsZcOtZu99TbhUzBgwmAr3B8iVzvtAJC9s1j9JfgYKONvigOan
	fW907bjzPXIbJhfjjHAPM1gAWp7w0szt0o94GrW4KKT4fyW0TN6/iMyrIBVAzVzDWj8KUOdboTG
	FqR1z6zBd8LGPI7xWCMwQ7P8rK5XOoshKUivKaRpaXpTDcA/HfNuerDGRM7mM5v76t/WzIXoM8c
	PNTxQyb6rsb2XYRe4xoypKXYpKR7fjdcR6RJxw=
X-Received: by 2002:a17:90b:5447:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-3903c66b3bfmr3047061a91.21.1785893298950;
        Tue, 04 Aug 2026 18:28:18 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:32eb:b46b:e9eb:65c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903d183dadsm554776a91.0.2026.08.04.18.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 18:28:18 -0700 (PDT)
Date: Wed, 5 Aug 2026 10:28:14 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Longlong Xia <xialonglong2025@163.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Longlong Xia <xialonglong@kylinos.cn>
Subject: Re: [PATCH 1/1] zram: reject disksizes that exceed slot index range
Message-ID: <anKRhIPsWUwvCzm_@google.com>
References: <20260804143832.146129-1-xialonglong2025@163.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804143832.146129-1-xialonglong2025@163.com>

On (26/08/04 22:38), Longlong Xia wrote:
> zram uses u32 slot indexes, while disksize_store() accepts a u64
> size. On 32-bit systems, a disksize larger than U32_MAX pages is
> truncated when zram_meta_alloc() assigns the page count to size_t.
> array_size() then sees only the truncated count, so a small table can
> be allocated while the original capacity is published. Valid I/O
> within that capacity can subsequently access beyond zram->table.
> 
> The same oversized capacity also lets full-device scanners compare a
> u32 index with an upper bound larger than U32_MAX, so the index can
> wrap instead of terminating.
> 
> Reject disksizes larger than U32_MAX pages before aligning and
> allocating the table. This keeps the table size, published capacity and
> slot index range consistent.
> 
> Fixes: 33863c21e69e ("Staging: zram: Replace ioctls with sysfs interface")
> Cc: <stable@vger.kernel.org>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
