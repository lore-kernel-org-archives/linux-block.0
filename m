Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57764B1E52
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747316358; cv=none; b=kGlYgH3RkOAzdGxX0wzSufQwkLKV6P2VBhUckkW2HbkKgXYncCAMsp6WF1w60VJHQ+cvRQszz6EIUU/esWMPeZYB0rzoIJVFs5Ldw8tUI2J0M1k+VgNo+m7noDSEE8P6iuFgeIGv86xhKjmfCV1g38Hzt64YeH2xetBg4cQCYzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747316358; c=relaxed/simple;
	bh=KHXvttMN7Ri0BSZIldbxg93snE3qLSdlXpvR/Seh814=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhMmk/6KtIcvMViK+C7ULvyL5EABqTZv3llVMLKjVh/++7EYHkiNNHxCfUNEF7F7VAT7WVPPOK8LKFfhPtJiq/5fCR5Bq4631O88WUChq1N2X2Oq3R5gyowLhXFi+qAolssn5wTvSnRC3iQpB9ba6b/CdW3BvLxTqYzww7A/YjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OWpKq9kF; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OWpKq9kF"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-861525e9b0aso69281339f.3
        for <linux-block@vger.kernel.org>; Thu, 15 May 2025 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747316354; x=1747921154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8OVQ0r9YVjFcpsPvZ/7nTuzBkfZJhUVIOnbNTiwU1k4=;
        b=OWpKq9kFiaCXkkGhRVLkvjs8gxMFsLrwjTQVH4sSXkHHopcFdZw62V6TcpMVarw/Do
         tzQ0m+hu/lTjCKyTu0B82fmUGJZ3egOFqeQNbcJ2ZmnC5IKLkgqqiFHh7oNZ7jBlgyKa
         w/gyWNUeSMyopPR1ToFUgv3peX9DFS1D/cmfQuxHn1xn6zpGGuj/A/59YH4+iy8043mE
         p0Axz7v509KjlveY6oCa+TBKsvClwvnWsRxYHSmyHLDYPiDEjsbW+CQmA9L0OjioySOj
         U4UcGGnXqPLnbBhRjHRT4Jvbv2SqvxRz9o9VKDyekiW1PhqcV4J/oNI76SEsZCOnC1HV
         tnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747316354; x=1747921154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OVQ0r9YVjFcpsPvZ/7nTuzBkfZJhUVIOnbNTiwU1k4=;
        b=ipQfqZCuveJXPhW1NcI5ZKBsYoDYwE25BeKaC/R6vxRnD3obyyo4A05eWw+L74SfDP
         UiqvxawtpikXiLq7LK6JmO4v/+JDUcmeda5DDMHaVnskX2YYydFfSlMaybnZt83fHhGV
         41QMdb4i9v/UaTmgLrCltsO6Am51hI5ViokLO2ugx6iRFIBMyNTE87h+S6dpUndz5JXH
         pcRhWsXxDCCJfZxNjzMSv87NtMA7DtkAXc6A+KAAFTKryN1avMXTdtEaaVxPcMxehaAL
         F+1NjAz8TlyUnxcKXts/URqqJyg0HXlU6EL9lV1KZt6v3xJx9A+ZkTCbnu4an3/Y7Tla
         H9lw==
X-Gm-Message-State: AOJu0YxrKpKEYGAQTzJWcho3LcRr1doAFv+sioIOP5HcaNk/BejJrac/
	bWGoIG5OdIts3m+WpF9H4eJabjCeN+DZNMtfL6kEDR1qlzqqYOLW6RPKPtgIKHI=
X-Gm-Gg: ASbGncsOZrZmdO1wod2rNiIl6DW2sGhIxq8rD46UItyXLublQ+xVsIVhkzVt5kSWIXI
	Tp5wAPMJMUq/Nklm/G5AcAF0WVdGUFtWsZIMcln+sdNL+IPHvvS6diEGs7FdcYzbRImQYKdsDck
	5++28o1GpSfDJ0BHWf6VdbPG7+CRILqZzLpM4J4/7QNXkUNohVDrmL3PNeFD/fqg1nVMHLqgvnC
	UMV2n26+3/1HsQmOal8wGWpk/+AySZWVYhEPQ4y770ZBOJuXAnoeoTmFV3EpOEAWFrjYuIAr55r
	Qln3N1HQzygLZz87MpNpLyRXSXXu9lDTtxIQbIkXVZQXVz9d
X-Google-Smtp-Source: AGHT+IHOhqs+yBP2I7LQCToHV9jutM3QEr/uoS8MGiXFRbjGP4pvMJtLW9HXAt6ycY4473MvFSQo7w==
X-Received: by 2002:a05:6602:488c:b0:867:47b2:e462 with SMTP id ca18e2360f4ac-86a08cdf567mr767715239f.0.1747316353690;
        Thu, 15 May 2025 06:39:13 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa2262d730sm3059055173.75.2025.05.15.06.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 06:39:13 -0700 (PDT)
Message-ID: <0d059764-76ba-4681-8cc1-4783424ad3bf@kernel.dk>
Date: Thu, 15 May 2025 07:39:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 6/7] blk-throttle: Split the service queue
To: Aishwarya <aishwarya.tcv@arm.com>, wozizhi@huaweicloud.com
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, tj@kernel.org,
 yangerkun@huawei.com, yukuai3@huawei.com, ryan.roberts@arm.com
References: <20250506020935.655574-7-wozizhi@huaweicloud.com>
 <20250515130830.9671-1-aishwarya.tcv@arm.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250515130830.9671-1-aishwarya.tcv@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/25 7:08 AM, Aishwarya wrote:
> Observed the following build warning when building the next-20250515 kernel with defconfig+CONFIG_BLK_DEV_THROTTLING applied:
> 
> Warning output:
> 
> ../block/blk-throttle.c: In function 'throtl_pending_timer_fn':
> ../block/blk-throttle.c:1153:30: warning: unused variable 'bio_cnt_w' [-Wunused-variable]
>  1153 |                 unsigned int bio_cnt_w = sq_queued(sq, WRITE);
>       |                              ^~~~~~~~~
> ../block/blk-throttle.c:1152:30: warning: unused variable 'bio_cnt_r' [-Wunused-variable]
>  1152 |                 unsigned int bio_cnt_r = sq_queued(sq, READ);
>       |                              ^~~~~~~~~
> 
> 
> There?s no warning with defconfig alone, and I?ve confirmed that the warning appears when CONFIG_BLK_DEV_THROTTLING is explicitly enabled.

This should fix it. The issue is if blktrace isn't enabled.

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index bf4faac83662..bd15357f23bd 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1149,8 +1149,8 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 	dispatched = false;
 
 	while (true) {
-		unsigned int bio_cnt_r = sq_queued(sq, READ);
-		unsigned int bio_cnt_w = sq_queued(sq, WRITE);
+		unsigned int __maybe_unused bio_cnt_r = sq_queued(sq, READ);
+		unsigned int __maybe_unused bio_cnt_w = sq_queued(sq, WRITE);
 
 		throtl_log(sq, "dispatch nr_queued=%u read=%u write=%u",
 			   bio_cnt_r + bio_cnt_w, bio_cnt_r, bio_cnt_w);

-- 
Jens Axboe
