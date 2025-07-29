Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3829D262FF5
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753792035; cv=none; b=gH94Xxv64JUWd4fdB6FepJRyyodyzIW9Pd5xjMyiEXV3zALSRAanpWv6LbvH09ox+RyMdLv4DPseZNb96rHV8beshyTHiTx0H8HEQ8HQKpRxXHhTVxVJGkWch2yXBZM5kTIp35UgLuTdDpBd5q4RC91d3ACDotfCINuf/GSesbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753792035; c=relaxed/simple;
	bh=z+AlFEiThIB3yzlOzlvIwJ8WODjQwhJr1nUP8j+2ZN8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XHJS45DrnRj78aRt5dMQhTzNzxPdVeywQpKK5ZhL1N7M/1FLOv+oTKSZ1p1gPvjdbU2coLdlmLmPOb7YDjNtLskCwPY5JxbKHsb/zAg3rvXIiOJnTxlf0lf6HKJYycdWVdflL9eoiGaTToRMCgp08U6nmYSGtOT2DVL4qq+a3zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AVejXhSd; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AVejXhSd"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e3e73e9177so9809685ab.3
        for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 05:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753792032; x=1754396832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRhxuQmdyUvmXy3hxnDOaur3wUT/fSUjggB7ZdRmyh8=;
        b=AVejXhSdJJoPXXplf0RwQxvDqqhmfrtYVz0tb/38IR32wBBwfrrcgPNb1HUfREhqfn
         JWfRd6u33GsJnKq+wL6/oMxGq3dy2Br6QXqE/T5PvTHcAAVxuje9tium9Mygn8A8pRyg
         u64Q5t5jAVjmTKxAHJzE4VmO7gV9pQqgFcqxMjjH80UYUn0woYgY+9Jo5nMXcLOkX5kE
         y6jj10R2fj9oq2TNEPTMtplShMRBxRe7krCH9WZ+uZ+D5KNvwBbLxO4WX3GOxcYoDQs9
         yonAVodxdeqBZSTXgUah5fRk+sPhIq0uO1XMPJ1AxlC1L8rr02cChxADM4vUsp68Aut2
         ykOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753792032; x=1754396832;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRhxuQmdyUvmXy3hxnDOaur3wUT/fSUjggB7ZdRmyh8=;
        b=ZX5g1zAiH2/VpPCb442CBZlU/tk9qTBPpAh0a+8TzdbywsVgfmWklDBiTNjwzzl5n2
         nLukjNFPnW0edsac5/wNpWcGrb5OEYnnHIG+zqj/XYQJB8oD/5a9yp8qu+u6CLomKto1
         j6xV6FY74aPYL3TWkuM4yX8fjrZq+QVbaQMXLzmVVJqR+qf5ionh8lKu+uSIYJBtvmWO
         3lCO4FEwxWhnsZD9cdkdzekmDsdGMyDjqxXNknwBTV90CraN4sd/X2xGWzWekrBs2Zc7
         GBhjocmjZj5rWWxLO8VKVsF6pgIOm8yBS+WuTKIfeZyYbWN+51hpeg9ozFqbXZ0oDJp6
         eHfw==
X-Gm-Message-State: AOJu0YyGFBVAfJOYzPro5w01UDjRSVC5/Yj0LwEM+/6jB6rWJENJ6Q4O
	IM+cjpZNwMPxV9fIIoNPSW0cwW5+9Oee/RbzlwYbFuWJZDK2hma6fIlWqnVAG86lGXY=
X-Gm-Gg: ASbGncsjqYwJAq52qGglpQzHwaMh5ypP2vDarGAu5aTV/5WKX9cbAqn9w3bgbXWdkEF
	/7XdpPt+ygYAFwRYTkiKbA6P5+QwCq2s/NKYbhDgQwuhTrTyhsg9LwiwfFokJzyPNpSIVJSo2Nu
	PhnQgI3nsW+yzAdyDhFjE3Ysej2yDHUh/LGkFdO7ZI69YNZcGVoBMG0fKcRGITxuPe0olj6J/Vm
	373HUmZB+00bWrXpWyzj7VZsIQC0dm7hbQztPnU5ImaSCjX5mUWQRdiFetNAHfWV4a2x7cum0KX
	/FxZ7uRiIhXJvfyFPV4O7J1xXLCjVLK8qZTIie08w5gOPglW31POa6jAw3kbXWt4HbIE8IcPsVF
	H9w6XX/YvMGBOKw==
X-Google-Smtp-Source: AGHT+IHxU/6W/4OkM14YAhuR+Ib1gzBY/3UCbYLfMBK/teGnjkyghGETjjmUgh5mL0YjAPo1uHs72A==
X-Received: by 2002:a05:6e02:3e90:b0:3e2:c69f:106d with SMTP id e9e14a558f8ab-3e3c529e1b9mr241142605ab.2.1753792031868;
        Tue, 29 Jul 2025 05:27:11 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-509002ae794sm258067173.45.2025.07.29.05.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 05:27:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20250616062856.1629897-1-dlemoal@kernel.org>
References: <20250616062856.1629897-1-dlemoal@kernel.org>
Subject: Re: [PATCH] block: Improve read ahead size for rotational devices
Message-Id: <175379203106.176672.14503199411239963437.b4-ty@kernel.dk>
Date: Tue, 29 Jul 2025 06:27:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 16 Jun 2025 15:28:56 +0900, Damien Le Moal wrote:
> For a device that does not advertize an optimal I/O size, the function
> blk_apply_bdi_limits() defaults to an initial setting of the ra_pages
> field of struct backing_dev_info to VM_READAHEAD_PAGES, that is, 128 KB.
> 
> This low I/O size value is far from being optimal for hard-disk devices:
> when reading files from multiple contexts using buffered I/Os, the seek
> overhead between the small read commands generated to read-ahead
> multiple files will significantly limit the performance that can be
> achieved.
> 
> [...]

Applied, thanks!

[1/1] block: Improve read ahead size for rotational devices
      (no commit info)

Best regards,
-- 
Jens Axboe



