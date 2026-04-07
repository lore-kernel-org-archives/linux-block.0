Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118213AA4F9
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564878; cv=none; b=draeU4mzqBAbAzpESzg8riQk3C1iGOqm6gvCYk8O8vLIJnHEcMbsLfrmZzy9YPY/Ux1Fmvo4dZ3dmLbjl7Ed8r8NSqBUj1q1vpeZMlf1Vg/ebQY+lqdu10wBT0d4cw88rraaqzlDjdQpyOtG7S9CLT6xFBHp/ii54lhtGRjXXsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564878; c=relaxed/simple;
	bh=O4XpneBwfLaQ46ee/b+Jc+gNkzmwxzmAIwctUWzRsGM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GRnwpQrgL2fS20Y8wv46nKhgBMZJp7PJONOzIoPDM7Si2eiZFUXU/AsJCPgrXkXJpkjGeX+lID+QlR7Cjj3dSQ+5IY7hwheJxgUVEpCqse64YRBDL/18L7xzbdQvzWg68jJYX5d38IfJu14Zmn1ZB15cVC/uOLGg0yz5Ws23KdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=gx7Dh4AZ; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="gx7Dh4AZ"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-68457156797so1141214eaf.1
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2026 05:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775564876; x=1776169676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTvEm0HNl3SdADY92hVTiu3yjS8irZ3O+yzPGT/Hy10=;
        b=gx7Dh4AZlXjQoCn/hpzolICBdLYvHKp6Ev3j0ok+OlZlWtYOXV8Z85KYQyPG99DxFx
         nDgzLeqQTif2ebaMVmEzuNV3TOel36WZSanpGHgdR0SkyEhdqQsdFGmSUOKXVF7qiwar
         8Y+ySTQ/XyPwBlG5/zZwoF2Fwx32Qz/hXLZB57Qem+Wc/+R6advGmAURyT7r0N2PatSR
         JqGQAXHp6IkWdEM4JdoMYkq1DzY1nv+bDf1bfZNzfcN12LaB/2CPoG/GoZ3N40HvhuAo
         +iKKOrLfgrRPyA+6HjC+7YuRwDqoFYmd2Or4yqf5/So41GXcnQ9a+nNyn0MK88hJOc0r
         Kd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775564876; x=1776169676;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JTvEm0HNl3SdADY92hVTiu3yjS8irZ3O+yzPGT/Hy10=;
        b=QBJZy+I1MKg80mYg2LB3rLpbn00keAYE4hKhPVh7r/WkdZYkrZaUKsbPEK8y8f4FIA
         dM/ThbyXQYgsu4JvLdLgjXijfPODiV0b+soO9KUBa6wzhA1sA0nent6TzU0sRBCHd5dg
         B6UNHrGKD8kv9sScpqY1aLGoCXBQ/Zk6kg6gXo/Kph17lZZQ8wQvcJ2gYAb4QGGqyIrE
         /oczkopk76QxKWiYdG144g8OYuQsaNLeduEfFlvcwPreIqRPOQpjxUjGtDS7sCsG+s46
         YJhekcTg63pz8B97cP2IkgG0V3YoOUkRbZoP8OgXy5ImAYS+KtBqo+TomCf5YChWJigv
         m7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/rK7E29xNNepPTK1VIHC/PzHuMI9G8qRklJMZRrXT1JNM4hTybQRoL6HKMCnIvEpLta4B/JbIQ0NpJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyABaZAC9rZyIiYujHK5eTrguXnamXp14pxa9t5PuwqoPck0w6P
	E6t+0O76Qzvmcx/VkYGuuJc5RCbxqccxbplTtfBBjvvcFLduwBVqKJgqie7kAN4BRk8=
X-Gm-Gg: AeBDiestRwAoO1fm2NCmqwlLLb54B6FF/2DXXTgWTaJQ3geKoMSFQhTHe/oIek4KV2J
	pxHiKcGzrSC8tFpk/miGxJmaoU4mGU2ylvAVxrNXR4lR0bFwmhUz7bh8bnwv54vzsxzcS6syLgi
	TaYo4scmPGWzUY+cq3kzKgfDq8luuWK8weuXtozksjaqHZuBgQ8ClyZ5QonTWx5I7poxFSub0jD
	ZhRX+/5yRsWk4VacUokAj/sK+n6g92+GdrQGexgb1bPFd5zgsNgZ/UMMwoEDSfTKPQJoE/mPEvc
	wYHFI3gKqBFmNOzRkizM71ThREy82LAjVVRTMMNtbzqiTDA9Kfp7/EQGTNzJPE4FdKr/lGxOtAk
	WAegczvwvTr5xsTB/1jOWkTvHSR1MnYZHC1jfWigW0HQz6I9H4s8iJO2ABQW3Qvc4BxZf+vRhS8
	2wlO/BXgysW0/CRITUXbfqwwTYg9GTWVhgPbY8vwY83ZtWione0D6CxnIUNllKGPIz7qY2ahxKd
	LUw
X-Received: by 2002:a05:6820:2d08:b0:67e:3e13:3301 with SMTP id 006d021491bc7-6822094b477mr8731867eaf.47.1775564875792;
        Tue, 07 Apr 2026 05:27:55 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6874bdf0f3esm1710157eaf.4.2026.04.07.05.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 05:27:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
 David Carlier <devnexen@gmail.com>
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260405154704.4610-1-devnexen@gmail.com>
References: <20260405154704.4610-1-devnexen@gmail.com>
Subject: Re: [PATCH v3] drbd: use get_random_u64() where appropriate
Message-Id: <177556487454.160102.7876439561425068141.b4-ty@b4>
Date: Tue, 07 Apr 2026 06:27:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1


On Sun, 05 Apr 2026 16:47:04 +0100, David Carlier wrote:
> Use the typed random integer helpers instead of
> get_random_bytes() when filling a single integer variable.
> The helpers return the value directly, require no pointer
> or size argument, and better express intent.

Applied, thanks!

[1/1] drbd: use get_random_u64() where appropriate
      commit: fa0cac9a515877fad856c860ad51107b86ed6c4f

Best regards,
-- 
Jens Axboe



