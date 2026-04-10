Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056B21EF39E
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826274; cv=none; b=L7vDrhEq5YcBt7idZfRJ84V/wow0/If+DX4Mb0Q7Cc/47oslgkfjq94Kpy1Ph17aWkxPdOxPjXFKi6aFSzmoD2zYrnpxIA8Kce1V4GOG/veir5FE7ItcR3CmAHP+KWk/2/grxcbhiMt0iXhaQZjksaOVbOYrxe88UhiRVb0BpD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826274; c=relaxed/simple;
	bh=4IiqkIGWNz72yHLJk/93c6fD9Z8AtJ7WrC3LWHw2gjM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KXHSpcbxhLTd4Pjzez5O0Vod1pY7Qqct2iNGX/jSKZZbs584D0KFECULZ4KDq9O6VE5CT99fzsLxZ9CGJK1Bg9zHvB53OJXLWdOCULY8aNRK6PzAxMRU8GDBsKsp7iyUqUw4AjOaYiqM4TLdmKJ6EZYal6S9E6zgdzcosqONo/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=fLdpoKnx; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="fLdpoKnx"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so4228528eec.1
        for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 06:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775826272; x=1776431072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYYeziDGTGiyHovB4RUa4IjAIQc0/ICrxZ5dnZlb1yg=;
        b=fLdpoKnxqK0N87d5VGwg8qdr2UwRp7Xi/eH/6CmU0+5nz0CUQEPiSjMshPg6BCMenR
         lncg7ZRPrVnnUife0Nvc17hwqyXl1GumkxXBoCwMAWY1XqkyRg48Z1WuXKrUOU4VOX6h
         bZmpRfFanLxiSw3Yii2quJ6F/BiBgc5R2R9/mtd/QmA21lSSraY68ltNzVm2ZDI/eAEI
         XthmCzhoJxFFDDMzVTPDK9yWiQLvX7AV4QIc9K9p1+3Tkty/Ph3WYMXWfyNNJkdTsrZN
         neCYindfp0Wknn0kncrATqoDGLU+GrDQk5/Bngf6cQX3JwZyDW/p51aXkcslpO+YJDEC
         e08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775826272; x=1776431072;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WYYeziDGTGiyHovB4RUa4IjAIQc0/ICrxZ5dnZlb1yg=;
        b=LlpHN/0KumLRO2uEXhJvBF8J/ZUC8kRfiC1yqccy01HXcd2X6q5bbZsA6o7Yy5jsVn
         5vDoDilWICZn34Vj7HzvSTfF/r7K/zBQKmKkZUl8LbUhsOae4unSaW/PkFaNYmCR3p3L
         73M9neyzeuOreFSwZBgixvm/dgZV/2+wYbBiGNOtMBn+1dwTBZF9VgfPqLnvwn9w9WiY
         GFvjAEbiz145zpcNyFub+FYIn0aY6ugCDTRbD2KiXVl8aseE6tRbLzDMfKnKFCZNGvlz
         fMurA95HOrBWM96z7e6uiSzqmIj0oLBllr8k3r/yqBFSumrV5ESn43IADyTuSxobUjZL
         JS9Q==
X-Gm-Message-State: AOJu0YxJpNFQaoXLn/CncyN+R6FB+1hKGKJwEr0I93k4YwhnuZlAi3W9
	Q9i6nkqw9FDAFnbf9U80rmr0DXX+YLppeH4Cb/qhDAvQBqDAjBhDDI8W7VyvKc3jJaQ=
X-Gm-Gg: AeBDietj7C3xpbL/9+AKAlRWdVJBDhXGuR2xx6fLbxlPZLq7VxhDLiflEzLXJc568Dw
	SlphAQfAYrtOv55XqlqBLelEjU8xz4pmt32x1id3XgKeNSyB+n2QyHbU6MpZb03CG9mAjy9fRDH
	hRhp8C6oqBtHRPCthCJx3wxC1nAsKW8MYJhzM/eXYX5brLWzvYLccc4gVOP9Dgm4piYrS6eo1lc
	NlRK5TGIRlKz/ic+XNB9ZmANdE99XSmPVK2LL4DeQPRXbLD9/7rzJKv5ulgVh/JDoKZoRt7muJK
	uQPezWyoV+UXUOXjLpFfjXeh1MhxSa4ufdGU/+Rb2tok1KaxKpfVAWBa3aqyBnDcQFHNi6vBoOR
	fkZIZg4mwly/mdTsXpwywDBjIeEEYW9/5Ye9KHwy/He60HotvXZXHzBoPwEJdlsGGEY3wrSdVAb
	DMbLbUa5LB+ivyvbGE88KOlipJIpRm+Doll/vDCOP4ODeWmYeYU8MZigfmDB/MtyIMopTE9dm7m
	b5fkDpNxeB4Ien4dZcof6KnpPSHFmVPw0hD
X-Received: by 2002:a05:693c:2b16:b0:2c8:72ff:bfb8 with SMTP id 5a478bee46e88-2d5843b9388mr2137101eec.0.1775826271952;
        Fri, 10 Apr 2026 06:04:31 -0700 (PDT)
Received: from [127.0.0.1] (239.sub-75-226-114.myvzw.com. [75.226.114.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa571csm4823872eec.10.2026.04.10.06.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 06:04:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20260410124136.3983429-1-tom.leiming@gmail.com>
References: <20260410124136.3983429-1-tom.leiming@gmail.com>
Subject: Re: [PATCH] ublk: fix tautological comparison warning in
 ublk_ctrl_reg_buf
Message-Id: <177582627068.500799.17335178348403719351.b4-ty@b4>
Date: Fri, 10 Apr 2026 07:04:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 10 Apr 2026 20:41:36 +0800, Ming Lei wrote:
> On 32-bit architectures, 'unsigned long size' can never exceed
> UBLK_SHMEM_BUF_SIZE_MAX (1ULL << 32), causing a tautological
> comparison warning. Validate buf_reg.len (__u64) directly before
> using it, and consolidate all input validation into a single check.
> 
> Also remove the unnecessary local variables 'addr' and 'size' since
> buf_reg.addr and buf_reg.len can be used directly.
> 
> [...]

Applied, thanks!

[1/1] ublk: fix tautological comparison warning in ublk_ctrl_reg_buf
      commit: 36446de0c30c62b9d89502fd36c4904996d86ecd

Best regards,
-- 
Jens Axboe



