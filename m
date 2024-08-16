Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7751BE250
	for <linux-block@vger.kernel.org>; Fri, 16 Aug 2024 21:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723842492; cv=none; b=dfEXpaCvWg7xAESV00ajdvbOTCt4xMAn35HYu5sNufXgBBzesTBpKagjbE07gsZH83t02lapCyfT9VLpVpGBnVm5BNG0DXJQ4iZlox/0jBf+4B0IE77/0JVkv0bSboh9vlmWRdjZgjrNzLj5AZ1MKEvZbOsD5X5CAalE/D0Gw3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723842492; c=relaxed/simple;
	bh=RTNTtQPqCNOw1K2uClJ4k44gutay3CqyOn5G6u/uNTI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t8tcnIOCoPKD578B3Qur1pLNn1H8IjLU4K7pTxRqmFXvWoGr8gp/tnToEidPbkS95X6IzVss2nt+uWhcdjdMwH6EIJRdg9lPrhlLNefZpX1LxzfcHdy5vyx95JIKo2e0lE+z/JFJzjuTt3xEJ9g3Mu2u8hYriKfFtn2f7ptIfDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=H9u3dxFA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="H9u3dxFA"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d26cb8f71so131724b3a.2
        for <linux-block@vger.kernel.org>; Fri, 16 Aug 2024 14:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723842489; x=1724447289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8NIjnbhYU7a04neJgUoTRfMCQshztceozNqQd56jE4=;
        b=H9u3dxFAhkwYs2omOU0ICUStt4kHRiV5I+Ew51cYH69jMZJLI7mK9DU1PhH39EHiV+
         CCsdm71DEnQVtPSoe8GP2VW1jc6NLLk6IKeB5vAhyNPZD8LKBCIOy+nR4hQiMh0+KwN+
         Z4SCiQflzCe2Q+7SCXk/Wr6UcJ1vAz/z/+u38zvyhR6dDzVXOZuTS1mEbXX9xs4uJ7hO
         XZB9p5U7XNYvPrae9aAOCWFsz9IPBjETsI2Bum7iCAxx0MnX8FwLE5czRHy5ne0kFRWg
         27K8MaqiIyfvU+yZ0rpXD7RsCWi+WQqCyMTVhUIU1QZ6R9ktFH+l5w/6GOKg/zt1FnyZ
         lbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723842489; x=1724447289;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8NIjnbhYU7a04neJgUoTRfMCQshztceozNqQd56jE4=;
        b=FY+h6rNplgRFgPUBvPDzWzC5vaY9ix7Yq2ljO5GgNx5Ct5A40G1VprhxgIIfcv6B1t
         4lVzGm66tY0eiFmX+pCDAUBPaNk1ItwUk9Cv+oGKT6/mO3v91GY1qQxrKjC9ev/KVYo9
         HPrfjU4H45gOxhJoXlWUJGrKnJtfWvaQd05/UvSST3g1y5s6ivrJjF02KWwHLdhBIFpA
         RAqKEJMW1jn6rOcG7mLpLgl+i0a8EGLIKgrpGC0My9JvPlL+FACpdFY+TvUp8rYWrEvc
         nJWD1odwR0Ob3cVuYixmFX5VzAUgQl5MFbXuO58kmUH/LJoS4Qvx2wSg+rGV3OomMKFG
         LFFQ==
X-Gm-Message-State: AOJu0YziJ12+UVjPOA5AnM+heOUJl7/M0VmWWkBklGuVWde5yWVDi2jO
	M/Ki1BSEdjM2NSYjyjqv5H+5H0aDH4hi2/6vZEDcsIQK81ZBVKvhTq0KFzk8mJw=
X-Google-Smtp-Source: AGHT+IED1A84GfSSEC/DQI5fPHxjBprCDdK5M++JNqvS4vAAYy6Dka5cLaX0EYTleULlZDRwl+LvQg==
X-Received: by 2002:a05:6a00:2d29:b0:70b:705f:8c5d with SMTP id d2e1a72fcca58-713c5287054mr2769750b3a.4.1723842488823;
        Fri, 16 Aug 2024 14:08:08 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af1bc1dsm3121001b3a.170.2024.08.16.14.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 14:08:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240816095821.877842-1-yuehaibing@huawei.com>
References: <20240816095821.877842-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] blk-cgroup: Remove unused declaration
 blkg_path()
Message-Id: <172384248784.90928.18000408712813246725.b4-ty@kernel.dk>
Date: Fri, 16 Aug 2024 15:08:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 16 Aug 2024 17:58:21 +0800, Yue Haibing wrote:
> Commit bb7e5a193d8b ("block, bfq: remove blkg_path()") removed the
> implementation but leave declaration.
> 
> 

Applied, thanks!

[1/1] blk-cgroup: Remove unused declaration blkg_path()
      commit: b2261de75212910e2ca01fa673c8855a535d8c60

Best regards,
-- 
Jens Axboe



