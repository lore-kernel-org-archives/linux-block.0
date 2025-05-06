Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23F82C2FCC
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746493807; cv=none; b=jX99FTBJyVFxjM5tb+5Ji0TyWbT7q8YOB3vVzc78w/ILt61hItDedqiTHbgbDfcd+Jy5CL9C8F+KZX0aKWEWDKmCUHRElZDTtooG+1Ohj7zI8kxLF/fnJUrhPRSnUyBmB/doI1xGC7c9XIT1Zs/vuPJCNuWVM024JWmQYRaUlmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746493807; c=relaxed/simple;
	bh=ism1yfrKaIv0+4TDvd0Jbm4li+4grSgG0D432/+6UWA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Aws2NrPAiTbdmeXcssGuRqsguKeXQFuC6tKyVLN+MpAXR8FnFLkUsQ2wp5HrKyK0oHBwFngaNS6kJlPQctO5Evnw86WMboSLF0A6PL1zuGocWL7TBxNW1/Z/h3iDWfBBB/NgpktNT2yki2zTewN2Hgeno6F6z7781X7v6Hlmlc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cBmD1lzp; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cBmD1lzp"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85b41281b50so149761839f.3
        for <linux-block@vger.kernel.org>; Mon, 05 May 2025 18:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746493805; x=1747098605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbU9wJMa7uYwsUafkrSR7JQpGDwQequIjcnVKBdo2DI=;
        b=cBmD1lzp9AIIbJ7Zk+2GiHSbu4hg4/cghrgitoesaVgmaFQYwgXRD4jnQGbeoXQ/Q2
         yGuiijrMFV0QMYyv7xKua/ZWPYwQzoJbUtpzC6K5Ta/z9c+BcAx/hSizTvS9A7ySBcb6
         RZh2+yhREXVNQrP3OSE7CW0o8/Iovz12m0EXY5NTHiorwiTOh7NRJHRobbmF3GhzP4Sr
         p9QF+ciU1rHgYQv0Q+vU8xoFI9/oQ7GwibKTy51YOlRfGXENg7Vt2eW4oA3u+pxGz82E
         QMa084RyRnjNsGobHIXHg+eosMhQU0NezSfGjKwOrxXRi/5WEtGZPSETGU36mMGJED+D
         QiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746493805; x=1747098605;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbU9wJMa7uYwsUafkrSR7JQpGDwQequIjcnVKBdo2DI=;
        b=i3A0IYEGCLIWrY1aJ4aM/Nx+hcQNNX7w6kLVDrYRa87uJ0JuUarsgC+i9aE2e/n2He
         lX7CUATnHR5/OdqAdBPwH6IYKiRgsndixD4d2b3MW0mFqb+//HgiwScuXRe7O+jKORAV
         0jlI+L+qG5MCEr7zlXMw6nmc33L4syhOWWUxEBAwK96+jEoHUf0+OtSDgdGlCk/loVYI
         lMqUJY9B9uOHG8U9nArpTpSQSL9czYSRJZSCLjNEDHfHeVa5aJ17dGHbCWCvlYS650t2
         Zw/8PZSPYvVUXSeaAuS39+YVWnkgqXXCcS/kRBlkf4liva7SXUaKgd+zXMcS/vqwpFeT
         UNlw==
X-Gm-Message-State: AOJu0YyGkRI0rH8+YiNfStjw2H3Wpsy6M1qaPBGtLGd4eIQqYmpgeQ+M
	9TqTmYoOcvCqZ7kpXUS8Bkby4HRT25CftFjxLvYxz4AEdXgg2b0WRuw1qSPHik4=
X-Gm-Gg: ASbGncus4+wUGMHRDvFWb38N259y+e/ZjVsXh3lQUjduikcHKX2R8J+JFL3C6ItkOfT
	uq+taIoBnVsd8uUQp7zzuLJPqG/QZEoo2xS5uRfJOLADLZSOkIIJ953GV/3x6EgB/T0JxzM/P0u
	WBY+hjn/sAsvZ8k/Qxm0KjRddZjXb+1qongehBV2oXm5HtAT3di8cnl3S24hOyz6+bh+jwMmT3V
	gAiGVfp2y/piG0Bi5v3zfFHLKV6ADxN7AoCcKw0C66NroD1zOYt0zJ6/Joykckjzm59I4wYVSAO
	XjIh9+YdR8bCtbRMw5CK9pHMrjpl8Knk
X-Google-Smtp-Source: AGHT+IG5uWs7/XSRaLrDHaC/U/WTMwkX4zIRDRmgMh3cRQVRYXxpdrG5z9eVBhBDDDKej+9+hykmjg==
X-Received: by 2002:a05:6602:2c92:b0:861:c75a:27a2 with SMTP id ca18e2360f4ac-86713ad4c4cmr1170509939f.4.1746493804822;
        Mon, 05 May 2025 18:10:04 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88aa57fb2sm1990674173.81.2025.05.05.18.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 18:10:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Zizhi Wo <wozizhi@huaweicloud.com>
Cc: yangerkun@huawei.com, yukuai3@huawei.com, ming.lei@redhat.com, 
 tj@kernel.org
In-Reply-To: <20250417132054.2866409-1-wozizhi@huaweicloud.com>
References: <20250417132054.2866409-1-wozizhi@huaweicloud.com>
Subject: Re: [PATCH V2 0/3] blk-throttle: Some bugfixes and modifications
Message-Id: <174649380387.1442275.5861328487387693589.b4-ty@kernel.dk>
Date: Mon, 05 May 2025 19:10:03 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 17 Apr 2025 21:20:51 +0800, Zizhi Wo wrote:
> Changes since V1:
> Modified patch 1 and 3 to make the changes more concise, without
> introducing additional logic changes.
> 
> The patchset mainly address the update logic of tg->[bytes/io]_disp and add
> related overflow checks. The last patch also simplified the process.
> 
> [...]

Applied, thanks!

[1/3] blk-throttle: Fix wrong tg->[bytes/io]_disp update in __tg_update_carryover()
      commit: f66cf69eb8765341bbeff0e92a7d0d2027f62452
[2/3] blk-throttle: Delete unnecessary carryover-related fields from throtl_grp
      commit: 7b89d46051ab310096994303b969768c4a9eb18f
[3/3] blk-throttle: Add an additional overflow check to the call calculate_bytes/io_allowed
      commit: 18b8144a1bd8be5a88cc438c0c9213bae1be1a9d

Best regards,
-- 
Jens Axboe



