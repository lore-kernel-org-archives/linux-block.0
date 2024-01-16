Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323021CD2E
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705424301; cv=none; b=VWgXEG+fZHEtQHbJY95+mn5PEQg1ODeIybqD5o0iEAeaceOWNG1IfyavH4ljWchzC4gFI94orjbSTw8e8PNMMnIo8Tp1zamusB35wDjXatCuqrMHXCCqhZV0BKce7VUnujUGkbSPjDgKr+fS3SZT530uaPSgVfdj6FhFniPw6B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705424301; c=relaxed/simple;
	bh=gRLa62f2pSShzc7ZxqXJIfdpLq2AvaGwVU2grF7v5RA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=UaLR6lQP4NEEKAg37Mm+bsFhSaIGK15XVoj2uOvV6Mhvf/KYnWbcMFe8+QWi6cVaXqL2GQyOriRGhFWYAl8gJH43ANbSaGaOVc0RIrhoP+y90N3q8Vo0hBcl3EccVRrb3XrzCqIh6Vut7ruwhXUMRwDblOEkXVNyFN0blsxSF1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oaLjtjQn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oaLjtjQn"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36095e0601bso4076505ab.0
        for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 08:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705424298; x=1706029098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pDf//gEwOmtmjZU7qzFLBNM4Nf4e87Z0wxn8Y0f3tsg=;
        b=oaLjtjQn7pn07bmn0FWGO86sy6UxURCsNv/VqFCd3WyMt6xPcJAOpRgn/+DFV+z0ea
         uSgLGo1+ss9DCHSXaop/6i1xPrX6otYAynqnSKwSw3hpCitKhdQ8sk7AzZLy9QUa3XDd
         Uj/RTfWOwUe1N5gh212ebDEEvEfuEdRg1TMN/BFS99nUNCtJrtK8bCzPDew18Hzivdkf
         +wAiyOGD0fBEJYVpUxJezwJFAGpgTq3fT4KrlupskZE9L1teFOYwXKoG3i193ETvBPam
         B4EVkhDxlMBavy1K2NTHK3gR7TeUzMP6nTWURYCdsuw4B0YizvR7FHFpst9QHn4sMsKK
         Grow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705424298; x=1706029098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pDf//gEwOmtmjZU7qzFLBNM4Nf4e87Z0wxn8Y0f3tsg=;
        b=uq/ax+SS2snU0Bqv1vHxi6nwMhn85Fy4H0RmxbPVW4caozqD0zKW3OuMBkEkVWtKoz
         dbeOBq6NVlJpYvOscA53MeqB7UdQ0uipqgGM8foh8kOiJM8B1z6QqNZQmHHPwmgU64IH
         2wZ0/rtOux59za893mhaYQMoCZNYm+OO8xX7H7SFNz/yZGDjgDoI/SsAiUOscRijXXF8
         zDeaGudJ0TjKB5tu4EKxzQfkLS6p7WcPi7qCGc+G9OyW//o6+5DHEyQ4StLqg77mfJFl
         I/NWbhIZrc6vPX6Js3Rty6wzc2O0vz3m5HfPbdfoZsagifA7Hm+e1xYYOMR/JJ4uImym
         NmpA==
X-Gm-Message-State: AOJu0Yx/YySDARFbkwBXkGonK/OmA/OC9tFQJ3XxUQPC8UeXItcEHCRR
	d56yfmKfY1EenXCy+TYEs8F9JcCZFj5568VHb60mrw3zM5Fg1Q==
X-Google-Smtp-Source: AGHT+IFii8BqVERC8fEaRd93IKBe0jWGjFrCPLnuRwMMafBtx20d+h5I6jK6jvG+yNJ5zKTVLaNtyQ==
X-Received: by 2002:a05:6e02:1c2f:b0:360:702a:3f89 with SMTP id m15-20020a056e021c2f00b00360702a3f89mr13786223ilh.0.1705424297889;
        Tue, 16 Jan 2024 08:58:17 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c14-20020a02a60e000000b0046ea43e4d0csm71744jam.168.2024.01.16.08.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:58:17 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: kbusch@kernel.org,
	joshi.k@samsung.com
Subject: [PATCHSET RFC v2 0/5] Cache issue side time querying
Date: Tue, 16 Jan 2024 09:54:21 -0700
Message-ID: <20240116165814.236767-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

When I run my peak testing to see if we've regressed, my test script
always does:

	echo 0 > /sys/block/$DEV/queue/iostats
	echo 2 > /sys/block/$DEV/queue/nomerges

for each device being used. It's unfortunate that we need to disable
iostats, but without doing that, I lose about 12% performance. The main
reason for that is the time querying we need to do, when iostats are
enabled. As it turns out, lots of other block code is quite trigger
happy with querying time as well. We do have some nice batching in place
which helps ammortize that, but it's not perfect.

This trivial patchset simply caches the current time in struct blk_plug,
on the premise that any issue side time querying can get adequate
granularity through that. Nobody really needs nsec granularity on the
timestamp.

Results in patch 2, but tldr is a more than 9% improvement (108M -> 118M
IOPS) for my test case, which doesn't even enable most of the costly
block layer items that you'd typically find in a distro and which would
further increase the number of issue side time calls. This brings iostats
enabled _almost_ to the level of turning it off.

v2:
	- Fix typo in cover letter, the prep script obviously turns
	  _off_ iostats normally
	- Cover rest of block/* cases that use ktime_get_ns()
	- Fix build error in block/blk-wbt.c
	- Don't use the LSB to detect if the timestamp is valid or not,
	  just accept we'll do double ktime_get_ns() if we happen to
	  get 0 as a valid time.
	- Invalidate timestamp on any schedule out condition
	- Add two patches reclaiming the added space in blk_plug
	- Update to current perf results

-- 
Jens Axboe


