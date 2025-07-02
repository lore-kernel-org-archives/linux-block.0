Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66A42DE6FD
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488675; cv=none; b=NafeeWPJmIzNb+leMEPLrui4NQbaK2G3BcM4wREOTn+fOvjEEyysoScfugo0dZdwwo6nBbwatEi4dbK9/HqtSdNSGuttPJm1vt2/NQo9zL1cwOEotITi2b2TInRAcR30SoBVvjVO3i95xNDEP+0cEBSOCHTaej9WdjyGFwvA+o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488675; c=relaxed/simple;
	bh=SMrF7il7A7IBEPMN4vcSWUohZne1mN0sTm9+vd1z90w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlY+3guFKP4EWm8tsfVVs8/lvivtUljWv2ccs+SfsptmTYxKYYvNPxaA8tjF2ArePiCU6JzlrsdDMxfeSTNPXh1mWqZyh+jovyo2bqDdcmrOLSO37Tc6kGCBaJNCB2DyhvIEVXbo61LqVQjixHtN+iOW9lDtjPnQ0xOHCafdAZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GKbRBeVo; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GKbRBeVo"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313fab41fd5so1582288a91.1
        for <linux-block@vger.kernel.org>; Wed, 02 Jul 2025 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1751488673; x=1752093473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMrF7il7A7IBEPMN4vcSWUohZne1mN0sTm9+vd1z90w=;
        b=GKbRBeVoLIUvEAGYoxBvT59KvSTMmAXbjyr5PabB9HbhZmlKEblZINud2g5GFffRAR
         beMw6vG9lS/NRBmL5KL2ErPdG990L4QB1Wv2UZka3gp/gVv4f4BN98svP5X0gtq9j1ZW
         NVvS0Z0s8tdVk10JAtuzwD/cbw236zGZu+f78SKw41QCl0oaAKrU8rsSnlYmGqypm/Qd
         eeqWM4YGQ8Sp/oXGSP+9k2NF2HxYo5kSX9KIqZPl6uHFn7YENto116CeTy2VfBs+e5pi
         UaPNZobNHzd9r8W6rQjZHEUy8VsF7jqYo87wWvBLUxOzVgHR7dfd8nmnVpuC21GjKR1v
         Arsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751488673; x=1752093473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMrF7il7A7IBEPMN4vcSWUohZne1mN0sTm9+vd1z90w=;
        b=AqYXtdXoUTniP01GKQefg02vdhRsIBNM5ieOPWQm/l/ocJ0oMKWUTK6jX66s9UQ53j
         ST3Pk6XrEZwPY+iEuKqY+awX+oUIWGhQQwIkBRUMWAvVle2zwK65iD5mt0p1N9TelzGf
         ZZ6i2W+RRpYV0f5vQlpoPoSJ+ESdF7CbdGK6IZdUl2Vq4W862xlgh0qrRShw25krd1k1
         1Wed4i2BGgy8i7Gl/+c0RqxMcvGawB0RXYuqKzVs/0gQDLUzo1epAcPEQsG5tJTSbQXA
         RuCH2bIJm7/F8ZmuKXSrivvj0nua7ULb25NnBqxG6uaBRWA3U223LlfSiHHdnj1/K/YD
         Fnvw==
X-Forwarded-Encrypted: i=1; AJvYcCXxBgS8qer1aRHlcfdq2xVCb0l4u5x1VB9ffz9kYcVL0DYD/gQWytdBpuj1yj8IfYi3hsjQhxWTv41jUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwQlp68V5rgiIj7CR7BAmmIO9Z73oL0d7ZOrQS2SGZpaWn2NLV
	Bcgr4332Shm2lFV6TKqyqmUSafq8kX90PRDenXYMBWOkRjJzq0rn+LUxzD8KqrtIKRnNl++oEVH
	wfc58aaDLuEKBJQU2xaaXLwgMWSAaagIZZ5w0g56GQqQB9dtRWB8HJhkBYw==
X-Gm-Gg: ASbGncvxW2qEnJr8Ntl1DgpujUn4tODxqc8W8Q1X7W5TFkDL0gGk9Am4cIjZtPcBjPC
	pWVrUgl7KkYgdKMxxLD4qqOT8Ut2IV7kIHjUabYAVMDRPIvauXfTl9gamFi9De6Egg743XRrg1P
	/twPm4mc0PpJZPlDCdwQ04SAppoqjREbd/h9C+Hc0FKT8=
X-Google-Smtp-Source: AGHT+IHqyFueId85/bJY6vE/qBSACxq7P9GAxpLpYvPSwLhhzM7AqJZfJZId3JATc4Q6btmtc3vcXTWsyT9avJ8vTxY=
X-Received: by 2002:a17:90b:6ce:b0:311:c5d9:2c8b with SMTP id
 98e67ed59e1d1-31a90becd9cmr2535254a91.5.1751488673029; Wed, 02 Jul 2025
 13:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701072325.1458109-1-ming.lei@redhat.com>
In-Reply-To: <20250701072325.1458109-1-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 2 Jul 2025 16:37:41 -0400
X-Gm-Features: Ac12FXwvS-Iib_n3kZuF-VGKe5i32r34YUhzsrkA-FHbVe10Ciy6qNdXvpke8Ys
Message-ID: <CADUfDZpeaJfPaYAGkQgAOF6cPquoTxrwXpb0rwKmFcR0nmfyqQ@mail.gmail.com>
Subject: Re: [PATCH] ublk: don't queue request if the associated uring_cmd is canceled
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Changhui Zhong <czhong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 3:23=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Commit 524346e9d79f ("ublk: build batch from IOs in same io_ring_ctx and =
io task")
> need to dereference `io->cmd` for checking if the IO can be added to curr=
ent
> batch, see ublk_belong_to_same_batch() and io_uring_cmd_ctx_handle(). How=
ever,
> `io->cmd` may become invalid after the uring_cmd is canceled.
>
> Fixes it by only allowing to queue this IO in case that ublk_prep_req()
> returns `BLK_STS_OK`, when 'io->cmd' is guaranteed to be valid.
>
> Reported-by: Changhui Zhong <czhong@redhat.com>
> Fixes: 524346e9d79f ("ublk: build batch from IOs in same io_ring_ctx and =
io task")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
