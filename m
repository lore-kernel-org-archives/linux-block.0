Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7882E35898
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 23:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763164489; cv=none; b=KTaqv3QlvDNDK2mZEGQFVIea65m/Vw/MP6JdlzNSY3T95whjfD4BMRL+vj12Tbciy9vxrPAeBvoNsLrb0c99dbJpQLjKpy/UWoMV44Ijgv/rVp5x7j+JWbA/FfUgO7NVSEpR5gucQxafVnNMsSlFYgTDW6x44J2NYsUszCOnCrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763164489; c=relaxed/simple;
	bh=8b2K75exTopC25Duwa3XNxKklUYHIMlCaizUVN8+ses=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IVTxqF/7gOpgYP5hLpy9UNxEx5zFaohogsrfGQCjPM4pY2MxB9lWBPNQu5ebNUVADuhI6IWaisY0lRgsrWp9K7Y55jiUFPn/iFtwj2RjGkDFMmXvybS8cNAwnPK6GRvGi1KtMoEidbt2rvNKJlHJv6AGsNKrzdxlC9G8Ua20lbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XG9IpBMU; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XG9IpBMU"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bc274b8ab7dso1799227a12.3
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 15:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763164488; x=1763769288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hgM/nvnBybHbCEHd2i0eoRGXYVypUnH143ZWqlNySO0=;
        b=XG9IpBMUV0srPz359pUU2bxfv81KKJ8BdUnkYM7bRM4lugMjRLsirrAptlLdjT+PMK
         mgRooc0l4Bbo2x20R2MKMzNoFkzNSq9WV54gyzt2Zshr39vm+gmcQN2zUfYLR/Ai8rtT
         bixudUWnqwbF8uU5jOwbdqIt1M4nSQGf4EDGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763164488; x=1763769288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgM/nvnBybHbCEHd2i0eoRGXYVypUnH143ZWqlNySO0=;
        b=rikJWe6iwcOS7QQjeiqxyAKMcSBncHBsdqUiYqRQCQV6K+gpw1qUCWLyQCqpzd/wOx
         0uzZ9i58L1+mJIqZ9A7tKlNIVOnJODP3lu8pTwKny1ryDRYVn+vdZhbJiQW3DYFwXeDc
         GQ7MaXLvC08m7QA+D55uxokW2Ifxv1y3e7XydHkkUr9S/AVZB4UHtHRF20xhHi1/oDTM
         g80wihd85CsQEGEjf+msP7iOITWndnBw1/8fmR0a3x2TK7pZDs+32HAmX8yLve6zYY6a
         VontL+jQk8Riy/YhQeyHNk2Jc/WV3HEDJp8Ji+VgzPEukIG97c/uLPbFkEihGNvdA4Qt
         ENnw==
X-Forwarded-Encrypted: i=1; AJvYcCWwxhbNZDp/h5bAHwTIs+aQ8ALBlHEcMGB+GfbntS6xHaupg8VNVzuo01waP1/yw1yy992vKvWjIb0V8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyztauXfmkR379+lUwIWWr6pJDnyBvaNKp1Q1nzR5WHkEyGg5wb
	ZrMQMqMR+4X7wiwQG4fOamMS97gspJnks0OqMsZYMG+TSPce71La3PFTLlG1ySGVrw==
X-Gm-Gg: ASbGncsUylpWPM3D525Ab3jruSP0w4/3nnTWGyMlR77jWCYwAPg9eIuneJWPZTkVJMy
	DgDm+rlx+bSqIrGOOcFstpXxhD//OFVaJYeXjI/81fl7W38KLT5ObFpD9pTobXrzYXqiLXgaDGA
	/Ms6oFxr89/S5C/bsOHTo4MCwH6N/B3OKUONqw3Qs4F09junIfnWeTz7JAH2EXBMBtZoEMqcEdm
	02r7w/ZeQ/8lHJc5qi8lskPeIzH3jfbKVZHmbpYLaiIOCn43X1JmHJV2wiheXSoh63KVwzbnkjQ
	dWRKl9VUA7G5sXloKSKa87wHPeYF4k6Rao9T7TAHV9e5O1NOTjv63OpH839cG4GENZLegxW9tId
	jc1HjjrS1aD9WVQYkwvTFCAmCXRzZi3z4zJ0+wTNZ998IOEMrAxk6bwzuaXZ3xNBtS+lHXI90Cv
	fzORGpTHzxFP7Jns5qNMJH3uHm4M16Rt9QUyccNQKuNkw9S/rfzOcYSGvUAQYRG0xRI06+Kd0=
X-Google-Smtp-Source: AGHT+IG3JcoLJMtRbmF6VRDQOY9UH+gOZKPuPSg70/zIMIlY7t2a6Vyb+8LbWG8aqa1hQUqyH5V/Ag==
X-Received: by 2002:a05:7301:d194:b0:2a4:617a:418a with SMTP id 5a478bee46e88-2a4abaa252cmr1665974eec.13.1763164487804;
        Fri, 14 Nov 2025 15:54:47 -0800 (PST)
Received: from khazhy-linux.svl.corp.google.com ([2a00:79e0:2e5b:9:bb76:6725:868a:78e5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49db7a753sm14114818eec.6.2025.11.14.15.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 15:54:47 -0800 (PST)
From: Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH v2 0/3] block/blk-throttle: Fix throttle slice time for SSDs
Date: Fri, 14 Nov 2025 15:54:31 -0800
Message-ID: <20251114235434.2168072-1-khazhy@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW"),
the throttle slice time differs between SSD and non-SSD devices. This
causes test failures with slow throttle speeds on SSD devices.

The first patch in the series fixes the problem by restoring the throttle
slice time to a fixed value, matching behavior seen prior to above
mentioned revert. The remaining patches clean up unneeeded code after removing
CONFIG_BLK_DEV_THROTTLING_LOW.

Guenter Roeck (3):
  block/blk-throttle: Fix throttle slice time for SSDs
  block/blk-throttle: drop unneeded blk_stat_enable_accounting
  block/blk-throttle: Remove throtl_slice from struct throtl_data

 block/blk-throttle.c | 45 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

-- 

v2: block accounting fix into separate patch

2.52.0.rc1.455.g30608eb744-goog

