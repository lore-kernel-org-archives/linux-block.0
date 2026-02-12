Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322923451C1
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770895627; cv=none; b=sOueYj8wjFwjnxcksxi+sZe2+sSAfT1EKgCPRTDoK4LAnNKDd3goNhj+xrfkDNqMfYqv6FO7HyuI0Es/FQ7q8jj7ToexLMnJxI6S5gtNZKMFFtfvexQYrQMOzpOPrGLb/IjNaDAcr2zsfl+ycij7beSMZwK+co2guROSK20ecHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770895627; c=relaxed/simple;
	bh=aVKhTR5XhLZI6aTjd89DHSMnmnyhbfHIX5ecRrNkkcQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tFUN7qyRXCWAYHe1sNIHVYup1/mKAosRR/aRX+FJ2Ck+Eki4wqsW2qaiJ6D4/oQa97J56iYOcNOrAn8OaIjY6e5Y3aH5YG8cv1DQZIiQRNbNAPWKZQt7rG0Y6QJl8ATTTbCdibvyBYE79iY1jTrGNXOMihNDfQBDljeVBjRQijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WPqHdssh; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WPqHdssh"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40429b1d8baso2588505fac.0
        for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 03:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770895625; x=1771500425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCldroI7429Qp90gcUTtFsnAvy8jQqFz5POUC1/x6i8=;
        b=WPqHdsshOW46gzVxYqMEMDDTluwXKSqC6bH8UJmvL1D3EkIuJIan6+kjJCqzM6hrAR
         cvKQITqowRENi3lTbz10VCXq08uEWoMIJzYIAauBJ1ZP+SqDVoqQHXhiCzauZvfOKKcG
         YMTHwwumURO+ZHtNSvmISMW82XvcfqsJT7PilHa4gy2jdQloMbUMql7nXGfqmUroRGLk
         N+haU2ck3QNphIskFdXDJb71s6UX66eYVlqONSqJaxGdF9BHqdxXFMjz8Gsh0sW3YNc4
         poqC1oeHeSzU/cOdsddXLtGqVSwBMOSPKJCn4/A5JeF7lxc+LoPjJJt5Pp79dfv8/SUu
         mlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770895625; x=1771500425;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wCldroI7429Qp90gcUTtFsnAvy8jQqFz5POUC1/x6i8=;
        b=P9cnew0RcuucOLfino02NpF22ibTSWeXVhv78XEZRLOep4T26cFRKDB0tR67cCfS28
         i44dEgJVIYaA5AL7WqqVYzadj77AqS/fJ4cRZCmGz0SQTkTclSIhXZE19y72ZH79BVbF
         2cooQyG6YOXytHJ595wru4dQDN8LJYBW68zxLf0k3Rx3S8+1JspL911R5XE65bT7NqL0
         hbyv3mn+d+aPMOdGSiBdsJ+K4zeY6iEGq4gbpdS8NlX+HtzjLVG9Pl09CUGbqrRYp14M
         2NlnpzIVTQavrTUeCgsRvMY6NC9OCInIT9WJb1Gx7vUKdFncfYBkGn+GYUh2dlRq47dY
         bvVg==
X-Forwarded-Encrypted: i=1; AJvYcCUwo/lds/z4yRdenJstvFCDdc69p103cAZkYAe0wERMeHerWVrjjYDEX4A8zWnKiMBJoGSuOwYUIWJswA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdmvvsOHwzG/tiytPB367hllptupnjCxHcQWcnzP4vNZ3W9QDy
	Vfd5i2vkoSXfrHmICdu5UprsxxCUmKfhSNABGDD3Fno2dGLBIzG9mGu+RvvWy/ZvhDk=
X-Gm-Gg: AZuq6aK5TzdeWE7pzqVER29r3v+qEjBk9wiXltVf813gYqveHN3qKEBwYnrq/qO9V+J
	V/feqMU5vxp3+RbhjD4H11C249USH3WJk4wasnqXmTlvUZDQQ02StyWAUdTBQM/bWHC4tN+L6p/
	a9KfDLLEjmzWPxT468r/DhnvYdmvinBDVcrDLHl036ToGvN2Cz+hvEih3fLXRtYg6Sbe3jKorb1
	8RuROf/9brari4u3dU2xJ464damyM28jILkwfLipCCZjPiRyypq12uy2Z9xVLrMJw9MX6eEixWK
	CR5GCJFgqkiKrS5pTIIKRTl79fDHnfnnTXVeo/+m69VZatKNeBVA4nrSwPfBYSJIWirTdB03JUt
	LhMG0K9K4jgRky3Rwy7icHiOiF1B4xn4gWtkxCQrxHuXpv2t49/Tv1UdPqrVfxEPwFMfN2WP9yE
	+VjHoVBd30sHPD0Ceed52ixriJ0acJlnI+ePJP3m7Y40kgXMA/S8qv1SXK6OxvltciebtgeEZaG
	Z+g
X-Received: by 2002:a4a:ee84:0:b0:673:e6c4:749f with SMTP id 006d021491bc7-6759bf89abamr817782eaf.76.1770895625029;
        Thu, 12 Feb 2026 03:27:05 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6747293e4c2sm2232685eaf.2.2026.02.12.03.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 03:27:04 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linan122@huawei.com, song@kernel.org, yukuai@fnnas.com, hch@lst.de, 
 sagi@grimberg.me, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-block@vger.kernel.org
In-Reply-To: <20260211204438.22568-1-kch@nvidia.com>
References: <20260211204438.22568-1-kch@nvidia.com>
Subject: Re: [PATCH V4 0/3] block: ignore discard return value
Message-Id: <177089562347.419890.12862098263545903682.b4-ty@kernel.dk>
Date: Thu, 12 Feb 2026 04:27:03 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 11 Feb 2026 12:44:35 -0800, Chaitanya Kulkarni wrote:
> This version has remaining patches from the original series to change
> __blkdev_issue_discard() return type from int to void.
> 
> First two patches make md and nvmet drivers ignore the return value of
> __blkdev_issue_discard() call and last patch changes the actual function
> return type from int to void.
> 
> [...]

Applied, thanks!

[1/3] md: ignore discard return value
      commit: 699fcfb6cb80a9df67fd2086a1c930d196d709f2
[2/3] nvmet: ignore discard return value
      commit: 38d12f15c4772b5383b1249b2afb0d206a430f0f
[3/3] block: change return type to void
      commit: 453daece381e60df20da16c49ccc6a9bc5c6515a

Best regards,
-- 
Jens Axboe



