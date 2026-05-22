Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AC92D595B
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779458775; cv=none; b=Q0GD2Ci8wie3MgO8xP+xYS1C/lqLeOFuRyyzA3QcJE6hqG8HaW4BNC129kLpnGWcxx83fiQv/OO7gEWZfF79rly7MA1gZAX23mzf1hJxSmVgLF4yDPwHUvsnd1XVcPMnkf8gDzYiGX8ycwN0oYfs/yZuOwFAbk//eVpgFYJN5Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779458775; c=relaxed/simple;
	bh=f5jJJCsM/JWR4CJNNEmGgr8EFzCJIp5shx+59/Q5bbs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Mgr7UwxFNGz2KIyhQQAE4Z5N4fblffGlxExeNIS1cPfqzLUhEpx84jBP4WCM9nmOes+ZAuZWXmTLK99rh461q0hCSzlrIlq5v6OsKqZx3JlQUPp7Lkcx0f9J9PKQ/EhmqEGnmbuRcqzU26uEBd6VK+CJ6w9D/QJf5w6ANpmhGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=IHmHbNF2; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="IHmHbNF2"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dcdca9aa0bso8305545a34.0
        for <linux-block@vger.kernel.org>; Fri, 22 May 2026 07:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779458769; x=1780063569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fvaOE7B1ECyC1nyX+SUmDStiqBkBUAeeeXWKxfVfgU=;
        b=IHmHbNF2SFtpkTm0Nnbwbst7Lwdo0UpFKtghWP+vB7Ct9qIcOus+7GZDCvpE3N7/RB
         OyRuW1dWnobYlNERVfkDfog84kWmKHWt8rdfmhKFXjbaTyTpCL38PAb8jMzr5ySV2VBM
         MoIKA62B/FDcWvjGcnWbsWjPQWqXLhxMpHGU+XRxqsmQ+2SVJm+efNFdyq2KYjASS90S
         Kd9iyEzvoOLdFXx8CvwvY4Wq+tkCRQiR/P2t8gC1tRvUP0gAZSWhGrHsUat1F3KY2cqQ
         QiJCR1ToD4vfTRZL26GSZpAClDhbAVvfhOTL64Usng3D9sjg7+rxPB4VORP9JnKtO4QC
         Sl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779458769; x=1780063569;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4fvaOE7B1ECyC1nyX+SUmDStiqBkBUAeeeXWKxfVfgU=;
        b=QfuABW5QRN/TZDuHVHefmC1jouGXypf1iBLFQKzJ3XDCQX7ORjU1EJyuRg46iSS5t2
         GO2Hm04XdV4Yzc16fnFiDfUyPzzIbH9BDLsmqmlXZZaLxzt6qdu8plXSJUBop0XKPQGF
         5Z7HdEimefMzDW1wf7jQpFQozBshmyzv6AZeyFFT5cP2XxLAW/QAeVYodhceJ8oKuLRg
         kbAWfmKEJtQfpy6JiYAer6SpezHr7FQUv6lJ4D9z5nrnfcBqfV/2zsEKjfue2kTRqtge
         DPtI0QcIcjiv/FmqPCv+dkyA/MNg/JGz105CuHWIhYKDGWqmgK83UEBduB2ZVd63zc0R
         aqIQ==
X-Gm-Message-State: AOJu0YxsCdZ+XuRicF4AHzVgbQNPonwNgnhZQgIc+lsPyleT0DY0+aiq
	a25iHmc5niaGRvui5v80z4g9b1yJOmWJVqOfyeNVd0R7xoSO9hEyvfEgyZjkaIpHBim7iyEo4BX
	hVrwm
X-Gm-Gg: Acq92OG2zvGUScJltpA1tp5SEK6w12+KajkJ7FL45qPHRTb5Lciw6NpWInMmJvy2q33
	R98FER2Ajqhfq3QH5BAjktrSaNmgbSK0br2PoJoGoc47tx+he19PjyU14aiUx6WpmfXDB92N47K
	+VnPtJ7bNv+msebbI0dqgyIX+vn2eJsWW04yvGMm+sa453TkR9xFG5e6mM+7qUupAs3NxAfs000
	J0XG8UXH7iOegs/4aqiGAaTlsuRU93vT9wTSOWnUJrI3ugbzAw3fzojzKVA4DWgccbGaPLIUdYX
	gKaD4cJW1YuTFyu/MrZ56I7n0TG3vrEKOM2TPg0q/YnuZiwSA/OfsMnUwCxwzjtRPY9YAnKg7gT
	W4RirQcAmb4K1OunzjSr/PeeAf2hOXB7g//UaJxitpmSrM8yJHihS8CvNbl2cuSk75hUpwyZost
	Y3mnMzYIZqzVxvMkYliPNVEOz6XBJJVoAwp7RjM9ON9Vkp0cwHkxK+hJz5sd1d54cwrjTvtdrsL
	ws=
X-Received: by 2002:a05:6808:509f:b0:47a:4fd:95f0 with SMTP id 5614622812f47-4852da34acamr4121680b6e.12.1779458769501;
        Fri, 22 May 2026 07:06:09 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4855476ab77sm554972b6e.17.2026.05.22.07.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 07:06:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260520203654.1413640-1-csander@purestorage.com>
References: <20260520203654.1413640-1-csander@purestorage.com>
Subject: Re: [PATCH 7.2 0/2] ublk: enable UBLK_F_SHMEM_ZC on zone appends
Message-Id: <177945876675.102352.10435069703677405073.b4-ty@b4>
Date: Fri, 22 May 2026 08:06:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 20 May 2026 14:36:52 -0600, Caleb Sander Mateos wrote:
> Commit 4d4a512a1f87 ("ublk: add PFN-based buffer matching in I/O path")
> added support to ublk_setup_iod() for matching request buffers against
> registered UBLK_F_SHMEM_ZC buffers, but missed adding it to
> ublk_setup_iod_zoned() for zoned requests. ublk_setup_iod_zoned()
> duplicates the code for initializing struct ublksrv_io_desc, making it
> easy to forget to keep them in sync. Move the common code to a helper
> function ublk_init_iod(). This allows zone appends to leverage the
> shared memory zero copy optimization.
> 
> [...]

Applied, thanks!

[1/2] ublk: move ublk_req_build_flags() earlier
      commit: eee9224affae6c1bfd664e5b769e40e3ff099879
[2/2] ublk: factor out ublk_init_iod() helper
      commit: 23130b3ffcdb1568a9ef178ab3cba866e5486082

Best regards,
-- 
Jens Axboe



