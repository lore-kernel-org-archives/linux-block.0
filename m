Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259852E8DE5
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770894613; cv=none; b=B9FJ2A5L4jqHXLEt5ZfXYUb/4EmxDsGMHwWiVhff5AUxlxcqCO9PqbrtJNYM6qPMfQqTxI/IucbVuUmoIJwT2HxI9hOPYc6yKtSCYIJ8ipGPfFSuUBeqebnUgGTiI+H7S0jpwt7WvsSTgRiGVSCdjoqgoV2h9xKgF7TykKdxRNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770894613; c=relaxed/simple;
	bh=6a6EbYVe0NWS6vIKsUPGVkejgXfcbHHWblbh/BiAimk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=jUXZN6mWAVN2qDzSuvG2ZDJEvYruzKmALDWxi0UM4RmqrBysERwKwIqdT4LvEWg6XBPe7XhB8JUOqDuUsSeH/QXoE6zW6o6ZJ0nIk7u6xWh6pvhkU3XTANuvBFjr3jlAUSS+5IHP5iuX5qvsoaiJUiOZfx5U/zSN+nbkGWFzn+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BIhr2peI; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BIhr2peI"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d196a2334fso1667533a34.1
        for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 03:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770894611; x=1771499411; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gDa6YfyR7b2uyUcAIbDV88v1q/b3R33AK4WucWuNyU=;
        b=BIhr2peIOrmyMBH7m5GX8gC5ilNgTOhQ9V5g88mM6pkDNBR7epy+9FiPcaDeCZ3qw0
         yUFaI+2YRQeSYV90IRb+q89FBdRpYCfsBRRR6qe9jKyxw96I42JwTlXPQZ3IXC6HQrjJ
         a15xhqrIh9kQketVjatSfhH8ExpqfTnR9OHNxZjoz3+oDAU9f+dC66KGb2WVPYQzq8LQ
         qUp1bx5//Cec293Lmq0UUB5kngxKquaFg3ieYNEejedjGj0aUc8hLAoWapCaCxYFfpS/
         qlXFCAo5ALlbECzxin+ZAHygxhAQJD8aU/7R4oT5LX6ILLd6C8JII7pO+uDTXQcccM05
         L+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770894611; x=1771499411;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+gDa6YfyR7b2uyUcAIbDV88v1q/b3R33AK4WucWuNyU=;
        b=Yl1xzl26WXWi58qnbHjBFNx2bWDOGX8s8J4+nAlyzMNOqtnLa2QwRBcGRd0YXigTWx
         b8RLWTlNlXXRBwfSTSItQrABGNsz0+2BlfoyqGZr+2m+LZwZ0UJCCzj9ZcGeE+snauGL
         WCS+3ayua+JP9FmACcmooXw07aLDbsjQZ7jhxmaQUCbV+EF5EXt91/rBHaSqntD1mnIQ
         8Yemk/+5nv2oVDaMu3CkHM3cEDNumKa+WmbNusQS8Au7z6bn7vxw7nPBj3sc6cLoB8oY
         J26fpP2IhxJOSqTpKwsucvgGKV/6aBTHYMAGs5ngmLyO5jPYpvu6wB6LyrgAAff//IFk
         w00w==
X-Forwarded-Encrypted: i=1; AJvYcCVs2XQ7gubhEqxifzJol0IO6Xd2vIqg80FCHFmWrf6aec0mcpnr8nPOAP6LceW6zcfo8FTgcXChh5mC0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7WeV0W/kL52t3MJCw0qPrE/xFBz5fxnkjKoIplqNffdCszmp
	UaiEQqo34Qt2jWcM7yXf3vNfm9MG9poGCM4uKmscJ9s+b4r6TBNW4OF/UQ1qylZwLwJwlySnigB
	00TQusac=
X-Gm-Gg: AZuq6aL6m1xdcUvO3kRDA45SaF4VXgSogu6iundEHuJMgmW7VkfC5/VAe3P3+qiKcZe
	AYW+ISRTFdjTd3JONRTbfYn/acFiexJXOwj99h32e/Vcws3Mj90bfGNII8sBOvJwAWpKux/gKV3
	whN5zOFcr7VF3fmzQW73RzmTU8XFTxse3U3oWiiPREBdQPvGHrEdumxEJpl/XnLPofLcnyMXrZ6
	9rohmB+uhDS+E9GDqNuG8SEXLa4kZ0r7IXxlmcFVCg4bMMklEQPuM4nek8hrFDx1y65/nDJVNxv
	GbYiYt2MqPctfDM5+co43lh9tjavmyltWMEBAtVcjviQc7D3PH8bG9fgOsNCXUhd4YzOmxiiyPU
	SKmQOTOhVxF1gTaxI746P3Y8+gZKS3FgznEZS2jPpKJTgvBg303j3/8p6GoJg7rPRYkSJjVntIA
	AVnqV980rueOBmwXfCnTKoy1/eRGxsN47756YYAJNlnPZZvc+R5ZT6m9NnbQmBcpoT7+5bAW1Gp
	1t/st4NrA==
X-Received: by 2002:a05:6830:3113:b0:7cf:d2d4:8013 with SMTP id 46e09a7af769-7d4b3178738mr1130010a34.5.1770894611072;
        Thu, 12 Feb 2026 03:10:11 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a7547ac1sm3305031a34.7.2026.02.12.03.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 03:10:10 -0800 (PST)
Message-ID: <ed27f009-4607-47f4-9d72-ccfc1b1e5de3@kernel.dk>
Date: Thu, 12 Feb 2026 04:10:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: fix folio leak in bio_iov_iter_bounce_read()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

If iov_iter_extract_bvecs() returns an error or zero bytes extracted,
then the folio allocated is leaked on return. Ensure it's put before
returning.

Fixes: 8dd5e7c75d7b ("block: add helpers to bounce buffer an iov_iter into bios")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/bio.c b/block/bio.c
index b291b9aaeee1..8203bb7455a9 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1382,8 +1382,10 @@ static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter)
 		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec + 1, len,
 				&bio->bi_vcnt, bio->bi_max_vecs - 1, 0);
 		if (ret <= 0) {
-			if (!bio->bi_vcnt)
+			if (!bio->bi_vcnt) {
+				folio_put(folio);
 				return ret;
+			}
 			break;
 		}
 		len -= ret;

-- 
Jens Axboe

