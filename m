Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159C22747B
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 00:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750985258; cv=none; b=VvyT6uBdbYmbXMZ55H8C7ELdm8FkZeand+F40CVtYJIXEpdXDYB9nITphdkpVe9ThcdQicb8Z6KmrGJIzHAEc4j1uXnMP44zwnNnUtf9ExSMrR7qy9SIxLPStHC2BleADTVtYHmTcdXPUkBPTwTMn4koEUfqVp8Ti6WGH2kJizU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750985258; c=relaxed/simple;
	bh=bOQVGPGbLlZAJa7nExqZEvipmn396y6FOXxYEjxKqn0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jwlPpJEzIOxxZFg+rFlyefaAHor4rmHWLRlL/rFbCMQRZD/OMj4HLBcPqO+boaUzaH8jDrPCVA9Qe/1OnSH+O2OmatFcnx+9IP/BgZ1UZpoNd13Nt4jJt+80HhRXI5+2zOERL/dsMVeQzaiCuyTDTVmsYRCAf0KAjGnu/3MMCMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ByVZzJtD; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ByVZzJtD"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso1947523a91.0
        for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 17:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750985253; x=1751590053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXcF54MHkWhvjl48tAJDQZ0YAW1XI1MVhqOlLMlRD6k=;
        b=ByVZzJtDafvsP5aa+2Gl4UljUWVPD27ZtijclXG5ywQ5EOKM7xE0qxNZkQRKRpzyRL
         bHujxonqp1r8jR2FkdKBx+WDaZi8AFj1vwCPPSKOaltOt1TUeIybD/h6S9Ac/JaGbyTg
         Fr+xMc5K5SbZQs1now3TW/ubKm1FNoeDCoao3LRv+8vyDaETjlM5AqmJ8XgMNJonXAjY
         cMyTX5JC30iblu+U+EIwdBN2rt4W8Ur1HOgZivfDIQ6GcOzuzynGB2EKLD+yN6qzdGtK
         JgtKvovVqz3bIW18kCzLYU2TfgnLmdMIjIe1p3NoXOBuBXng2fAXBOajr6ZHGbNsSyu1
         XseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750985253; x=1751590053;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXcF54MHkWhvjl48tAJDQZ0YAW1XI1MVhqOlLMlRD6k=;
        b=cyXoTEggySDjO2r1pqQUaF5OAzdH+jWHItDVsCZNdJk7CtXJhNlnZi5qm8PDbd86wP
         0e/I3umee12OWd+krBxqzmUtg1FeVaCVKSXRTQw8gbcdyN37WawsMb74fIT0nLYUuiOL
         kmYnV5GvLhRV/n+gAlsICVsclrZqmhShjvmwk03Jxlo7TNWSQIFR5dgBkL/KiHr+xj6Q
         qB/xj5xmnQxVCQPKrGJcER08q4bzuFjfYoGKdzGytC/yhQeNN1s2tzjb3cJkAFwzuNID
         CYCEH7dEQzh+l9z+3qHN9oRke9qQgcjrntWc6cDCn8czIhXXcfZzK4n+Gb6drcnLvVEY
         ZgQQ==
X-Gm-Message-State: AOJu0Yy1O8KOCuJ2K+sMy2ykcIC2tI3YjhhWCJb9rZZpa0+S2MC0jG5g
	qFgUokpQgJeTC9q1yjc2L/O7z5GbSC6GopBx7/uBrXxGWL9eyzo4sfuetucFsaixkzs=
X-Gm-Gg: ASbGnctQASZ++PXcjuxHAwapsrcrJ+Dai/zEGiS2j3LS0Pk/O7Sgl1J4EHFe4BYMfKM
	mqr9D1/B6C5lB+vtN0tLY9UAeWAV0e+cHgRwecvX5z5Owt8Ok/oLawjC5JqurqXLFP9/yindMFp
	mqJW3odrr5FGezzvPfy24CRVk5DZ3tfqud8xE4gpGv2+UA8oJ14wbFjBSjbDdFygjpRDJn9EspT
	e8uMkHITTkiPkArhwfwm7yX+1ooEJqzDNKT+TR8gU9+M9byk+xB31XOJe5I8uMa9+duRVPsr6Q0
	9k6XELfAmOCz9ShS/mrA8EzThrxFt5q6zIS1pAGv46PyRSBWxlDvTA==
X-Google-Smtp-Source: AGHT+IEwV09l5JNm/1bcLiOprAt5YQ8EvIsB1LrXoqbfGMlf+KjE4dXctIFWZb/QTBkUY2mjJMFZCg==
X-Received: by 2002:a17:90b:254b:b0:313:279d:665c with SMTP id 98e67ed59e1d1-318c8ee539dmr1543113a91.7.1750985253046;
        Thu, 26 Jun 2025 17:47:33 -0700 (PDT)
Received: from [127.0.0.1] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f54270a5sm5536037a91.25.2025.06.26.17.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 17:47:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20250620151008.3976463-1-csander@purestorage.com>
References: <20250620151008.3976463-1-csander@purestorage.com>
Subject: Re: [PATCH v2 00/14] ublk: allow off-daemon zero-copy buffer
 registration
Message-Id: <175098525219.298187.9518585117655894766.b4-ty@kernel.dk>
Date: Thu, 26 Jun 2025 18:47:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Fri, 20 Jun 2025 09:09:54 -0600, Caleb Sander Mateos wrote:
> Currently ublk zero-copy requires ublk request buffers to be registered
> and unregistered by the ublk I/O's daemon task. However, as currently
> implemented, there is no reason for this restriction. Registration looks
> up the request via the ublk device's tagset rather than the daemon-local
> ublk_io structure and takes an atomic reference to prevent racing with
> dispatch or completion of the request. Ming has expressed interest in
> relaxing this restriction[1] so the ublk server can offload the I/O
> operation that uses the zero-copy buffer to another thread.
> 
> [...]

Applied, thanks!

[01/14] ublk: use vmalloc for ublk_device's __queues
        commit: d2bc702a8db21c9819f25737a4343f6dfc238582
[02/14] ublk: remove struct ublk_rq_data
        commit: f053751a413b232cecd5cb3d3d9c1f972a849310
[03/14] ublk: check cmd_op first
        commit: 6762d9c0b76e2a449a818539f352bd14a5799512
[04/14] ublk: handle UBLK_IO_FETCH_REQ earlier
        commit: 1a3402e31fca3dbeb915c34a077ca3d143b42e55
[05/14] ublk: remove task variable from __ublk_ch_uring_cmd()
        commit: e9415d3aee01b51c8633d38ca62f74f7071a74ba
[06/14] ublk: consolidate UBLK_IO_FLAG_{ACTIVE,OWNED_BY_SRV} checks
        commit: 82293b83e42366d15ded8516a4d45f8d466e69ba
[07/14] ublk: move ublk_prep_cancel() to case UBLK_IO_COMMIT_AND_FETCH_REQ
        commit: 624006c145af20924624d4f2846da74f94aa9078
[08/14] ublk: don't take ublk_queue in ublk_unregister_io_buf()
        commit: 3e6b973df269180c22e024606585f8b4ca33ca99
[09/14] ublk: allow UBLK_IO_(UN)REGISTER_IO_BUF on any task
        commit: 73166f433b3c2a6acebb850f5eefea36c137f6c3
[10/14] ublk: return early if blk_should_fake_timeout()
        commit: 358f19d7cadbb5a7626cfd5822260aadead7f37e
[11/14] ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon task
        commit: 47c894fdaaee8b424cdbcd0fe490a10ea89ab0ee
[12/14] ublk: optimize UBLK_IO_UNREGISTER_IO_BUF on daemon task
        commit: 230c5a4cfc6f98d2432aff05bb3ec092fde519f5
[13/14] ublk: remove ubq checks from ublk_{get,put}_req_ref()
        commit: 21d2d986b5511ac017660720ed0016ce2780396c
[14/14] ublk: cache-align struct ublk_io
        commit: 456ef6804f232f3b2f60147046e05500147b0099

Best regards,
-- 
Jens Axboe



