Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8134030EF84
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608168; cv=none; b=KMny8qCESrAGAL+keLq8b6y+DCbhtSsB+FxnZIeCtFlRCbhQQg0GfbISm0H/HZ2sKOu5AzsT5LB4RRTNrrUWskwE2GPo4w/3ghSKndXV+YwpHhkctXzLY1dUsGM5y2nt9bIKhGv7GkYlpyLytTxR9q//6lQd0N9B/RoKDP2yMfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608168; c=relaxed/simple;
	bh=hD3OyQ5pf25nKvDX44eZPgzgzaCMLNBDyqZl+ZVGAdQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hI8TJqUZsUINinJwPtkkgAKfXPIbTQwkdOvGDQ+d+0nenAIm5His+V9ttpZPPtwVEpcOsgvByadEoYhIV8rxWV3YaamJ9xnGXLj3us0bfTHSPcM2cr08Fs+aurffwt9iOJ6cqQl/FH2ffZxIHIGP1x+9Ndk0hUBLD65qH+ED8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pQNuksgV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pQNuksgV"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77d94c6562fso5209109b3a.2
        for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 23:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758608165; x=1759212965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqB+MBmWbGWhXPKkNDOEdyh6sNxW8IJTQY+jeJPWHj8=;
        b=pQNuksgV6XfvkPUrE68/laDXSvCRDVjQznG/iTdXDBXW3S7Xrj/2y16BfBMTSQx1pn
         bpKUEMbiebfFjhRo5j8VGy9vzfiJshHArWmV5/ESISGfTYDQu9ZSMz7NKg3vn9DSAuRE
         0WjV7EVgCvMeRT0CSla5eBAGrhEh9/StXm0+T9r3IIJJ9dIoffMduRGBLyeqULEuVtal
         WP0zUUABx6UeTAuxU5eMEZj9IxsWvrJrSDUKr93k3fogPGcopdMDaaTFozwE2ZrjBKmD
         9Yhq6ac61RWCylPbdyS/iRwhq+0mIKQfCzj0B2De49Oa0pe2dMVMr/6UUgVjnKW4cfOh
         fDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758608165; x=1759212965;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqB+MBmWbGWhXPKkNDOEdyh6sNxW8IJTQY+jeJPWHj8=;
        b=hVAE3YAUpDY2szUwDxifBBXtG/rcNllDgv7EjIvFW0ut0v7dfWt6l1BCfAheek5vFZ
         /aqphqwLxrICugROvu3UtS2GOItA+VtS2L1vFzIKDbTre2kOXle3BzFpyny0R3XzD0Y4
         C4RNqW2BpN2kopmSnrNu038f8smqtdhbFJYRiuGZ6roaXOXBnXVRUk40Uwvmtb6tQY6N
         uTwfOYbJr2Cdc2ml7xKhBzE12MrxgRMC8ARgNVKfdDadGmLBDRfESVE9rsyghdOn7UiJ
         q9mVfxt7B1NaVnfaXsPbejV9zaoEnyaJBuSSVIVXjDKGIWmpCyo7EqOY4f/q+IB9Ydlk
         K/6g==
X-Forwarded-Encrypted: i=1; AJvYcCVcDLqhnobnVVH2/pt46GkWxwzQrUDy8+6ARuUUXaFeW/PGY0XjnbrL5NarDNzYFw7a3of0opzWpU8mYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkd5gSJYM8EAHwKJ1jFAasLbsOvHOd6x4qgw7FWZ4fsiOeEaVn
	M9BRLsE831H+0IeIrctMu2zIqtE9ifjXnaWtL/eHI9H4/lZuKtV3pScgM5s9fcAggCk=
X-Gm-Gg: ASbGnctpxyDpsQiUXCYw2tfjBefvE/U5Xei6sQtlyaQfXnx8nDBjJgsUvjqiwhbTSdN
	fhVa0rTvLl8XeO04yXB6ztDq/RbmO6l39tbz+U/LaNtNAYSQPWLifSB1BNDMw8eUWWp90r9Bd6i
	cVbav0AFHG/Vfhve3bcZ77KDooUo10H/zKZFuWCoCZTWYz//tFF88zOblKJ6ONYZjP68ubQf/wF
	BLxt7N9/sG4Nw7MziLjg+gypVl5hSrz+kGanWLbr77uCu6ikSjv+GgF2fg4NcirVtipgBjdoa9Y
	CCwj0cjT/mTdUrB6moBUFV2zwHtYV3BhbHBAUjkypWFndZJa+ysU4UyYHHmAI8cMXyQXumj23IR
	gHQjU4to6oU/urTA9nA==
X-Google-Smtp-Source: AGHT+IHuGnb8PBfUENdPuGyGvLbbla7V1vgnkQ+GzlyH7sUUWYMzzRFQlMWMmSJwfIFZawKhZl2ScQ==
X-Received: by 2002:a05:6a00:4fd4:b0:77f:169d:7f62 with SMTP id d2e1a72fcca58-77f538ea09bmr2180704b3a.14.1758608165503;
        Mon, 22 Sep 2025 23:16:05 -0700 (PDT)
Received: from [127.0.0.1] ([178.208.16.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc24739fsm14285188b3a.28.2025.09.22.23.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 23:16:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
In-Reply-To: <20250922170234.2269956-1-csander@purestorage.com>
References: <20250922170234.2269956-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring/cmd: drop unused res2 param from
 io_uring_cmd_done()
Message-Id: <175860816137.146699.7149828855280856823.b4-ty@kernel.dk>
Date: Tue, 23 Sep 2025 00:16:01 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 22 Sep 2025 11:02:31 -0600, Caleb Sander Mateos wrote:
> Commit 79525b51acc1 ("io_uring: fix nvme's 32b cqes on mixed cq") split
> out a separate io_uring_cmd_done32() helper for ->uring_cmd()
> implementations that return 32-byte CQEs. The res2 value passed to
> io_uring_cmd_done() is now unused because __io_uring_cmd_done() ignores
> it when is_cqe32 is passed as false. So drop the parameter from
> io_uring_cmd_done() to simplify the callers and clarify that it's not
> possible to return an extra value beyond the 32-bit CQE result.
> 
> [...]

Applied, thanks!

[1/1] io_uring/cmd: drop unused res2 param from io_uring_cmd_done()
      commit: ef9f603fd3d4b7937f2cdbce40e47df0a54b2a55

Best regards,
-- 
Jens Axboe



