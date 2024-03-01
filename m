Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C4270CAA
	for <linux-block@vger.kernel.org>; Fri,  1 Mar 2024 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308547; cv=none; b=ZPkaPxctcuQbwa52V1FzboMQ4JROkHTVRcGfSy79LsOw5h24ureAC32O5FIsKDEAQyHmrYuKANg+41VolYo+DaW4BDCjLJw5eVtR8goPjyFtB9uAER8JBrzzV+nDH1/Mr10VwNGpvHYYztQS9qPOQFPi13wds7J+SV5yqsiIF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308547; c=relaxed/simple;
	bh=z8bQj4nyX9I35XGiew42GRrnNPiJWRmDuZYCF6ZKJPY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j4vLnIqHViVAQjTSqrqlAA5eSr6AUNOwALW7p+3pnIe8VBCqMlWzsi54gU4GdMfnupN6MVlFrskgFC7yCPDSX9eM6rKv2vX/XO4vO3vxCDDkztZLmDkUpMWdIC/N7O5ziVbZM7f537sUJybcArzcFaRH1G6qqA93sULHPt7Ap8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JtaWHXih; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JtaWHXih"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c82d2bdc31so1689239f.0
        for <linux-block@vger.kernel.org>; Fri, 01 Mar 2024 07:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709308544; x=1709913344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgjI9uub3d3zJshf48T+jDOY7FDzlEqVwK3scHxIK08=;
        b=JtaWHXihHYfoIXRDTLSMAIftqhBs9BB3ENmnPhoPWQnVMez9mVuWwM6fYszQ4IKliA
         a2c1NHDisRRx9yYYosqFIt1iWdhiqvDXP8fZI6EVvMsPD28BlFPOO2rCxie1P+ZQ8daa
         WTyRXf6srnpIEXGDYUK1kTpvscftM1l/r/W1iZarKwSJKstvyKl4vDbEcLKE+AwIN1q1
         T9DuboVr0KVPVWyM+B25wC4pRYGUAe1psSqtOj6/EAoel37cnN1IrjSuGyGWCnVzkHYg
         GX36xDzFb7+dBrfnIczxR6I/7/4s2Q9tJuIU0PvrQss+4cWqy71c3yH0A5qeWuDwvpIm
         d9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709308544; x=1709913344;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgjI9uub3d3zJshf48T+jDOY7FDzlEqVwK3scHxIK08=;
        b=sGme0Ec+ZtzLLV0YBUg8vSVIawIypNq2hYmh5rc5cbFPfEPkia/wUWlOr6RtGsxPf+
         HHaBABOhRwJHo586gjbgJqkEsMY3xpoKNpsQHTEdoAfNja4TrvU4vWm5zaMUW/YIsU0h
         PcFJUNUD/9Kl2DSmawZ/O+wp3hvUJophkfYKOuWxQzwTauVLNLeSv4CXpZV2FFXJQuVJ
         dIkWzNKuc2ZQlqJcVK19kBfPaBGOrRX9ofub4U1JMqDpDpSYTorBMKrTHUet47wLI82y
         ksaHtW3Y03tAnS3Ucd7dyA+Ebd9Z5GentQiaTlcw9sZKMEh5/FjSnCnS4/H+VU+d2GSK
         b6VQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7uPf3zWY3wU2PLfvnqrXjuiq6pNdPfgPrGCbHHXfn5zhxUaw46ZcbhN136oHLQarY+gbF+I45p2SWiKm6L/elBA9M/AZdtXGeNz0=
X-Gm-Message-State: AOJu0YzxyBDkSuseYc7bdTzzBVvcjZWiR2nkEOGe44YRkQ0ephUMQ1hb
	Ow8BamMwzhZpWo4LOhAy8wB3pwwxIIUVDeh2rEhnNbjdAtepDTWHkMJ7CTEq59J8p2+WlaRmhbx
	T
X-Google-Smtp-Source: AGHT+IGSixrXiLDrWM02T9EQx2sINQe1SZ1K5RuRsjIz22eppz96SZfKq161wqvSZyqsqoDy96ZtOw==
X-Received: by 2002:a6b:6615:0:b0:7c8:1ede:72ea with SMTP id a21-20020a6b6615000000b007c81ede72eamr2022129ioc.0.1709308544451;
        Fri, 01 Mar 2024 07:55:44 -0800 (PST)
Received: from [127.0.0.1] ([99.196.129.26])
        by smtp.gmail.com with ESMTPSA id b4-20020a02c984000000b004745e754b73sm894609jap.176.2024.03.01.07.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:55:43 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>, 
 Yu Kuai <yukuai3@huawei.com>, Christoph Hellwig <hch@lst.de>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-raid@vger.kernel.org
In-Reply-To: <20240228225653.947152-1-hch@lst.de>
References: <20240228225653.947152-1-hch@lst.de>
Subject: Re: (subset) atomic queue limit updates for stackable devices v3
Message-Id: <170930853640.1084422.8284935730781819597.b4-ty@kernel.dk>
Date: Fri, 01 Mar 2024 08:55:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 28 Feb 2024 14:56:39 -0800, Christoph Hellwig wrote:
> this series adds new helpers for the atomic queue limit update
> functionality and then switches dm and md over to it.  The dm switch is
> pretty trivial as it was basically implementing the model by hand
> already, md is a bit more work.
> 
> I've run the mdadm testsuite, and it has the same (rather large) number
> of failures as the baseline, and the lvm2 test suite goes as far as
> the baseline before handing in __md_stop_writes.
> 
> [...]

Applied, thanks!

[01/14] block: add a queue_limits_set helper
        commit: 631d4efb8009df64deae8c1382b8cf43879a4e22
[02/14] block: add a queue_limits_stack_bdev helper
        commit: c1373f1cf452e4c7553a9d3bc05d87ec15c4f85f
[03/14] dm: use queue_limits_set
        commit: 8e0ef412869430d114158fc3b9b1fb111e247bd3

Best regards,
-- 
Jens Axboe



