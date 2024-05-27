Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60B517E900
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823030; cv=none; b=gXhMEMHFLHiG7aiBta6WzpqCnKs98hPXdkQ8RynLRQ9q4Ze82k9xMN5lr+A0vORJ4Dl94esVdX9hoP78IGOdvrvj2kFm9d9zbTwF8WgJzwovmL8CjV8zpfgqK/KAWjKfcF89NWGNAE1GZ+naXnmQwo+xCSjo66fQ8/zE/GUKsUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823030; c=relaxed/simple;
	bh=5jiH4x1XWMSnP7qoMjrpmykCRTHBhIhKSZ3Gp9R829s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I1oyCdUP7d9V88NtPoIr3Qf500/eA+pT9EI9Qi0ftcmWQkFdPXJMfZuqXY/fWaS6WXPz+iz91IkcEAFz0SHpStt5hmmD36pkgV4Z1lfcJoZK7TZEf1SZTDgp0/90O6ApFx/XjMxl4JgSFlkuj8s/JfPlo0eSgUhkNcwnYCWUHRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Hcj7y/c+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Hcj7y/c+"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f3452ba14dso18615ad.3
        for <linux-block@vger.kernel.org>; Mon, 27 May 2024 08:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716823028; x=1717427828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmPSot7ggLnz+XQPHJ/svK2HUqmn9I3vNorDkw0wgw4=;
        b=Hcj7y/c+xOtIvCedClk3kJ1emLIrF+rL57mr6H5CdcSms140ABpQ87wYDLzdlAtPzb
         7uTFn46S0g3f7V3zOoiMHoiK9FcVVZn9RYFEkRoawywjZYCB8aqm/IMDxh/voDpzsR/t
         kEI/FrWGyVmo3LftV9SQ+oAb4v8hDSkP+UxDDacJo0wfLbta5YHfCzE5ag4ZHVk5Hokl
         Y1HMvf+LFtgDSWa5YAHEtXlyoIM3M2zlId5eUKpaRDWxoS29qPsuXKyhTv3RkB3V39vU
         dKh0mXdrzFMVqgaM+0S5FVAymEXQKsKHjLuzKBkk4qN1IVnpSCUIFrWvGFtM8DX9ugc0
         T9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716823028; x=1717427828;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmPSot7ggLnz+XQPHJ/svK2HUqmn9I3vNorDkw0wgw4=;
        b=lAI1d9tgJf1fuCi+fnHmdd0RnEEHpDhJQCQG1IN2qsa42AMJ7AxD8SAO6c4r7A8xV4
         91iqXSfFzsKggcjwJyoJj6jPltmUUP+Vd9c1pyiaFJDpx5GcRk7v+kfurPtnqwuqhgRs
         KUKtG62ZklWGgju3PdIjyRc3i9MfmvkWcNYHp6lWocJurrf6y5giJ+tnPDAoKzsrGFju
         FDQTxEOOEPE4DC7m2+Z+MRqWKgGfj8R4jO9+CJcSHAAsAtJoFKi5DjK0/YU2EedGhu7F
         XG+5yhRRFaEa0i63rIn2EBF16h32iKPTtOyIkNWwIhdmmki+efgBxguXhLycMJeOp57R
         Pg1A==
X-Forwarded-Encrypted: i=1; AJvYcCUXTUOP/0GkbPltAbR7xRdiyMN/J7VXpKJYEIG0hCbkhCIetAImh/sTNdxHQb5X2MZ8rxhm7DSjMFTcWdiFw84z+dfE0gamXJ6NovE=
X-Gm-Message-State: AOJu0YxsAl6B0Bp+LkEsu+NRUY66V9Ngjep2PH5w0msotj/xuKrr0lFl
	KTN88xnfMGkkNiCkCsFYzatxz+TxLZz9DdmiHJJlnmWqdCMESuLPUixrZdM11QOuxIO+J7qr6Pj
	P
X-Google-Smtp-Source: AGHT+IHE849WWUx6bhlmTYdHVKsY/r/dVwclg2T4wtnnhKmGhqVNqk5z4HVEcOzw4kd0DhXQltjrtQ==
X-Received: by 2002:a17:902:f686:b0:1f3:3d5a:e864 with SMTP id d9443c01a7336-1f4494f3db4mr114828955ad.3.1716823027556;
        Mon, 27 May 2024 08:17:07 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9a4fadsm62169365ad.224.2024.05.27.08.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 08:17:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, dm-devel@lists.linux.dev, 
 linux-block@vger.kernel.org
In-Reply-To: <20240527123634.1116952-1-hch@lst.de>
References: <20240527123634.1116952-1-hch@lst.de>
Subject: Re: convert newly added dm-zone code to the atomic queue commit
 API v3
Message-Id: <171682302619.252705.15503452020920646398.b4-ty@kernel.dk>
Date: Mon, 27 May 2024 09:17:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 27 May 2024 14:36:17 +0200, Christoph Hellwig wrote:
> the new dm-zone code added by Damien in 6.10-rc directly modifies the
> queue limits instead of using the commit-style API that dm has used
> forever and that the block layer adopted now, and thus can only run
> after all the other changes have been commited.  This is quite a land
> mine and can be easily fixed.
> 
> Mike said he's fine with merging this through the block tree as the
> dm-zone changes came in through that.
> 
> [...]

Applied, thanks!

[1/3] dm: move setting zoned_enabled to dm_table_set_restrictions
      commit: d9780064b163b91c28e4d44ec3115599db65b7fa
[2/3] dm: remove dm_check_zoned
      commit: 5e7a4bbcc33d7df6bcc8565a8938c196285e5423
[3/3] dm: make dm_set_zones_restrictions work on the queue limits
      commit: c8c1f7012b807ca4da0136eacab96961b56f25d5

Best regards,
-- 
Jens Axboe



