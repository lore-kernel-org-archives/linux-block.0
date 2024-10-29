Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF32193074
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215612; cv=none; b=b1vl4NEoQ0eg+w3RSTKoLumaT3nEFDJNAt3F/PnqwqVQZK6HMeLXoqcfB5i4p69z3p5nByV3hXmuTuGcTz6g4IbUnQ23GRClaRDdFjzrX5BzJn/yQV1/dlDw7TpQpSwBkmCG7XV/XBd624bYWlC2XkknYjNmz+pYxFKSY4Jrzz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215612; c=relaxed/simple;
	bh=mOI3USml5wMEgAskjQopGx7xsMbvlgUOmnwo/F/FJZ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GxQ4RYDpf1ku/vkfnZMY3QA1o1hQAp8At9/VC3fBN82/dIrS7DStUEw/mv4V4QFjIJTA0P1UX4et4K+yGV8rso1aadpiwhLByva63SPZ5+Y72wiUPm5hnlo9iVaVeLwTd4NB0KZl9sFRmrR5yApQ+0dXNhfalXUhQQY9M3sP51s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iHloh05y; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iHloh05y"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-83aff992087so215225139f.3
        for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 08:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730215610; x=1730820410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njWCUb6WKmM9AwCN6viJ83zXGf5vfYItmyLFZGTUg7w=;
        b=iHloh05yD54xZvSuqPBFp0uQ9IYo9VtTwy3/MkQPhV3XLo61xP/56uapcJM0KaRS0f
         1GNLAaxx1XQU0fYwJcCVMFLwdj80JnGXU28GWilIXv+BKsheIvWvqNfzJ46ZChN5d4dV
         TpBgUsU12WugQmJiI/Fm9xzv4CEop/6gLZhbL/bq+keFjfr9STS6OpjBrM8CifRnvxh7
         J6VERNqvo9AFNbhxlO3ab9dCaWZwQmyJGdqqLiKBvfmmwQ5EfKjpkd/U8R01c1jxgBb0
         ZY2++zkfYcz8+PsetmC8BKpQLnT/Q9vVFazZr9xfAS/PAjRIZyLxT23YRmfMkESX5dNz
         AIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730215610; x=1730820410;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njWCUb6WKmM9AwCN6viJ83zXGf5vfYItmyLFZGTUg7w=;
        b=SogellpvUgSpl2nA+f4og2uF1V2ydPDQ0eH5P4DIJGcKfT4nwfrvVlsIoTkFQm7jVI
         Knzqug/dZfF5+PbjdM9hu1uctwmB9RgrpGTtmvpphFxdAN+/FZfiag10DGvJ+BVEXFDB
         myyGL13XlqmHLjdRZVQ8oYQX6AH20IFHbuo7bPRHY9rk0BuXUGVOok17RtCa1ayXhNE7
         pNa5YBtuyQrcVLLF3cCxFS0b1xS61yYBoW8BjJVkb0CRx6LKFDPhzfOtm8+ER8WR3Ziv
         r/GzbM+j/ZYH02ZeWcUnWWwpmNrHn8YDYr/FP4Tyy/HWf5E1MGkPVQ9b43K9PMkwwMHo
         W6Cw==
X-Gm-Message-State: AOJu0YwA/aYr8ilnYq8LlULHfOUWv0+eXQfPUXTvfUAJzngjYbLgc6Ei
	sI3UZaMU2u1bUZz4cLFvnN7vDlr/PzNkm8AKsm2W9o3tq9vr1GyaUKmWho0R5ZdTspjYyoe0rOh
	q
X-Google-Smtp-Source: AGHT+IF8+ujeGVSKHswq6wV9ukEwoBnHZSjISf9gtVYSHp0qGKs7IBaQ8VPYbVHvxnbmDoahRz/AUw==
X-Received: by 2002:a05:6602:1355:b0:838:9b6:46a3 with SMTP id ca18e2360f4ac-83b1c5d674fmr1260840639f.15.1730215609714;
        Tue, 29 Oct 2024 08:26:49 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc727b17cbsm2461640173.171.2024.10.29.08.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 08:26:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20241029141937.249920-1-hch@lst.de>
References: <20241029141937.249920-1-hch@lst.de>
Subject: Re: [PATCH] block: add a bdev_limits helper
Message-Id: <173021560852.667860.12450152011739544297.b4-ty@kernel.dk>
Date: Tue, 29 Oct 2024 09:26:48 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 29 Oct 2024 15:19:37 +0100, Christoph Hellwig wrote:
> Add a helper to get the queue_limits from the bdev without having to
> poke into the request_queue.
> 
> 

Applied, thanks!

[1/1] block: add a bdev_limits helper
      (no commit info)

Best regards,
-- 
Jens Axboe



