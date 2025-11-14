Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733AE30DD0E
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 23:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763164492; cv=none; b=NUHph1jD5xcFDU42eSp7y2XKAJjwPbd/TpSjFg+P5RLIcPv77MdPy3L3FuvekglU/I+9uTb+2wTwFQVAiM+Q8G+XlcBOJBWZoDZ3GjnC7YqefVeujHH6meWzaceUX57LrDU1352s3vLBAPgj7/OY9kEgCRb2Wd+3VY2gefYmPkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763164492; c=relaxed/simple;
	bh=eZmo6/5xCexjplSdLKsWrnqHmeMVHTordQIE+X1VxUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gj6ZgS/y4vSndvJbBQdEptpBwj1Cw4SKLDLKxV8zrVUW3VMuOcRqvxgXvF+SWlFsisfTsbmMCb8ZxGK6xk5yNN9+TwXn+1ytQPjx9fDbVluL1+RDGkP8NhxVkcTJT37pkk2u8YkmSu72a5f6bkwc8ofJhSyDTso9K451wU7nbNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HXRR9iCD; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HXRR9iCD"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bc1f6dfeb3dso1419874a12.1
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 15:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763164489; x=1763769289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4f5r+TGOOPde/WLtRUa45GVIxXbdn1Vo4b55yI0gt4=;
        b=HXRR9iCD4ENjXznIuoGTr8IHj75+6u5IHRhUrtib9y946Xg5VIN5NRPwxxI/fCVPg6
         V/F1L73PrHf/vD83VcnkkpY0FOxSsEUtXYY0ZEsa0Ip6cnFo8aWIugXUEhnqzrZZ6VOX
         yvsICP43bAt7HJqMG9DikG1YDf35gqBpq7Dmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763164489; x=1763769289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4f5r+TGOOPde/WLtRUa45GVIxXbdn1Vo4b55yI0gt4=;
        b=btv8ZShn207vYkp93KZsERXZrzYD11laV5fVf/8eNi5Us2Md7e5zB2S210Y2QA2K0T
         2aF30lUKMhMKedd1qttGAf2YK0w5yBtbh9v0V6V+hB6wFYtiXO8TVvCXQjRPWC40pfm4
         1se/yOaxznyaCp+aTIMTl6qf8ExSqbkzvshfXElRQx0x68b0lp9oEko1zP6CK3fjq0aC
         FWeDtWooQtHBblWJS2snE0PaDIfUo0fAPG+Q3hVtrn9fFbkz3eZhtujLccEE91DsqP72
         GkgMaJ5ketAyWNpx72T9+TyPRZvgT6Z/m5O0WZcyCZ6Gwj0RwMldLo5t72iVfe2EISQy
         n0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXfS0umLSQg9HCfuzcmiwMZKKBEBFSADvNDLjFZ+7zLfQ3fgYe4PPRQO9fT+7G/E6qbl36c7+Y1STWy6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT9v6sBi4BuIIEL1vO8yp/+zBwPU8BlBqVEHsIdyR/mYZ7iDkV
	jF2zhTrfvmTahLOwMJujjVHJrkWWw5LG/un06zb6lxhd5r1RMtUio6wXwBUoC62Iyg==
X-Gm-Gg: ASbGncuiThj39D/tMh3WFoMZo0nzTzXVlBlBskf75LuCQioCSclUKQRJy8BzhSVrGWT
	F0eTeln5U7NWvO73sfctKln1zJMsk/B1VvkLExAkBZtnf4Fu6Ub+X57SimEyXnCz2z9p0kyz9Gi
	CzmXnwsset8806531l4SWz7Y0KLgg4DcaKzLfBxk2HF9GW/gn29mgC8qewrFovLc6n1m8eYdZDn
	WOCc0qDX/LAdEp/N6s65WaBARwA1Eh+EhU0CkK8v2VbR6lIGOs+LxMI73cYpQJedhpE/1yUV6n1
	WTGIsCFRZFL+FrDvmbnsm+LHzHGPSjFnihWf450FL7TXnRR0lDvsRbU0nps/ixs4jtE9lF0B0lo
	cn0FiysZHygAeok4orjbmjW9ImI3C2OQC9hnCayObFpP4IviKzVCcjE37bOsbkVD/N4pLSzY9m8
	70suJU7DaZQNHT5qu94L41zALZjC4Br6F75xdheNt8EW8EmyFWWaG1c59nGUTceJR810SQI5jiO
	4q6KLspSg==
X-Google-Smtp-Source: AGHT+IFtwwfARtE+LZgjm4XpePNHmAw5KTc8Gn91NyCPCwHKkcDkm5Smf3lVi3mzi3s6gN/2LN1I7g==
X-Received: by 2002:a05:693c:40dc:b0:2a4:3593:4679 with SMTP id 5a478bee46e88-2a4abd973e6mr2295298eec.21.1763164488752;
        Fri, 14 Nov 2025 15:54:48 -0800 (PST)
Received: from khazhy-linux.svl.corp.google.com ([2a00:79e0:2e5b:9:bb76:6725:868a:78e5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49db7a753sm14114818eec.6.2025.11.14.15.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 15:54:48 -0800 (PST)
From: Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Yu Kuai <yukuai@kernel.org>,
	Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH v2 1/3] block/blk-throttle: Fix throttle slice time for SSDs
Date: Fri, 14 Nov 2025 15:54:32 -0800
Message-ID: <20251114235434.2168072-2-khazhy@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114235434.2168072-1-khazhy@google.com>
References: <20251114235434.2168072-1-khazhy@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

Commit d61fcfa4bb18 ("blk-throttle: choose a small throtl_slice for SSD")
introduced device type specific throttle slices if BLK_DEV_THROTTLING_LOW
was enabled. Commit bf20ab538c81 ("blk-throttle: remove
CONFIG_BLK_DEV_THROTTLING_LOW") removed support for BLK_DEV_THROTTLING_LOW,
but left the device type specific throttle slices in place. This
effectively changed throttling behavior on systems with SSD which now use
a different and non-configurable slice time compared to non-SSD devices.
Practical impact is that throughput tests with low configured throttle
values (65536 bps) experience less than expected throughput on SSDs,
presumably due to rounding errors associated with the small throttle slice
time used for those devices. The same tests pass when setting the throttle
values to 65536 * 4 = 262144 bps.

The original code sets the throttle slice time to DFL_THROTL_SLICE_HD if
CONFIG_BLK_DEV_THROTTLING_LOW is disabled. Restore that code to fix the
problem. With that, DFL_THROTL_SLICE_SSD is no longer necessary. Revert to
the original code and re-introduce DFL_THROTL_SLICE to replace both
DFL_THROTL_SLICE_HD and DFL_THROTL_SLICE_SSD. This effectively reverts
commit d61fcfa4bb18 ("blk-throttle: choose a small throtl_slice for SSD").

While at it, also remove MAX_THROTL_SLICE since it is not used anymore.

Fixes: bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW")
Cc: Yu Kuai <yukuai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/blk-throttle.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 2c5b64b1a724..c19d052a8f2f 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -22,9 +22,7 @@
 #define THROTL_QUANTUM 32
 
 /* Throttling is performed over a slice and after that slice is renewed */
-#define DFL_THROTL_SLICE_HD (HZ / 10)
-#define DFL_THROTL_SLICE_SSD (HZ / 50)
-#define MAX_THROTL_SLICE (HZ)
+#define DFL_THROTL_SLICE (HZ / 10)
 
 /* A workqueue to queue throttle related work */
 static struct workqueue_struct *kthrotld_workqueue;
@@ -1341,10 +1339,7 @@ static int blk_throtl_init(struct gendisk *disk)
 		goto out;
 	}
 
-	if (blk_queue_nonrot(q))
-		td->throtl_slice = DFL_THROTL_SLICE_SSD;
-	else
-		td->throtl_slice = DFL_THROTL_SLICE_HD;
+	td->throtl_slice = DFL_THROTL_SLICE;
 	td->track_bio_latency = !queue_is_mq(q);
 	if (!td->track_bio_latency)
 		blk_stat_enable_accounting(q);
-- 
2.52.0.rc1.455.g30608eb744-goog

