Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A889920E6EE
	for <linux-block@vger.kernel.org>; Thu, 23 Jan 2025 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737638287; cv=none; b=TdIrsb6V7zN9bHcnPQX7CEIvkyGv4pyioD+ggEx1by+44HoNtLIf7Miap4b2LOeTRVJeSJrfWAJNV/O2RrMl+LFKBd9PryHHymj/WgCPf3ofcIiAvevzf00eW5DyTlhh30vJoNHBWzD4rjq3HV/4Mz6R6hDcBBM1lViQAIFtdH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737638287; c=relaxed/simple;
	bh=xBKbNvSotp+Y071aLmv3gNwZBcLQ9Uvc9+MqzR7Zav0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=QZ/iTEHrkqWsoePNgkOfaKjD8i+nZNE4rPg5x2QKUESqdSlwTN8z9lOhffVPlcPedhde25U6iO8g9LWF7Uxzw6IGpXWcf/CcHV0ENbKGe3IE7LzPd8iObYVn3tAVsNLXElZqpqGhnKYhJyrlqfUAF4B3W9F2UscHjmscE94aH+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ghxhVIFh; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ghxhVIFh"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3cfa9272c14so3061765ab.3
        for <linux-block@vger.kernel.org>; Thu, 23 Jan 2025 05:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1737638283; x=1738243083; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQwLVuZ67fRKefl8hFx+ExezQ7Esj5qTwVa0bsQz+c4=;
        b=ghxhVIFh8/2z8orrH1t4vLGLe7maN48ibyjhAzxaSFZQOeSw7QQmj8arNYDI0sIzvV
         sIPx3W7bFOH+ZMHjpsoz4ifayep7CI1qib1X0/C4zWMGhvdT2NkUyYGIEkGLm4qodDCG
         X5Dp8OEDrTH8vTggoC7zZQ7UftcxWXhrLJlhQinDh1NbI5P1CtfsKUhvJKGmhuC7eg1a
         cPnZd6RRvZTa59ofE0nYeyIVVUEDW/vFsQerG7Txq+o7QtFebUKwhCxMMHXitc/Pck/A
         g1B45JbeFfROzZWk32lEA1CXDUI6y4rqtYUhKpdCp4ZmcjWeLui8PzfMwK4qxNYhK6lo
         D9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737638283; x=1738243083;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QQwLVuZ67fRKefl8hFx+ExezQ7Esj5qTwVa0bsQz+c4=;
        b=sHNkFv9Bkcklee4grotMbifJnAzicCHaQIqKHjdl2VrihIkNOmD74jZiEc0hT2JT8F
         Ao86FgqFJHcoLgVOzJ9OQQ5UFwfNk3/IZdOJeCxfILl4GZwxiXhxeKBPK9elw8hmXTBb
         /1qhEdJatfKFbvqlxieP1sBjOdtEPtjGXPM3zWumOoT2420u37c4bq15qARQGKqZs8zd
         aOaI/uDf5rXoqlKEtIzhoF5eD1nCIYhvd7Ww7XtAe4XCB22JJnllPdV0yRG5BYIuebft
         kth731v0ZI1k44sqRb0bWSdhhOuuypIiOxKuvGcoHyLaF3eUoThUo9qQToXM7AK0zQOr
         gKNQ==
X-Gm-Message-State: AOJu0YwcPqy293+jDRxvTnXPSVmmqGANJxJ9TM0y55e/AMwxckWjSVyB
	d73EvXwVXVFAYQAXLRz2PdxyLStnqMhQ/knMqUIYL74AsaTFtemtSwimGNdirBNcWIfC8dJk4MJ
	i
X-Gm-Gg: ASbGncsKMSpuOvCujwc7xtrgxbUQ4BFag9lNAEVVBKRtQK7+6OFEz8NUT+Pmaa8fy2L
	lB00voQ40SvGHXxKbAHNlPgXY5c9AQN5t2TotQC/g+3sZS/eN0E5DGLFiUN+z0r45dByZbGEjUb
	La41cKgyjz1bS4eYBv9VUqx1F6WT28F4uHQDDA33VzjA1jJIAzA56TMxHm9kRHwcCXpgKsrmKUB
	OQ+ciJWKb4WGFE8zB8G5uMdyIXSvGol3LZwXyl5+1PwmJZsxfZzruBfNeiy+gQZvBFmQ3CU2tey
	3A==
X-Google-Smtp-Source: AGHT+IEW/5rIi7dQjm3Jed2p8SS+TGBjr+9AcIg7FHeIC7peK5ZKsyEQTkYwVDTgAPf6gRpjH/3z2Q==
X-Received: by 2002:a05:6e02:4803:b0:3ce:7ae7:a8c2 with SMTP id e9e14a558f8ab-3cf74426a65mr145809815ab.11.1737638282941;
        Thu, 23 Jan 2025 05:18:02 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3cfa10c3495sm21646625ab.59.2025.01.23.05.18.01
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 05:18:02 -0800 (PST)
Message-ID: <47af5107-96fb-426c-961e-25d464f3b26b@kernel.dk>
Date: Thu, 23 Jan 2025 06:18:01 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: don't revert iter for -EIOCBQUEUED
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

blkdev_read_iter() has a few odd checks, like gating the position and
count adjustment on whether or not the result is bigger-than-or-equal to
zero (where bigger than makes more sense), and not checking the return
value of blkdev_direct_IO() before doing an iov_iter_revert(). The
latter can lead to attempting to revert with a negative value, which
when passed to iov_iter_revert() as an unsigned value will lead to
throwing a WARN_ON() because unroll is bigger than MAX_RW_COUNT.

Be sane and don't revert for -EIOCBQUEUED, like what is done in other
spots.

Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/fops.c b/block/fops.c
index 6d5c4fc5a216..be9f1dbea9ce 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -783,11 +783,12 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		file_accessed(iocb->ki_filp);
 
 		ret = blkdev_direct_IO(iocb, to);
-		if (ret >= 0) {
+		if (ret > 0) {
 			iocb->ki_pos += ret;
 			count -= ret;
 		}
-		iov_iter_revert(to, count - iov_iter_count(to));
+		if (ret != -EIOCBQUEUED)
+			iov_iter_revert(to, count - iov_iter_count(to));
 		if (ret < 0 || !count)
 			goto reexpand;
 	}

-- 
Jens Axboe

