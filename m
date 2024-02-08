Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2910283CAB
	for <linux-block@vger.kernel.org>; Thu,  8 Feb 2024 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412370; cv=none; b=PNHRRAFiv4cEUb8eKEtHPrRF322q+3btjJKHFzr4ignsQB68kcrYG/Zor0Y/F1f7gLF7EViUI7K5el9+4KACK0jU7V/RW/c1QDrEpZdi8fdjJg+oRgzuAqe6R355hNU7Hl5ql/V9qctx7iC0wt6KtA0NpMGeglFjsohWGuidRss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412370; c=relaxed/simple;
	bh=AIEgU0V1g1nSho2UWkRURvPzJPm9oPVlHGX6wRLgm6E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O4WnNAy6lBnoMmLAxmxfVRxW/c11SqTz6TW3ypxzzt6I6NIiKG7bob2ZIHDCM3sqL+WsChHQprCHyYBxxdIrTlSGHYLz+xE6g7JAWIGCD+pU5PMSPWNBgNPJUTbztocasvghj8SgJPQ1vZypow/sS7+50Bgic1JzxSmaDjr7Ns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NCkfAQFd; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NCkfAQFd"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso9889339f.0
        for <linux-block@vger.kernel.org>; Thu, 08 Feb 2024 09:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707412367; x=1708017167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsCIZkl0nmR84Phg+akbf2xIXLOesyEDRMsbgKsDjIo=;
        b=NCkfAQFdqMH9ohzyEphPAE2XdnKgwOnqg3lFy9X1l1AcYjXq8XWw75LsOCGOwMcBFh
         M0wuCnuSLfgELfIKmxOONPNxlOwBU+5LZMTXR735BvRSIBJCQRV0L6eVtweVeuZxx6MP
         dnfeVNsn3/n21on4WaRPk1aSzgfnIU7ohWdxtdXOYb5BrxV8z9S1FYQBqZQ/a3SkFM2E
         FqJFYbOey5BSaMFCKSPamrkoCS6/shD1bXgv4Ed0GqnkJ9i6ARj2a/IBieQra7i3m1/Y
         oGb02vihDIsgfrSH5dro+FtE1f8dCBVnwC/3n3gji+HfjV9saqvmTMBI5shapfRBCcb4
         hlqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707412367; x=1708017167;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsCIZkl0nmR84Phg+akbf2xIXLOesyEDRMsbgKsDjIo=;
        b=iGvFblNzoko+8yJno6woOpJls/T0oyVY83pQeWPdNfSHSzEGg3f+C5z46CQA3CilIS
         2Vjmo1lCKPUWNS72ZwJWtAIq/e9iN9Zs7SjgyDNj0+gdHrhz2K4eh389u52A+MFv73If
         JMowHk11XqUV6CBdOwa5gF5KMoPTY3pupqCySePwhbb7bRQ9dKmy2YgrzFQnDUl5lAWM
         01e7LSHTbhDdoSFEborIBW8YyufpTRaS91BqQUgZijBDrLUhbCAdU1ekY7+vEnqtlbTZ
         A9lLc+VK3ygGj5OJPHw5a8AP4kxC0YbBGHF4749Nymm99gm2RA3qjEpDEo0L4j6AFjg4
         Z5Zw==
X-Forwarded-Encrypted: i=1; AJvYcCU1gJhRvNvem1iwJt2OlBxoFqneRlhI4j51pEl7jA4JHGtQQTsaLwcE7J16J9Z77cfZ6JOB+O0iIyNI8zvFBBjsuqNul0dNYlfpCC0=
X-Gm-Message-State: AOJu0YzX4bHZv9cnKN6x1bCetEPRiMvZehIx139E3+xKoXc6CkXauOLT
	BDDJgKUrjnteFoxGNUkTsDlyewL/ijwMDLBe5jSkyjIsD/L+9vg0RKtgiC8pMYEhszLF1gdp093
	4oL0=
X-Google-Smtp-Source: AGHT+IHTeFLLa4+D4qPa0huYZiUSegoj8zJfG3N22QhdohjlsQlehD4ZYeolut4A2dGViw77zuv9yg==
X-Received: by 2002:a6b:671c:0:b0:7c3:f955:ada6 with SMTP id b28-20020a6b671c000000b007c3f955ada6mr245680ioc.1.1707412366769;
        Thu, 08 Feb 2024 09:12:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0zKLtzwp/gGBW9veUdkDIdKwee5n7OzI3gMx5Q9bg40rPF69E8Bm9vIFHoLqjjYIl7jEQ+5PndyCFlXnS0JYJa5qhRvtoP7vF8F5Ds4ZhCrxwwXPDjZ7qlIhjDMDG/wb2Y21heBXXuEM=
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b23-20020a05663801b700b004713f3c2831sm993173jaq.61.2024.02.08.09.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:12:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>
Cc: =?utf-8?q?Breno_Leit=C3=A3o?= <leitao@debian.org>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <ZVvc9L_CYk5LO1fT@slm.duckdns.org>
References: <ZVvc9L_CYk5LO1fT@slm.duckdns.org>
Subject: Re: [PATCH block-6.7] blk-iocost: Fix an UBSAN shift-out-of-bounds
 warning
Message-Id: <170741236605.1366825.11529079339239149351.b4-ty@kernel.dk>
Date: Thu, 08 Feb 2024 10:12:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 20 Nov 2023 12:25:56 -1000, Tejun Heo wrote:
> When iocg_kick_delay() is called from a CPU different than the one which set
> the delay, @now may be in the past of @iocg->delay_at leading to the
> following warning:
> 
>   UBSAN: shift-out-of-bounds in block/blk-iocost.c:1359:23
>   shift exponent 18446744073709 is too large for 64-bit type 'u64' (aka 'unsigned long long')
>   ...
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x79/0xc0
>    __ubsan_handle_shift_out_of_bounds+0x2ab/0x300
>    iocg_kick_delay+0x222/0x230
>    ioc_rqos_merge+0x1d7/0x2c0
>    __rq_qos_merge+0x2c/0x80
>    bio_attempt_back_merge+0x83/0x190
>    blk_attempt_plug_merge+0x101/0x150
>    blk_mq_submit_bio+0x2b1/0x720
>    submit_bio_noacct_nocheck+0x320/0x3e0
>    __swap_writepage+0x2ab/0x9d0
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: Fix an UBSAN shift-out-of-bounds warning
      (no commit info)

Best regards,
-- 
Jens Axboe



