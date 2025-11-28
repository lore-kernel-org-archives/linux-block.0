Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2923A22F389
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764346974; cv=none; b=Bq6YO0OW0OSc8iIL+b0sVlsN4tjdUh1baDh6wsrqG3ZqoGWmknRfyo+ZlRAEZfM91+rjk/gizvcKm2QDTy/C7dXf3DN7mlT7ZMZWjZ8lZqZDldHAe7aehopjHGiJxR1u5sYymN9JzUDm3NI9gK21s7uDDwuBXAS4xCnC/OLN9m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764346974; c=relaxed/simple;
	bh=7SeOUGT/CxlqtFUY91dMnIywIga6b6GgbUl9xxojROc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qL92J84xiUcDD0/UL9+1RJ38YOG4d+o2ZvxqxpftGPoodl9y01b0IXJsWFo6F2qOVVDPg9yN0z2GldkplCI4Mtf5KRdYNM2/TVM4mKmqhbNUwwp+N9N2YKYrW/R/pYA/R4/eAp5eIKAIX9D3TcHVyidRixSx+Va5vYTZPyg1qmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qdUmQ1P1; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qdUmQ1P1"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-949042bca69so81796139f.1
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 08:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764346972; x=1764951772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mKIUNGvk8dLdgudoSCXMpUc7SRNB/NSnUYncxD4AMU=;
        b=qdUmQ1P1+xPTHxETHIgaYuhovmCMeO+DHzh/DvZpas9oZtXAuPbSZisLd6FsiuZPkU
         tGS5n0MT9fAMZcSwA1QRiD45hd3INX3mZEY0p09TeEYc28Jmh8UDxhVwBygRqI7Ba6xN
         szDxNSlLEj5U/HAIOx5aV4sarenGYC+AB7WUM3kvwq1DgW3EoGSm7oTOmfStJv0akrm0
         WOs1/CDFnsfO+qUDnZjKptn+GrPu5OhGI2TAFG4FkCjOtsMDQ+KZbwOk/9I2niANzUG9
         rMmTYvCh4o2PTWkw2xWyfxiYjEPUQuRSQoj5I+98IUIAwAFLyGLyi8xkv7RtQ6lQMv0t
         KF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764346972; x=1764951772;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0mKIUNGvk8dLdgudoSCXMpUc7SRNB/NSnUYncxD4AMU=;
        b=tajydyOPgWaf7dKgDHxapwzVXDKTnEqIw2nnK8yOZVW1wIQROXrRHGYm82mzSFhy8N
         Dl8xnM5okYcxlwiq1RbLqlJ22jGs5ZIiFoYFg/UmPyfpmoxfeMMNKohwJttNOq5Fvw+/
         8vACiL9i80LZHVv95HYZ5XuZQnRJg4x3T5BQKj2w0FqKgkwBmAxi5zhGxozZ6UVCd257
         qfTI1vPQnPdk0r3OyLb9C8AL59D9QZreaV+zMDw0ffxO+N7L+zbm2Pnt1IK1OFlVaW3q
         i24tJVHcBpx3ae8f0g7p8PxeKOcbf64pyUUWZDDD42tafnr6Oj3QYEHsNWD6QH32jPpK
         1spQ==
X-Gm-Message-State: AOJu0YxWgBUJVMa3BcHBLFCbXMvPDIuz7IXWuLGHyM4QAMJNpx+Xo6in
	Ae0Ai5Ea3Vwltacd7lOj/xegdtlqgty/LKjXbpOZcUdSbSB0I6XI3pVetFKOrRwO0HM=
X-Gm-Gg: ASbGnctXUOQYfx7n6+EyxxlZwOhsPUEdPP/FRjNUfZtQnlkbrF3F1jBBYBqCVBdsTEz
	nYgjNs6UIQKBU/kpbstOKBfyixczW+zM7Q0PS7BwTaND3cRMiWE4q6DkCOk03UbQbqNHG2EXy8S
	wcbqgwy4KUfZop48BSNrY/DabXg5xUd50fE8rRFLVdbeEBtPAYKV2K01gx5SNjufEqnOqPke5VY
	9lPak6rt1o5f4iaZoCPgqk3m+j61uR3sy51vkd8D4wDjpZuSkg6Pz2lHJU7tOKI5xqlmZqK3QVT
	QCvxR404tmAfe8frT+G+ZXPniI6/tnR3UZAXFrI/yGCk13/NMBPOttpDZmVSt4tlGKuQ6SzBWP+
	Y71FLvjw6FMzGyWy9Vtz6JZxtNNgwW+zgxYTpsiW+mrdJ0B0cJF7E+zSjsH9B+qG5O7wawxY9//
	lTvVekGnDEAD1ZRg==
X-Google-Smtp-Source: AGHT+IH3b5IpSwY1DEO4gp5a0lvCLjp9Rg6AhMxZaNJz48FpO6tQj4Be0x22QMsx+VtaKkxfiP7qIg==
X-Received: by 2002:a02:cac2:0:b0:5b7:1c20:4903 with SMTP id 8926c6da1cb9f-5b9995f4087mr9937798173.3.1764346972234;
        Fri, 28 Nov 2025 08:22:52 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b9bc78113esm2309257173.40.2025.11.28.08.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:22:51 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>, 
 Stefani Seibold <stefani@seibold.net>, 
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20251121015851.3672073-1-ming.lei@redhat.com>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
Subject: Re: (subset) [PATCH V4 00/27] ublk: add UBLK_F_BATCH_IO
Message-Id: <176434697117.231521.16540370411311557296.b4-ty@kernel.dk>
Date: Fri, 28 Nov 2025 09:22:51 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 21 Nov 2025 09:58:22 +0800, Ming Lei wrote:
> This patchset adds UBLK_F_BATCH_IO feature for communicating between kernel and ublk
> server in batching way:
> 
> - Per-queue vs Per-I/O: Commands operate on queues rather than individual I/Os
> 
> - Batch processing: Multiple I/Os are handled in single operation
> 
> [...]

Applied, thanks!

[01/27] kfifo: add kfifo_alloc_node() helper for NUMA awareness
        commit: 9574b21e952256d4fa3c8797c94482a240992d18
[02/27] ublk: add parameter `struct io_uring_cmd *` to ublk_prep_auto_buf_reg()
        commit: 3035b9b46b0611898babc0b96ede65790d3566f7
[03/27] ublk: add `union ublk_io_buf` with improved naming
        commit: 8d61ece156bd4f2b9e7d3b2a374a26d42c7a4a06
[04/27] ublk: refactor auto buffer register in ublk_dispatch_req()
        commit: 0a9beafa7c633e6ff66b05b81eea78231b7e6520
[05/27] ublk: pass const pointer to ublk_queue_is_zoned()
        commit: 3443bab2f8e44e00adaf76ba677d4219416376f2
[06/27] ublk: add helper of __ublk_fetch()
        commit: 28d7a371f021419cb6c3a243f5cf167f88eb51b9

Best regards,
-- 
Jens Axboe



