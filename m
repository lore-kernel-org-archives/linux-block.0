Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910FC366
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618388; cv=none; b=YRbn3gPtpWgfeO5VJdw2/wLY9+2a+YwVx4Nu7qOt3e0Xaf2/WLYv+62/8kzUOmNFdYL6T7Wznhu3eJtAPgFwFn9+DTJXrRSaH/Z8bWd/PhjWo6jVfXL7CxrPqf8ebeHnZWT/txUrS3Bblo/cbtyXkUjioR5aijFipIzlc/8oASQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618388; c=relaxed/simple;
	bh=/YbZf5Fn9LbpelUmEwBC32jaMI6S+tSn+Ps+Q3aHypQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWs+0m5uaDHPet8/UIPsEks/gqX8neFeXvagWGluVmu16n7uBsXf9Wy2rPsWEScB9/g146w7ex/6Fte1X+YUie+EzGV5wi9//cpE/iPXA7mgsZ8hDEqBtecpOGkY3hIpq/928Ek2rqunFCtLgKV0TOv6UH5f0qRxqt5/Jb7n/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DrEUROak; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DrEUROak"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71d4fceec9aso826307a34.3
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 02:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732618385; x=1733223185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xLxX3fqZ63MUpmJR6uoNHWqb6sJsRbD2Q41zd6ClOoY=;
        b=DrEUROakKr/VvY7EX69GpVF6HJ06RnqpVgC5GP8b6WqX7RJhQNI+d5pXCIFnetX4Ad
         9HbZ9r3e14zXkLKcF5q74Yi33fRfxLLErL+FfRnNRvS0MUcB3IJujbQDP33+B17s9MAu
         ULDF/DUm/g8LDzW9eYVOSYwwt+8u4bQyFRPJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732618385; x=1733223185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLxX3fqZ63MUpmJR6uoNHWqb6sJsRbD2Q41zd6ClOoY=;
        b=wmJsLuOs7A8cptn1TIDy5Focd1m54hJJiDUUWSATiNMD2QDjdaOF1EAgPMuLiQedZq
         /rZ3mLpMR4Ov1N/2B7AbfO5hnAV/ljaJQ0hz5XjEaQdIB+usMGLZ5lNNg+vuxLtHHjt3
         JC9Tst7YZgFgaq4Aj74b7Q9JItJ7Ht03hOy5GBlZOS73t99X9SYlhLdUqg4473ONWJiz
         FfYVnPWqiOec+KiRiWueFgUCz6xF5ce6Q/7EyoP1aB5ouQvwPhfUufUY71qy0F9w3a8E
         BZ1UKHsVE0JX+hpyUqTqMZtTkSEDE8vk9JiJo4r4DnAvv2k8dxFFEBIh+Qt4yiTBFwli
         oQTw==
X-Forwarded-Encrypted: i=1; AJvYcCVOJiTj2PcHX1tLvG5c7ZhlOD5QyYhmSclYQDt+FpI1TGFBAAiz1+wKS6a7PvPDBnpdLS+JciYKtcD2dA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzArkmwTkVZGSG/hngZrkP4yCHgCaYOJwH1BxXLNe9PJ20JzctR
	W5MRA2pVhfHI4ZVf/bUk5B2nsAd/lmFHIhjck4ime02Aqi9+8GflKMBGwVCl/g==
X-Gm-Gg: ASbGncssDXQ01H3zNy8GgzLJ/jydmadUe28s2wUpno7LwbgYQSj29dIDQeMytPA5o8G
	nNX4O6TPDOFVxZW4AqLSyJa7CYFVH2IN3aqBJA64sNOn6/iTy4b7pL5We/aS1GOd4ti6zqH6GnS
	O0LBm4E0NUIjZ83Vs/rtCQpFPIv0XGyhOrkGWqfxZ6a6zQh7L4dJ8N/YCcVG/CfvMiBg2eCXKwK
	Jm+kgezK5TqywEGwD+7nlnBH/WfiuVagva9KzpgQ+C+ZUtFBMrv
X-Google-Smtp-Source: AGHT+IGajRjL89O7bO+/DCWKBN63WTQf/pItm4UqG98nob5Dg5f1i9I49Fpsa3xPr+v+FFH1dIk2tA==
X-Received: by 2002:a05:6830:488f:b0:71d:4f4b:6250 with SMTP id 46e09a7af769-71d4f4b62b7mr6941021a34.24.1732618385569;
        Tue, 26 Nov 2024 02:53:05 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:7631:203f:1b91:cbb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1d21d3sm8402126a12.21.2024.11.26.02.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 02:53:05 -0800 (PST)
Date: Tue, 26 Nov 2024 19:52:58 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, axboe@kernel.dk,
	bala.seshasayee@linux.intel.com, chrisl@kernel.org,
	david@redhat.com, hannes@cmpxchg.org, kanchana.p.sridhar@intel.com,
	kasong@tencent.com, linux-block@vger.kernel.org, minchan@kernel.org,
	nphamcs@gmail.com, ryan.roberts@arm.com, surenb@google.com,
	terrelln@fb.com, usamaarif642@gmail.com, v-songbaohua@oppo.com,
	wajdi.k.feghali@intel.com, willy@infradead.org,
	ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com,
	zhengtangquan@oppo.com, zhouchengming@bytedance.com,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH RFC v3 0/4] mTHP-friendly compression in zsmalloc and
 zram based on multi-pages
Message-ID: <20241126105258.GE440697@google.com>
References: <20241121222521.83458-1-21cnbao@gmail.com>
 <20241126050917.GC440697@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126050917.GC440697@google.com>

On (24/11/26 14:09), Sergey Senozhatsky wrote:
> > swap-out time(ms)       68711              49908
> > swap-in time(ms)        30687              20685
> > compression ratio       20.49%             16.9%

I'm also sort of curious if you'd use zstd with pre-trained user
dictionary [1] (e.g. based on a dump of your swap-file under most
common workloads) would it give you desired compression ratio
improvements (on current zram, that does single page compression).

[1] https://github.com/facebook/zstd?tab=readme-ov-file#the-case-for-small-data-compression
