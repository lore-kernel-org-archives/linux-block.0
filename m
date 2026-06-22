Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC901D9A66
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 22:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782165658; cv=none; b=lhSe47p5k0DgL+9/D7KVTSaZHitRoT4Sl+AJ067Bi1jzqh7SRAmA1kfDmuhoJ9tgUDZYD8Yi7EAmb20QDjFI5AO7HEkYfbnv/tkQPGDr/MSMNmalVRyR5iorSA/+LJL8uDX/q/Q8uRh5Y5gbiAfWk9JTGGvrlkbZI4Vp8Fv3qr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782165658; c=relaxed/simple;
	bh=Z+VOmPL6UsjAak6vheeWw3SPO80cIX9HQCOAZQzA5Fc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l4J+FwBqxmJL7QjahRncglG35kilM4ajVfA5SppAj7sGBIO5+0zgM3XV06qYdg0CKoM+wbH/cxzTkpqRGnJN2ZjnLpGAKYoWRUfW0CqecWSB9epp23z+CDuwhENRn0ffKlAi6v9EaV67whkPsRtvzdRi7gOw7+OI4h4z7yaKUEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=GnFOldxz; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="GnFOldxz"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-519b63eff15so46323811cf.2
        for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 15:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782165655; x=1782770455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xh88miaMrBkzBO/ZhAkAiOZ836Hz7L8WEnVcXTH7wCM=;
        b=GnFOldxztS9i7FFasfD5aH6T1IHP/MeCLDyRq4r9G/i+kacB1XHfdgNO/k4eB/mXCZ
         wQF5n4+tCpJpDprim5dkOmAqUbTF0+MlExUrvRsFmfnypbe3Ye1hW6ksFt4zwGEd5+C2
         owYV9eTOmjOXK+8tcSujCiKFUxh8UG81OqJCjaL2Qi2CPHSblLXv4YVs9K17lIO+g76H
         qhyp2kQO4md4q3fC02c64kjyEiCjVhEmV1GYbBVUKHcXL7fnO6FE3ai8KUWcZ18Pc3/k
         dp6JcINfd9bAr2FzwnKd30ziS3U5YupJbgdtfV1Hhs2bmsZT6gvyDnyEV+tYmSpXtGeO
         i0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782165655; x=1782770455;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xh88miaMrBkzBO/ZhAkAiOZ836Hz7L8WEnVcXTH7wCM=;
        b=cQk/O8Bt4K5c2y5xQmCLV3E3fl8B0yISWODSAZspXH1nhl12lmcw8Yhczy4saVgXK7
         9fo5ITVgdwmhXBNxAsfKQAmRdOp0trBpbSdNh5FLAh0DUtMFRtMQ2TMA32M3gagWBuQ8
         KIHTTPe0qRp3bRMrJynLsE0td4Tn2WHrP5AeKeagZgOzD7bkqbJi5r4tJDBSDnuPmTdL
         K985V2jx/DZB++gjKEPEJxJ7yNDdxwdYnjSKLD9CNwZSSCdgi0hp5HxXB8PeONXwVDCZ
         sFofSyz0g0yoqqVFq3OB2DEWliisur5fQAwxN6UeS8xTk+pNkElCbN/NesL2+qeqZ2xN
         I9cQ==
X-Forwarded-Encrypted: i=1; AFNElJ/r4zRZFsxepGXY7C4zUYsuHZ+pE2gMcYKZ2L3ag+H4uJ04VEXP4+mpQ84tcfkSJoQjJECNFArwBYqdlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYpzRsKsidy1i9muopurVV4eYJUzTJIfzr2XQ7P409E4m9UJdA
	so7MgEtHsSj/QueMj9BzkMmbcD+CbW2osUFJ+r5OkltOul6GFh8KQkpRyEC3qkq/Ej5A2QneKj5
	9kSSU3o4=
X-Gm-Gg: AfdE7cmZs2ILBhsd91hjVKMQsdjxnGpLoiHkKT1Jbz2jMIB4Ug8VVmmIHj/sDIJ73AW
	QllUJtaGa3xED8AoyuUJvI9SGs72xsmmhFaf4olkNdyUWYemRRxidTtWE12deZGSMxwTwKbzXLt
	DR1Lv49NEz9l0LwFg8XN16HhMpR4+4zqSJDG9yIZfKFmsiub9UdjoDwa2WXRJiVDDF82plManTj
	brfzSVkr+NV4nWQTFThSUw92ViMwjFMvI/RqslkamS/0fkqMCuw7MaWVNAlacJf7vDAg3ItRDiy
	UsNL4YPfQ1FIc3qhGhLm+WIq45fqfDrieEsMy+MjAkP2Vwbvon1cnVC8Sd7dgua/izF9jNpm3uS
	soECTXuQCWSmFOaJHqGxY36/cSGwvRap1IRMgjJ6t+M/Z88T663n/vSm2k+ZiBzGW72NqVmS6U3
	QnlJWtg6tocjR1YQz8WtA0LSlEnNjFPlOTPaU5cb18Tvz4Qw==
X-Received: by 2002:a05:622a:164f:b0:517:8f98:aaff with SMTP id d75a77b69052e-519e4dbb30fmr237908161cf.49.1782165640804;
        Mon, 22 Jun 2026 15:00:40 -0700 (PDT)
Received: from [127.0.0.1] ([99.196.128.58])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f018898sm106932496d6.7.2026.06.22.15.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 15:00:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: dlemoal@kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20260622160752.1552516-1-hch@lst.de>
References: <20260622160752.1552516-1-hch@lst.de>
Subject: Re: [PATCH] block: fix incorrect error injection static key
 decrement
Message-Id: <178216563599.110437.3664547875799802211.b4-ty@b4>
Date: Mon, 22 Jun 2026 16:00:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 22 Jun 2026 18:07:52 +0200, Christoph Hellwig wrote:
> Only decrement the static key when we had items and thus it was
> incremented before.

Applied, thanks!

[1/1] block: fix incorrect error injection static key decrement
      commit: 214cdae69dba9bb1fc0b517b7fb97bab385a2e3a

Best regards,
-- 
Jens Axboe



