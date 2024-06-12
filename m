Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310B61822DF
	for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211635; cv=none; b=tpvhieOlUPFi4NXEQxSRLa8YwyyeUgHy1Le/VhKheo1QJDAk3Z+tLND6PDrOFt6MC4V5KyQbrVU4nv/eZtBdyiymKc62CUHI+LaCuFsmHPSNqjGVhiL1Uvs2Zf/g8iPkziHm3t4aFH7Zy7ugUwBk52NLHy7F8xb9jfQEJFWVE+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211635; c=relaxed/simple;
	bh=z7OSESrLBJWD8/2P+n6PssT3cGyqehX+NT08g2ul/ak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RfR5Q4EPo3BK5qC0hEEG3jG0OqlIfSKd+Y5mJFkKvEPxT8s5mbRiN/wnDG52Hy6fQRGRzKbKMAKSQzgTDAvpzfNr580f+TkzWrgC1tsVcfzGhnySJ/fqIW3kI4XuUyRFgmo9XBCyYdN2OL9I7ZjLmhsqKJXBdY4L7eVu9bMS9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VQL6jN6w; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VQL6jN6w"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5bb33237b60so4283eaf.0
        for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 10:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718211633; x=1718816433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIIMrgyJCYaT/orKY6h7hla5hxEimOF+QR3n0b8qkwQ=;
        b=VQL6jN6wXII+0/GTI8ADCcDokINenQqRRIV3nL7RCIfeGDvpujUgG/wRDNTADE5Z7z
         xTFtwoTr+rBrxNivi6StBO3hXeuL5eP5Eo4YEiK0kIhc24+NFULNS3S4EZGiB6CzKQTF
         rIpeVRTMScffnIFXcB+TLOrWIbLwUqsg3qlTSQLAeFks43TixsGSCtT9/k8REK81oPI3
         rRCx7/ZEgl4x2eVd7MgXOhdQTW+Melf0OITzrZIC8Ld4Z3O9XH8QHv/Ru2ImZB69Espr
         tX5vd9oZSqGZ3YJsNDBrBF2DcwgrThhRC613+YcmTarhXcNNRGEo1xt+hZVPe2S2Bmee
         QQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718211633; x=1718816433;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIIMrgyJCYaT/orKY6h7hla5hxEimOF+QR3n0b8qkwQ=;
        b=KKWSvcZIoaBvqyRdwFy+eKv6pqer0EindjKCP7d79BOYadwICshDqXpjV5pTWpOGze
         Q+PYrLhJJwlhnN288ny9L1yavYy9O43031f/Xp5VvLnO11k4LyDO3TyKhI5X2Br5oKQw
         YFSo/oJJcpR0OW50kM+fQvPeX8M0TIHEAcEz5SUfi4gL23bGhXjJGvDrfkM802laF1k3
         /1Q6VyiVgza5r7lFpWRVYlu6OmfYn3zI2dmsq3fiGUOhrQybGc+O5Uj3CO+5iPsohMn6
         gikK+w9voB2xpQEEjRiBR3uwhHI1WgiYAwW5Efx7QQHWsGMBYrmn3KmX6PtvWYVmj8rH
         +APQ==
X-Gm-Message-State: AOJu0YzNQBznS5Aq7/JISI56kZBAHcNJrT2ScFRh8lmFfgrMS7pHdQGO
	RYIt+7TxXgFYMQsz0CjqLLvmInBkmbxvYVIwAO6thho/MUJNCmquTnhRLRMZWdI=
X-Google-Smtp-Source: AGHT+IFXpy0/wkthwrMNmOsZve5zPcmpq79rWCq5ChB1WBkOzd5P+ePWJWqvxcVOmqaENKj4ouM+4w==
X-Received: by 2002:a05:6808:d4d:b0:3d2:1b8a:be58 with SMTP id 5614622812f47-3d23e17b4b3mr2893332b6e.3.1718211631029;
        Wed, 12 Jun 2024 10:00:31 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d242affa88sm115841b6e.1.2024.06.12.10.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 10:00:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, hch@lst.de, f.weber@proxmox.com, 
 bvanassche@acm.org, Chengming Zhou <chengming.zhou@linux.dev>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com
In-Reply-To: <20240608143115.972486-1-chengming.zhou@linux.dev>
References: <20240608143115.972486-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH v2] block: fix request.queuelist usage in flush
Message-Id: <171821162990.49689.4088473696825322669.b4-ty@kernel.dk>
Date: Wed, 12 Jun 2024 11:00:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Sat, 08 Jun 2024 22:31:15 +0800, Chengming Zhou wrote:
> Friedrich Weber reported a kernel crash problem and bisected to commit
> 81ada09cc25e ("blk-flush: reuse rq queuelist in flush state machine").
> 
> The root cause is that we use "list_move_tail(&rq->queuelist, pending)"
> in the PREFLUSH/POSTFLUSH sequences. But rq->queuelist.next == xxx since
> it's popped out from plug->cached_rq in __blk_mq_alloc_requests_batch().
> We don't initialize its queuelist just for this first request, although
> the queuelist of all later popped requests will be initialized.
> 
> [...]

Applied, thanks!

[1/1] block: fix request.queuelist usage in flush
      commit: d0321c812d89c5910d8da8e4b10c891c6b96ff70

Best regards,
-- 
Jens Axboe



