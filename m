Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D49C14D2B1
	for <linux-block@vger.kernel.org>; Sun,  8 Sep 2024 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725807410; cv=none; b=DsFn9VIpjiw/GYvKuf9WPkzVS9TkWnSxWLr4WIvEz5laVRsO8hPFfiy5LCpo1Fb2HFQnyXJ5pPAtVJvHTqrMfkId4meFj/37Cw6+eqp1GwLymcUR6JvwaSE4aaQS0APMn1KT17b8ozHIDnAt+H3sHKOAvL0hjnyWOtq2jo8QOiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725807410; c=relaxed/simple;
	bh=h+XZpRMYPsysTD0CNc/vQ35wL7alHsPvEK7IN22K+0M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oYlteeC/WXK4WG4WwbJcMD6DZ6F/w3EbN8vU8p1Ly0DWrUaMxUzvb+qJ1AVnIeqh3+nH7pJM2+OrGq8ebrHy7TBzr6nzyze0X6rWZAhHsp/2Shlhh7yHncLlJQWV5hEzgmSV+TzY+HMSrWjXPkTKrx2EodJAIh1rt4UH8CjU50U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KFcnLBlY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KFcnLBlY"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2068bee21d8so34699775ad.2
        for <linux-block@vger.kernel.org>; Sun, 08 Sep 2024 07:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725807406; x=1726412206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cw732y6mcg84drG6YMPb5eVJP3NzKw3RL/2ng9RKfso=;
        b=KFcnLBlYCgwGls8YHmVElQrQ5WqozyqjW0O7we5hqG7md1CqbnGhdTs+ZjY+bypVMM
         JvSD8KCtVngpNfCZMMCTpLKHq0d2u/lbLWvEYK/+SBbM7r0b9uBcQ+oOf015VBN5BPgZ
         XhqZP7NmwoRlfmnkYggPPeD9iuOXTYOsdKGXyPNjiT0v0HNA334sfotbpwVuw0ZEQx7W
         dM3znMWDomJGVZhwl+LJv5jboMG3kU/AUA++mSgQNFpO30gsuavceRlLmaclSxBn7KLK
         d/4QOP9OJiCPN/uNMNzyQC+3FBFLVgN3r/MbD6wZ1bH7GyPNSA4FDc8nMJMav9K5678d
         gIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725807406; x=1726412206;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cw732y6mcg84drG6YMPb5eVJP3NzKw3RL/2ng9RKfso=;
        b=L5sRtc8RqAelrwiGoaZFnmHO7f8Asy9dxczTk/96cBNRWE6mqb4UOjqDfZYQ5XixQq
         WIAt08wbpfLZU9UHVeFKCFpvYGcoq3DhBijdDgWH8QO0VyqwgO4D+Gi64gisYvh2SjvY
         PMkcCoQE+teVU5vsHKqa7lZ6rLXt1gQED0HwbEBuMGpeaEii0HgObyfWVloVa/R2cjAw
         A0ICCva4lLXrLKwKdKCWEWW0cHS95KGslAusir7ZoHvGzYOM9J/Jeyen9vrSdp5qoFNu
         9505/vQpeHROXe/Vz/e2JgUqM96TleQPYW4S0iuVo0r3gFMG3taz2wITAN2m3M8uYOLv
         yqfQ==
X-Gm-Message-State: AOJu0Yz2MQs1ou0/vsGRtADaBuj77SRxDFpg4/V074BQpaY6cmBtqgWH
	pqmi3rfNpMqJIj47c9ivYtK/54RsWH0df1XGUozUX/x/wPfWl+b1MntZvLcAjPjYO0qmTbMJT2p
	W
X-Google-Smtp-Source: AGHT+IEBtP9PCbcGxIXupfRgdyTO1QncL5RvYz0E+YeiSsXcKjhQNv1TVkqBRmwrk18A4iSX9sz5cw==
X-Received: by 2002:a17:903:2b05:b0:207:232f:36dc with SMTP id d9443c01a7336-207232f3760mr34218435ad.50.1725807405558;
        Sun, 08 Sep 2024 07:56:45 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e0f6f5sm20951925ad.11.2024.09.08.07.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 07:56:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hare@suse.de, dlemoal@kernel.org, ming.lei@redhat.com, 
 john.g.garry@oracle.com, Li Zetao <lizetao1@huawei.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20240907034046.3595268-1-lizetao1@huawei.com>
References: <20240907034046.3595268-1-lizetao1@huawei.com>
Subject: Re: [PATCH -next v2] mtip32xx: Remove redundant null pointer
 checks in mtip_hw_debugfs_init()
Message-Id: <172580740407.254205.3190774834093585611.b4-ty@kernel.dk>
Date: Sun, 08 Sep 2024 08:56:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Sat, 07 Sep 2024 11:40:46 +0800, Li Zetao wrote:
> Since the debugfs_create_dir() never returns a null pointer, checking
> the return value for a null pointer is redundant. Since
> debugfs_create_file() can deal with a ERR_PTR() style pointer, drop
> the check.  Since mtip_hw_debugfs_init does not pay attention to the
> return value, its return type can be changed to void.
> 
> 
> [...]

Applied, thanks!

[1/1] mtip32xx: Remove redundant null pointer checks in mtip_hw_debugfs_init()
      commit: a02e98bebc15f1d973c2a62005be9456a657e2b6

Best regards,
-- 
Jens Axboe



