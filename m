Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3652ED168
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872909; cv=none; b=UwngOq4jBGLCaPkN8XLnR3k8PzOdVx8QMEcDL2WXWlb4Nf7F+YgjLxpGaf6a7HzayaRx/bc9+PaYHd+ikh70O/7NzhAaBPFMBdSRlYnme7qXBhzGiZr5Ky8zWr5JKoHWo7kz0UAwxErnzYiTlmiN/zG0ytQCSgOjphT+DZYL8Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872909; c=relaxed/simple;
	bh=IDzGxHq9G2T2u5zie0LgunD38R2u4+ZROGlwA2sYuto=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FOTzKZAuwEiWyEhlUGJyvg+/Awg+CzXv3gOEF3LoH4TZMqMEzmpD4CvludbisDaPT1BiSCMJd6wPR50sX4XeY6ySqcjvPVuYcMbPkMmjEnwCtUflmRK6er+m9xINiDQloFFNRx0j87QKPEDYfU5yxxd3fDMienNJzAr88A2Bph0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kcCfFivu; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kcCfFivu"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-433261f2045so22260085ab.3
        for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 06:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762872905; x=1763477705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3jc2GDCRHhNPU8mBCq0ZuHdUaipS86a32LMjN98VxI=;
        b=kcCfFivuOzt8eoVkhy17x2q3kH0JRuAExxF1vGX0+8Wzc+4IieWk2J9G62fo4nJmEZ
         CybrNjGSU+YeYQEhPApXmnwtjplk1CMNxN40Bh68dPnbTCKF2oqkHn5VA6m9pvx9Cl1H
         +58Sdu6dzoYPzTorr+1ON5n4YB1qqRStfauUNE5LocU3apyKQu13A26YtUirVNmA/xkK
         qOcBAdbx8k/axZs/tQoJxDqQiM4/98rJfRKRrALVidZ9jtaBH3hmuVvOgJsnW2S4rOTb
         WHG754u50B91DcZBc++KuWoX71D8jtf39H0qJICbNYMyxoXCQ4QImXwDePnD8ZJwegB9
         xnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762872905; x=1763477705;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C3jc2GDCRHhNPU8mBCq0ZuHdUaipS86a32LMjN98VxI=;
        b=xDADZXXoEEymTtdYlijB6dn1McJq87IXsQckK8W9HkrsZBaqU2s31Lf7ejdaMqpQk7
         s/hxAiSukK/Tt92jHhXFerMsP7BNZI9a3YCIgN7YjQtyBka35D103n8hKMbs3tASaB/n
         aLK2NAF9bKMGojvNSbsTTD09/OdXEtQYRsZVtB9HXZLoivRujbV0e+lhfaB1iSDJ3Y3Y
         11hb9t6DEJ+7DnKFIr0Is1KJXe04XjQDi7Bf5BhYbmJCSFCApE+Ndrmw/ZGggrl408Ws
         SS+61xqvjFQjUnF3eDqs5YxcAThosurqf00W59F6f2zwI89XA0SPMlf+dRJ5T7NPc0yv
         Yh4w==
X-Gm-Message-State: AOJu0Yz0zZbgqPgL/qodDI1fHEJJvW0nEA5PJJoQ1DKEVacV/xgtm4NC
	ZqDDLATn5OwGtbH47idipX1IHSnVJQOnK+fBA2wraFe1RrfjWMxrhu9XYtj7HiPfjfU=
X-Gm-Gg: ASbGnctFMz/5Hae5DYB4hxfp9WFdZXJdbdMfgCn3hm2DjujZP96YbqD6m4KHcQ1QPOT
	j22u+hfZ9of00haL6NfM96CxHjk5l44Go3nkqZ2i3RCk3M1cWVcSo4PTK7fjI3yLRdMsUiiV6Ks
	YI4hsOhoqDbkYg7d3nrJpbkwccGbGZWa/B79m1DEzDz7gCVbSn0AtIJV8qqUMu3ejkyq6a7cvW4
	Y66zKEfcEy9XZ5E8i4JLr+Ve0vCwB57eNyj2X2mKf829hZMU/kGvLQ5RaC4o2dVFf/STs51KJuX
	86cd/C6YoBmRJMzYHoxwHHQ5nORdYkUWEhfw68imtCIyt4w4FYF1GlAoLGYuY1WZoh9iJ7o9B6R
	/GaQ0xAcm/L4yuCiy4Fto4I6m8ZfhMyVvI12isSMsp2KRXMdztshF0P7Ad5Ri9ZxyLXwTqnVOnN
	c0Wbc=
X-Google-Smtp-Source: AGHT+IEeVaK16D7QrLZYEoxptsELh2qMxx3UIU36lDX4rPR5UgDt53SfHNNG5sJw/liF0Up/ATsk5Q==
X-Received: by 2002:a05:6e02:190e:b0:433:7b82:3077 with SMTP id e9e14a558f8ab-4337b8232a8mr119180695ab.16.1762872905355;
        Tue, 11 Nov 2025 06:55:05 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43380302872sm26311045ab.32.2025.11.11.06.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:55:04 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20251109074426.6674-1-ckulkarnilinux@gmail.com>
References: <20251109074426.6674-1-ckulkarnilinux@gmail.com>
Subject: Re: [PATCH] block: add lockdep to queue_limits_commit_update()
Message-Id: <176287290420.173215.15622655002534585192.b4-ty@kernel.dk>
Date: Tue, 11 Nov 2025 07:55:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 08 Nov 2025 23:44:26 -0800, Chaitanya Kulkarni wrote:
> queue_limits_commit_update() expects q->limits_lock to be held by
> the caller (via queue_limits_start_update()).
> 
> The API pattern is:
> 
>   lim = queue_limits_start_update(q);  /* acquires lock */
>               /* modify lim */
>   queue_limits_commit_update(q, &lim); /* releases lock */
> 
> [...]

Applied, thanks!

[1/1] block: add lockdep to queue_limits_commit_update()
      commit: 86afb1cdc28f4332c6e0a1937244e0a80d4d63b1

Best regards,
-- 
Jens Axboe



