Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A8E6A33B
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 04:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767760100; cv=none; b=j9Xiw8YvDQw/SVunoRNpiyU4GOOB7/6sMphB8tM0qbFdD+/gYCdvzUwTZmiqWBfX+F7p/9e/QT43KXex3tEq884T9GV9gO7J3wGPDoat9uUI+KFKMooL6KPCs6l0C3ujAEeK1r/JZXKK2EP2xhiWAULl+r0l1WlNarVHZu81HmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767760100; c=relaxed/simple;
	bh=f2jhy0sSOQ92qHcYgk5u8vpOp8prFdML9fHvs0aUyDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFYj0EDvb8T0QYCTZ70d+zvArwz17h/0CcmJjq6wku5BhurfOQIW5rrq4g/csJ7HlfgiOiLKYjr5uAt5A2YKZJZdPoQgGdHb/yEHUMDFYhAtOch0QIx1Pk/4CYendZLBaJ4VDQtTGTHPdNhhThBnb+wNPlepl86FaBrYQtYyWKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YXQ6gvuY; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YXQ6gvuY"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bcfd82f55ebso146062a12.1
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 20:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767760098; x=1768364898; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lHnkuioL4uAKz+quBgfo5p0xKOWMA07CTVehzvC4g0g=;
        b=YXQ6gvuYl27wkQ3XJ9UscMkJ0c3nFbDNwErLYCl2OT0h9plsg9ilBlcA+cWEUfRjBa
         0V7RYMmZy42dpXECgqBe494yCwnUw/8Fp0kHj0ieAaam0y03dZajROwR7VGP6PNwAPNl
         xbuZY+TirTMP7AyCJbkflGC9zmXv49GsSiOTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767760098; x=1768364898;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHnkuioL4uAKz+quBgfo5p0xKOWMA07CTVehzvC4g0g=;
        b=u+/zNkoGU3lIpKD6ul8SkOVVj5APu1qwIM6QZzaI2cAQAc8x9eHnWKTYm6He6Wx1TT
         FO151V41ckhC7oSaolsSACwAzRX5FRUi6ycOxkEv0483LiA/N5BPaFwJkrDcahah23lE
         x3ublvkd4sDMbB6ulM0swDcUsHdL0vwzRnCsK7OHogbP7uJJSZN+9duuWnMaCFKGySBp
         UwAD8lMwfH3VVl8WFjfVQZG/1WlDu5QhT/j49mj7LZ8pd2j5zvV9K+japcJsE/rBqtXi
         FUlE7N1cJV4IljlQZGo8KKfCx1fAPVwwVS3W15Cl2DOHYyUTzLK0zisVaqc0COJURWsZ
         GVTg==
X-Forwarded-Encrypted: i=1; AJvYcCUUf91sDbGagCT6mpT8F9usHj2ek8cd+V0hOvrTfofOjGKnvlA5NOoOTadtYbFilB31OBIhb7qkamwnvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIoou4fU2oKI5EwoQEC4h2xbf1IBjHEZGL/izaiAq6dqvgqFUj
	QjSstr4FnPK7rF+dKY19KuPt/UNor1PjS0wf4aQ+MnkQ6jbkxs1/dyy3mfOBCpsVAw==
X-Gm-Gg: AY/fxX43hkfvIWjP3TFhqqKaxS649E/xA9hWVeZWE7LhHTaBGvqyWUZviMBHBy4h35k
	rRtft5sp1plIxg/z1MGA8eTMas2/Suuh29/WZ1/wrRTH9+sXR4LGCUyha2jbsAqFixAkXbBxDMm
	vYxfvpZDbVnoyUduefEoSZqWFJKXH7wVSeAnxQduM5KUDmE03uyLWoQ/W/KQsbdWFYxtIx7GEq2
	rkAkkIEVCac7hhzKz9yv1U59AQd9pW8rOFR49DgYxjufXjQmxjEbVNTpAgyxEE2z5rQsM2GmdnW
	6H1xo/mzaG1cRtdBhPWNap2cS26ug7luptM+uGJOpbMs+LNzAYvTMLOEF7W//kHS44xB/Yo4zZD
	ELOeeVy2i+SQKi15CDUAQAVRXpnM1VB9PtrFdQTkHW9/oEWYk/lgardrdg16W9sbrVCF8FZQ3rk
	N9n1jKhmtzPGxth6EnFXzPpLSRQPgAG61gnJEpaPRq/hkfe0iUW0Y=
X-Google-Smtp-Source: AGHT+IGeUQkxH4Y6IawwUJQJllB/6lg+8Ctvx8R3Cj+8E1aOahzcqPjitaieJ2XpuHPozrGfu9gLJw==
X-Received: by 2002:a17:90b:49:b0:340:8d99:49d4 with SMTP id 98e67ed59e1d1-34f5f831cabmr3930755a91.1.1767760098369;
        Tue, 06 Jan 2026 20:28:18 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:9f6a:2617:8891:93ff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7b1d81sm3584165a91.1.2026.01.06.20.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 20:28:16 -0800 (PST)
Date: Wed, 7 Jan 2026 13:28:11 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: zhangdongdong <zhangdongdong925@sina.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Richard Chang <richardycc@google.com>, 
	Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>, 
	David Stevens <stevensd@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, Minchan Kim <minchan@google.com>
Subject: Re: [PATCHv2 1/7] zram: introduce compressed data writeback
Message-ID: <7bnmkuodymm33yclp6e5oir2sqnqmpwlsb5qlxqyawszb5bvlu@l63wu3ckqihc>
References: <20251201094754.4149975-1-senozhatsky@chromium.org>
 <20251201094754.4149975-2-senozhatsky@chromium.org>
 <40e38fa7-725b-407a-917a-59c5a76dedcb@sina.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40e38fa7-725b-407a-917a-59c5a76dedcb@sina.com>

On (26/01/07 11:50), zhangdongdong wrote:
> Hi Sergey,
> 
> Thanks for the work on decompression-on-demand.
> 
> One concern I’d like to raise is the use of a workqueue for readback
> decompression. In our measurements, deferring decompression to a worker
> introduces non-trivial scheduling overhead, and under memory pressure
> the added latency can be noticeable (tens of milliseconds in some cases).

The problem is those bio completions happen in atomic context, and zram
requires both compression and decompression to be non-atomic.  And we
can't do sync read on the zram side, because those bio-s are chained.
So the current plan is to look how system hi-prio per-cpu workqueue
will handle this.

Did you try high priority workqueue?
