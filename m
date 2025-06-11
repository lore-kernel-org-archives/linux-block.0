Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB33528137F
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645803; cv=none; b=RkfRH9qdKDxTAAhhYYk1saw7VUUnF0VNq6b/Gm1pbHEtpN4SUh2xrOuSZtiX11yQ4BLBVPLR3rzvUpm2jiAuB8x5Hq77hvvPaSEtJSy84K6tc39rrghf2Q+sq+F1bkzLJ7Poo6mNLb9MfzNEbmyVGZN81yy62SyqgzDDcMd/Oec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645803; c=relaxed/simple;
	bh=o8xNFzC0DxRG1eAunhW0prT+24qgZ091n32hbtWX9Rw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qFUJqpXc4f2PE58sRgddEap1ip1IGJAmcOMcRx1pzKzDN8Pu0eBv4Om3eF7TUMbY+8OPuuYbti8GCeyaOEedPiXxlL/vBee4fKPkTgXKB5thIqvMXesYCo++DVceZ3fvcX6YSrndKB1fpv5wRdgbmHSh8gqy6AD7MzS/AKhy84Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=17wG05gP; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="17wG05gP"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-861d7a09c88so190591339f.2
        for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 05:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749645800; x=1750250600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgA0CIKoQ7HJrt8cATG9Wf1LVblq6WZfWDSVNDeZAyk=;
        b=17wG05gPE6FuwyHA3pA/Kb4V80CQGfgNkQcQNID4M8PPz2KTjcih2eDXvCV2I1WkQn
         mMCG3w5KCveqVPYO786faDESOfDauJVnPDEmSEtIHUa6WprzmK1npwdUZWnMh/iT3o5D
         bPlFIOeGWMRMFudXccCWHRW71LCtr4ioJ09sWwJg7qls5tsd490nRLPWv19/Ftc5iyiJ
         uNfYrpwK0nNRR+W1tU3We6u6nB/mAr4QrBwkW3nI4Og7F/WfX8lAB0CLpr54NLhyozPC
         DhOTeDLkNdftdUpxQiap1Xl726e1jxRid6TjNTttlD2dnhY1mxtPr01HBfKX9XZ+RtTD
         kUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749645800; x=1750250600;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgA0CIKoQ7HJrt8cATG9Wf1LVblq6WZfWDSVNDeZAyk=;
        b=RYnUv5HS3bxvj2kloKG8vTxsTBraloQu+V+XqO6pfgQzgXoil/BzQ7AxuA1AlLp1B8
         e+xJe2DPlNxT/Ujm7AOeH4HmFAU4B3oICSO7UMpYF8qs+oXlYjTuwKy9es8y7pTYCG6D
         3+3u3IvJvHmRV8w9cSWqDgGQctjNJw6gsOdrJfZjlq6XirNx3sfLWF2je0VzGrmrSxwb
         PYAoGCsuN0n+3UfGG/NERAEjj57JxlwLvvn3Npq99J+IAFaFY0GgTgb1UPJ2HLAXqQRO
         Xu/go4LMLBNUNeA4tVd+hxz9brpuFwDEQkJ3AsHQSIHkQVBVXJ7oNyGqxq5/sbOy4Pmh
         ZErw==
X-Gm-Message-State: AOJu0YzkW4E6remM7dfUAkXHgeQAuWb14Dq2sLKa4cZsR3LYs/eAJwRF
	XndpWSlHCWv6oTRUz5QBmBO/31BTFDlSNy7Ggf2Kq2bRn5kY0jB52Tai0ePjPkjlhEmy3dSldKS
	ZUwi6
X-Gm-Gg: ASbGncs8BjVLUPPmW36EzvkJQ+YhTX4YKzzO+SomnOaIBBhdARlYuz0YXAY/T6hh6Y7
	RxU3JFO7Y2KZzFxPyzGzfBdvmLhPkilLBr00Bz3kTddU+28tVSQOOvjXobhbEilgUvegW6svpFm
	WVXmuztaV1xVdXlweks3cHfhpgwkYMM74He0xXToxnJyNsdrpxfvSFKrI0ExxZUtV9b+1S92A9/
	I0Nf26ihSKMzB0/mbw2yPlkAZzXmIQEkmnxqQcqGj+R8/bel4KaGBjwV0M6+Z+tXG3BNwFTUxrE
	IrTeG7WZIwY6EVw45gU9dND5ZetDZkiaLHhR9OelT6IUNqbVA0JyIQ==
X-Google-Smtp-Source: AGHT+IHiOVYrFqWZcmvZkhB5s2rQX0dzB9+fwhDhtcJqM0ftdjLlLq1TrBmo35pADwKc/QtFp5DGNQ==
X-Received: by 2002:a05:6602:3a15:b0:864:48ec:c312 with SMTP id ca18e2360f4ac-875bcc0a054mr364354139f.3.1749645800474;
        Wed, 11 Jun 2025 05:43:20 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-875bc585b5asm39495339f.9.2025.06.11.05.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 05:43:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250611044416.2351850-1-hch@lst.de>
References: <20250611044416.2351850-1-hch@lst.de>
Subject: Re: [PATCH] block: don't use submit_bio_noacct_nocheck in
 blk_zone_wplug_bio_work
Message-Id: <174964579922.357731.17911835098022083800.b4-ty@kernel.dk>
Date: Wed, 11 Jun 2025 06:43:19 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 11 Jun 2025 06:44:16 +0200, Christoph Hellwig wrote:
> Bios queued up in the zone write plug have already gone through all all
> preparation in the submit_bio path, including the freeze protection.
> 
> Submitting them through submit_bio_noacct_nocheck duplicates the work
> and can can cause deadlocks when freezing a queue with pending bio
> write plugs.
> 
> [...]

Applied, thanks!

[1/1] block: don't use submit_bio_noacct_nocheck in blk_zone_wplug_bio_work
      commit: cf625013d8741c01407bbb4a60c111b61b9fa69d

Best regards,
-- 
Jens Axboe



