Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC6D41C2F4
	for <linux-block@vger.kernel.org>; Wed,  4 Feb 2026 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770222554; cv=none; b=HPawkls/+ESEXcuPyjcclrfCpuDrrkKh0qQE55hyZLOb6UdMH1i6rBJiJVoqZawobpvADUITwZ+HLhyMhMcElvFabR+mDJmXL/fVURWyKBOrLlJGbIPJ5C1k/PpUeBIQ/f5VoZrnnpwFUFeQjXqK6qSWDOS104kUe8O0ESFgipw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770222554; c=relaxed/simple;
	bh=zx6zdUMJ3RWLn3ws9n48sdVAdIHgBT02jJR/P/LpS2Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sXNuLFZgU6n+U5mxdmJ1mz7di8iqXd0CsoYilXxcy4zmb5m7ZDmhkQJWpiPPTGHZvyPm+jUHLBAbF0ABoVRw+rJ1dOYSmSEuW8DHKXHk/qgPlPS73YBpZpUNkskHf3yrPIjcBF3M1GH4/bdFTzVHHceFobjn5+ibjy9u6q1s71Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=c8wd/yFe; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="c8wd/yFe"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45e934bb51dso2660808b6e.1
        for <linux-block@vger.kernel.org>; Wed, 04 Feb 2026 08:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770222552; x=1770827352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9Cy4ZG9D75M6RO/VmoqzuT0aEphF0+VmauEpS+Qd98=;
        b=c8wd/yFewXgNLiFbbRXdcUzATVA8dj7vt6UJjUldGWPfF5go5sIYvUXXm//5uAZei2
         xSApenc/T9j9YylBljZfNiIbCvM2Vrf1ePBoi+AoWklVyKmvXb1vOCEv3XMTiHvIdctU
         yDqxIBBjWERCe6di60Rjoqy18Ac0l/H5T9RCeN7+AFKl62JADE2gkjrQoWTnnuutu813
         SAHp22LZ4Ihuh4FAIiluu752HPMEILdn/R4H3dL8FTiQdHpvK+J+4qyIB7iuScZImavQ
         E5gyw26tDXXlojzbmJvoD6ME8hLu4GNq1IutRLwlzPHiLgJ5dhJ31HIN11IlRByTnhgU
         ho5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770222552; x=1770827352;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O9Cy4ZG9D75M6RO/VmoqzuT0aEphF0+VmauEpS+Qd98=;
        b=l6GB6OpsfsdpDd4CZSepCDN5kqX2clg8naJcY211ZJG/VGhZV6YqMjeF9adQwZsqHH
         FLs5CNYG4hmZGo2KZoaBKwwv5iWiUUyZhU2kLbE8fEVPY6QwNFtSgi0b1Cps8qQgXToN
         0S/OVNjH1xOBfknrbbkLBQWLQgmLosXXjU6X3xSasIU5fr1e9sRQuchcWaZOCFviF79I
         ODnHkGz/BlWEZB1CCdIz0R84UYeMJaEmATpyrqxGtLTpSZa6X/sgeggcw8WpwCsNK7fb
         uu+4TkUxNBoBuSfKXD5sLfeBf7pppG7O5/jOPPTI4f2S760FyQZ3CEOhxfL5jBpkz91d
         Uinw==
X-Gm-Message-State: AOJu0Yxk4lajkaorG5Q+FsabufBCSsiQBUiCkIcuETXWPrwUHKVA0GFk
	NN02tQEVHqpXdl3IbXAiPy48yIb57hNrtOGGbYuWFE1w1blSmvoUAKH3nQ3NFcsvqs8=
X-Gm-Gg: AZuq6aKEQ5CP2BS7VounOYqRHJhVK6Mc6SdMYzEfW9/uoNYOsDo6rfo4lSLlu612VJZ
	ss7F6v23MYPxESewW//Nqk92Y77l/QG21PK4484D4MzCIL+hM49YIbdHoVvvGcTHtvTI2jdcatJ
	a/TGsWBpXWRm+Bnupr4t6n/OjLUH4LE0BSYCS1X0IEGaoiUVFwnh+dGMLaB3zbreWmSpcDjHMFR
	UsRCUKf2hH6w6bD7XYIRs/mKjBUilooXzFiAqMahAEFVIJsPQnYGoQsQeLdhgWB9eWCr7NcYSjS
	/N1c1auLgOgH262CBSN/d6dcayppM/TYqWEvtbcBHcEH1afaAUrAciWVFEfSP4U9zqcrf80Z381
	pXLhpwF4+8ckzfBQdBE/WyICzNO8gii0Q0ccE+pwdvOGpA37uSUYvI5MlR8TqrPk2lNMWAebXJq
	mi4fDsGcyoSzEEl5PbavpmYRnkkZJTBxGH3L7It8drn+iaXQ5oQg7KX8p6bvTL+AA=
X-Received: by 2002:a05:6808:bc2:b0:450:d28e:2509 with SMTP id 5614622812f47-462d5ab6738mr1488455b6e.66.1770222551943;
        Wed, 04 Feb 2026 08:29:11 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462d6614885sm1573550b6e.1.2026.02.04.08.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 08:29:08 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Yang Xiuwei <yangxiuwei2025@163.com>
Cc: linux-block@vger.kernel.org, Yang Xiuwei <yangxiuwei@kylinos.cn>
In-Reply-To: <20260106024257.144974-1-yangxiuwei2025@163.com>
References: <20260106024257.144974-1-yangxiuwei2025@163.com>
Subject: Re: [PATCH] block: remove redundant kill_bdev() call in
 set_blocksize()
Message-Id: <177022254820.27547.9593412596108847919.b4-ty@kernel.dk>
Date: Wed, 04 Feb 2026 09:29:08 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 06 Jan 2026 10:42:57 +0800, Yang Xiuwei wrote:
> The second kill_bdev() call in set_blocksize() is redundant as the first
> call already clears all buffers and pagecache, and locks prevent new
> pagecache creation between the calls.
> 
> 

Applied, thanks!

[1/1] block: remove redundant kill_bdev() call in set_blocksize()
      commit: d4d78dd43cecaeaadb24e78927a4d6fda7d1f1d9

Best regards,
-- 
Jens Axboe



