Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE0D386C21
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 02:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810755; cv=none; b=gy0eEia+kux+1QgqlEB/oS4ysBlBzJYMC+AAqGh8xW9bOU5rZXVu7xWLF8HlxziFjBS6sfv27IVEdpnrh4Bl1EoeKWO0pp/IO/bVRTzo4uqNxs0WZabMhWMc+3vuTZX82zZc0yIYJI3XeVRWzOwbCe213Q/00DLjd9pzxiQ6k3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810755; c=relaxed/simple;
	bh=2JVPtDCN47pdjWGHpFlTUVTYYO2uGwfT9rqlWW2wzzI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SuJiAO27mmfOb/zH6mW6lln2wUTYszZM/b8aG9UsYetm6GQAkcE7ljomtmcXWa1Od8AzTlm7I28Xv84t0fHZgPLXk4bM6c6Z3VQr2lxX1B8lnyVVmYvbSNmnITS01gGZXBcbxNkRWv85TOBADUxrcj1cYmFn2y98lmM/QvJbPjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Qu0G1wLK; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Qu0G1wLK"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-448cf99c133so715145fac.1
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 19:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785810752; x=1786415552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EyuWLscMoDFLylHcOF1OW+0Ytbk0KdH3dMnyedJceS8=;
        b=Qu0G1wLKyop/lB49KH1SfQHGK3vB+qEQUwZJKKWJl+KaKMjBsiaaeLVgX1MhczBgV3
         jHzvhET2Lt58AfOIFlp9chISjVcgiuoqJAHRFe6tK9dLyX7Us5ZwInq3oep2sK1ITcBn
         AZMFyF1xoAsZGiwQ8m9MHCAyRuIQxJcE737HkdRfV3YLKT7Z4/lYt3BQB8zs99/yyfgu
         7K/GJ23bo+hnYMEHIGNG0gkV2wO2Udge86IC3wewx6BCJ2jEw8NHilghiwivK0zBzhn9
         /RklY0vsYs6Lt160gqebw6dheODBvep45LQe7Kk5OAL3njRvWWYqJhkVFcfERgyPDiXl
         0GjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785810752; x=1786415552;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EyuWLscMoDFLylHcOF1OW+0Ytbk0KdH3dMnyedJceS8=;
        b=MGRRIcZu6WPwXYYAOjyFBPiixlgoOfYuw+6HM61wB6PEop9rsFsxj6rmxAFO8mdkIE
         N/8UcDDYyv27+qygebXG7ypaeEzWVhWCWxZsN/VANYh8JSNSeyh7S6/yHDhFzL90NCPE
         rTMgXRpqgha9FILx2eOFl/SladfX/fodk34DzCrafNT/S6CLlGqIWBt2YGqNO9pZTDNz
         QGSCSAZK9wrxnhVX5jMnG+J/98UwGHvJhQ75r/yFYWht/YP0oB2NpHpcMzgLbGhQDkuF
         1Dyo+l5+t68xJR/R/27SHGU4at6IZofI7DSG3XbJpncurt048xdtFmqevWoKSbJjK30O
         MfgA==
X-Gm-Message-State: AOJu0Yyr8sxAP4ANljKfjpbSmL7c8UzyIgREIU9koDhgnfZhEI3npoG6
	5XShHnxcYgo2V+nwdaV+CTRXlWUwHpe/hKK959UQu1rSgyS50T194v5xbF2uOhwPIAo=
X-Gm-Gg: AR+sD12HxbZtZpJuNig3ITgpbaFiAEojz1JMh6ZRun9ZbWyis2vKZJkLvI4oZnTq1m3
	3Km6ahiKHaY0imKlJT2PrVrvsOtV9dEkLAWMkKFVh90LAeNZpUW9klG6cz/4B1tTalT0AzhUvOD
	kAC5FxhsLgF+bL3EpNcO7/aXWKOfXQ+akYcbzqs8f5MbfSarIAc618HbzwGfVSC9/TF/acxFNHV
	LAC4xasbMlhxQkFWfImodKbtscWP4ot6ulDm1C5FIuNyEe3MiKlgTO22udPNEQaT33U/yn9FPQt
	4rlk4kdkxj/PlxcLIKSdwmrB5REtAIVZOAUqF3TwbdXwa1qzxryUAopC+buhMqMPdHMgR7wJaZl
	WuGA6H5pZM7YoWzhG6Z7IRsBI4ybk9SRNry5jvVtCtEK9tKpq/k2d4bGo65hnzywqxt5wvl/S+c
	21gow0x6fguYg/EgVtDlWocrcyzTE5Bs9nJtTwM/7HtI7RXT95du2OkEcYZr2l7j8tuYKS54mXK
	dTRsoBJaGrhp+RpBDhEP0zRKv/oafQ1lTw76jwcMw==
X-Received: by 2002:a05:6820:290a:b0:6aa:facd:4cd2 with SMTP id 006d021491bc7-6ae8282948fmr2892682eaf.7.1785810752466;
        Mon, 03 Aug 2026 19:32:32 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f66c1fe3sm10700195fac.14.2026.08.03.19.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 19:32:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260729171041.45061-1-csander@purestorage.com>
References: <20260729171041.45061-1-csander@purestorage.com>
Subject: Re: [PATCH v2 0/3] ublk: harden user buffer handling
Message-Id: <178581075067.549250.11766809724124520359.b4-ty@b4>
Date: Mon, 03 Aug 2026 20:32:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 29 Jul 2026 11:10:38 -0600, Caleb Sander Mateos wrote:
> For ublk devices not using user copy or zero copy, the ublk driver
> copies request data to/from an arbitrary buffer provided by the
> userspace ublk server on each I/O.
> 
> Fix several bugs where the kernel driver is overly trusting of the
> userspace buffer. Ensure that an invalid userspace buffer at worst
> results in a failed or requeued I/O and can't trigger panics or
> undefined behavior.
> 
> [...]

Applied, thanks!

[1/3] ublk: check import_ubuf() return value
      commit: 3831568792af75b6523fa93bb91560e29189cf55
[2/3] ublk: check for ublk_unmap_io() returning 0
      commit: 24fd3706178f1ae5501fd1ff9036e170ed0665ba
[3/3] ublk: remove WARN_ON_ONCE() in ublk_unmap_io()
      commit: 15c1339ef44054cc79c49b40b24a26aa80a2253e

Best regards,
-- 
Jens Axboe



