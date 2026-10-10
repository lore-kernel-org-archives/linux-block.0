Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872023BD17
	for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 02:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599769; cv=none; b=rWOqOvenHj2J93FWctBZoujjVxTn70DTJnlnDJskndLUYq2o3/6I8uWDV+8ambYK0QntWnKpaOCdPk/jHBtXfFuByrzO6l/7Rmfrnnt2NmNd6RVfUzR5VelGGqaAijGwVCRXP5t/c23KsgKc04YKBdyf/nV/mRzdw5/YqUN1Fhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599769; c=relaxed/simple;
	bh=4auVpVDECss8JHkyoH45SEYXeAJOaapu1VO6PnM/Kw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bbbnlh/TOXbz2sPI5yhrryBFLWYNDTd7IRV3qyqCqpzYnZxjl0QmQqvdkbFbf/TBen/lEtw+HoDJTNPmN3e1EAlye5UwTPUactgCCWAvt+SDx7pLNByOinhW7IBk8pcD203SNrCT+hEI6LFtOxPSVi9o0gxAJJRgYweLKWfq4dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPtVtRED; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPtVtRED"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3515f9a5d25so782409eec.0
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 19:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791599767; x=1792204567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4auVpVDECss8JHkyoH45SEYXeAJOaapu1VO6PnM/Kw4=;
        b=NPtVtRED3qHxhYQLxI0Vb5BlsVTtD3AfaSOwnSjW0i4XLoENGPMB1bVBBSpZZLDAJF
         wFQICE2YdalciSF2Ta7YbBElehgnIWpFo5O/ROqZkClLkTnKKmErNW9qobmT3+fSdEN7
         cbOqGEozO53eQh8unjjwefvI6/RXKTnhJnFENfd7wSqeCIrxnB9IA7QjJSd3WlCjkFVT
         Ry46rdsRkCvmgV/R5YF2NmqxgeULSxZSWqNx89CXCQRsNXz5VrjX2ln6E+w0QW/KqdGd
         MbVC4D0mS9Tg+UrTI6vB1Bfl4xx7PVmbDjMC8E20nLeEjfI7LVOHaAi9+EqaQ1TO+OK3
         w86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791599767; x=1792204567;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4auVpVDECss8JHkyoH45SEYXeAJOaapu1VO6PnM/Kw4=;
        b=ArInlUpr0AIoluHKD1o5TbURiiyKaHIb8/vxJVtBE0Syl4me3sp89tfIlkgxGJ5Nmh
         Xmtt2A+MYrB/eelAoK8ze0nbWMy9Er+D12dN2PaLKWSz+HBY3v2Po5OeELU5aTnbYICH
         /rP4eXIvw21RRAdnB90iDGXbaD7uYRH4+BPd3GhVV1VSkIiso8A9lXqL2MJ5Qbq/GUf5
         GDwNgbMKWuCcI4BLDk/0eJ/vsZtg9EMFf0TNe+PTC91yldGL0IkThC9YB2njgvL4N62A
         E50QwuJhaOar+H8y7M4u5DRN0liBGfDk1igVY4DXI42c/XjcYOND2az1Dpr0lS8C/EIc
         dL0g==
X-Gm-Message-State: AFq9FYLXny44AQ+0yeigJbOLbYocVngLdHJPPF7HQ3YSt56Xb+pPSE7q
	fHIgSvC4Kfq91jzezxjkxRkTSO+rdP1xnQgMAXMAIrvAs1ccIJhTR4CS
X-Gm-Gg: AYBFou1bWVaDHGNXJLqSOMkEe/4vomdxTdlXktzEOXron5lHGAlEDH3LRUHmtAxFKV6
	/3ye5YWLZ53u2IxPqTLM/0IUZBGIyZGAzI+OHaIptucQtJapHOe5m2eQeRSvC8wQLd7M6R6PixZ
	UyCI7yKx1D0kSPbhduyQFWi/ZkvaLmNj+2vEF3CTRiVX1+B641iNmBHTujmL6fPGw4ofqW5niUL
	wNR1lgTcu71f5elz16Ql53Zxd8P5KJcrdZBVYGxx3s5qr+NTYlMkx5OmY5z2xtXBBJV2l6C3Dw8
	pXM1UjQM3nQFHiGDgJNoYTazEMlqJVB7IoS4UjLacS9LByDwIZQ+vctB/vWlu6Qje0iIz5ucH01
	eN+Q5J/cyBzO6osC4lMRvqKKBDrHnRVEETSv9jXU6kDws5qm4gRydWvhApJE1h3mTo3yaLUrvbe
	N5uohWOVfyQe1/s1Iw2tu2+Pr6G7k1+wZ6mJNKXdMi8QuU/r6wpNnHxh7X5zuqjg==
X-Received: by 2002:a05:7301:221b:b0:342:645a:5cf with SMTP id 5a478bee46e88-3537dde8888mr4922240eec.1.1791599767463;
        Fri, 09 Oct 2026 19:36:07 -0700 (PDT)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca67b21sm10057666eec.11.2026.10.09.19.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 19:36:05 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Ming Lei <tom.leiming@gmail.com>,
	Wen Xiong <wenxiong@linux.ibm.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: run the hw queue synchronously for unplugged scheduler inserts
Date: Sat, 10 Oct 2026 10:35:47 +0800
Message-ID: <20261010023548.3666200-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930-bug-blk-mq-noplug-sched-dispatch-v1-1-ff1e49e52b00@gmail.com>
References: <20260930-bug-blk-mq-noplug-sched-dispatch-v1-1-ff1e49e52b00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jens, Ming,

Gentle ping on this one. It fixes a v7.2 regression from 9cbbac29d752
("block: Remove redundant plug in __submit_bio()"): unplugged I/O to a
device with an I/O scheduler is now run from kblockd, and the kworker
preempts the submitter once per I/O. A single-queue null_blk device with
mq-deadline drops from 289K to 193K IOPS, and a single-queue ublk device
from 265K to 113K.

Every single-queue device that defaults to mq-deadline is affected, so it
would be good to get this fixed in 7.3. Any comments are welcome.

Thanks,
Qiliang
