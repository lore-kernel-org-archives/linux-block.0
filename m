Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A65F35CBC8
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652128; cv=none; b=UMFIF/iq8DmQ0or74f8VUD3S7fGqasxsU2MObhN6+ZgmcDmzo4pAD6vmua6vQdWPPWOfxRBaGtOir8U9rqycnKns4LyiK7n8O0RXVwZjr9PRp9ulPH92vxWd2StA5Auh9SVO64lvL7JhxFv8uZXDcSEj6/6f3XjhmOns2Bte/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652128; c=relaxed/simple;
	bh=+MhYmx0qZ5ECK4TsfTdnamhw9SfRF4XVYiotCwLLito=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hj654ILvzgWynv3n8fYi5xcjd1+R55gzLN7Q0VO2/oGbCectJQOmx7U8vw21QZGMB6R0mMSrgBF3riX854z8MRmhOEONn/8nqUB0wzXVH9jap6vZzfLrnq36EYitcxNWU2itzOxFD9oB8xKJxj+3yotnolg3Wzn54fm4wraj6Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oZV3ZH9L; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oZV3ZH9L"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297ef378069so9874815ad.3
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 07:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763652126; x=1764256926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e2iGg+ib6UXPOcDyrMO0wHUXBQgntN6Dn49JrmQl88Q=;
        b=oZV3ZH9L6hSizI30rihu07STpPfl207DqXTHd2TFjmH6i9wTBfb0pvhgpEQ+rNRCCL
         5Obk2I658w0eQJ757DaWazrcFV1kzVjXDWC5xBtRE4qIZRNeTdRzp5B+wdB1LSOIW4Ul
         YYpIXsTAcf2reZv5TW02mTYUupKb9CIyWdxxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763652126; x=1764256926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2iGg+ib6UXPOcDyrMO0wHUXBQgntN6Dn49JrmQl88Q=;
        b=uqCgqQs69hrRTdU9PfApBcWSI/g5iIy77bxQe/uMwbiZSy44ud8YhRzr6nyJsSPsFX
         6Ay3fiEU7k3Qg+fDUTAURfBOhj26S3YoS3DUa++UEvh7IsVw0HAi1CzJ7idRowQR8S/N
         9OO9M9MXm6dnDoTdb+09G4BewIZgviZ6Z5/mglEGhVZuuv9ldHHSztz83cpDBtIUfAlF
         AHEmKz16hcG2Vkdwf8lguXcP2Kwl/dfyi3H9st83nIfvZbtzZVktuQEvV3qVpOXKE+Ra
         whOc2wlDn8oqkEm/YyKGKGRu6/+egQuJMQx18YqOiWBUzn5oOICPE9Cu5v9kYqhw8N/D
         7NoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdI4wGUSvJw2ddK7Erx1AkOXXJFWvnNEAvjs3uS05sAIQ3qCmGjPTH5zOCM9vN3ojTZTV6/3erUJkz9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYoYt4UuuJ7WHUJzfroH/+gGXfsiJTO0RQpmvvOALiNc8+T0/q
	wu8qtVRNlw4gaq9A7ozsAcj8hj4cICNu1l/RfU4PRya8/GHs/WlW1+Cqwkd3F8n7KA==
X-Gm-Gg: ASbGncvfVG3icMWzhSVyZDxyPUZShNX+KUzT65KWjB0zqseOLleLy9o/wewsMTulCrR
	UgxreH/b4XGAHvNbsmDlPRddfjgVbdH6iosfQGagn02UNa6NrnO6OGq3h6HUPhEyirO+5vVQ5wO
	zx/kk6eoAO/mkJyZ3z4yTyGVzHrS5rK186vBYBaSkHcF0XJPIUgf3G8WZUIvncaCkmbmZoPUbSu
	kU/Djy7uij8E8xF3cXdE66lv7+6gatsZTlhMCFDW1ffNZAZcMwjOAWk/bvDLp1jbvVBvzVT63D4
	7Qyn+ejkJ9oscAD7jFNSbUyLqdVH9P29qF0z1OCvW25Kx4z0FO9vc8iJFPqYIy6KwMMTKYO5S+I
	sXLpp1pqib6xrlNBMEKWbYE+PsBX+NX0oBkzv73llsODqZoEbTFrwhK1DCPql5YdGcCKgiILwd2
	F0nEo9GAwTwaufHGC+Cjn4iY/Sq2UuMtdnFgoKLg==
X-Google-Smtp-Source: AGHT+IE8tNk0FkEIShJqDYWzZEbbNAd6ppfq05qQmtYQbN9xJbxUzpj7n3cqYrDIpYxS6M/t0wrnYw==
X-Received: by 2002:a17:90b:4a4b:b0:340:4abf:391d with SMTP id 98e67ed59e1d1-34727c05f0fmr4499624a91.16.1763652126303;
        Thu, 20 Nov 2025 07:22:06 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6762:7dba:8487:43a1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f023f968sm3179642b3a.38.2025.11.20.07.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 07:22:05 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>
Cc: Brian Geffon <bgeffon@google.com>,
	Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCHv5 0/6] zram: introduce writeback bio batching
Date: Fri, 21 Nov 2025 00:21:20 +0900
Message-ID: <20251120152126.3126298-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC

This is a different approach compared to [1].  Instead of
using blk plug API to batch writeback bios, we just keep
submitting them and track available of done/idle requests
(we still use a pool of requests, to put a constraint on
memory usage).  The intuition is that blk plug API is good
for sequential IO patterns, but zram writeback is more
likely to use random IO patterns.

I only did minimal testing so far (in a VM).  More testing
(on real H/W) is needed, any help is highly appreciated.

[1] https://lore.kernel.org/linux-kernel/20251118073000.1928107-1-senozhatsky@chromium.org

v3 -> v4:
- do not use blk plug API

Sergey Senozhatsky (6):
  zram: introduce writeback bio batching
  zram: add writeback batch size device attr
  zram: take write lock in wb limit store handlers
  zram: drop wb_limit_lock
  zram: rework bdev block allocation
  zram: read slot block idx under slot lock

 drivers/block/zram/zram_drv.c | 470 ++++++++++++++++++++++++++--------
 drivers/block/zram/zram_drv.h |   2 +-
 2 files changed, 364 insertions(+), 108 deletions(-)

-- 
2.52.0.rc1.455.g30608eb744-goog

