Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD71314D01
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966994; cv=none; b=PRxek9Vtw0oPfuK6N8I2/tJB3i6luluSO7cmnCxa/bAoYgwR14koMY1ZOuhG1Ln7AG0lOjdx+52k1Hp4sngsOw0ugG2PDTpIpK6DyLoAq3CLIRX59U54g1d8UfLrPWhNH3jFqbtfQViUgY5D5EK1xXsybpcvTE7+oTgMjzShU+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966994; c=relaxed/simple;
	bh=B3J8PMqtuZITMp1IcO3YNNiPQLuqaBPXdeBv3QA2NgQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RR3Yk09bE3WXym4G/OG8C7c3OrDuVd2qxrrGgtaLeb/wfK7GtLjEqH2rLrC763FWRgAAwCg4NIrl78v35Lthq0UR8rVJFFV/F9whO5CEEa7JeupFfkpCGGF+04vR+qcdmCkZpfJNWVAnz4WecDxr9bOm/+E5s0BnA9rhbJ+c/hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=F/cQbzGl; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="F/cQbzGl"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-9486adc1aa9so40791739f.1
        for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 09:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762966989; x=1763571789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INNWdzquQhMrFKilVhDsGCvlU8ZA90/4NfdE2POFlD8=;
        b=F/cQbzGlCa/aYHB+zgQ67bYbZ46BgvCc4iv0hOTok9UVlZ7/W3BhklbnDC22u6kFFS
         nugASIDRrWkQTpR+Lr39TemvPLL6YYZa1mUrHaMF5sW0TimFDNVzGIbhWtkQcFBFd1pL
         UkP1HXAct5V6iVXPVIIInCgeKpV4D1KOVSXOyxZPo/vC7sKsVgv4qA4OAK8VkDxxxVRM
         h6XGmZEauhP/rJA65epZE3CAI6rlPN5QKXAqgI3PjN9expqjmA2qNnVSsEk/58MGh4jY
         VNUAi1t8uCeNf2Kk49sZ5KJMgjEvOJbuQukAor5NZ665FXFu7gCm31c1Y/3Ny4Yy1v4H
         8d3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762966989; x=1763571789;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=INNWdzquQhMrFKilVhDsGCvlU8ZA90/4NfdE2POFlD8=;
        b=vxoOuJ7zQmzVxhQ9G1NiluONgKTiULBDQgp8yo0ZJspDCirB6Mk3E2RNM8FvF64wVA
         uVLV4mXgzjQQ2W2rUqEyIgVT6i2Mk14PL08FcKGHKSdk02h0jp5AHWHZK6cBaTEW92fU
         aA+EQ9nnurgs6hB/ECrrXidoHRtWHOeO1Vj1I33jcZUv63cVbQIhOaJ6pneuhV18rNFR
         S5HIHDRVwzuhwl9DZBvKOTVqbC/3jhNmO3xjX6t1BKHwzdsEUBSz2DQtp9jjECY3QneL
         8UWKAtD17XSJ7qkCwrg/1/4hJoh3hVw7ZP865mNbA2VwcnvzdIGObn+OQwxfR8/3N90p
         3Txw==
X-Forwarded-Encrypted: i=1; AJvYcCUkA+FwSuTw3B1YJJ0xC1zXhk/HqTd14CU3w2jTZHtEEVur64WJSjGSyJ3/j8RE8EsXx62kElU9P9JfSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP5hLV8X70TjxHSBWwWo+CdHV9ptOQ56ClCDNs/1dK7Hy+CA/a
	a0XetRkDjVctHHbQf+0n+vno7FWFJg9tNGHDlL/9qLi9uYgr4OT07q6Kto9cFH0LD6o=
X-Gm-Gg: ASbGncs2zia3jrbDpbERK8tbDnn7C6FFiVLyDrl4DSsJlHWbgFQTbugWDUGrlfo/rR8
	Rf5eqkF46dZ3cridmtCLtER25nZQCZJhftENQC8nm9lgI25luxDGGUD6bISCUvQivzQg2uKKEL1
	7U/5QRGU1+o1u/B0bSvKm1kpX0zp98vXbPLOeC0OVbl2kpxxkGXDrXAJrUPkE6a0ygBpuIUU6rj
	I5EQ93CDgP9alT4IN6JXZMQTZCI68OdsTlwuy8Nc0/JQfgUogDlzuOB3VVOIbBlE9ezFNqVtsnS
	U1/WxoLY3IdRjE8QFZ/LqeO5y9NCNl6ulGL2ty7qTDgMQp00544CzYppiBAv/fneHKerTwiDuBf
	4r1VT8RqbuAv3eYmXgFSbqnC1TkVbyeoCwk0Zg8OEZbkKh5yrjRtYJ5G46EjtgPwQxXI=
X-Google-Smtp-Source: AGHT+IEjlaBfpcDRoffK6K0+8LI9icKpPLxbkDytdosjfbExIsUC1J8YWm/klofwRXzdDNl7+x+ZAQ==
X-Received: by 2002:a05:6e02:3e89:b0:430:aea6:833f with SMTP id e9e14a558f8ab-43473d0f45amr40116445ab.8.1762966989371;
        Wed, 12 Nov 2025 09:03:09 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7ab10686esm1185231173.46.2025.11.12.09.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 09:03:08 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: dlemoal@kernel.org, johannes.thumshirn@wdc.com, bvanassche@acm.org, 
 linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: Keith Busch <kbusch@kernel.org>
In-Reply-To: <20251112164218.816774-1-kbusch@meta.com>
References: <20251112164218.816774-1-kbusch@meta.com>
Subject: Re: [PATCH] null_blk: fix zone read length beyond write pointer
Message-Id: <176296698714.27533.9371583953536786103.b4-ty@kernel.dk>
Date: Wed, 12 Nov 2025 10:03:07 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 12 Nov 2025 08:42:18 -0800, Keith Busch wrote:
> Fix up the divisor calculating the number of zone sectors being read and
> handle a read that straddles the zone write pointer. The length is
> rounded up a sector boundary, so be sure to truncate any excess bytes
> off to avoid copying past the data segment.
> 
> 

Applied, thanks!

[1/1] null_blk: fix zone read length beyond write pointer
      commit: 3749ea4deeba6049ea97e653d964568a45543e37

Best regards,
-- 
Jens Axboe



