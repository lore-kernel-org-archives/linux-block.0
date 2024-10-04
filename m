Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF4B77107
	for <linux-block@vger.kernel.org>; Fri,  4 Oct 2024 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728028170; cv=none; b=u9uN4/G1EkazWkAIdbgeAoGpWiF2wBbakJ8xyjy3WdvKR6en1MHPW0a4BJIw6yCxIk/Xvk4iv324TYi9dBfZSBeLDO72lXN5qY2jstlz0QUV4CyYFMBLT7Tdn8veTgdm/gp01F4x+XXMyCacBnRwFAObjRbBIRm6vWOt6YV7xLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728028170; c=relaxed/simple;
	bh=uWI9Y3wGxaOZ50c2KrZuMaQwdcT4vDrnO2S9iWoXzUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iauZG8pzzqUsppJn4wMZD7Nh9L07a7wvaLvRyFOoxXburQLMEj1s4c3dhq7WXXZN1B2+eu1sNgTWpc1Y+HiFg+R4FOD0SBhAbVGvBbBxxTTUeGvjub502+xZ5twPx2dWUi7xYSYjP1S2l1rQ5yLX/F1gVodbWTBxD+3g0BAxgMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GqT0Nwqq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GqT0Nwqq"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b0b2528d8so20731185ad.2
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2024 00:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728028168; x=1728632968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=atMHzrqYvsCgaEtQ7AVl+03E5wPm74inyiybNu8yKaI=;
        b=GqT0NwqqMaz0qItq0/RzeREo5UQ7LI5QzeR+0q0ChiDXwL/xYlX6ikdBKCpSiJC3oF
         nhaljHYqPpKplhWuVHot16GIXq5Rekhrp3gB2dE0qd0K0JQQHMUrZIkvIopzflrWaeJR
         lwR/k4k+GPQFn/V6YTdDGSmxU5GUHqwXfcS4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728028168; x=1728632968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atMHzrqYvsCgaEtQ7AVl+03E5wPm74inyiybNu8yKaI=;
        b=R3rjXE4/qSR/LdpSWd4Ngx6Wpw15Pk0ffha8W5KhXKqwe0XJrb3vDwSRAL05xZQB5h
         s27yUstJYZtPhWgbL7Yv1lslcfsl41Yyn+09YdGf/GPm43aju9ZppaPzzn93zy2za8uf
         zgcamePFyiuGkneSsjFvElFuN5B8jN96H1nGgLLounZHk8aihNgDdp1xrzQf8uEjdgKQ
         EoZ/5ImLSOSPl5O+Pegrg5P3tJVWGB7V0WT8P4aaoZ1aRVA7vOhmWou52jk4Xm7wFfQp
         ena0QxO1BkEFuLgFw57MPSySTDRJQw7b52b3ZP+K6/2xqbmXscVtwCTJhA163DGOLdWw
         pHsA==
X-Forwarded-Encrypted: i=1; AJvYcCXeJ5/WDaUD2EPe3EImNcuRg2byG2J5L9to/oxP6HDg540lUMiov3zxcxTL2hbe4lAA2OHjjIHAQO61Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCvRbngATTi05ew3YzyKOSo6HDrm2K9cjmeiDOPNO3Wh0V8rnj
	mrScXmGHqAT7pUxHhvaHm0ezRq5NpyJJuz8BaPIfAochqcPd4dTrwMWTO276Q+FckiFSbAki+tE
	2Xg==
X-Google-Smtp-Source: AGHT+IFItqP6jLrD+gLp58Gl8QcN2yrFc4pGs4XpppXaKepcyhSGPWzl9QuhHTb7rXWq39jr+N72tg==
X-Received: by 2002:a17:902:f552:b0:20b:85da:a6e5 with SMTP id d9443c01a7336-20bfdf64f63mr26121905ad.8.1728028168070;
        Fri, 04 Oct 2024 00:49:28 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:17b3:dfd3:7130:df15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beefafbfesm19122245ad.216.2024.10.04.00.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 00:49:27 -0700 (PDT)
Date: Fri, 4 Oct 2024 16:49:24 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yang Yang <yang.yang@vivo.com>
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <20241004074924.GQ11458@google.com>
References: <20241003085610.GK11458@google.com>
 <Zv6d1Iy18wKvliLm@infradead.org>
 <Zv6fbloZRg2xQ1Jf@infradead.org>
 <20241003140051.GM11458@google.com>
 <20241003141709.GN11458@google.com>
 <20241004042127.GO11458@google.com>
 <Zv-O9tldIzPfD8ju@infradead.org>
 <20241004074818.GP11458@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004074818.GP11458@google.com>

On (24/10/04 16:48), Sergey Senozhatsky wrote:
[..]
> +	/*
> +	 * Fail any new I/O.
> +	 */
> +	test_bit(GD_DEAD, &disk->state);

	 ^^^ set bit, of course.

> +	blk_queue_disk_dead(disk->queue);
> +
