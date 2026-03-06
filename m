Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB54F37C11A
	for <linux-block@vger.kernel.org>; Fri,  6 Mar 2026 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772796365; cv=none; b=FT1N02SqwfDjp4qctEaKLQ/EhRIvgp+IJYrTRNJK4N8hbAf/EmqAZtpbBQzHX8klXPWyrR+Oe3lC26k2tAvb6kDlnsG4MggODdEJ7sM+TvFKRQsl7DD67vYGVgAZq+6fcLbZv83pHu1nPV+Xih8XuHGs57Q2bpsTyqLN7HTOFFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772796365; c=relaxed/simple;
	bh=jAGSKj1ZsgiqwMByh0L+FjCY51vEgZrFGEp0Xvl+V78=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A/DnXQGHaN7Lvn9tptEr73bcQ9NlQDYgghjF3wauDHccSJwyrxxhP5tYFSj1VaxZtjYzE6DLYPlLgbe3hFmXYQySDJZjejv04ylRmJixk/bVl+0AQx6FrjdC7CBZydisEUpElkENDufVEI1FkuvBSnrDMhvN5ebqM02reNG/mZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fxRsu4eN; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fxRsu4eN"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64ca09f2170so9529603d50.1
        for <linux-block@vger.kernel.org>; Fri, 06 Mar 2026 03:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772796363; x=1773401163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CY5l8ywo2gfwV8s6iTms1Cd6/EkzG/nG2cleNFaj6AE=;
        b=fxRsu4eNGypRs0WamIJoEq5Pjj5DD1rfqULA8/qZugTdoAi9SDe9JnZIXIGGhALWjO
         0U4jJ/ZNcq+FLUkU6QFR3rop6vgZReg+mGvqNFSAiyxlQ5GYEPGA4k/vkROhd0Ct01LZ
         hxUv03v5fMZcuMHRBjP1iCrxzGiHbxrk1VjwOWxRAzvs+Lhcg2ZnFGm9vZ7Mi9t2TQBt
         9dwN26txz15KjlhJdii8VP/hKDk67oUnoNsKqX2s6wgvcT0lx0iiT4bwe4e4xHQ3901D
         YDy9X+MQ1c9fr540nt0AJunGLOj9wS/89Mqh+WKg3KEGXuSF1VpaQnO1kUQDM1eMGrj8
         3tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772796363; x=1773401163;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CY5l8ywo2gfwV8s6iTms1Cd6/EkzG/nG2cleNFaj6AE=;
        b=HNW6sbi1xjkKB3QsVpaYhTMs7S74nirsWP+mWaTvkCvshZ/5J3eF2YSjQZqQ2vPo4K
         YsWFJB7+I/ums5S5dUN/VgPUrzpwV0u4oRqZnZGx4jPfkWC1TAsKCYCnE+i9rfVjVB5e
         JHGZpDplQVSG7q8J5kMpnN1laTJdQCbgnRDlVbbnYXCUKBFGIKcMzpeHXcNv3e1PQ0hV
         YPyvTQ79DIN3FIEfUq2wbAreFumJkdqDH1XEkV0QqKVMK0bF8ytR87cui1lCiTRPkrXi
         VV0UXrYu1BswQNOF92pK9m37JwQzzT58s6bicH7qIkk2m/0OZIPEcr8wjmPGDDJRbVUM
         GPIA==
X-Gm-Message-State: AOJu0YzhsuxL4G7NUF2hr0O+uFNLLWqUC9Ju9lidMe9afwXBs0LiMjPL
	LZo1KeHnsVOQJxWbm1NCTTQgz2fBjQ72eCYBJzLXlbGhCY51oK8E8eEiaQxKXCKJO/U=
X-Gm-Gg: ATEYQzxKnIuhoTakY1jn2CPTnThtoEFUXaVDgtLu1nIe+khoB0wLC6oz/VsO5AG8NUi
	uvNBj3Qw9iZwunjBU3AIUptOY5nXRM7HT8q+20VbwIuw0BiSOxuGkSF44GnuP8vUxX7YUn5JwZL
	aa5PYlNEuRzkguGcxJP1T3qm/lKUB5HkKP+9efqtMooTpUoC34/1wZ0+qXq+u87RjCwU5lBmQ6J
	4rbMQsdHWto0yWSxZ7aSU5QHfOXdVcpuzaiaFSe24UiFVGseMvPooO1ckw+riPKz808qvX4FS5S
	0OQQOcjXvYaFWs2NizW/CbBIMjNVm5w8RZbh+KeSiY66HlmhAA0Hg3wa5lJBPTcsdxE39aRfrNX
	FsjEtFKv6c0Kdm0+7om+btpD4Otloh7maHVujgatR9rLybTBAYMu32D2j7SX+Gx7c1DIaWO/8Rx
	VNkSg/Nv9OSHVfr9qNxYIvdUmGUHWmYUAV3qMXL9KAeHOrYKntFJ/M1tLixrlNzs0=
X-Received: by 2002:a53:e1a3:0:b0:64c:96e9:43bb with SMTP id 956f58d0204a3-64d141961a1mr1289970d50.34.1772796362748;
        Fri, 06 Mar 2026 03:26:02 -0800 (PST)
Received: from [127.0.0.1] ([2601:703:4183:37b0::7115])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d176e70e7sm555642d50.20.2026.03.06.03.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 03:26:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, Mehul Rao <mehulrao@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260305193146.304526-1-mehulrao@gmail.com>
References: <20260305193146.304526-1-mehulrao@gmail.com>
Subject: Re: [PATCH] ublk: fix NULL pointer dereference in
 ublk_ctrl_set_size()
Message-Id: <177279636192.680057.1248751372115881016.b4-ty@kernel.dk>
Date: Fri, 06 Mar 2026 04:26:01 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 05 Mar 2026 14:31:46 -0500, Mehul Rao wrote:
> ublk_ctrl_set_size() unconditionally dereferences ub->ub_disk via
> set_capacity_and_notify() without checking if it is NULL.
> 
> ub->ub_disk is NULL before UBLK_CMD_START_DEV completes (it is only
> assigned in ublk_ctrl_start_dev()) and after UBLK_CMD_STOP_DEV runs
> (ublk_detach_disk() sets it to NULL). Since the UBLK_CMD_UPDATE_SIZE
> handler performs no state validation, a user can trigger a NULL pointer
> dereference by sending UPDATE_SIZE to a device that has been added but
> not yet started, or one that has been stopped.
> 
> [...]

Applied, thanks!

[1/1] ublk: fix NULL pointer dereference in ublk_ctrl_set_size()
      commit: 25966fc097691e5c925ad080f64a2f19c5fd940a

Best regards,
-- 
Jens Axboe



