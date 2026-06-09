Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B863446C0
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020938; cv=none; b=OFIEu3GKlWg80d1wKHhsLlk4zXBcmvjCSq/lmVaD8/4ClHa7YDrFxNeoH6dQO1XBwWb+++Qs0OJemT/v8mYXKPMjuvbJS2LXcRQBqoJstaiyUVPoJxuw9CPYSMoE3oW2w+3KZhu1Obe8vm8EQU9C7U75QfusCQtkO/5JBV/TDVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020938; c=relaxed/simple;
	bh=yxr+nqFvE05ybrHpLzEUCDLnrFxx9XA8szYp/Y/bI/4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EaJBM+pCAEsQVO2LdIQavLeTECFU2sojYx3QA2eIRFn9j8o9bPlWfdCUa4z5C+SpxDsCG99mbxsBGON6cnefG/6AdTuMl12Y8Xmp/ahoxLenBO0keAWSeJiTdpUGuRJLOPEAg9NgvfAjM5nbPyu7zjyIMnPOeXxi1F8u7OldFeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=U+aYV/rx; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="U+aYV/rx"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-43d23173511so3803338fac.0
        for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781020936; x=1781625736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wne9u11eEr8I97omWkO8Al7ip6I2l2rLAsMnhcuURVw=;
        b=U+aYV/rxDkGbuo9EyZTAJDFYC8OfmJI1H9yJCcvqpYs1mYXmiEo4lTq2qIZmbtSaCI
         ReIkWmrSiqqQCLtBzkBGPIQHf6hKwoxfHcZh+B0iNM6v9D6AzxVZBHR3VsmVTTR1uGy0
         mZ1sYNKTunAuB2Og47+ayxrvIeEjLKO7ctmQ7a7vDsYASXM2rdOwpoxr9/Kkn66bUjGe
         bW7zUFOTnK1iS0NuwkQBsNA1TEQLTwNeZTWx9+rf0gEviT9+UxiKv4rCckNjghNK/R94
         NAUBvy78gzijI1LnrzsfmVqZq5otJBtyBX4krjGAB5T1dtG2jxBRxLxFi91ppFBLEJQT
         KeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781020936; x=1781625736;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wne9u11eEr8I97omWkO8Al7ip6I2l2rLAsMnhcuURVw=;
        b=g1c5t9cfFIoj3TZolT9WNs7hAu8acxT1l58ZoNiJkfTfqGvSMbPyKTzlrc20iYM5d/
         E8CLt8dnRRQ2JZOWhPTtZ+mmsQOlI3YFAezsgo2kGhKK9bJGZOPIIApQAd5MgHSuJchp
         NUf9/LjRGfTQwRfIp4yaqKLDGTEke858bWywtFI9sle5uOjFn3WlGdTX0E6j5nFM0ZSX
         gegf7gebTBCE4uXeBPjGGeVBbU854XMGHUdDdrImXW1KEueFMNQ/+NSt/uoeNQ7tFFH/
         qi6EkPhxgqtkh7L3WFNUWoQ2+CMAMH8RlF145/z+FphTzHyEr5pn136wjkXMpdZNWV3E
         W1OQ==
X-Forwarded-Encrypted: i=1; AFNElJ9J4P7NfEPprGR9aRyn5CdKZnIg+Grt0XuLwZodlEkXYtMM18qLpoXwoCAMyHGb8JY5r0y6I5XXxS82jQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXRhmwv5O4OydRsqC+BWOFpPtlDSyfGBOjledw3HRRWLy8FB7X
	8aiw1LU9xdkEApPhwqFTtlhT5MiN+HIXP6L3Dm2yBG0ICydjEncgVZb6kO78Yw/BrLQ+kh/yHRg
	oCDj5
X-Gm-Gg: Acq92OEqGbf2cXHlJi7j9C4PtnDUR/ktEcqXd7WANvw4S4BsZr8RMVc9K2GTiJ8yevC
	QSlUULUOrinM8bTk3rbjTi9fGPYj2F9Z7USbqcDOWnvcu4hxZ0TZp/I7RLihVvB0k1A8lK3Safv
	lCcGcq5HBz5V+rAC8hS0966pjaKez2gb196K6n61HTIPcwiPDgV0Bnvt/QC/MzBdKz4JFWrJ+xb
	3PmIx3BrrAQe7Ry2nk9WkNg8rtA47qfOkgM0lkr8JIncBmhqMYdK31BkAVMGg8DKv6cjW2U+Jqv
	by7Lnx0BnIxQo2mzSCj1YoBDQDxEaudZdpHqSJne3GzBZSMDbZgHBJDWKrnjCYOXDH3m9TS73fI
	mVfIsKxaJ7aZCHRY+1qsbNC3hdRrInm0YKodg4JqSuvmHU+ZlTFwBOSZgSLvYYcMsddTzEjd8KO
	G8mxjTaYB6iUQRTdDaUhcO3j4x1f+vz7963onXEzjgq8DkVEAAp8grcgt9+lkf3g1QC9WJW30EC
	09bOo1UIvU6Og==
X-Received: by 2002:a05:6870:d8c6:b0:439:c2da:7dd2 with SMTP id 586e51a60fabf-441ed982165mr2157518fac.31.1781020933776;
        Tue, 09 Jun 2026 09:02:13 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8465e00sm16161761fac.15.2026.06.09.09.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:02:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Michael S . Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Michael Bommarito <michael.bommarito@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260607124834.3059944-1-michael.bommarito@gmail.com>
References: <20260607124834.3059944-1-michael.bommarito@gmail.com>
Subject: Re: [PATCH v2] virtio-blk: clamp zone report to the report buffer
 capacity
Message-Id: <178102093279.1199099.8171367690352183837.b4-ty@b4>
Date: Tue, 09 Jun 2026 10:02:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 07 Jun 2026 08:48:34 -0400, Michael Bommarito wrote:
> virtblk_report_zones() trusts the device-reported number of zones when
> walking the report buffer:
> 
> 	nz = min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),
> 		   nr_zones);
> 	...
> 	for (i = 0; i < nz && zone_idx < nr_zones; i++) {
> 		ret = virtblk_parse_zone(vblk, &report->zones[i], ...);
> 
> [...]

Applied, thanks!

[1/1] virtio-blk: clamp zone report to the report buffer capacity
      commit: 0fd835f5e9477ebea2439b8ada58f34e1b8cf25a

Best regards,
-- 
Jens Axboe



