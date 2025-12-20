Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CAC2222C0
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766220377; cv=none; b=lO+3i+/STsW13Mq3CDDZd2qDz2WHcFkLO7r+AuJHyinA9MFkZJSoavXaT+fl93e3G5QbURGGsayBUifS4HPBUhBpeNfcB6uFnPgZPDnoCka+HzpcIGr1mamybFiyc2bPAR8mIw8Aod1yrZnBWVvZdxGd9/LdfsjcgH3JhTkd4Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766220377; c=relaxed/simple;
	bh=GJz0TV3dGwznk2pjw9vchjZ3oHpNifJ97zBYxc0cjic=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ejTwZUqP/rQagCqSLC/ypg5VjVRBhtYjAnbyJqbjGcqfF5qcTxE+G5Tbu0B11i+pFHcgN2EFEmIv26/oNphppe7yo1U1FMV9XZPdzzmhVTWejM4N4b7S3v5EwEG/W0OIzhjYr20X+pWA7I/P6gouIon1jqJ7mU5JB1gKRYzGbwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rI2mq1wY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rI2mq1wY"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477770019e4so21811065e9.3
        for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 00:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766220374; x=1766825174; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMd8hFhEdud5JNvQYdjzkL/DFZ3OGk2JIW+0oeUQ8pU=;
        b=rI2mq1wYV33LL/hVOGnUHEdqMy7FE74tJZZYDESVmV3uFFvgFyfcULvds93LXHmz0G
         fDPbn1/7LBHefYErleS8drDAR9+NLjt/XLP5/vsmpkyXuH8BVnX6kU6D2ErLgFMgMnmw
         4LpN5bDE2eUlTWuHvGw1cRRJX8p547rJNvHpsdnnIuDt+8044iaN1BFyr+HBOPGjaoCV
         iHTJMxSnFU1KPN2reyUN/jA/mujx6GYseQi/B8vKZjQw7Quilb/VCiDXwCX1lhYhkziX
         qeyX8Reb+FLA9d1T+FnnVLc38HvoCxjCR10xpZre6/DH0vG7717ThmL0FmpFMA/1Wqqt
         h9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766220374; x=1766825174;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMd8hFhEdud5JNvQYdjzkL/DFZ3OGk2JIW+0oeUQ8pU=;
        b=A1VsIQy2nAt+skdTzfAhlcuLW4FeM4AcoS4WF9fvKbL1PbjkjPQEOG1Z/YWYI+aoZv
         Z1fKYJm3dtWiZqXYXLLsPCbI/8FzANZC1dyb4xG6EnPkkUVHHTT5/llafVhmDL/K4h93
         tJTFMg/akLnKyNaHdaB6GsgI5AjMzxoxikCwE1F4sjAmlOK15tK4Zs8bom+uxY6ux4WW
         2rtNv8I6j4JWiX5RzQfDS/d6knsuuaF6Ovo1NBtzOnmor1kUFMj0krIrIct4REi7dCp1
         aQP3HSVsFP6VA5eFh/vs+c+Lm7PPtzD5yZHEF5FXf+DrY4lZKd8buSnlBqUw5BRX8g6V
         JLyw==
X-Forwarded-Encrypted: i=1; AJvYcCXfma214mQ3MpVYvJeZQqPI2UCpiFT1iKllL2D5hNDdAgmO2i80dJMJsDjocp2E4s2Y03VO0nMPdCOviQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0J2VZL+hXDt0sT9EhbEdrnV9s8sccfRLtofjvkr/AsYxN2CfM
	pJlDMb1tBUEPuXBNVGt1ITk6X6uUEjCxJSX2/a4DwgaObRfbdqdi2yLDaNB9OTh9lqY=
X-Gm-Gg: AY/fxX6m9ziQYPDXRgl0Bme2hYAO1eQJeMoHc5AqRCJEWN/uvpKWK9j1ulg0ZqAcSRC
	sPfsWmbGoMgCx0fZO+9RFIs3+3/+Uc4IMVbz29n08oM7cFltbYPx+rOgoEbDyu2zNo5/EWE+Zex
	e9OPNLAq5V5hoBqniliIQ+fjEREiVBJ8TxpMf8XYR0/uCFaohs+LcXTd8r2gfgW1ogQVOWeLCaV
	J/EBkDzlbrcHdVenHsYhF43DmUDnLIsLRbpc2+7SEVZVIH9CZyGLyD746Xfkwk13irLYgVnLZlm
	JkzkYnFuT/DiYwbH+ikHrPNFCIoxxCNAyQ5OLP7jV+X3XVXi9KmP2xzjlzNZyhHYUQY07SJNxyy
	bwVDwqbTmPAgo3QbbbRXdPTsmlhMfZ48PuoagUnzx7i9RiUVcwvp012uYaHs9giFXpNWJnxkzOr
	4v+0x0J8qejS+eIB5R
X-Google-Smtp-Source: AGHT+IGRYugwrsODSO161b7aXZ0dgJ/paBxDcbXlBkrr1+MKuen7cVrZowP77Fgt7jWv7lc6dZre1g==
X-Received: by 2002:a05:600c:1d1d:b0:477:9eb8:97d2 with SMTP id 5b1f17b1804b1-47d1953b8acmr52521985e9.8.1766220373854;
        Sat, 20 Dec 2025 00:46:13 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19346e48sm79604965e9.2.2025.12.20.00.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 00:46:13 -0800 (PST)
Date: Sat, 20 Dec 2025 11:46:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] block: rnbd-clt: Fix signedness bug in init_dev()
Message-ID: <aUZiUjcgaOue4j9S@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "dev->clt_device_id" variable is set using ida_alloc_max() which
returns an int and in particular it returns negative error codes.
Change the type from u32 to int to fix the error checking.

Fixes: c9b5645fd8ca ("block: rnbd-clt: Fix leaked ID in init_dev()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/block/rnbd/rnbd-clt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
index a48e040abe63..fbc1ed766025 100644
--- a/drivers/block/rnbd/rnbd-clt.h
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -112,7 +112,7 @@ struct rnbd_clt_dev {
 	struct rnbd_queue	*hw_queues;
 	u32			device_id;
 	/* local Idr index - used to track minor number allocations. */
-	u32			clt_device_id;
+	int			clt_device_id;
 	struct mutex		lock;
 	enum rnbd_clt_dev_state	dev_state;
 	refcount_t		refcount;
-- 
2.51.0

