Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A5926ED33
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976893; cv=none; b=PLq1+qCzNxDByCodUAT9xsbw4jvCCvTkXTlMse9jP3L2ZO/VGO+5zH/NW+Xr54LhePZERiAvVVio56pbduNlw3cUHf6JGoOvBpNbnEsAiDbCPiE+SNWznCOcEw6Y/dG92Sk4kgT16WPz/1gToHXCQxicx8+256ZU7FVN7+jquMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976893; c=relaxed/simple;
	bh=oJhnoNfdVu5cCGCpdUuJORj/+X57meCVQ2ExvmKXB8s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dbYLZ5ZPOVDNIMF6lIZ4PmgdQSXWNBXtybl1+JyeJ1vNWeeXy4rojaj7CsMEWhZwPBQwGvLtBC1kMu88eVajbtNmDktxAwrqy6SamhPPwGFcbk8VJKbQNE4ihSFPeLoTcXnKjAqBoU3R33OFb3xO78gs0yoluT9wXM3lCcfRkZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=eb9xWi8R; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="eb9xWi8R"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43c2fbe2117so1217710fac.0
        for <linux-block@vger.kernel.org>; Thu, 28 May 2026 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779976890; x=1780581690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yxwrtkp41KMjXtE8hqzN77oqavDpPnNscKy85ZSDfo=;
        b=eb9xWi8RZrAhaG3KCEl5lghJwiiuI/onDXlKH0LR+CgVXxWOrSq//2w6vw2tzBq2nT
         Cma6jG4EBtcfFpDbTqxBw5WlwJuqYd6k+hA99rOMr/d2HjYQGg3fAqaHRrHo9KREqzmA
         6PJ3oteW9z1QfyOJ4mUUfuiQ+QiK28EKpeRWpMWx9l0pKmyxtlUc+/9Z515OVlFCDyp2
         xKA2ysUpp1CwkgDBU4PTZk1dGlM3KFK/mvQ+UpiE0UPbnKiasvM8wfYvX9we/EqLEnWy
         map2NWBg4gx+NpeVT04i0QlsaXy+UBJohfUW6T9A0dKV6O+ywkLG+d1M4dpZSJ9UcCz5
         7dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779976890; x=1780581690;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/yxwrtkp41KMjXtE8hqzN77oqavDpPnNscKy85ZSDfo=;
        b=J4OTiY35eVlR6mv689vrD0TYhFfgsbw/sTbh06PVOJW5PYcrzuvW2KEWZ+vWcSt8cf
         34peR+XhcVXNBsK07rN8SItqLfjqUuZZKi2kr7XOQXM4IcfW6acoNYCOsARAXGJrXiwG
         8Dv0/Y1X0CNZ2N6LPmTWba9FBrkgWSuJTxJ0VD43oHx2ncUQT91iMac7fiqCiEzhhu+G
         blITlgTh+wULMavaImCFADa7GIEp4txcIUXZrc+8yLD/fyvWRzsp69PvQbQEmqH8XCTc
         iOq6d6fwZ3XVG1cuJwHecdO/6q8fTbVrstwT0UR2Ehy3nIqlGov6LZeddSxgRgq2DGOH
         ECGw==
X-Gm-Message-State: AOJu0Yxk1pMJh2oi8FYSdZJivgAQhlBmbALoDo8FFVO/60jNz2pXEiy9
	Yc9CoLCYaqbzNCLbyYMgPs7qW0N2J+dYkjUdycH+4uXt/EEF7YHigEeILsqsAMOxjVRYJw/22cI
	AMNR2
X-Gm-Gg: Acq92OEretN9AWhRl8qfQQt1k02uV6fuB1qoYHDKBG8bjNvH9kz33HekcWxUyt+5pse
	HHgUrckLWHaloTgdA3T0cVqKfrYfegWFM4rqdcuSAcGWA17lLTiZyXGdS6Ou17eHR4XcOWO4Ne7
	KraZiGd8GFFkj0f2FcVItXnO0e1atjjBrmSdJEjff+lD+a1rXYuI8kFJFSeN0em5Fn1cXVgUv26
	dYOKBnmXonWsgsWVliuqzfy2/RRXK/9XzCDuzjzPdmA6E0h5mwJ5ZWmRnbi7XRm752aCuFNMgCD
	saGRMhuuKGVy4czXXQTE/RTLYpl/SvsSk7VM+ZoCAdXc/iw5uGkTGLwWZtx13zuQPwAvEruP2nd
	g/AF0kyVdWopOuQjnANzno1P5D86u7hhvQaGwWa0a1pu4+VOOGTbCHUPPlu6PRMwQwVeX8Y/PK/
	FwI0EsjhOvTrUVd/VU3eR2Ux3eK5kRgDKC61AuM/rSNfz+q0/Y+69kewNcgKj9+vlPMsfrkZZaM
	pXAzVYht5a6QQ==
X-Received: by 2002:a05:6870:2183:b0:43b:9b9e:dc28 with SMTP id 586e51a60fabf-43b9b9ee0e5mr11995906fac.23.1779976889931;
        Thu, 28 May 2026 07:01:29 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b63976202sm17356278fac.12.2026.05.28.07.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:01:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
 Md Haris Iqbal <haris.iqbal@linux.dev>, Damien Le Moal <dlemoal@kernel.org>, 
 Hannes Reinecke <hare@kernel.org>
In-Reply-To: <20260528084632.2505277-1-hch@lst.de>
References: <20260528084632.2505277-1-hch@lst.de>
Subject: Re: [PATCH v2] block: add a bio_endio_status helper
Message-Id: <177997688864.93541.4223793676643831681.b4-ty@b4>
Date: Thu, 28 May 2026 08:01:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 28 May 2026 10:46:13 +0200, Christoph Hellwig wrote:
> Add a helper that sets bi_status and call bio_endio() as that is a very
> common pattern and convert the core block code over to it.

Applied, thanks!

[1/1] block: add a bio_endio_status helper
      commit: a7d8eaee7fafe2e2c58aef9579bdef778c144029

Best regards,
-- 
Jens Axboe



