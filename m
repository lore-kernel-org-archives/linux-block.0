Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCDE56759
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 20:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sfK3TOqs"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7beeeb1ba87so23858139f.0
        for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 12:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705003605; x=1705608405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PU5j9lD8u2lukoBl954L2rDXS1wz7DI/s3BYl/gbk6w=;
        b=sfK3TOqsVD6Gi2hpOjBSS9oLylMGDdJO5nvMHg0jqvJaUExzzfgZIGxNWrYB7HRWDy
         xk+vW9ehSBqEjvJlCvbKUdIvjsPfXA5HqaH2ybq6Cr++CjJjTrx/2OW96wkFBSpbxFCl
         96Gb/3ftKtRl7PmfS6ldU4Q3laP9oTTd9hC9dmwaPj7ZfidAtMv0A7oCaG3FJPkbtpe1
         u0icZIwp5OXW4zDYIt0VoVQIRYojGlc3GX25D4XM5EZlApuKzCWThCw+NAFmnrcwDs3z
         4Zu3y60nuXUE2jq2lzGX42T017pYqhtVFi7D08EldckklSRYJ05uNuXjfbGVZ3kDMHBs
         ksRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705003605; x=1705608405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PU5j9lD8u2lukoBl954L2rDXS1wz7DI/s3BYl/gbk6w=;
        b=W9BnKpstm8bpis4/PAx39ofZAEe8WVt1nTxy351or3eMvTVOFTx6BMPoj9bHXXeTRl
         Oo4hZn6/mYRUUakf5XqSTNkwz3F3ekRe2VAJ/OHWM1ABgwU9p2VUTbPg7KuMazT6xiKt
         zqibPDFN4x2le4TxXTouLVixw/QAD3eqwdUNZN7yjCvcfmBpioYh24GIVoVFQj+l1cX7
         6AngIn4PLntNnFMLaSPaZkt0Qn7zgPRb2hDheMf4cDs/yCKqs1RsAiu/kO2IYKrYyL/q
         /OSWty7q38qVw+kJw5Sqymeg5RlF2mSi2b+hHFyGKKVrvbyr3p7JgEjDUSP5Dv+40NaA
         dg/g==
X-Gm-Message-State: AOJu0YxvX0vynbykSg8DToFEYBqp/pKb67d7ogG2JpqseGfEcwUZNVh4
	/Lxpz3kgXLSoptjEE2725JymTP4OBajCYJF48L6x+gREsU6dvg==
X-Google-Smtp-Source: AGHT+IEn0aTLPIhzkqJKFh5b+YUhuiHuo80Pltv6b0tdzXdfqLCeTsa6UCZ5FRtS49ixOGDjBQ4ubw==
X-Received: by 2002:a6b:f004:0:b0:7be:d855:4893 with SMTP id w4-20020a6bf004000000b007bed8554893mr386739ioc.2.1705003604769;
        Thu, 11 Jan 2024 12:06:44 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y2-20020a02ce82000000b0046d18e358b3sm503857jaq.63.2024.01.11.12.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 12:06:44 -0800 (PST)
Message-ID: <1d682398-9922-404b-ac50-2fb292793ddb@kernel.dk>
Date: Thu, 11 Jan 2024 13:06:43 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] blk-mq: ensure a q_usage_counter reference is held
 when splitting bios
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20240111135705.2155518-1-hch@lst.de>
 <20240111135705.2155518-3-hch@lst.de>
 <d713fe1b-3eaa-4de4-99a6-5910247ffad5@kernel.dk>
 <20240111161440.GA16626@lst.de>
 <d91cb6ee-50bd-4397-b82f-d34dfc135b4a@kernel.dk>
 <20240111171002.GA20150@lst.de>
 <8a2ab893-c4e1-4bc3-9c0a-556c62f8f921@kernel.dk>
 <20240111172438.GA22255@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240111172438.GA22255@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 10:24 AM, Christoph Hellwig wrote:
> On Thu, Jan 11, 2024 at 10:18:31AM -0700, Jens Axboe wrote:
>> This also highlights a potential inefficiency in the patch, as now we're
>> grabbing+dropping references when we don't need to. May not be a big
>> deal, but it's one of the things that cached requests got rid of. Though
>> I'm not quite sure how to refactor to get rid of that, as we'd need to
>> shuffle the splitting and request get for that.
>>
>> Could you take another look at the series with that in mind?
> 
> I thought about it, but it gets pretty ugly quickly.  bio_queue_enter
> needs to move back into blk_mq_submit_bio, and then we'd skip it
> initially if bio_may_exceed_limits is false, and then we later need
> to add it back.  (we'll probably also need to special case
> blk_queue_bounce as that setting could change to.  I wish we could
> finally kill that)

Something like this? Not super pretty with the duplication, but...
Should suffice for a fix, and then we can refactor it on top of that.
ioprio is inherited when cloning, so we don't need to do that post the
split.

For the bounce side, how would these settings change at runtime? Should
be set at init time and then never change. And agree would be so nice to
kill that code...

diff --git a/block/blk-mq.c b/block/blk-mq.c
index aa9a05fdd023..01134e845d8d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2945,12 +2945,6 @@ void blk_mq_submit_bio(struct bio *bio)
 	blk_status_t ret;
 
 	bio = blk_queue_bounce(bio, q);
-	if (bio_may_exceed_limits(bio, &q->limits)) {
-		bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
-		if (!bio)
-			return;
-	}
-
 	bio_set_ioprio(bio);
 
 	if (plug) {
@@ -2959,6 +2953,11 @@ void blk_mq_submit_bio(struct bio *bio)
 			rq = NULL;
 	}
 	if (rq) {
+		if (unlikely(bio_may_exceed_limits(bio, &q->limits))) {
+			bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
+			if (!bio)
+				return;
+		}
 		if (!bio_integrity_prep(bio))
 			return;
 		if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
@@ -2969,6 +2968,11 @@ void blk_mq_submit_bio(struct bio *bio)
 	} else {
 		if (unlikely(bio_queue_enter(bio)))
 			return;
+		if (unlikely(bio_may_exceed_limits(bio, &q->limits))) {
+			bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
+			if (!bio)
+				goto fail;
+		}
 		if (!bio_integrity_prep(bio))
 			goto fail;
 	}

-- 
Jens Axboe

