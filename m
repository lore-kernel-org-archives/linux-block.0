Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A24288514
	for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314434; cv=none; b=VGA9ltlFYEbx1U62WPnha9w30zQ5CQsyYTpCntBEhe1RBcRi+8WCmBa31aJhr/pHfmAAOZd3W3SMk9xCrZWJmyKslXZvNON4DAliKUjr2MIWQ0wN3bJvLq+oXuDSrHCSug01uQNlanEm+RUtDNu/NvpOklmBG+RAwWrYIhGTCHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314434; c=relaxed/simple;
	bh=hf6s52dLGZ0lpKJRZoRViqWJQptNB5oe1T70COAuRSM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kpThyjbJS5Xy7q9bYzcxjeOKOoVx0LD2OGfQauPQhjWRQ62iyNlcZyvCRsYu+jKh6n48gi5wd4jQG/H4eE23lW5LVIAexg72meHMEmQoBgLpICfpnVmEuzOPw6opeeUOm/prwYGrgnCawciW8nk/8ExpBTIguZ0qHczrhd63VGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0QbWSe50; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0QbWSe50"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-45391956bfcso5651906b6e.3
        for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 06:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768314432; x=1768919232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzKL7ZSdDLz29zbAC5Cajq0TXX02OSfm0cUmfKHWr1Y=;
        b=0QbWSe50NxRPuIG+fTy3V0YFvPKPEqtN4cKYY+A438s3Mg+iF9SRa3FCa8vlQskhRZ
         jdALXYq/pv8nT8i1VhNWuTpj90eB3UyghEjlcB3hz6HaEuka8cqQk7gd6z3P9QemuwNo
         9mCfiBvB6k1R9SAdMMMo5uFmA6yQuQwocXfpbOq4+VK3b+tZ/Ijm4EWbavDcrucuOVwT
         ahvKqXzfQtIp3oaWKHj5xXmsiZxvFkv1FIFHVf1FxRl6C8rBhK415xX2ZerA2v8V//2k
         pV5tYcFTxHf4/pjdH8iYAyqEKNnUc+rkVp/1x+FJvuYoTHAplTjEMAlgj4+FkjqinWr9
         m6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768314432; x=1768919232;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QzKL7ZSdDLz29zbAC5Cajq0TXX02OSfm0cUmfKHWr1Y=;
        b=lb8WRTTp3L5d7z8n+jf6rJ2kJ18cRQsHPwY19u7zRUjp5fTvtMOdGKY63whZ/oVKzY
         /LFqrFeCNAh1TGc6Vf9MHKLAugZ5fy5Wqe7RelguTX0djAxjvf5NzTpbjERmdNW2RF1q
         0hqnC4GkD9FuLkaGQFZaWQBTw5HsWvtCXowHQ9TZm/6jdF5QLHaocSWxM+PD6Fr28YcF
         lX2AiHpQG8Gny8Q+dFCxOau4yCJblMJMRMhwg1I3EauspTjOcSMBP4i3jNbCp7qOOQpp
         EjNJ6EQMx6ekP1JVfWEuAXCpsHfeToPRRRKKZ9/V9Mtskedn2f5IT+vBtgW/H85JArR4
         T/ug==
X-Gm-Message-State: AOJu0YwKfHHRCGV9V6oNHnw0g0efDLPV4QA0zPwQnhXZGJ+rQAEJSGWL
	TcS9p1qp5ZZQzobYrJNStZ3gKYe0WORoKF/eOuUqWU7BSBKoT+bF7mMeLd5JccXSfAA=
X-Gm-Gg: AY/fxX49zlphpQIfL2Ad1QCMS5ERuOmTIZ+JQDuzzo7+hDYLsKSivRY3DaBRcFhi8kI
	Y9vTiB2G70XxfAM/G5GNgMv5tzrH5+D0dWlBsUH2apggQ98BNDj6uItULGDsy4z6z8pVxYz6lvG
	VdDLZ8Y+i6XDNnQwsHPKunOSWPNZTaD59IDycRs9l+y0Ps/YGnAEOgSYD5N6KCpCNOuV23B1v6h
	77x1xDbka26gAOjd78Nw13OgajbChiNaj87PIkemeUk0C1iqOTahDW90JpQy9+eq5OoVaGQMmTp
	Dn3LdOJ/QHFgYRtQKjuNuQImnRfHzdBf09iEG8q2y8Yh5OOEc03PURJVavUo0pfcMcv8Q0YLuLH
	F4g52ViVhpMii9lrIxgGbwzDBfS79G8YW4jqYxBBrv+8cgc6zFtM1PTrG8PWRD+WEJBr5/agJMv
	L9Mxd/FUIziz9CiQ==
X-Google-Smtp-Source: AGHT+IGgoAVfUvQ5XNClJU9TQFXgAAOmUpO76vAflCfN019fvAQZ4m4UDxdQ4D8xBrgjsyvEsyTshA==
X-Received: by 2002:a05:6808:6508:b0:453:746a:c61c with SMTP id 5614622812f47-45a6bf00314mr11597395b6e.66.1768314431880;
        Tue, 13 Jan 2026 06:27:11 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-403fa2058f5sm456126fac.13.2026.01.13.06.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:27:10 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>
Cc: gjoyce@ibm.com, stable@vger.kernel.org, 
 Chaitanya Kulkarni <kch@nvidia.com>
In-Reply-To: <20260113065729.1764122-1-nilay@linux.ibm.com>
References: <20260113065729.1764122-1-nilay@linux.ibm.com>
Subject: Re: [PATCHv2] null_blk: fix kmemleak by releasing references to
 fault configfs items
Message-Id: <176831443053.313337.11697399001631923709.b4-ty@kernel.dk>
Date: Tue, 13 Jan 2026 07:27:10 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 13 Jan 2026 12:27:22 +0530, Nilay Shroff wrote:
> When CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is enabled, the null-blk
> driver sets up fault injection support by creating the timeout_inject,
> requeue_inject, and init_hctx_fault_inject configfs items as children
> of the top-level nullbX configfs group.
> 
> However, when the nullbX device is removed, the references taken to
> these fault-config configfs items are not released. As a result,
> kmemleak reports a memory leak, for example:
> 
> [...]

Applied, thanks!

[1/1] null_blk: fix kmemleak by releasing references to fault configfs items
      commit: 40b94ec7edbbb867c4e26a1a43d2b898f04b93c5

Best regards,
-- 
Jens Axboe



