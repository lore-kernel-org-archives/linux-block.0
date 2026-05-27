Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28475247291
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894221; cv=none; b=PUOWbrgX5UC6Pw9ZwtrWAHqxUKr8JEieGq5f5lTteWDhVsZUDLU3oixqCG6aO4dCbCNJ5X/r8vXiyRtHSiPHrh7tOFl420CC2O5tlYeQ1WLoCgzJYQ5X3SG3164/Aluemkkj4LiumuVjw0QUNsGerpryVtYXqZxpvCYOVDwHgpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894221; c=relaxed/simple;
	bh=U0u93bBo7e+diH0YTmmoPXmzjuUJK0B1+tq78etZyQI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VTgCWWTh4YG2+K6DjKfGR8K+wpBoV5lzTTyOfJwqwZQ/Q9cq3R4g3KSf0j3jI+gdPynSvERiWHAUAQvY2alB/7Ha+eEjx9vaCG09V/frJr3Fpie8WlWJPYNSocfQbhbZSu3b+ZYk7Fy4GRTkvku1SWaCm0Gnm+7srCM9SrmEJqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=YwEvolZY; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="YwEvolZY"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e66f966d01so680729a34.3
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779894219; x=1780499019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fEH/quYvL54NUsV43nYYd5b8CdUleJ97MuuW/OAkcI=;
        b=YwEvolZY9GE/HYCO8uG99VW89UD7RL6ycd4evJC0mMigWWtV1A0h04k6Y+Qq0csl8P
         QODIEnH7pnpcb/CV4QL93bfNB2z4ongFxKNwP4rE5IDbZA6HqY+N4LnyssxRKzwqCyqe
         uc9FYp3bdq31yu7gPcMFT68CEFrxYttRm5vxXcUzStDoWZD1TdQwdFuDPcU7IQaAOMN8
         ysYyHAKm17xJ/o8pR+tH9vpEbhoBvdOd6PPVPozqwCGHIKxoi2dBFok6YKHOBKyCthNJ
         6oy0wT8ZRUP/o2jH2CX7XUiS7hC0OpFpil0DC4A2xe2iIPfEjvTrWY3c/tBP+KZdeLk6
         QMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779894219; x=1780499019;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6fEH/quYvL54NUsV43nYYd5b8CdUleJ97MuuW/OAkcI=;
        b=gziYHizrzOFcGE7/tjPgzYMN4EZUe327EfP8XUEsOyudeh/pWChsgF79Wddsb93J4B
         NPGFhuXTxbUBknsthKsM9t8v6/6PbcA8shdXLody3BhvO245O4TJESWUTxg+0O1SaHnw
         cpYZCO1owmAm/fqAIRPXsYUO+pPWcLGy6t3JLPaHSy1H2x+J7twVnqWVo4NbfshdRBvk
         W/RCbpM5bigyFLKP0/2GpmCoap2A5VJ9xO2eB942aTK+pKgQWFqGOSFSAgloxxBGXLCz
         snlwwrkpfNuRDdX2zLVpy3375UsLU7uMgJzCIxMHasehYoaJh7k7sXJcijnuiqP+WJBn
         wS+g==
X-Gm-Message-State: AOJu0YwPCE8QFSrTN1wfewVengF938HmFl2i3uhdSm7U+9T1PftV0xOH
	HNYYdrDvFcTviFQvZq3kyKlF7FUs+edtAzDFWKjFIHVpqiUa79V+xtqIl7+AS86/hX4=
X-Gm-Gg: Acq92OEiybDxpWKsZOkNXb9CDKNtq5eYZOXboe3jewocMNRlTf9VroA2MxkjXuIG3yM
	UfJLuA2CRGfUb42CX/vDmqx1tmwx414qRPCwfVQVQF1BoVHO8d9mvYGGHk5/t7YnVFYuhB9HMaG
	9Ou4rUaBl+Nqdv0AKnFYJqjkgc0lc3A26KVk9Cfc8DIeOagtpNF3SQ2oTByMB1dlTOAgBAmGEFm
	+ny/NlCqCoXB8GVJjoL7OsMrzCZL7un8VlaVjMlrFJt+VZgwxNDsZSXYh7jrZP0hvM1qIFBEuU4
	bO7p1HB8ZoiXOQgfJkpwqUtPQjfngs5kOlRHjwsoNhXAEusnGhZqTvz+0/LQyrOUuOQfB2vggZi
	NRgmAZ2KtkGQ5uo50TEE8WQSXlpzgBUEdKYmzaQbaqQ9Ll0DeSvpQQTIxe7QskXZgBU6KZbQsYC
	FiD76YpirXz9vG+sJZiom581sOXud26vSurgcHV+DR/SERKLsTY+/m1DMWxi5CHJqeCC9mTXA=
X-Received: by 2002:a05:6830:6da2:b0:7e6:4181:89fd with SMTP id 46e09a7af769-7e641818bafmr6883498a34.22.1779894219002;
        Wed, 27 May 2026 08:03:39 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e606459bf7sm11486184a34.1.2026.05.27.08.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:03:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>
In-Reply-To: <20260527144042.2095194-1-tom.leiming@gmail.com>
References: <20260527144042.2095194-1-tom.leiming@gmail.com>
Subject: Re: [PATCH] ublk: set canceling flag even when disk is not
 allocated
Message-Id: <177989421749.747733.6714490209812219292.b4-ty@b4>
Date: Wed, 27 May 2026 09:03:37 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 27 May 2026 09:40:42 -0500, Ming Lei wrote:
> ublk_start_cancel() previously bailed out early when ublk_get_disk()
> returned NULL, treating it as "our disk has been dead".  That is correct
> for the post-teardown case, but it also wrongly covers the pre-start
> case: ublk_ctrl_start_dev() has not assigned ub->ub_disk yet, while
> io_uring is already tearing down the daemon's uring_cmds via
> ublk_uring_cmd_cancel_fn().
> 
> [...]

Applied, thanks!

[1/1] ublk: set canceling flag even when disk is not allocated
      commit: 1133b93fc7f63defaa2c07d5f49873c14bb74681

Best regards,
-- 
Jens Axboe



