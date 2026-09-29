Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE704503EE
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670976; cv=none; b=U158qhW+8VWMwX43LeoufLjG8E2fMw4Sbn02LolMNmy7YlqnKC2LzyHSvrPrwNGeC9klDVWqaf4l8gy331JO6yu3qGzHKgALt9c5BlIJMUxtvZBL4rtvwdGrn44xNMrQ4MDn7736GwcvTm06zNY8dD2lLRAnhL2iO1nzktvaRPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670976; c=relaxed/simple;
	bh=VRAOKD8IQiv5Doj3zfyFa4TmmxoE+pNf7XnBp7cBamM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWQxPcIesllfRJADH3LUA8PNkvEz7rc0+rM72kgLqLMHoMRD24cT25KM0jkpps8hlMIKeskrElA9RrV6oEcg5UYYPZjXkAPxp1JDbTbuR2ywP+B6yfNwVY25jUIJJyuDjKiFMksNDjMpqL1DNiqLaI4UMqG3Cre7cNFwdczEb2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gCKSrm8k; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gCKSrm8k"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc7979d1dedso1136293a12.3
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 01:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790670967; x=1791275767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wqIX/K8+VwYyF/xC9PmKKDDvSH4cgd5EwORlAHhZrEs=;
        b=gCKSrm8kWVAQuscs8wlwU0pm78XNEwx96TPwSd1D7QSM41nZ9IgUycfbIMNk8oXEz/
         +9Gzcb7XDuQI3KK0Ufpap2f8MbdpJBu5cdjWK//V/LItFlBO60fv/TRXUnisbMSW1DrK
         kScCkr+CyDoRtfy1KlPyuY0IjKIQuj/pHVjYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790670967; x=1791275767;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wqIX/K8+VwYyF/xC9PmKKDDvSH4cgd5EwORlAHhZrEs=;
        b=c8kqQvQOIZL1pQjB3RXf6ukHTqxHB/cIGAs4PfXfbteTtVz4JWm1s5ACt4r1jzV8rb
         X7fuiXqQxkN26F3DvcaM3wCKcXer3DjWyLtzQMA/STYdXVhn+HnSKkSz8AcFR+pUvaBv
         8Vy3NTZkINlW97RrVbe3VluQQ+ecBGEXD7nrrsbBz0mLWMYftDMqE/7mNW2hzIUPFLYp
         d4F5rrdORaaKtTEfc4BmAfSSeS84Dup0j7pDKA4A61iw6LdWysA8aNIEAp99ydcdURi4
         3i531WiCS0p/ZSZ2ISaJk7evodff8T2ls55XtWYvcOMCiIkp7Tfe2hA7sJwl5PoOetVn
         W9Jg==
X-Forwarded-Encrypted: i=1; AKwUvBwz7/8/Vc3Uabret0wBtdf/7mdiII9R5Cemcyy6r7/42o7xc7+SI+/hQ3TVeVk6/0TOx6ifunS5mpdIdQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLQtW9JFeuM0J261bzyR/9xepnvNdi8tJPhqqsVTuy9QIzJp/aX
	F+lOVZS9G664T8GCMVh9Q6renid4cPKO68ASc78KvMx+/p9wTcB5z8UvvotTSuppKPj4ZwxSSq6
	zMSo=
X-Gm-Gg: AYBFou3IrX0OarGWazeDqZpZSg526MtfXGBksOlwDQCBL5s1rJaa46g5qh7Uqc7UxMq
	Wv3wKjEfMVeiCZxKMoXA9Qw94Ys5lc5EINfELd7QEajxd0FmHtEACLeh9pNWdYN2X8iPaiUX0k2
	9qxDPBEO3rQmy/30vQwDeFbNAWxO5wcE5aMpdipgEXTgtagNYBIVDHPt/kK4l9ynlZl2dH0Tnp6
	hasFcYFjjD6ei0gd0/cjwCBFYZQTPHZyTP9bBfdbXOP87paKhicsvJMhk7bZDs6pfBXa6CYFYLj
	HImaEeiQpuMTlIX+3jfOs1DCJVQnso9MzPM7iHYlsLRxRsq5GePcyNiu4Evj3fVG36qqyNSmVec
	u+WqoKJGfStweHUv6gVjfLtiSqDOQnbrNgeBDDjxtgLeCEwyT5Ap1/4Hb1DzbaLv/rVu0HmIqOk
	fsA2xisjEnW2BOg2xWTgJIf750lDOplKV82+Xc9AFa3/+YqSSq434A5gl8OTtDDEGlGNafLHk+C
	xgPI/YlukuCKtptqJgB1ss7ahK7JXE9GlEI27XqbcdF2oGmazA=
X-Received: by 2002:a17:90b:55cb:b0:3a0:f4ee:d2a6 with SMTP id 98e67ed59e1d1-3a0f4eee43emr6338930a91.19.1790670967013;
        Tue, 29 Sep 2026 01:36:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:31b3:f8c3:893a:d0bb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a492dfc5absm2202607a91.3.2026.09.29.01.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 01:36:06 -0700 (PDT)
Date: Tue, 29 Sep 2026 17:36:03 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	Pooyan Azad <pooyan.azadparvar@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] zram: fix short reads from block_state
Message-ID: <art30sD5xpFZx9QG@google.com>
References: <20260928164826.24858-1-pooyan.azadparvar@gmail.com>
 <20260929071846.24829-1-pooyan.azadparvar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929071846.24829-1-pooyan.azadparvar@gmail.com>

On (26/09/29 09:18), Pooyan Azad wrote:
> read_block_state() formats each entry directly into the buffer supplied
> by read(). If the remaining buffer is too small for one complete record,
> snprintf() returns the full record length and the function stops without
> copying data or advancing the file position. A read smaller than a record
> therefore returns zero at a non-EOF position and cannot make progress.
> 
> Convert block_state to seq_file so formatted records are buffered
> independently of the userspace read size. Keep dev_lock held across each
> seq_file iteration and continue to protect individual entries with their
> slot locks.
> 
> Fixes: c0265342bff4 ("zram: introduce zram memory tracking")
> Closes: https://lore.kernel.org/r/CANC3H+LdtoydSp+o2ecErAw7k6R2+gRf9LyxcaoHv_mGhJmyQQ@mail.gmail.com/
> Signed-off-by: Pooyan Azad <pooyan.azadparvar@gmail.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
