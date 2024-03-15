Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E89E54745
	for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 22:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710543204; cv=none; b=TOxtSIRKuTJLLMATkdnYgq3P/bMV/LsLoS3fzbcp5p6yOKNEkneZ0s2CiRGigdC3zw7Dl9QmX38EabnUL2BjoEQnFJdrjxJwRT0/RO7np4x7hspetDWzMJJDFCDaHVrIQtAkCLvWfqzYkaJNPRyWuDWL2zPIehxuEu1/QMPy/WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710543204; c=relaxed/simple;
	bh=KukBDF47a2o9oLJYgrlrmtHZXua30WLdz55X9f1BMeU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MJcedfo2W1mVoykCiYQd8wkaqZHqWSNcYgumC65cmzVCTcDf3taE+z/0FLj+RTpaI7HNqng5h0QPLZD+j9FnI4QQlGkmELRBufbWJgSU3w0uWN3fWgqx27HkqzLddANeBO46D/UJetQtFYe0M+6EJ45uF4R7UOe0g6je7EvsIpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oxduklnU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oxduklnU"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e694337fffso608850b3a.1
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 15:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710543203; x=1711148003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=En6z+lg+gwktvkY6m+MElKf4+jRysCg/5WE78tzLxP0=;
        b=oxduklnU83OX8FuMUd1/ArTXuqU0Jw2f2V75UnT9sbgHs1qNm1HFid5KbZ4WqnaYN1
         wNNsNyfbpQi3kLJGU1d8R4SxOn02Wh8LC8BK62Hsy/YPeLQThgqXc31fXw6bpGD1xYC8
         YROcXJv1QrSqpIFjcl6UHE3v1GdcY2iDlup36ikWKkikAFyfGUXMcDZp1Dtm4eqU5L+N
         Qw98ZFHp8LXYpZBNOJmCvmB/fmT7P40apZ6NR0Y4ZtmU8tFtyu5cQ9Ij18449hDnSrA5
         5yZByWuYmlQZblEMbFiFw3AwDK/L556UJ08KqbK7OJG0NoUmr9k4VALvXuISYRTDt4iz
         7azQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710543203; x=1711148003;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=En6z+lg+gwktvkY6m+MElKf4+jRysCg/5WE78tzLxP0=;
        b=ruPMVYOFs7SA+r/wLnck38pQ24TXSBhdKi+HoSo3bUH9eTF1022RuskNffqlIUGRy4
         SmojK5H3ji1uguw5mbkLR9AwHZ44k9odqz++7g6d9ey8JB2PpIOaca8fmLm9EKoGIAI9
         GiNCBDzVwmwaFf8IuhmAltJjb59it3IfFsGsfUopa+vOCAXoZMsjbJPnhQnkFVIaHC4B
         SOZb9VT3+ikctoi05SbKu/dJ0dzblQQqytQDgHrgFoUVB39KZAIGpavmziXgjoFXBa6s
         14H/OwZQLlfy1LO2Q3oFJz6Mzm2VU+ucbG3fAb3BOCaMiVzZQIeTi4wsras0hd8tIkxY
         MAYw==
X-Gm-Message-State: AOJu0YwIIynCruJo00Vwk01+VsMVOaQXrf+7pZfcJHCfBKjfv3lQOA72
	PW2oShlAemwJ4TlVQZrPQJT6J6VIf51/nuCk9cKwPBUxnT/miwEPkir6neqwLS4=
X-Google-Smtp-Source: AGHT+IFsZXgseueBAmDMJVF+oQwU1cC65fn42Y9GYzFcYhYiZnAwPnhfGYJqqNY+B2UZcJ6MWC/ARw==
X-Received: by 2002:a17:902:ce91:b0:1dc:df03:ad86 with SMTP id f17-20020a170902ce9100b001dcdf03ad86mr4997005plg.2.1710543202831;
        Fri, 15 Mar 2024 15:53:22 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902d48600b001ddde0fc02csm4443948plg.129.2024.03.15.15.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 15:53:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>, 
 Ming Lei <ming.lei@redhat.com>
In-Reply-To: <cover.1710514702.git.asml.silence@gmail.com>
References: <cover.1710514702.git.asml.silence@gmail.com>
Subject: Re: (subset) [PATCH 00/11] remove aux CQE caches
Message-Id: <171054320158.386037.13510354610893597382.b4-ty@kernel.dk>
Date: Fri, 15 Mar 2024 16:53:21 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 15 Mar 2024 15:29:50 +0000, Pavel Begunkov wrote:
> Patch 1 is a fix.
> 
> Patches 2-7 are cleanups mainly dealing with issue_flags conversions,
> misundertsandings of the flags and of the tw state. It'd be great to have
> even without even w/o the rest.
> 
> 8-11 mandate ctx locking for task_work and finally removes the CQE
> caches, instead we post directly into the CQ. Note that the cache is
> used by multishot auxiliary completions.
> 
> [...]

Applied, thanks!

[02/11] io_uring/cmd: kill one issue_flags to tw conversion
        commit: 31ab0342cf6434e1e2879d12f0526830ce97365d
[03/11] io_uring/cmd: fix tw <-> issue_flags conversion
        commit: b48f3e29b89055894b3f50c657658c325b5b49fd
[04/11] io_uring/cmd: introduce io_uring_cmd_complete
        commit: c5b4c92ca69215c0af17e4e9d8c84c8942f3257d
[05/11] ublk: don't hard code IO_URING_F_UNLOCKED
        commit: c54cfb81fe1774231fca952eff928389bfc3b2e3
[06/11] nvme/io_uring: don't hard code IO_URING_F_UNLOCKED
        commit: 800a90681f3c3383660a8e3e2d279e0f056afaee
[07/11] io_uring/rw: avoid punting to io-wq directly
        commit: 56d565d54373c17b7620fc605c899c41968e48d0
[08/11] io_uring: force tw ctx locking
        commit: f087cdd065af0418ffc8a9ed39eadc93347efdd5
[09/11] io_uring: remove struct io_tw_state::locked
        commit: 339f8d66e996ec52b47221448ff4b3534cc9a58d
[10/11] io_uring: refactor io_fill_cqe_req_aux
        commit: 7b31c3964b769a6a16c4e414baa8094b441e498e
[11/11] io_uring: get rid of intermediate aux cqe caches
        commit: 5a475a1f47412a44ed184aac04b9ff0aeaa31d65

Best regards,
-- 
Jens Axboe



