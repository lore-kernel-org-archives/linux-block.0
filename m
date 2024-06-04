Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBE716419
	for <linux-block@vger.kernel.org>; Tue,  4 Jun 2024 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510642; cv=none; b=jgEE6mG1s6r80WPuLriUBwgGIlEvqsBWpMbCq+kI85HHUamSD3O1PE0PC0PfKlm/iPGnPs0WSPIThVK9Zw2d8Low3uOOF8v7FHLcZ5/MJHcluOSZHtpbjorzMWyc7UHGjr9mrXYQOIsVdBncx4Iwgle8uOVq/akUeOf9UDc28XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510642; c=relaxed/simple;
	bh=huLSRBNy5PxQ3jwYLVFn/vcVsswN30JmnD1cxehH2D0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bO09Vw4Dl5QcZKsxnoVj/UL9/q+JPJ8QNOX1F0oGy894B+wp7KTmF2IykVkmZJXMmfVylz5hoeiDJmdH9gTkuQLEKtg99YqM9DxF20g+9pxr2uhe+CtqF0GGVTAD5/sQ9vOlN5Fe84PHkadEAMV8b3+ziigMPZlskAO687tvOW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qYNTVHS4; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qYNTVHS4"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70264696399so65899b3a.3
        for <linux-block@vger.kernel.org>; Tue, 04 Jun 2024 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717510640; x=1718115440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkJ21ZkyQafe4wcLOoZRQCL0rFCtk91xN44Tj1tR6SQ=;
        b=qYNTVHS4IvdAf4mB2t4QLTaLfal+ni0NqtTk62hOgg1gLnOdvFw7NxzEm1AwB2dyp+
         BmbaIKjBP7SZN2pvldD2ljj7NeSKPzqL8OkG8JKwA7THp+HnF32CxrwCs/qUf0pXZucR
         xDMvTFNMc1n/r8xSJzsgi0UJPo+8+lmas54ZCLPT4/nvpeYXMMcfnLlNFvN/Mtk9Uoay
         Z2NGe6hXfJ1Z4yAmUFN9pbw/qOjVFsE3xKGiQOGprhy5lLe4S6UZgqQSSIFai+L/mQv9
         AqOIWvej78YbbUB9ZGevziDh8slWidamJ1YpKGeoG/OxiwZwaH0fci0wzLUmwY6lGJWf
         hapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717510640; x=1718115440;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkJ21ZkyQafe4wcLOoZRQCL0rFCtk91xN44Tj1tR6SQ=;
        b=stKDAlOAB1WvjI76aVHFWxQLHZfsWy5WOQ2ljuLpX3PhIVRLPjZLHX+pPxDV7j/P+A
         UKaNH8oKkx1cpst48ICmqaY2it5OmBkpj1gdCyAP1s11FmB3qALqdgJOjThy8PMdZ6uJ
         hpLfTIwt4aEuus5TX8LMVYCm5LGScFYyXye6gCoJhwbxLbQynrzPcaPdcMDaEcQofe1O
         OGWNIDSrsfzTrJRvxwg25Egy2rnLopxfUer1JT++sAm1EVqsNqNOVqwaoLnfZMUKBJWg
         qWJUKemVub66XODhRjbgrwMqck7FxtYAodAhS0abvetwnZoFqDU+PVj9WbyPFQOAiO3u
         mlXQ==
X-Gm-Message-State: AOJu0YwLzTRIRSfg2xy3ZbiaFqkJh7ktmHXjCVm/NCL1vP0VRRyVRirf
	qkA4i3M04VMvrgxep8mttfs39NCP+EVVIa0htW9G6xCuYBajQCSo5Z1jmpmAui1m4oK1byKNJyg
	z
X-Google-Smtp-Source: AGHT+IEBqulbCLQzbATvm9efh4+qHDny10+2m/uVMwoiB0wI78fd61USIWTQx0er3QwGUHB3JAc4cQ==
X-Received: by 2002:a62:e116:0:b0:6ec:ee44:17bb with SMTP id d2e1a72fcca58-70247899e76mr12225845b3a.2.1717510639671;
        Tue, 04 Jun 2024 07:17:19 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702541eeadcsm5396462b3a.150.2024.06.04.07.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 07:17:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, hch@lst.de, f.weber@proxmox.com, 
 bvanassche@acm.org, Chengming Zhou <chengming.zhou@linux.dev>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com
In-Reply-To: <20240604064745.808610-1-chengming.zhou@linux.dev>
References: <20240604064745.808610-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH] block: fix request.queuelist usage in flush
Message-Id: <171751063844.375344.3358896610081062168.b4-ty@kernel.dk>
Date: Tue, 04 Jun 2024 08:17:18 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 04 Jun 2024 14:47:45 +0800, Chengming Zhou wrote:
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
      commit: a315b96155e4c0362742aa3c3b3aebe2ec3844bd

Best regards,
-- 
Jens Axboe



