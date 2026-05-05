Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEE7318B9D
	for <linux-block@vger.kernel.org>; Tue,  5 May 2026 03:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777951516; cv=none; b=iyPb55Qejd0SnZQS6tIVumE/aK1xQ3yGAyCDPn0It8LkKaJHuzLOwXguCpF2Ap7hl3DDeLPd9cLPtcW3VtWKd6JGjJ1O83PUdeOLDV7w7Lb0R7o2NvDR0HKpnfka3jLxJlZRsC9BrT5/dLNmr67vF+wd3lL2fM23VXSsbkVn7e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777951516; c=relaxed/simple;
	bh=R5q6IqVd1ysQsurgFaqaoDH3f/2x1lsyKg2rGu8qncc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsjjtPkxT9QPHcZk7jm8EFIp2/XwlluHmHueseA6ch6Ygh7/GaExdDAqople35MEpRlKRsrTp8VF9BwgFm1ZTwzRPZ/syW+sjfnJSwwV1PTVfYuXfkIDnikyiV26rQ8l0BUZ0XiFG5zTAfv7zxp6o5AeQzEbZyBnkGgP6Pt+xMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aT5Xz6/Q; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aT5Xz6/Q"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b9705613ddso27834775ad.1
        for <linux-block@vger.kernel.org>; Mon, 04 May 2026 20:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777951513; x=1778556313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IOgn1ypZ4nduY+SbHUWa7G7iPPnNvuWv4v36Xev0RXs=;
        b=aT5Xz6/QaXa7SsUxXo/X7867gHIU7vHTL1syWa9RI7hxrZeYrp1OP+Nyve/JQOVkRy
         GL/4HI3RacfE7CJ/PEfpDexLkVHm0I1FwKU6kAUp4mWnjfGYl7TB9hsZTeLxcaZ5M8SD
         g92n6nJtdUh78TTyIds1sBizpn7sM87O3f0LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777951513; x=1778556313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOgn1ypZ4nduY+SbHUWa7G7iPPnNvuWv4v36Xev0RXs=;
        b=ln3gzB4hdijNAyR/8f/qljWHBZY92eBh54VJJNnlNoy8hw3z5P07gtx5OPjQOiXVMQ
         ArfmrbdJNjB1m9hWF5Nyv3UqTErrZjpu4IbeWxMPis6jMaWrc7GglmszPbHbPO06ZbUR
         cJB/5weZwfB/NiwJdiBfRiqssQu11mx8UdVWHvkhdYPXTujgIGzrGDxexOpQoWuEIBOo
         HG2Aczpr3AMSbq8FYc5ghnC6rI+1P2+bx5GrhAaROychNeYMYd6yMFXSja4wDw0aG/u+
         HCwDwOqwvb+cXSml2QigII5Q56rE49nF+tROa1OWTjvUDQ28pUanUN0n14EUvAoKSECz
         ickw==
X-Forwarded-Encrypted: i=1; AFNElJ/ohF1htf3JZnqDV4Tw7Sf/z4OOUuNmVnS8BurR3YJfDTFIWuqNFoKchCLKS4pTR1dfTyGPp7G0y+F3qQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3EFQtsJanclWDR/VipMSqYjit3gINr4cGla6+EVsU+/Ys4/LL
	ysNg/pD5LpkzTZCEt7feTZ1R/3rSEBMkcyM5rDnr4PAtvQHO4rcCrthbTHAt9m2Ikw==
X-Gm-Gg: AeBDietLy0jlVi5K1MOKldHLxIkMbIZF77u1iP6esz75PACD987QYwTNTMExnaX50Y+
	n26wiUWoDf/peNJ/bU64+5Tku5P6QLy9NzPhKUXdPOlHY5Dah0qY7Ga33pYgVyRVhjqXy9Ebogu
	QC4WYc8QwrFEFBgtaXj0Mp9+QvCWh+XQ0IGLrJXlm/UZzaVzDYQvCtrmY8Mp2oObsdLWFhAu6Vd
	MUT+ssYU1G6TxpZWbupp2zrzLyqemFgjrvEbKqC3Pve/zSUfwQCK4c+PzEqMQ8JDf268TxROYAF
	05rgwXBkGbpissrcUIegASPeyWaWwaXEh5sWugYdie/qUrxyzY/Eq6sM6uacRPOBBnbVhakOT/u
	CCNeyygcFLdYRNX8K4UoqAULb8Nr8mXRa2trdgKbcpGjVv8LNVYNVX5fTz8bn4Gq9I29t/kFa89
	om2WtOi1paGHtXOzlYovLi2IEQBz+H5hQIhwpBpijRWaVAt0vg7fbX+1TphL/rjF+Ec2koP20yP
	J3SahYV1/S2
X-Received: by 2002:a17:903:3c66:b0:2b2:4cd2:e16c with SMTP id d9443c01a7336-2b9f260d87bmr118255855ad.20.1777951513193;
        Mon, 04 May 2026 20:25:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:1159:b1b3:930d:d5eb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae0e605sm119301085ad.41.2026.05.04.20.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 20:25:12 -0700 (PDT)
Date: Tue, 5 May 2026 12:25:07 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	Richard Chang <richardycc@google.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, bgeffon@google.com, 
	liumartin@google.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH] zram: fix use-after-free in zram_writeback_endio
Message-ID: <afli4ssQC9pFArSq@google.com>
References: <20260504123230.3833765-1-richardycc@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504123230.3833765-1-richardycc@google.com>

On (26/05/04 12:32), Richard Chang wrote:
> A crash was observed in zram_writeback_endio due to a NULL pointer
> dereference in wake_up. The root cause is a race condition between the
> bio completion handler (zram_writeback_endio) and the writeback task.
> 
> In zram_writeback_endio, wake_up() is called on &wb_ctl->done_wait after
> releasing wb_ctl->done_lock. This creates a race window where the
> writeback task can see num_inflight become 0, return, and free wb_ctl
> before zram_writeback_endio calls wake_up().
> 
> CPU 0 (zram_writeback_endio)       CPU 1 (zram_complete_done_reqs)
> ============================       ============================
> spin_lock(&wb_ctl->done_lock);
> list_add(&req->entry, &wb_ctl->done_reqs);
> spin_unlock(&wb_ctl->done_lock);
>                                    while (&wb_ctl->num_inflight) > 0)
>                                    spin_lock(&wb_ctl->done_lock);
>                                    list_del(&req->entry);
>                                    spin_unlock(&wb_ctl->done_lock);
> 				   // num_inflight becomes 0
>                                    atomic_dec(&wb_ctl->num_inflight);
>                                    returns to writeback_store();
> 				   // frees wb_ctl
>                                    release_wb_ctl(wb_ctl);
> 
> // UAF crash!
> wake_up(&wb_ctl->done_wait);
> 
> Fix this by moving wake_up() inside the done_lock critical section.
> This ensures that zram_complete_done_reqs cannot consume the request
> and decrement num_inflight until zram_writeback_endio has finished
> calling wake_up() and released the lock.
> 
> Fixes: f405066a1f0d ("zram: introduce writeback bio batching")
> Signed-off-by: Richard Chang <richardycc@google.com>

Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
