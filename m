Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C8D18E1F
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715447043; cv=none; b=MBHcMgPddm6/2O8YpTgShLey7xDGchGOAeztVa8ICb5EwSYt/OqwqfYuhMBxTSpU7eE5Dg8VEpFlpOCvwgv4c6waabI0tnZqjT8EeNkgPvzCgfH8QuoUOBr34zVvcXQIpbhBZiiFecH6/2vbt7KlKi2PeCV4BMujXDAvjWu83yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715447043; c=relaxed/simple;
	bh=wZWk3Xr/mPmlC5lZyQOPWTMyteuUBw1nHeQvKhE4pmU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M7Bqtb1mK8iPhLZFk3S6fwdR+j7gYGYwphkYr2+/ylWuncqbRPi/uZyaqz/CnqHG9pmc4ohSuiVeNivleYUNZnkmhuay4X03NcUkQdP070w2eKEuQwlD/KuIoeDDMYdNmMHkDrCthzSPeo6gbJvrXEz1fZFLvl66snCXzh5UHTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IJtptj+M; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IJtptj+M"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2b4b30702a5so803720a91.1
        for <linux-block@vger.kernel.org>; Sat, 11 May 2024 10:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715447039; x=1716051839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5RYDq0sQ0FFV9c0o/9fI9m5/lcDInA2F35bjIY1CUo=;
        b=IJtptj+MZDKZ6FzH9cF+Dq19nz0x4s1+cMHK8/Yw7FyHkKBu1+iTs/YpEpaZ5w3dks
         7/Br+yYwDB7Hj9zxK0tqbsIo15YOiIKHJ3fsWewqd9tIJQYfre3NX6l4vkeT61rmXWeR
         P7xQHaabdvd/2J1qyAtzSnw5r+ivWwml/9Eu1uMq8naenPpS4rGJ8lzR2FhqWvKu+qHN
         BbyMNvKyJrofvaHiVy+Eyd5YB0jBrZTNc5U8EX+fkHdFHVzY54fr+lK56uf+PZhTW+9R
         CqmtVPS7qg97Ehrsz9zH/4QiickiLJcGC2dNRFSkNRP3Y3dzanfalDRPRBksml579UHO
         pMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715447039; x=1716051839;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5RYDq0sQ0FFV9c0o/9fI9m5/lcDInA2F35bjIY1CUo=;
        b=rySJ/bM5Uibe4DOfWGgu5+PL+eZw/cY6z2OUy+6pUvoJL7yIpithIdkQZ1mdIhDodg
         1JmGmyF7txx4dqCpbhXY1sgC1muhWRY4IQJqzSp0nyQ8hBNKKtSPuu6IxKx87ie4YD0x
         gJEeeQyh/B/oTubt95yIWRyC631+rZ+N2s5fdpLzAh/Aq95f973wF/fIq9yYUOFjYzBy
         OKCvvFiB/w6RxXi9H5Wtv6oUsVmxlEemWBtfu75vSnmh0dhVT57aMmz7G0bwD91uRJJZ
         g/qCLS9bTnZVm57YZggNk2RERGtGbVvqObHuYv65T96PJAJDocGwo+oPwmVQ6J3UWoKo
         4DFQ==
X-Gm-Message-State: AOJu0YyVpP6SNyDMsSiBYMn34SXQU4QqwWL8bpzXMbKSMay0RfMz2DU6
	9B7G98AAujuL2MlcYd6acB9zIMhSD7vW0qQDn7U9cnbM+7dZFP53VQ/Hcx+RIloDrd+0+TquIiT
	R
X-Google-Smtp-Source: AGHT+IEwTBE8UAPksHtdcjc6wpuqBSQS8YhA4bTHiOsDr/N+DYs8t/FOSYCuYxV2CsT50maKJHu4MA==
X-Received: by 2002:a17:90a:d716:b0:2b8:cb2c:4fda with SMTP id 98e67ed59e1d1-2b8cb2c509dmr125241a91.1.1715447039631;
        Sat, 11 May 2024 10:03:59 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b6710565e3sm5081769a91.11.2024.05.11.10.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 10:03:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20240510201816.24921-1-bvanassche@acm.org>
References: <20240510201816.24921-1-bvanassche@acm.org>
Subject: Re: [PATCH] null_blk: Fix two sparse warnings
Message-Id: <171544703866.418778.16613935289747164338.b4-ty@kernel.dk>
Date: Sat, 11 May 2024 11:03:58 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 10 May 2024 13:18:16 -0700, Bart Van Assche wrote:
> Fix the following sparse warnings:
> 
> drivers/block/null_blk/main.c:1243:35: warning: incorrect type in return expression (different base types)
> drivers/block/null_blk/main.c:1243:35:    expected int
> drivers/block/null_blk/main.c:1243:35:    got restricted blk_status_t
> drivers/block/null_blk/main.c:1291:30: warning: incorrect type in return expression (different base types)
> drivers/block/null_blk/main.c:1291:30:    expected restricted blk_status_t
> drivers/block/null_blk/main.c:1291:30:    got int
> 
> [...]

Applied, thanks!

[1/1] null_blk: Fix two sparse warnings
      commit: e655d93e55b9ef7508b59d2d42a58549a37fd4aa

Best regards,
-- 
Jens Axboe



