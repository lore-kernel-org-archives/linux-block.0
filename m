Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DA92054FB
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 23:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741217113; cv=none; b=URftfHF+/xORPhlwJEw/7hifSQLpxXT6hXVj95OlzA06N/04HGc9nJjVxGHjuRVcS/na/uNadWez4C5c6aWMKN66bpq2v0EefWnGvHah1jmXaw6NuLu44v9OnSlnleYOQAVXhqHovlToqN49HE+y5fZzn7aLPSDystWqvpdhj4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741217113; c=relaxed/simple;
	bh=ydTk/iuTKsVlDZZMdxpL5fo9gKeB2DDLMWgRTVqvrpU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q5oFOZj67Jm0M2Nqj3M2cSa/n/JGhz45pAseNXUq0GUfZjEW/wkMVDKJLwHxZU+fp/F2XXpwMjnVu5/5BRFmJBhrcAiVEZPsNnxV086g6QdPxTntnITNyQl/wq9+yd51KnRz1rCfgv0xsYzwR1qoIpfXMztuOoQVQCfx8Ib6WOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rLJrT6wJ; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rLJrT6wJ"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85ae131983eso6478039f.0
        for <linux-block@vger.kernel.org>; Wed, 05 Mar 2025 15:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741217110; x=1741821910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0RhbP0JdWKLySfTbL+kC7pjlCWicLno65Zg0j3u3BA=;
        b=rLJrT6wJk8mcInX2qo/VaoDnuNEeYnbyam+fAzPlnkMtcaHnPNiEpRs5JoMqbhKHhb
         rasBiJaQI++l8MsEeEp8X6tiMVxeZyQxV46j1U3opD2wSSo26rq135CF4mYagu1q4y2Z
         ACQb4H2xOOlOv7qX1EYtHiftSe4uVgm5S1lsUQUQz9XvidE3ABK+YZ1luNp90Kt6rRQJ
         8YU5+mWJMkrAP1fIUx5QmWmP0x028Y7JZ47gnNhkCnglggi4qdx5ztaon2OHeZce9p3V
         BLjbPOlOYiwuZT9dGAcf4AQ7U0p8YfaycQTxs6Ff4XYCsrv9HAdeJ+CLsbpE+QtoPYoN
         xygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741217110; x=1741821910;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0RhbP0JdWKLySfTbL+kC7pjlCWicLno65Zg0j3u3BA=;
        b=EphYDdovsxc78ddZA52iHsfnHBKGAexVp9zwbBVHh8Fc/Yrkpp/ANw/pc2/m3s9MkO
         n8SUg4vgRv/yOG0G76TypQZFG3RjZUAkPLaQ1wGZgTr4GVRqBEZ0wUBvoiWcbpF302ul
         ZXxGpyJKPWSNlkHJgw6pGcT9fXTpvnXXaSDUrKrgvxcXjIblX6FgwtQ9CzxFrYshwRVS
         HlZb8zHEjkugLS9cZJHQJ3gyUPdsDul1Nv2sY9jD+DiHnh5QjaWQXNNGAStTWQiXsqAe
         MKTY0+sA0xkFQbo94EWpbgC3s3mT1bKgb7KsSREqgLJjnZ1iuN5Bo7gz7Jg2tiOBLzdD
         1btw==
X-Gm-Message-State: AOJu0YzzonCj5r3vHGmF7Uz1iwLIhUlD/dvl4F4SnbjBBs/TktojlcUI
	GRrkvszb3IecnU75CgqlaVLcP26iV7rXPyF4pCTwNMu8+V6t64pjGa1dloOU93c=
X-Gm-Gg: ASbGncuA3iP7BJFNCjdjKzGqdvhGBR+InIuVp69xXmIKuT9UxJfTeh8liPPO6BzF35p
	LzFH+gHVizSiUTRkGadbMLOmYSA0IRVY6tSRTipdi7T+vqT//21jCteaPzZEaNEDLsPW1qX3EM5
	mClPvHAhO8xw/PozzF+Y3rsjgLbdFZTvoEq+8MkC2sG1ae29ED+2XASZZ+nRPe0w4kBMGq5h/EX
	tfhFAgCUtFoJ0Bg6bao+PQNZ5rmF4GDrD7i8TC5DxyCARXcyn671s3UBnmYyOTTiMMA+O+ZoJHB
	pOOVSDM3i1i6oV6/oR+Txj+o7AX0fusFSWX8
X-Google-Smtp-Source: AGHT+IH3KqAbGDF1xwNKnUg78tOxCRXKwYUEhnJ7WUjiCyUqzy+1A7ZGZSeoPkNgg09EhM62HVsbDg==
X-Received: by 2002:a05:6602:7208:b0:855:a4a4:a938 with SMTP id ca18e2360f4ac-85aff8bded8mr643813439f.2.1741217110443;
        Wed, 05 Mar 2025 15:25:10 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209df3ea9sm17360173.27.2025.03.05.15.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 15:25:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Yu Kuai <yukuai3@huawei.com>
In-Reply-To: <20250305043123.3938491-1-ming.lei@redhat.com>
References: <20250305043123.3938491-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/3] blk-throttle: remove last_bytes/ios and carryover
 byte/ios
Message-Id: <174121710911.165456.3433159135540117935.b4-ty@kernel.dk>
Date: Wed, 05 Mar 2025 16:25:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 05 Mar 2025 12:31:18 +0800, Ming Lei wrote:
> Remove last_bytes_disp and last_ios_disp which isn't used any more.
> 
> Remove carryover bytes/ios because we can carry the compensation bytes/ios
> against dispatch bytes/ios directly.
> 
> Depends on "[PATCH v2] blk-throttle: fix lower bps rate by throtl_trim_slice()"[1]
> 
> [...]

Applied, thanks!

[1/3] blk-throttle: remove last_bytes_disp and last_ios_disp
      commit: 483a393e7e6189aac7d47b5295029159ab7a1cf1
[2/3] blk-throttle: don't take carryover for prioritized processing of metadata
      commit: a9fc8868b350cbf4ff730a4ea9651319cc669516
[3/3] blk-throttle: carry over directly
      commit: 6cc477c36875ea5329b8bfbdf4d91f83dc653c91

Best regards,
-- 
Jens Axboe



