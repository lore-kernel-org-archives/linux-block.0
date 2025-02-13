Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C026B0A5
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459932; cv=none; b=F2RFGObPqgPa2KY9GP4EbVay9ktN86XbilHo5AoxVAvyn38XxrsOPGUg1Q1NoRcwehI5aojL4fUd9d2vYEoMgfG+EGmg1yzrEMuFzJK6jxGif6quRlYTXOe++zyWP1dz9Zl4QuI9Bg8SkjSiwKdBkifEWXM5rIcnEfRau1y7xU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459932; c=relaxed/simple;
	bh=s1A+Y5kzlhhTuz/DgbGulVmobjpa8VOcJCacegCISoc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=BNRmYrQGV/Ck8s1DSFhmVFuYPRnfNcfNvbdtmHlTDSI9QSAYo26b0ZwhQuTDOfG9wOMjn7QVDGdxgyvSbYKdP1Zhi6n0b7IxZPvgJJx/bvzOxFhHo3lW2mgpS07wUOglbAhqTMVUMTmJuOzKJmC5m03U3Dt/FhQs7wli9ceFVKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aBx+ts0C; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aBx+ts0C"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-851c4f1fb18so32004939f.2
        for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 07:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739459928; x=1740064728; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+knxZstdnaugWHjaUUMNfVeCrV53rPdumfau1GeufM=;
        b=aBx+ts0Cv82d0Ar0jouUfJTjv3OKZWVI/f2jyxqlcUeRONY6fl/x6XHVgHgP3GaNlb
         CZK5KyWGBve3YcN7epgUKSdfUilcROaYNkVY4J6evgrQwqziWS3fEeAzgFNYNZGe4qNG
         M5EuzE2l1p9EpVGi2D3PmB04JIx2CouRsCVm6r6NYGkU+AGUdWk2rObHfrgrrkbzwBpZ
         gXtRE1urv7AweASG0hWRzjYJoeWJGB85aNBZK4CwhOeRXA/FP+REgumcLRcy4KJVrDvi
         PrQrUg1BqZqYMqYhTf6LYKmQLNXI5ZrG2kkLOUiAVx03AskpJmgiuc9t8vcyVi5A/l1k
         aolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739459928; x=1740064728;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V+knxZstdnaugWHjaUUMNfVeCrV53rPdumfau1GeufM=;
        b=clwFZKctNF3Bt37ApTp8ClILGb8cVJcMq1n4lXBsGRIzo1t7048/TyfeYx4Rekt0Jx
         lMuShdJHhRFBsibRxcQ3kyojI0LwpH54hcg2uGtmcg0lD9ys0Sv59g8Xa3Y+ti68I7rQ
         3wxQl4tb7jmT6tuMiWKkdsljTspTgeNoMwCR9JEuMblNsBMroez62el3AVlTDIddretK
         DLIvY2lOXS6M/IF5NYuPz9k9KTfGzdcnYXcwS1vPD62hI5Z+Oui9A696h4TgI6K9IAsm
         o+hMnjoiPFE6qrLNns5OmsjcSgNHKztdE2Te2HEGtwTukXo4/rzYpbw+zXerY1yhExIJ
         uUjA==
X-Gm-Message-State: AOJu0YzqL42mum8JCTnwY/TUUVQVxsNaj9wbcefSAEiKfF5MwS28bd/6
	YMvTYVa9I0LhYMeFocFduO1ksmBKzj8InIqvVVuGHbXtXEK9fAxS+fSH1MgdgSZW6W4nI6t0Vgi
	V
X-Gm-Gg: ASbGncuHBfRZj8++559K2voCD9uZDPQwMJi23ckBpcNw1sPjvSIzxwbLgI1M3qGb4Le
	BA/yAHz+bpAFhrHBZhlQjoBo6DipwbX2eoTpP8o8pQ+iC+MouvzxnQ6FPHvaKFDGv6jbQqsoQ5X
	W65ojiBNVmk5UeYYlRgoOg8EU8ut3nveEuGxl7rq9cHYLNv++hXuXmuqioAqafgPm+XRpdZkmKQ
	yl8HkqUkwkBbu2W+GgXOk2ZM6a/r46MnFD5NaWSbyEBX43ud2RvnINioe6sCoRj2+AtloKLCpFr
	4K4UOnXjGTc=
X-Google-Smtp-Source: AGHT+IH/PAvblpmLolwRTSOvvxmgkOk0Duj8Z/6p9fjyJuDFNe/pVf4FW1NXemeq7op1QwYvV6Zz4Q==
X-Received: by 2002:a05:6602:2c95:b0:855:6d7a:1820 with SMTP id ca18e2360f4ac-8556d7a1ebdmr126087839f.4.1739459927844;
        Thu, 13 Feb 2025 07:18:47 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed282ae717sm356385173.80.2025.02.13.07.18.47
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 07:18:47 -0800 (PST)
Message-ID: <20575f0a-656e-4bb3-9d82-dec6c7e3a35c@kernel.dk>
Date: Thu, 13 Feb 2025 08:18:46 -0700
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
Subject: [PATCH] block: cleanup and fix batch completion adding conditions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The conditions for whether or not a request is allowed adding to a
completion batch are a bit hard to read, and they also have a few
issues. One is that ioerror may indeed be a random value on passthrough,
and it's being checked unconditionally of whether or not the given
request is a passthrough request or not.

Rewrite the conditions to be separate for easier reading, and only check
ioerror for non-passthrough requests. This fixes an issue with bio
unmapping on passthrough, where it fails getting added to a batch. This
both leads to suboptimal performance, and may trigger a potential
schedule-under-atomic condition for polled passthrough IO.

Fixes: f794f3351f26 ("block: add support for blk_mq_end_request_batch()")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index a0a9007cc1e3..cc1cb5de8fb6 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -861,12 +861,22 @@ static inline bool blk_mq_add_to_batch(struct request *req,
 				       void (*complete)(struct io_comp_batch *))
 {
 	/*
-	 * blk_mq_end_request_batch() can't end request allocated from
-	 * sched tags
+	 * Check various conditions that exclude batch processing:
+	 * 1) No batch container
+	 * 2) Has scheduler data attached
+	 * 3) Not a passthrough request and end_io set
+	 * 4) Not a passthrough request and an ioerror
 	 */
-	if (!iob || (req->rq_flags & RQF_SCHED_TAGS) || ioerror ||
-			(req->end_io && !blk_rq_is_passthrough(req)))
+	if (!iob)
 		return false;
+	if (req->rq_flags & RQF_SCHED_TAGS)
+		return false;
+	if (!blk_rq_is_passthrough(req)) {
+		if (req->end_io)
+			return false;
+		if (ioerror < 0)
+			return false;
+	}
 
 	if (!iob->complete)
 		iob->complete = complete;
-- 
Jens Axboe

