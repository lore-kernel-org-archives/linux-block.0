Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2F31DE4EE
	for <linux-block@vger.kernel.org>; Mon,  7 Oct 2024 20:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332812; cv=none; b=Gweq6k7Zo58azAy39G2on3CPahfGN07FGr6VJ4yg1sT0xtSHQvIMgeMP2ZiJbhPKayr2YUlm+D4/E6Menf/nOjXVHB2WvtrSyYlqP4TtjeyWNhJlZejauBUAwSlIljQ66OSVMrUHXBrL7qW4rbwsN8rYaCZHK36k5yM0JcXipmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332812; c=relaxed/simple;
	bh=AJeO2SxKiTYCu8CzursHzIXa6Lqd4sAJg/mrdLQthok=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=peWDzj40jEa8OpdHd0FAGVungBQqKg0p8b9Jrrh2pkYovew/bU/n+ClXqQ6mODsR73pyhTZpLylzl9Pgsild3eKayPkvcedhSGtjmAP9OEvSxOkXwiCbbRcJ7OhL6u9wEl8JYTzxNE24zRVuNeL/h8YjquzyFmECzP8+Y+KLdc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FL3saFVW; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FL3saFVW"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82ce603d8b5so226746439f.0
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2024 13:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728332810; x=1728937610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZCcd++xWrRB6jM2L3IPUNyZv6F54BVIafTy9ndBz9c=;
        b=FL3saFVWy8cx4atz54oCWMLSNRbmSbXQe5WGlGIXQBgERjzzKZiYQbXsD/hx4OgXJ2
         znN7rDXg8FGunmh2MZ3AHaAsALNAsG7X9sQ0JfoLeGBbuFQipiydWp9HR7YJHggueNIL
         c33LVbXfVkUnkAKL8nOirEudRyH4DxpisAbeXGjy7+8cir1EGCGSauZRcxUZJ6Ivpd1l
         ZoMFNfCuSIE4sQYaV6/BPH+nJYU3g+RJ1DVgM2WfGp/dsSjcsy9c+ApcHvHg6DcUo8/U
         uBuhz8uw30OVom+fAevMpKSHw/R4jomimSYP6qyjSBrPEkNjvVU5lmHCI8Tp3T4L9C9J
         p1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728332810; x=1728937610;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZCcd++xWrRB6jM2L3IPUNyZv6F54BVIafTy9ndBz9c=;
        b=nZKlh7TR4LcoH5u1vh7Wl+6cyU/3mZnoxKxmpGrsnWfp9gtbCoxClHW/Qtzy9h5nTj
         MKXVAfJlblHUvyebSfCH8mRCuWwU/MsIVjNyWRBDOxKh8rUDcLrKBPqWhRBARENfZpTh
         F0yqvF6N9bwFz4Fc13/nflmN2DPWkD1d/OmMMYp9c5ZVqvhpAlNHh4p2KXHj4A72QA3p
         uDoT78TZ9KxCI+FYINlpjJJaACTzwQi9k+pjInm2kFEaL+3mnDNK6TCTqcz6m5MI1eDN
         zwME37jfysXbYJYJFYEr8WbJGf9tcJVVNR/Vh4CAWQwMCHxIQXTdRsBBoe696j7sbrCU
         oZmA==
X-Gm-Message-State: AOJu0YysQt7nWJxTOBiLOI90EsZZr+s1sEqGKOfdQ4V1kk7DPxQLPNtO
	5GhdfSa8+5WouU4BssyTBpQt/87ZzWbY2jSP1B/zZCBdEHSQWYFOT2pFpBUhkoE=
X-Google-Smtp-Source: AGHT+IHO8CtWvUja+aEarGWEBzeYs+O+arUT37QOPQ1nPet2F3553K4uNnuRObsSI23cKsQpfRbIxA==
X-Received: by 2002:a05:6602:6c09:b0:82c:ddfc:c57b with SMTP id ca18e2360f4ac-834f7c7f2b7mr1509082239f.5.1728332809908;
        Mon, 07 Oct 2024 13:26:49 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83503b306c7sm142886339f.46.2024.10.07.13.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:26:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: SurajSonawane2415 <surajsonawane0215@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 hch@infradead.org
In-Reply-To: <20241007111416.13814-1-surajsonawane0215@gmail.com>
References: <20241004123922.35834-1-surajsonawane0215@gmail.com>
 <20241007111416.13814-1-surajsonawane0215@gmail.com>
Subject: Re: [PATCH V2] block: Fix elevator_get_default() to check for null
 q->tag_set
Message-Id: <172833280891.162752.17563005273256584675.b4-ty@kernel.dk>
Date: Mon, 07 Oct 2024 14:26:48 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 07 Oct 2024 16:44:16 +0530, SurajSonawane2415 wrote:
> Fix error "block/elevator.c:569 elevator_get_default() error:
> we previously assumed 'q->tag_set' could be null (see line 565)".
> Since 'q->tag_set' cannot be NULL for blk-mq queues,
> remove the unnecessary check in both `elevator_get_default`
> and `elv_support_iosched`. This simplifies the logic and
> ensures correct assumptions about 'q->tag_set' in blk-mq queues.
> 
> [...]

Applied, thanks!

[1/1] block: Fix elevator_get_default() to check for null q->tag_set
      commit: b402328a24ee7193a8ab84277c0c90ae16768126

Best regards,
-- 
Jens Axboe



