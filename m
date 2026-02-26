Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD203A4F3D
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772101646; cv=none; b=Qfhf+lYVuC8LUUge/jwWppr+vHH0JaYXlryn8+9j9V50zNVzAkR/iZk2/syR5YXp6CCMxjV330ERZgRpNYmye/RIKDVN4LH2MRpUZT8h2mpGft9kbpgF/iGDxNyuKD6Y5jYlotVg4uKOs/inf+v5oMpr8WLvkd1NT13DIsI6dz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772101646; c=relaxed/simple;
	bh=Uaiul+pRa8BIOsaQ1gQAyL0YUie6OJf6H/L4D6o86EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7Iqmt54noxgvRe5Opsr/p/qoY7nI4w1wgJUviczkE01QHcUdBxU/Zg9Jtd5VDE0D1RaHw8cLKI3suIOlX6sVCyDML/REhBS3K0/IclFWxmpnukj0xRVtqgPGLSX71P8xTTSaC+32tOkajVy0Ak8XAy2yQaLgOQAhl4Gf2U4ffI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YpiQibrs; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YpiQibrs"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-827390e8a3cso457422b3a.0
        for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 02:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772101644; x=1772706444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uYd9LQOgtGfr6ToFGPcm9vHMjH23U3Gx01wMC48gKw4=;
        b=YpiQibrsjTNMmFiKa7/ZOIUlAwD5H/GFE0Po+GcDbwAdvCMjcqvWtC1W7U4cPxz4D8
         T3WhAR8Q5OmjwY0xa+exZZcBEQ8GssohxKoB8GAY3sptx2ipQHT06Zs8wso/zzK+Limr
         A7VIrPaAis0A1G3tR2aQP7tnArLJAI3gUjO7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772101644; x=1772706444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYd9LQOgtGfr6ToFGPcm9vHMjH23U3Gx01wMC48gKw4=;
        b=ka2Ym5Y5ojqWTol56Vtl+zJIKvieDxQYC6MvJYFGRr0Kl0dlBBntWO54cA9/Iwsqjq
         CMNkowcv+UbET7bEcGq75PfKdceB9KF9ijX4ZFBZfoCJpG8oKc/uQfqGR9bnmxdPfD5p
         tXk2uE8vjnhH4X2Y7ZQ1K2hdX8Hfe4UQREfFCa55tuZhfVVdSMI8ENWVH17ZD7zS1V8J
         JkaKQ5I1yc3Z1gLRrBU4tsqml0zXCjl63lH76j85sTepaYuUgtdwA0ZuP/cMqVkpb2Vo
         IMM5vkF4I2EFeJpJOIuMraJVBYONkqJeCY1ZjJk6xUCTvW+EGhwaVioyjoBTXjko1HZK
         Eqlw==
X-Forwarded-Encrypted: i=1; AJvYcCVi0d1J3nS8rRsaCGMTtoEub76BkQMwxr8w9WDZm3TxZqFVudMS2mhQvrWfxM9dvQxXf0PMmHlTbnbsOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXutwLj27wptCZOMZL1M8wPLtfwPGqKB8ZfjRTrQeAe0YXrYzQ
	J2tBFtPXzQUgAtu3v8L3b4fAR2uV2tpSs3jInEWeH/n9+py0LI7QvIVNjKdm+DHntNRFe50pyBO
	uMk8=
X-Gm-Gg: ATEYQzyRU5ZWGhOG9gHh8xQ8mPX6QnBcFPAy/0d+e4891Hm64pG0EkQQjzwwLLtTco3
	KCCM63FHMOs+GMSpafMOlP/kuATsVdHaFCsQhuhlhCxalBCZQiNi/zoXhTHduQD5u45F42eHN0R
	MxbqVqNtLZdV5Qn27gB3lgddc1A8Lc1eiq+Vup226+xgANRqdhAxJBK+etB/HWe6VcBtgZ0Dn+B
	laXhmP2TvDW4ETO7C7XoF17PZhn98/w1+9l5SStUkyegktgovZdagc61wrnR5p2DgV4J/xXNUUb
	4zgJSlGSJ9VmZdlH2ouKC2x0qHyAbCHRey24ZRBY2t9MyxFvOcI/cjAzvGbWU7rINC712Jf61D9
	4l8IJ3tPs3uEaRGuJ4Rd+iQoVUxGZYgydqIWNmASqe/5BV6Uey8ymxIL/rPpcCZQa+1IRv2ZW1y
	1s8Y3aCpUsROJStnfj6nGKsz18BrxKYf+zjJovVL2vYyA2vadHYM07Hjb1V+dcNk8=
X-Received: by 2002:a05:6a00:4217:b0:824:ad25:6477 with SMTP id d2e1a72fcca58-8273984fd38mr1756156b3a.30.1772101644430;
        Thu, 26 Feb 2026 02:27:24 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:280f:e47e:6718:7698])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a064167sm2076304b3a.56.2026.02.26.02.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 02:27:23 -0800 (PST)
Date: Thu, 26 Feb 2026 19:27:19 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: gao xu <gaoxu2@honor.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "surenb@google.com" <surenb@google.com>, 
	zhouxiaolong <zhouxiaolong9@honor.com>
Subject: Re: [PATCH] zram: compression algorithms name use static fields
Message-ID: <p3k2ohyq7jbbhjrvi5er5rencd4ffmcauk5ts72co2exjwgfyc@r4fgfsdp5hep>
References: <32d733a0719c479f85d06f6fec3cc533@honor.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32d733a0719c479f85d06f6fec3cc533@honor.com>

On (26/02/26 07:50), gao xu wrote:
> Subject: [PATCH] zram: compression algorithms name use static fields

Can you also change the order of the words in the subject line in v2?
Perhaps, to something like
	zram: use statically allocated compression algorithms names
or something along those lines.  The current subject line is a bit
hard to parse.
