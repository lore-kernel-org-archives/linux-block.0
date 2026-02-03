Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0E73A8FE2
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128322; cv=none; b=ReASzQFWXcT9tnvopLLef3hiZ4YChLocXYQoZPOlX+yYbgJrNUPeEEuWnveMbQ+9DUIQpy6kLHmnPVUcPbS4zVK791K1yWRGLYGguSRlClC9hWSmBqN4IWP5ke7BD40xTyhgneGiMLVNWyZtlpX8iKqYtf+TNY/AG4BSKhrPy1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128322; c=relaxed/simple;
	bh=0BhorpACNUl4Cwrl2jZ0JWi7TG8vpJ10g9B08vNYnr4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EY2+UxxIRH8hwsV6VQ2mN7n5K/RaQ7E/spyiRtbp0/0FLkq8UQA9uvNPabhsP54b3NJ+GJW694C3di34dZcfYQlW2tQR9y7sQyw8wjRXAaSYIhmh9xq54C8J1/VrdlfbCDOZukEYujBMJFgYFFUcUPxTZN0n7BiyFixgcqALQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JuV9jenV; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JuV9jenV"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-45f015a3259so2157307b6e.2
        for <linux-block@vger.kernel.org>; Tue, 03 Feb 2026 06:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770128318; x=1770733118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftziA6tdxyXPX3qXiu9MtZHw8CpYDliMRtslvchTnUk=;
        b=JuV9jenVMD3WcV/sSHjI5inLMkHrQbWS/4gMqulNR/tQUwTjnxd6D7PuRPLaO74B7/
         8w4oxVX0LcLL9rf9tdxX+LXUN3D9Ew1DjmqKTnt2CRjqsBP/LZiIv/tBJ1+nM+DQrhpd
         zYfRRJff+N4Rh0o6R2rDqJc3gLPoDr4ejX2ojsTqWpOGeMkyaXRD7Y41bjrorJVzZAk0
         UmF5IM/iT0PB/LCrAGOreWNyYMJlCESt5ZHMsESl0pVlbIZgYZ2ug1Lt3+kEi1haW1sr
         I4a4wJ5NQ6ZjLsKZYVshf3Cecu8dUnKZT8e7eX1ETobDbHEWoIfzBLArEwN/hQiUZHZi
         P1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770128318; x=1770733118;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ftziA6tdxyXPX3qXiu9MtZHw8CpYDliMRtslvchTnUk=;
        b=kLSr62LQuU4kQ0GtJJf7jPpZ2jCbj6cbQqThBJ8bdzV1kT7LZGpOoD/6FD/zLAkZ7g
         yTkTXjXpMG95BR7nKSOidqhePzGCtcmuV/alW0r3y/xB6y3ZmrUsWgqwsxeGIHcF21kb
         JphyRIb+gcCuyMeDie23pyGsXO8AUgmzI/F2mJWQ4LHqfd7SPtaeDobvQJ8AEh7mzMZS
         Uj7zjXeqSswrIQO6EzDdl7Qkdy8yfNUeX+OVPxtxEjRJ9XErY+I/ehklvJZIXPa/kBMh
         YzqnMvxlUdBegdteBxNvxw2DlhbsnjiQY/IBW44fflROMdXvfQO7DcLzmiuHn/3TyBPr
         WbUA==
X-Gm-Message-State: AOJu0YyfA+dc5KaT/zNOuWGe8LdUcZ+oMzayskgFp9n9sBsoCnoGWt3m
	58Nd5Jpzo3h67Dxrp7LVIHOM9Iq2/Nf+4Mtj+AK2eixd1fEru3uUYF9/RiICEvvDhj8=
X-Gm-Gg: AZuq6aIjq47R3sBYNFevzt7pWANpGBRJ4/LqtN0OXzO/vgxqDiOfriYlP7K5Yk2V7W5
	MaMT28iYw/c1t/EzshOhDibcOqvfxY3YoumJwSk0oKAffwhjzCdrIxohco4EAMZe1gzSdq3PSPa
	D6nIBZxl8RyU8nGEHIHkqW118aUXsEx7AUx6JxWRv0tZ1918hlahyxvettBNKRkqtc88nLLrHYl
	Y28EUpP84uO430b6s1TAbqNgMgjkoBy+zzcM5nfmCtffkR+fcPsAfsSWt0tzimI34vwPLsr5KBU
	s7tXsh02cjFnGdZUWvFEpi2fWyk7aNvLLWv76gpFOkJvir8bKo6oKPBH2nLmCXlk6CoC+/t9M8L
	Tc9mPK96Yz/zxd2aqfwQZd6zRSS4CCVLarehTb/xlu8g8V3dkmm7RETUlSdrQsrv6hh2PlcX00x
	dAU6+ZpJzmtLAFA1i92IGapoLGpv0kTwNqeelLFlqtgTfG06fZ0ZGwU97HMK2yG8ff
X-Received: by 2002:a05:6808:3a10:b0:450:c321:d50d with SMTP id 5614622812f47-45f34ca28d6mr8251081b6e.40.1770128317874;
        Tue, 03 Feb 2026 06:18:37 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462cb7ca939sm611916b6e.9.2026.02.03.06.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 06:18:36 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, tj@kernel.org, nilay@linux.ibm.com, 
 ming.lei@redhat.com, Yu Kuai <yukuai@fnnas.com>
Cc: bvanassche@acm.org, hare@suse.de
In-Reply-To: <20260203081952.732210-1-yukuai@fnnas.com>
References: <20260203081952.732210-1-yukuai@fnnas.com>
Subject: Re: [PATCH v7 0/8] blk-mq: introduce new queue attribute
 async_depth
Message-Id: <177012831648.1184270.13164634466085803116.b4-ty@kernel.dk>
Date: Tue, 03 Feb 2026 07:18:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 03 Feb 2026 16:19:41 +0800, Yu Kuai wrote:
> Changes in v7:
>  - add review tag;
>  - rebase with for-7.0/block;
> Changes in v6:
>  - split patch 3 to factor out a helper;
>  - improve some wording;
> Changes in v5:
>  - just resend with new email server;
> Changes in v4:
>  - add review tag for the last patch 3;
>  - rebase with my new email address, patches are not changed;
> Changes in v3:
>  - use guard()/scope_guard() in patch 3;
>  - add review tag other than patch 3;
> Changes in v2:
>  - keep limit_depth() method for kyber and mq-deadline in patch 3;
>  - add description about sysfs api change for kyber and mq-deadline;
>  - improve documentation in patch 7;
>  - add review tag for patch 1;
> 
> [...]

Applied, thanks!

[1/8] block: convert nr_requests to unsigned int
      commit: 73e0b2945d4b54fa826ecb7d01e5e42a355ecfb7
[2/8] blk-mq-sched: unify elevators checking for async requests
      commit: 8209353834bdded4019e2a13b1e1555e3076eaef
[3/8] blk-mq: factor out a helper blk_mq_limit_depth()
      commit: c35c0d11265819063335583dd791a42ffc3b84d7
[4/8] blk-mq: add a new queue sysfs attribute async_depth
      commit: 012379e5fb1d7c56e894b1d1d81e564a567e9ef5
[5/8] kyber: covert to use request_queue->async_depth
      commit: 5400a8a9adfdfa90fc1a5d8f999e20c142360e72
[6/8] mq-deadline: covert to use request_queue->async_depth
      commit: 80383e7ffab9b40a4bf26bd13e1a7c53cea3fa87
[7/8] block, bfq: convert to use request_queue->async_depth
      commit: cbb8e161097d29b65352e84a2016f5b54667a927
[8/8] blk-mq: add documentation for new queue attribute async_dpeth
      commit: f6f4162bf702e44d59ae75c17c1d268664591b7e

Best regards,
-- 
Jens Axboe



