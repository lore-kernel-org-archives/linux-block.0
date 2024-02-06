Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A1F4C69
	for <linux-block@vger.kernel.org>; Tue,  6 Feb 2024 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237866; cv=none; b=HODP3WXc3Gf1jMKjwDuluzEpXI5q4sLuxIl+v3XYmpIBYDSMDdztZUti7RjGfrvAOxgoFdhMakkKqioJiudLwd5Jq2oCe6bo0xxhxjgqacrBeWjStoaRCkysKrveptNxPcS6OlO6iHfjzXPXm/FflLNTOrG31TisIE9LXSKV3ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237866; c=relaxed/simple;
	bh=Ci5gwbrSM7cmnUZjQU3RB0yI/1+Eq7LqAgTZ83suCgc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CRh641DAFZO0jsRQSWBi5bZidpGDJRnMSbLRG6yfD0BRNlcZ4g1kl15UHe/W+vAJOEI/kt3Km1EyCGzPUdtsw5xJNQ86LXSu0h0gPtnfzkw7ch7tnsnGcDKIkaKPdedi8lS2xy5mp/e3nX8+ZcGe0ZFOHpNa1Fq4MzlbyP3HrWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KRQFwn5k; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KRQFwn5k"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso98929939f.1
        for <linux-block@vger.kernel.org>; Tue, 06 Feb 2024 08:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707237863; x=1707842663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQcEl2yXnIh9XZWtfFgTdh1YAJ2nWzHZ9qOn3KNYSqE=;
        b=KRQFwn5k22dhb3NV0WTSWzkkrlUMs1IJPp9U/18DFuLTAZfK9VfDYX6XEtYhD2jD1v
         2nuVBUjghNwSIHv8rbbA7JjQPNYE8dJNtNrqIWqNV3XjY44KxKKoPLpVW++AYoANwBVn
         IBmMDMFpPvyVQYSEQbmIdgFaNjs5TuuybzqWO59JHOWObWr6i8PAPuYBgqCFtTG2tOdn
         QS5JAWa77rlrgBcn3GJuZwcsazo1IXF/YwgcbDXm7YcKl+2+46ONDsZcv1cf7VP30i4j
         r+6xz/9rHUUYehcjQh4T7MCk+vMHS/t1QRzSY0MbNm7h4ylYt3hckL69HjEMIiE3B69P
         0qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237863; x=1707842663;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQcEl2yXnIh9XZWtfFgTdh1YAJ2nWzHZ9qOn3KNYSqE=;
        b=oNba7AL20WFZqEuBqJ63gvdDjV7gCKReCCVrPZptkIUhiSyP0U5zhijbgAbfj1AAqX
         362dMzibsqEHP7lH5UXnzKUe1oXvw0C5pdfqiVaKOXqREhFI928kx0jnpluMAK+6agQw
         qaOdL6lpssOWgmmdUiNjeypNxDk/+gdzO3vm/Vj10yfOH46ReHprkN41QjQkUfi8HLio
         Wo0MltVFNjxmAqjyd+EFp4FhOCqz2bAFmtDbKlJQt+72hFuGhHwIRrRcDTjfY+MA4OYd
         U0yFxOogx8t/44ML9L7x52jB7gEXyl/EYnW4yv5e9nwOg7S83YIFHqaKLMBbAyfQwy61
         LHRg==
X-Gm-Message-State: AOJu0YwZ3ZQ4vIaP8Kiwve8LxfrVOyPgKgPVDpXb+eAfZvfbYRd5n/7F
	OazMkmcByObTAeMMlADQ5b0YS+gZyjY9WhmgPldeSbh0qkjxbAL5eW0zDrHf1pM=
X-Google-Smtp-Source: AGHT+IHZcEs7aDBPkKePRyf15PFF2B8+VP6+6XCTuENUCVBVzCXkDyrXenAcuFqRY39ol7B/hYJTww==
X-Received: by 2002:a92:c248:0:b0:363:b624:6304 with SMTP id k8-20020a92c248000000b00363b6246304mr3743736ilo.0.1707237863190;
        Tue, 06 Feb 2024 08:44:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXbAW8t4ckd3AZqia0sjMAtxuucZtqgd9p1TKGWqFHopEeROfOeib5LPZvgU5noh22po3h7Z3oSEhEDoSDr8ba7eM0U0+C8KnplV2tM64wikCdkKojirvUn4us=
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bq9-20020a056e02238900b00363a91effdbsm164701ilb.76.2024.02.06.08.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:44:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
In-Reply-To: <20240123175826.21452-1-jack@suse.cz>
References: <20240123175826.21452-1-jack@suse.cz>
Subject: Re: [PATCH] blk-wbt: Fix detection of dirty-throttled tasks
Message-Id: <170723786248.650796.10431002551375769170.b4-ty@kernel.dk>
Date: Tue, 06 Feb 2024 09:44:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 23 Jan 2024 18:58:26 +0100, Jan Kara wrote:
> The detection of dirty-throttled tasks in blk-wbt has been subtly broken
> since its beginning in 2016. Namely if we are doing cgroup writeback and
> the throttled task is not in the root cgroup, balance_dirty_pages() will
> set dirty_sleep for the non-root bdi_writeback structure. However
> blk-wbt checks dirty_sleep only in the root cgroup bdi_writeback
> structure. Thus detection of recently throttled tasks is not working in
> this case (we noticed this when we switched to cgroup v2 and suddently
> writeback was slow).
> 
> [...]

Applied, thanks!

[1/1] blk-wbt: Fix detection of dirty-throttled tasks
      commit: f814bdda774c183b0cc15ec8f3b6e7c6f4527ba5

Best regards,
-- 
Jens Axboe



