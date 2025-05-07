Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0657728A702
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626573; cv=none; b=feN08Zps+H0xZew7UVOytbIHaum8Y/yeLC0BFooP9nEke4fJGat7pl3GHoCP8G1mgrTljjJLozVMjM+GYekL9Pr1cZVnwguVAy3F2r6BbEzN0iK4dFOUCPdxh07/zbyJmnlHhcx1bZ+FiJs5NWihODP6MoIHrTyvPU4ennUBcjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626573; c=relaxed/simple;
	bh=U4ylADaFtEJRt0szkwksohVMj8r3hhzyIFVFMjEKJXs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oq1xJCuVPRVB6m/fcQIKHle8uf8dKFcUkG9uhUHxj/e0R7o/s4TWJ2/QRTAoBOCMOeva+/W+PG6BY9dU3eQc0n0PbrkwqjeSRZdTxgjstUoUZhi7cz14NO90CUQq76gSXMCkZ59ZmluIgrJ6SK8dQyX6vBcwT7WCemiW07JcfEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TUXCapsa; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TUXCapsa"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2da3c572a0bso3984215fac.3
        for <linux-block@vger.kernel.org>; Wed, 07 May 2025 07:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746626571; x=1747231371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdN9GLHJ7ZRaEnF+wtNRBx2DC88wfvTYy6Xket6UoVg=;
        b=TUXCapsaFtx3MlEB/1+Tt7TS7b2MyXQ7GPDZpsx3ggzRMuIlX/zU77KLp1f0kX2TNk
         ECGkDRiGeHbxsfabT4dWvrNBnKnAMh/I/VbBEdf3+N7Nb+QDMF70GxkwryjhmWJLHPQK
         zY7uk9dTdd+vhPyAnLQLen+V78RRrIvGWLDoaHtEpULUdIdJM6Lgm+66uihlayMxkU+t
         4KRP0ZEjiD6kRzU7oJsB9VT9Lw0Z3jPaJNs9fAhFNA4clDGXTPA6q7o4L0Sy74FM06jg
         8PakzkAiRTqPTS1aqp5+a/xCinJJodJpEEAWOX+Y65SWucgAxE5nExuPrdDVd8ksfjgW
         WY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746626571; x=1747231371;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdN9GLHJ7ZRaEnF+wtNRBx2DC88wfvTYy6Xket6UoVg=;
        b=eHUXIkHxIaupUo9Ksf0B6ZfvJdUhIhR7t4FdA9mn0kwY2/g5X7XGYijToEZNkmY2FY
         rbN9jwfwRyS/bkXZ6qCoMv0tXqhvcEUzBr7u8qG2u9R8XCHcTsCvZVdkbmYi1+S1pkwp
         80Eo1ovCQoe1UBGCMGKajq57Ti67VteHqDMRAhF2mTsM3ncYd/qWr8pqytAIlxrDs5jg
         GE//MniOUuDykI2AGIeLVn2Ax9GG2v+Pcdk1rHS6qaTSdJg/wIw7UsProLcUoaCh4qsA
         3cBeNHtJiVvYOkyTiI/om/3oYziHxuLHgYAt7OYdAfsiEztwrMNcPPLMfzbU4p6BwaUZ
         vzoQ==
X-Gm-Message-State: AOJu0YwdQj5LjY2rFx28yoZ6fu4d3QXHCEjzAGvci51zLfndiWifCxoO
	7AAgUClBGrKJ1gByoyVkdLlLu6yBRKUmn3M+sIL4KvYYegtsaMW54r2zCpvZO4j8rQy+qAqGn1T
	n
X-Gm-Gg: ASbGncunzCx4oy7m8BK6xrYL52EosNUgkhdyzgXii6WU60YkYRt7xMrLQfilwp0AchQ
	0dSA8Ga/Q82Aq3nxgHiHIl+exSCwter/7TcDfVo3VGkS5liwFKPDk5m3gI43t02nynGe0AUp2Lx
	GuunYbb89DsuQKcDvZzSjaUzSPNuLtyc+RNDkApDMdqHTXIJVJdvgm21j7JC+3vF1v4OsZDiHj0
	GllkCqKQvmOb03ir+h/qGwaVellTp3eirVXXQUCb/TAPHmxuox8ExGji3Og8H/aPGfRb4F7srFy
	TlcSvHFIIpTuUZ0Ov/Bd5IJgv+OWMH0=
X-Google-Smtp-Source: AGHT+IHQy5iDnwarvlR8q3Ymj3XY7/F3cv1LWY2iaCstqJOzsDmoce1joN67ZPWLJMAO7GOwsu1jkw==
X-Received: by 2002:a17:902:e88e:b0:21f:dbb:20a6 with SMTP id d9443c01a7336-22e5eccc4e5mr44985355ad.33.1746626554918;
        Wed, 07 May 2025 07:02:34 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f9fc6bb606sm642485173.18.2025.05.07.07.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 07:02:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
 Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250507133328.3040255-1-ming.lei@redhat.com>
References: <20250507133328.3040255-1-ming.lei@redhat.com>
Subject: Re: [PATCH for-6.16] fs: aio: initialize .ki_write_stream of
 read-write request
Message-Id: <174662655365.1844963.2171610424115584329.b4-ty@kernel.dk>
Date: Wed, 07 May 2025 08:02:33 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 07 May 2025 21:33:28 +0800, Ming Lei wrote:
> AIO needs to initialize .ki_write_stream explicitly for read/write request,
> otherwise random .ki_write_stream is used, and cause -EINVAL returned for
> aio write randomly.
> 
> 

Applied, thanks!

[1/1] fs: aio: initialize .ki_write_stream of read-write request
      commit: 037af793557ed192b2c10cf2379ac97abacedf55

Best regards,
-- 
Jens Axboe



