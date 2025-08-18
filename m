Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B372264A7
	for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537528; cv=none; b=n5mHEOOzffg8E+vFxvyBZrOqo29+VkJ2RwfCNMXOxK6QFNG7LS9MjBeKL/GnR8GwNm/hnPKXU/DhzCCJW+pAG6nOm2Gvv1bEaG/P8oSeZM+rwFBZ9wiL3AWMWqqSDjLy+LbA8rzAcp6PEW/bSn2HMoc1VNCJ1g/2Ok8Dgjeqs7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537528; c=relaxed/simple;
	bh=w7Fzpn7SJ/Hb2R6gM6eyJk4m3715eX39NvQOLiXzCRY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nLze9/OsMUuAYYbcU5roJDr7KI253KutglNveWlttO0GBRhjlPqH9PyHehyyqM9x3HvCGWvYkIqconGCNk/STsbtX5x62WVHs5YkeX5OtDKACcp7VUKXw5U8gpuKeqzU2tg1T7MMYSi/c8a/1PDYP3qrXXYviMeEGogNXiVbngo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2FW8V74K; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2FW8V74K"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e66da97a68so4793295ab.3
        for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755537526; x=1756142326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fu8r2yKO66DThw+kJlK6y2+lhb7FMN/P2S3CMzC2Wlc=;
        b=2FW8V74K6T19uSMupc+yOPTlguayrjYxGBrKELPIXWX5cZnGMUI8rXdmwkL69cLyAC
         rXwty+Uj1l9PPCjQZjzCKcsexznrtHF2NduGTzbvGb/FspWG7ysNQOkuJDNAVKEYQnlD
         WkcUTcoqkCmxKwLdf268rUv+eqowxK3eser/6ohelC6CNnEWTi1HITN4Tv9K+Pyobgls
         ZJQ40fXjEIiSPq+A2orMe/SvfWBo5josvwkb85sn87naSfaiwq5F58fD9a2n6vH+WTuL
         4dxLnn69OjOBXLYa+rWkY7fFnw66lBu/Ldm2qlS2+PFca+FKad5CMik8R7/H90QWJkp8
         EqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755537526; x=1756142326;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fu8r2yKO66DThw+kJlK6y2+lhb7FMN/P2S3CMzC2Wlc=;
        b=r7vlxMgHPuLFSkpqs0U2RIF2os6qPfZa57pXGpew++y7yP0REDU7dS05d8u3StOLS0
         5Gxz/Do+9M4oNlDrowRQlI9YTCO0mJYm6Gy7W590J0z6pj0j2Ks0/i5rrH06duG9ozmh
         uAS6V7sLfAKImzVw0e0RcBRJAvViiWVCW7sowdYRhnhM9GUw97apq2VLy3S5wlygd6fn
         lYAkafJYazhxz9VaM+36LQtG8ZEa6a8MvdtP0kL/+SXjVUFvJGyCFR/nvtPQOM+AoESe
         Q3tl/3nis5EoQOBCHJQSfnX/ZzsvFczAu4dacZtP7dc+ev5mQ9S7C+YO5+N6p+r54sUu
         EZDg==
X-Forwarded-Encrypted: i=1; AJvYcCXsWWqmf79nn5vpd64+8UBURiyirk6AuKOuj3fTSqOWoc2VVDv4t+uV7UQRLO3ldeMV0T9rKFHspUTwHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw7xvQPAHycPAhDehep5SjiIQLSHXw8/yFRouYdxFy/v0z3RV6
	lrO7ehAJZonRtwpb++ZUD9pQ11OjkVGYilrM1fam5oqJFp4COTHhVValrAqLsCp87ic=
X-Gm-Gg: ASbGncsXDBAPibl1DKrJVimJ7q3qpo8A1etYvjN7QyWagRAEJ1Y2z2VzmcgLy3Y2e45
	avkYLnDh+zrdIhCVBD3DpXeJUWWM+4ynX/B6e4ZBr0DNOoBvVdXkU/SMsZTflRlhS/pNIDcNQLa
	yyl4QwjY5k/1FYZfMdO9vTpR+QoT2OZnDPGBufExiI4qCothcjvW/UvLr6zaBT7CVjYFU94FM/z
	x3gIyQw5MY2l2091be9UOEAW/Z51gotWiuwDFRHgCwWrc3W01KkL0GJsGIlfUVIVOPIkFDU9OQL
	v4tglXTMlWK+2oMBB53g2tJ74TNeTmE1uuMhzw9S8xNfGPIWffYQGVte3w7rMpZSPZIdoJcV6ZT
	R/vVHmvQwxwY7eg==
X-Google-Smtp-Source: AGHT+IGofyjOjXefOUTkdbQvdNHi/3ejsDvhudF69ftu0/UflWY1YbJ16NMpskRsqN16HQ53bFvpEA==
X-Received: by 2002:a05:6e02:1a87:b0:3e5:2646:df03 with SMTP id e9e14a558f8ab-3e58390e18bmr179454925ab.12.1755537525819;
        Mon, 18 Aug 2025 10:18:45 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e58c321sm37866815ab.1.2025.08.18.10.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 10:18:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org
In-Reply-To: <20250818045456.1482889-1-hch@lst.de>
References: <20250818045456.1482889-1-hch@lst.de>
Subject: Re: fix stacking of PI-capable devices
Message-Id: <175553752471.87011.16999242916763470821.b4-ty@kernel.dk>
Date: Mon, 18 Aug 2025 11:18:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 18 Aug 2025 06:54:49 +0200, Christoph Hellwig wrote:
> this series fixes stacking devices such as DM on top of PI-capable
> devices by adding support for the new pi_tuple_size field to the
> stacking helper.  It also makes the error message when this goes wrong
> more readable.
> 
> Diffstat:
>  blk-settings.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] block: handle pi_tuple_size in queue_limits_stack_integrity
      commit: 61ca3b891b4b9667334c1356a73f28954c92d43a
[2/2] block: remove newlines from the warnings in blk_validate_integrity_limits
      commit: f4ae1744033d54b63c31a3664a4fdf5cebec7f27

Best regards,
-- 
Jens Axboe



