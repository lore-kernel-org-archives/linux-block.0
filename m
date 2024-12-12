Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B10913F43A
	for <linux-block@vger.kernel.org>; Thu, 12 Dec 2024 03:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733975913; cv=none; b=L1q2ASMnr7zRRIwvmjIpE2vLV03OAaYBFr+AuTwhKb+U6vSoSlMfMPn1+ZjjSna1ItH/ltd1/klu6qznLVJhMyNk/jMxyFd1sqdRVLmp3SnRXnGgh0HBa2ArvMdKtEUplBjJGSyn9UBDdZgtNTIjrmkbEOzUiEAl5kvnRNzvjwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733975913; c=relaxed/simple;
	bh=F36O0Dgg1mhlcRno/fBPjRyjEsASJc7EpOfe35xMwec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ygw+NXnx9nNvyl7IoJsexdM4aXEPE3Ws6sFMh2ki2MFywBlqmOqLv4HLQe15hx+e9AAW801quK2LZoaop/aOcNInO8RFhy1xawXWBeOsKuL0UlpEhgXcqVQzWkZIp1nDvmbS1TUHShgnMiYJp29KVRPIgwF3t5cb0d05k3JZ0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GIHOvg4U; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GIHOvg4U"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7feffe7cdb7so144452a12.1
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2024 19:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733975911; x=1734580711; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgpWYN8QlsUV56/RVatR17L4XIXA6XIYGaqKFNGgJR8=;
        b=GIHOvg4UbiVaM9uJK6lQZFuZiHZSvykDeyOlu3rgwhXtP6D+dr37wy+QXu/W5zv+vB
         o4+ODtk4V/0FJZFwHC2d9UtjHmDpDyoXn4mCwJkMYXw9dw0A4MDCzhFdnEtE7qhoeCcd
         FkrAjSio9mns5VLH1IHWv8giyxJN5OIfO3NXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733975911; x=1734580711;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgpWYN8QlsUV56/RVatR17L4XIXA6XIYGaqKFNGgJR8=;
        b=ltpT3mh6UCD2yWygtCwmjLeneauwXH3kFU37nCqONAty37Bik5gM+3+1F3Joi5s7OQ
         PGKLNkRGPaI6eiMmpuyNpjpWMpZ/nCB2CgLO8uMcuF1A6FDLXuyB/8sy+lycti0eHkbE
         FX20fk4BzyHL8l50TIj7pZvjlHreR5VwEknF026mNWCuifx5lR9ndCTOzC0rImPCY6po
         s2vjKrLY3GeeS17w63i7CquRR9Gnu1PlK/VCqlx1O3qTmwBMzhRW2IPLrA+b7whUu4r2
         581V5xURhr6S/XNFymv7na99JKuG+UJQUZuN8hYugewjfSWeDhS4GxrVmGzzM0MXMuC/
         M6mA==
X-Forwarded-Encrypted: i=1; AJvYcCUuee/x9YlNPjgYbMnrtbiF7WnTeWXCpKnpeZrHjgFZkj24niUb/BvcYbtnNB+jGkpsQh+wB1ugwWHMwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQSuKlBSui7+V7bfncDfk6b0914P1GHHmIQokLacBqqWMHGOX0
	jSR1QAlsSy13jp3FczX+9lPKrniL1pYBNhzmJ00LywWYK+YC7q5RfVNlfyVIPA==
X-Gm-Gg: ASbGncuav/SftKVwWszXGxFVNKnTY8jfrWEkiyNIqY1f8ce0h8Gnfa9rOtQ1N7m0Z5B
	MYzBv3kOlgU92hlUz1m+b25X8Edo4b7quwX17anBYa5ccX6xK7txBozBV6ajIg4rQ2z2VpZtiCP
	SeHqjZrnWPjaMEhsnIaHe8vZUoP97h+/0hVDHM5MC+H6RLEydKRnBaKS7qQArc+lKQ+5f4pf0Jp
	uonhzNf73Y2X6VWG5i3lC4uPC9CKLbUO8Hz+YpcK9VbyWK9hJGfPrF0556P
X-Google-Smtp-Source: AGHT+IHKkfFoUJmuviCWJxeHOxw/i7OyuK3tNEwkKuGLCgFdomsJz63utqGvLX0dQV2QgpKkzX7kug==
X-Received: by 2002:a17:90b:3ec6:b0:2ee:8031:cdbc with SMTP id 98e67ed59e1d1-2f13930b92amr3181455a91.23.1733975911667;
        Wed, 11 Dec 2024 19:58:31 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:d087:4c7f:6de6:41eb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90d3asm218413a91.7.2024.12.11.19.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 19:58:31 -0800 (PST)
Date: Thu, 12 Dec 2024 12:58:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	caiqingfu <baicaiaichibaicai@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [bugzilla:219548] the kernel crashes when storing an EXT4 file
 system in a ZRAM device
Message-ID: <20241212035826.GH2091455@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We've got two reports [1] [2] (could be the same person) which
suggest that ext4 may change page content while the page is under
write().  The particular problem here the case when ext4 is on
the zram device.  zram compresses every page written to it, so if
the page content can be modified concurrently with zram's compression
then we can't really use zram with ext4.

Can you take a look please?

[1] https://bugzilla.kernel.org/show_bug.cgi?id=219548
[2] https://lore.kernel.org/linux-kernel/20241129115735.136033-1-baicaiaichibaicai@gmail.com
