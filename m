Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04050A935
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 05:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726549543; cv=none; b=hu3rsZi4ci9Z6xMSZT27Ymu/jZ0wuF2lij/ECosfw1pjEkHgtudovr2SqXRWQxE4G+BgF7tjVPcxcOGWb2iDTkMNG31YIanaVYaPzk//aSXOVG7T1aWmieqp0LFJW0PLCSITYCYEPPuuya8+1ULFzSdwmpDK14WwZdI5lpj3YyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726549543; c=relaxed/simple;
	bh=sI/2mt7ZT8N34yENSaH7wnfjV+R3hlFLykW9UNdwiOg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jnnottioFoEKctO8cNd9v/zXgP4UGOeercUcKyrx2mIaKM8Y3koOuxiOZHI4l6daaBVKLYnq3CuL37EV8pEchvg5CAih3ZZ23yKKb/v+XjTWYGA1jqnB50iTtY8fbKi4Cu+21EHFf7H7eAHe/D1KzcN6ukCypZjERtWv6vRVJUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gY9SIGlL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gY9SIGlL"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so44188635e9.3
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2024 22:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726549537; x=1727154337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnXFGLwLgpergV5Rek/ag+qOrPfRTIWsHRHyAV4CVNE=;
        b=gY9SIGlLryd4m1wlyKDzpsKNUdOhFyO3i3DcqU9qDCgycy/xg3f5XXjksXMvLuoQmx
         O3+dIIGkweLX2ZL9Ij6Axdqq9scIbfAKHm7AtwdT7cTA76XiumPHMugw0DR+aZH+s5Xf
         t90mCkw3P+HjMS8uz954dle4JSDy1dNXDY9/Uj/LTWg4r/xt6WOpmK6TfD8qr3c0vX9F
         bC324h0g4xdXIxiJMqpd19EpXHQ0K5bXOpJgDWiVNfWZS5Hv+x4mMgAAqa1zK8lQd/RT
         lGzhOq8LeRGErM5fb4S0DA41Of7upMiFCNfNUcQLruzuSip+IvpfmkAx5GeEXblY9qgl
         Mddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726549537; x=1727154337;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnXFGLwLgpergV5Rek/ag+qOrPfRTIWsHRHyAV4CVNE=;
        b=LofMtinrItFn8F8I04EqiafinbC2EmInYdChSq58T1mkk+4lMEyUQSr269NNmYB2dB
         etYQ4qXQXFC2H6sIgRPfQ3t0AvhaU4TpFsWRdSMWnCYabYy2mTunH3v2PFXn8xVBai0b
         p9enVPYOWH4pm/ZQJ4EZuahnuobRXoBsfpuEpzHZDEGrlgptHd2ytHNMhPqP4oWGs5Gq
         JRaW7jXiVZcqpYGGXssHCPi3IfyVTGGwuLf0UA+wkqmV5ohEcyTdToPlTVjDunV2rTAU
         sIrsFPLYDDm1zLwmqzp3jQlVCEUgS2dh0yO7XG3csHl2PXGl0Y4yN/Y2ngHOTbFgYkBl
         wVlw==
X-Gm-Message-State: AOJu0Yze7EOnggZI51B+JJAvBJq/9OVdyLZc8H2rwbMwBLCOV/loFtlY
	NNk/EcZ3BufEbai0PZn1RpF3NxvZn6tg3KxLQR8YHyPOAF956zlVrpfwxmC+iO2Hf865qvjfJgv
	O+pSRYN2E
X-Google-Smtp-Source: AGHT+IGmD4cTooVvjm65bHFOQH0ZzIoM3T7BNUcz8mFESImVuIFtWIMwCz732+UwRTY70k9kZczvgw==
X-Received: by 2002:a05:6000:184c:b0:374:c022:fa76 with SMTP id ffacd0b85a97d-378c2d5ab83mr10513603f8f.37.1726549536565;
        Mon, 16 Sep 2024 22:05:36 -0700 (PDT)
Received: from [127.0.0.1] ([185.44.53.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f99b0sm8600063f8f.60.2024.09.16.22.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:05:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com
In-Reply-To: <20240917045457.429698-1-joshi.k@samsung.com>
References: <CGME20240917050236epcas5p3b032bf733800ef5b2b9d1ebe9ce92838@epcas5p3.samsung.com>
 <20240917045457.429698-1-joshi.k@samsung.com>
Subject: Re: [PATCH] block: remove bogus union
Message-Id: <172654953561.180692.8301135057283740885.b4-ty@kernel.dk>
Date: Mon, 16 Sep 2024 23:05:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Tue, 17 Sep 2024 10:24:57 +0530, Kanchan Joshi wrote:
> The union around bi_integrity field is pointless.
> Remove it.
> 
> 

Applied, thanks!

[1/1] block: remove bogus union
      commit: 4208c562a27899212e8046080555e0f204e0579a

Best regards,
-- 
Jens Axboe



