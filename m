Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F7F1B142D
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 04:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791692890; cv=none; b=oKMaSo87UlxkUycU8hx3BbffNsty6RlJQ+fwVvsh6J3JnzbEjPkma49hdRz/WHaLoFWYJ7isUDL1dQRzeaxjpVBOoxU8tJkZkN08EhQcwwr0Hr7qpjczqvX3Aov1c44HsEQlcOLebXN7cjkVvlWhC/uU40yaeQ19WvQwvtxuf24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791692890; c=relaxed/simple;
	bh=NUKj3EZm97qkLDRMMjG9360voWGZgERsw4v1velbTR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOt84T5qHS2w2Ibu5fRIsNfK8jGOoo2sz5470IOYdM1zTTobbcFxAjxdvdPNFeugzggYcR2yZLYjZODsDSRKd9aqDoOBBuBqhUIv7Fg+Gh4BI23LEFnxcOvfr3gdrXDqGlchGubfpIwvqiyB2OIKBAzOC/xWKF6Un+6v5Blb3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A+js9uAG; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A+js9uAG"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so1888636a91.1
        for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 21:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791692889; x=1792297689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VgUBQDdodR1jUKBZJnt7Hs3MkCVZjH756ozkqdENr9k=;
        b=A+js9uAGkzq/KqoVVUu4Rs9vLb2eRzVIEzc4yTu4oLveDL6jxCuHCgBM5xCqS+b4V4
         sGx3VhsrOPlv5cymWkHxRpE8t9fK8B3r721RmhWUNx+CSXRU1fgn9HcAjFpo/nuio9Yb
         LG4HenxlRPUojJB26n3ku32RLIAvCJv6rhWXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791692889; x=1792297689;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VgUBQDdodR1jUKBZJnt7Hs3MkCVZjH756ozkqdENr9k=;
        b=1hCkqTaUdQwbun9K5lIKcxN5tXzXXhqFDJJRMCf0VaIaENjWBLVMm2Xg5rtaJWEodB
         K96cjtCBW+AqD4WxFNy+w0vjvNqat/1ynGM+nZlfFgKiTzq7uP1OceewOj1YID3sC/m8
         xZfn6NFZrumQj43UPUIuk67PfmmReYi/iz+z3RpeprQQnGU5ppwlibxPhwDo+3RzIjLU
         yxRMqCW1MGK1HMLI0k8JC7sqP97dqI6enmdtqXsuPu3Q3eWLyvPl6DQrpzDRGHIBJtWo
         i2msfDMamYgyrBB6FL2M1f7N7Aoz++YacDYY3LgNF85qwEFaBTz8sJzESCe9EFuVZqdR
         3egQ==
X-Forwarded-Encrypted: i=1; AKwUvByTKtDhKftZLvyYR9KWaErNMm7Q7+hGvlIiF0SbuGocY6Ul53NJnHkyLDsjY44XYN8tZEmZQUUrKcTcGg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIedF9Kts3zFJmr9JQnhvZxLWUnoFzmiMGOf7S4RbZbg18UASA7
	nru1lt5UjYUk1nDkPXr+L9psdzBa8ilz9KsTeYEY/oLnhdduKqnLAdHzKeJ2LYhQOQ==
X-Gm-Gg: AYBFou3jVyD8odwGqeTo3iIGo9KUdDHyBAl/XdC/MvS6rNz9viPQXehkoiLm8zfiLoJ
	YFO0CBO61N2IZgmFxAKk/57U6DoCh7B+xvj9lzHmjlmuUmxxlKrp+SG4vqyVcZjmGTJlJVRuOFB
	K78XumC2d3xwh8hVhgTBhkSUrcGqieEluFnkbBFRaMlI9sCbBYpoc76LdcOoMTg3LFzAqQF9Gm9
	cOjnOk0sT8k5yC+Cc73/DfODfvOXcOZmMuJ/IlrnLP58pmqFFtlF7D+iz9K0XBeSXrksHlwQpvG
	t7nLefXj28cNs8sJ39jYUPm617dfndBZeHCst86ZRZCbn0VhYxSb854XM05ecAOHsIB6f+9lJkg
	ebhqs3ZibuBtTdm2gNBADtFPTKT5A2RR1WZizgaxFrPtdAIV/hFRvmbJFfllzL+o4n+gj+MP4zC
	tL6V7mNsui3iTjjrtUfkLssRYne03Qm4epM20O6D+qfu5w+SM3c8+bsTPzYEX5J3S4w9xfIfeXC
	q8ISNugYkpFE+cpEOeHdjzUh3fsmm19Yd6fUkU=
X-Received: by 2002:a17:90b:3b84:b0:3a0:d7f2:5a58 with SMTP id 98e67ed59e1d1-3ab3a369ebamr3764665a91.3.1791692888901;
        Sat, 10 Oct 2026 21:28:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:75d8:6a8c:e079:f021])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab37163e21sm11921110a91.14.2026.10.10.21.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 21:28:07 -0700 (PDT)
Date: Sun, 11 Oct 2026 13:28:01 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
	Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v2 11/11] zram: use rw_semaphore for decompression streams
Message-ID: <assQJStvoDK0nepk@google.com>
References: <20261009071157.3730698-1-senozhatsky@chromium.org>
 <20261009071157.3730698-12-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009071157.3730698-12-senozhatsky@chromium.org>

On (26/10/09 16:11), Sergey Senozhatsky wrote:
> Currently, per-CPU decompression streams use a mutex, so there is
> a chance for priority inversion - a low priority Reader can get
> preempted by a higher priority Reader, which simply will get
> blocked on the stream mutex.
> 
> Switch zcomp_dstrm lock from mutex to rw_semaphore to permit parallel
> usage.  However, things are not completely straightforward.  Many
> backends have stateless decompression and don't modify decompression
> context, so those can be used concurrently.  But then there are backends
> that do modify decompression context.  We also can have compressed
> object span across physical pages, which zcomp linearises using stream's
> ->local_copy buffer before decompression.  That buffer, clearly, cannot
> be used concurrently.
> 
> When the backend has no per-stream decompression context (stateless)
> and zsmalloc object fits in a single page (ZCOMP_DECOMP_INPLACE), take
> the stream lock in shared mode (read).  Otherwise, when ->local_copy
> is needed (ZCOMP_DECOMP_BOUNCE) or the backend has a decompression
> context (zstd, deflate), take the lock in exclusive mode (write).
> 
> A quick synthetic fio test on 24 CPUs (preempt=full, lz4, 48 low
> priority (nice 19) readers, 24 normal priority (nice 0) CPU hogs
> and 24 high priority (nice -19) readers):
> 
>   Metric           Base               Patched
>   ----------------------------------------------------------
>   Read IOPS        473k               680k          (+43.8%)
>   Read clat avg    35.98 us           21.28 us      (-40.9%)
>   Read clat p99.95 55.55 us           20.86 us      (-2.7x)
>   Read clat p99.99 6,717 us           2,834 us      (-2.4x)
>   Read clat max    2,005,100 us       1,614,300 us  (-19.5%)
> 
> Suggested-by: Brian Geffon <bgeffon@google.com>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

JFI
I have completely reworked this patch.  Will run tests and then
send out v3.
