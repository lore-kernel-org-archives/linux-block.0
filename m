Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09257418A33
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785925748; cv=none; b=mkau1EZCE70rpcIOSgwvC1Al4yRKlJkEoxsP3G7cG6lI2xvBN63X+AG7Wtce2y0dm2CqOmdCLAWQHqLAUVEuwVqpM6bsKVcluzW05oEwAkJx8OV0cdAqQNDBa61HwdMHQBjcDi2dGedD7FNTuB0MLIW8aJd/Ny9NL5WEwjb3i7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785925748; c=relaxed/simple;
	bh=StromziW+40JYZDwey68lBv5UX9Ghm/SOb7iQ63o/3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFU3QRR7PJU2tBte2IzC7UZ1B1w/t8gaoc2AQeEHOWJ4F0Fvjj8ICPB2dbSY40FFiRTD5FzhrmCgUsiUGODYWb2qE7ehvL+eOaI8HDD0e7wRbH7zGky7FO2U5tpJZLo4gYetySuzQYfHGp5Mk7QGYpzWL9F0/scB/6kDJPrY124=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y/u9Sp6n; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y/u9Sp6n"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-383cb94f742so833485a91.3
        for <linux-block@vger.kernel.org>; Wed, 05 Aug 2026 03:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785925746; x=1786530546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yxmm2cjRCk3GSE4g/lkjj6zw4WWlmgAbO/trdtnK1C4=;
        b=Y/u9Sp6nltKRLaeAjg5iuymnnM4YPfvxH+qMT2AxrXuXWBvE+0NvZIKkATFM/nj9ki
         MOeQUz5ZdqIkcTDamsgY5lMJPwmbruITBZguLulvcF8JRviXEjZablTihBEMgeE52i3v
         3paA2LSTCseiVqAqg1s1qcPsYfE3BOKXg62Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785925746; x=1786530546;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yxmm2cjRCk3GSE4g/lkjj6zw4WWlmgAbO/trdtnK1C4=;
        b=WGuVZuf+YXx3F+Rfr1XlyqvDC56eC9xbaPjsTUXPR/SZkQfyUc0Ru2eLOApHNmpA8r
         vS/785ScA3+co3juQm/gDxHZ/bKOu3zjpd8gSQGQ0vfOGHKQv/9haaVJhJR9aCTGVeG4
         xfPDU1MMxjJZ11jTkXzeu4iReCcdHMKWCd70qzVe7tFW944S13c9slYJjeA8eLiTpilC
         D8FOWGQCAsQdENf0Gs2kTsD3vzYtgAq35qwjQHf5HIChGNhyf7eqY3vF1ukSD2qxoerf
         XgJus3ZDD54Brp6wij/hPQyMyvfFjEDZB0uxc8+1XJiloj8FzqQU/mi2I0WMbhrShHlW
         dVkg==
X-Forwarded-Encrypted: i=1; AHgh+Ro4eqyJs6PjT2mq9KAclpnN46nRoupJHA2mNxw4GmwP8DsiXHDNs+CjQGN/PrjMUWMtwQdnHXxwZDG09w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzU1JiO3B7bOUsI+I3DfHpA4V/ru3NPitlHQf9a8dPdgnrH3GEq
	k3RZszGcoFwABEwBy4oBHy0yj4mkaQvi4jYkKP2SUtWnURWPEKTcjAWhHi4ZjOik7w==
X-Gm-Gg: AR+sD11AzLuOkBC7uWMEnh6Z60OLcP0BejsRb1tGr6nY71O7DHuZQBIRLAdnKCpgWCf
	Wn3jcHoQHfDw8tpFj+NXWjjZU/BI5fbtU0CxNoucVXTAyLxRJ2ah4+Q21Nxx2zZlAaOI1Z8Ba0q
	+8DgOCeePYfZwm/EtStwa+/YVjTDmssB+6e/LEE7P1zimGFmUHIPef/vODZBitX++v6DwPnMFP4
	eU7vmLqdzjSuUQjmNgrBJ+bh1pG5f+EzJMPXRtvfnqrIi3TqtQwS5l35LZVQ1idJW0yrvV8839d
	Tiui9IbRwaeYMXcw1n+JA9tPgLDLoc9dZ1uRbYu6IU1Ic4gEwIlZH0XGve3VL+LcQlm1qrqh770
	Cxun8xHCwkYhu1gzDMCD4/jp+C+yMbXsjYGxIwtFOPwU7G8XQ0yqF9f5UX2yM8HFar84qlc5Yms
	NZxQ6UjBNeyK0xpAaDD9kyLthcmRO5rhsXr8uWn3jVRocJxWLUBCuPf4SV3e9J6WB5/2lFEsIOx
	2a5hYn54n4ZwoQklw4ev2PE7gLR
X-Received: by 2002:a17:90b:2d84:b0:38f:18f9:785 with SMTP id 98e67ed59e1d1-3903c538263mr5818956a91.8.1785925746154;
        Wed, 05 Aug 2026 03:29:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8002:2a47:a704:5a58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903914186esm2780030a91.1.2026.08.05.03.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 03:29:05 -0700 (PDT)
Date: Wed, 5 Aug 2026 19:29:02 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Longlong Xia <xialonglong@kylinos.cn>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] zram: freeze device queue before device reset
Message-ID: <anMQTJeiBZUHX2Y_@google.com>
References: <20260805021854.1057715-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805021854.1057715-1-senozhatsky@chromium.org>

On (26/08/05 11:18), Sergey Senozhatsky wrote:
> Device reset does not take into account in-flight async IO
> requests so we can free meta table and reset device concurrently
> with those requests being executed. The block layer guidelines
> indicate that queue state should be protected by blk_mq_freeze_queue()
> during teardown.  Freeze zram queue before device reset.
> 
> Fixes: cd67e10ac699 ("zram: promote zram from staging")
> Link: https://sashiko.dev/#/patchset/20260804065919.3970386-1-xialonglong2025@163.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

lockdep doesn't seem to be happy...
Let me look into it.
