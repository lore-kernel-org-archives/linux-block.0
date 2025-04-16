Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D3520E315
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765232; cv=none; b=udMCgbFxDy0jZ78FE9PL/5ECCgcPw0WiHcB6z6jtbJPy9tl67ZB9M58mdcR2qcuk165vShbGetUDV0H/g+z7bexAdCpSllQsU2MqDs6SXMJh+tyW0eznZCiyXnGgGylIVfPfuDJJRh4WK+DVrVm+DCkK8HLjDE6s9h16Gg+XFQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765232; c=relaxed/simple;
	bh=qdbShBVDXRXuERsXt/CMFfZ5WDCfebnsWxZbKNHCahQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j+rR6BHZeZHOo2VUURASct8pcEO/IzeCO5BhO7/RAMJQ1TlSOSGf/2gRPOscOHT9yPnANnhIb559ITQCPf9lhNcwzHfutAUtB2rPcVkySMNvGDYXpKbURee2FGLPNdwm+27Jwb5v6BJMgp4BUpP1/UfuwG26RhtaM1D03LffgQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CRqd8O8M; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CRqd8O8M"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85b4170f1f5so226120739f.3
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 18:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744765230; x=1745370030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjJDAlW2tyJt+aGIS38UXGt6ddbFqZUu++MZ9lCqgWo=;
        b=CRqd8O8MZ73nB8Dv8PkyiIqBd9JREe2KFxd/Mw93/8X7HeYw67YNajyNzbKHqjPOmM
         fsxfndzVlLSKQ9ILnQNl08aLeaw6a2l+3wQNOiANhSqNykwDeRpuzEtb3W+L9899E9Zl
         dOkp9uwJeC7GBkc7txsLc4oVUdhYl1w+cwu4njFjsZi4IRrE0pjGTBPlMiZJwwyaRtlb
         O1erBrbj8cZlfSA4z1zus+TWONDF6/fP7Ef8LYLC2WLmrdpgiTi7cihWN/Bp+teyJG7P
         0r7xi+ZG75F7IBXZbvuODS2HKIKkKbiAgspFhLdMIbZNFlNQc0V9AYYBAR8Y34QzP/li
         G7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744765230; x=1745370030;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjJDAlW2tyJt+aGIS38UXGt6ddbFqZUu++MZ9lCqgWo=;
        b=gxIuS1ZigRrsizKWdLViKIUGdWjlLxYSDRqQ6s9UCtuSzq8+uZRcNuZ1dxUDE9EiyM
         NLzX++uosxrSWAWjEIWDlHoTXZO6e4Fu/AcV/6a5VQjRNIurvq8o77PRpNkU5vBoB+tg
         msKzfYFnXNBpUg+4ab+BQEsiii26EoC0SUzQiqGFg2fFf6NCsi5IXmXgQcXD/mkJk3yJ
         Mp9JTBijl7EEsHeIhFOhaXAAdK3VivapOCVl6+wxNHFJj1w3N2DqXsUYttySc2Fk3yuv
         U2PN/q/v19mg8nkFEysZSxUasb111OhyRN4mXjZxFkm2UyiuLJl/WPUiI7lv3L/kmNpJ
         ESBQ==
X-Gm-Message-State: AOJu0YxWqdZgJBbMf9ENHth2WeNfWrQkhJLbMSunssoWJAxcksPQRCfD
	LR3vezNVxrFrIyiuwerAvIcmW9g5B3TrnfrYij6vUSZZa3hR4iRrxXkc1ErrI8E=
X-Gm-Gg: ASbGncvrUrqclwx4oG/XjRPMT6bDLvX3mVTktN7yFettCw5wfu17sEpAWUSrseLCOVr
	wfBRz9vjpY7h8P8EbgF5aGzmDuP2meET4w5cFc313A46JfnaEixiDygjfNosLXPMJkHAgNDYH8V
	OmKx2ZLblfUx0TdKXporiBW550VLSnjtBnk+0/WNsQDZy6WGiS4Soq2Zj/4WPax2QX+80+vtIJE
	nO0B388ry09zD1uYsRbMOOXJHa6BPI601QK09RutueEVh8f/dDS4zpQsK6Z5R6bfzx3XkIXHlIQ
	YNwFUqnzZLNd23Ri5wUVkcGEE9drcxOb
X-Google-Smtp-Source: AGHT+IFHwIsJxtWXBwEGh1+ECfJxC3TeoGjseykrcR4eYLp0SW9CI9pHc0sRsbg358s7OdyWxdF0sg==
X-Received: by 2002:a05:6602:370c:b0:85e:1ee9:1c18 with SMTP id ca18e2360f4ac-861bfcb14c1mr173042939f.9.1744765229886;
        Tue, 15 Apr 2025 18:00:29 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e02105sm3375786173.90.2025.04.15.18.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 18:00:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Ming Lei <ming.lei@redhat.com>, John Garry <john.g.garry@oracle.com>
In-Reply-To: <20250415205134.3650042-1-bvanassche@acm.org>
References: <20250415205134.3650042-1-bvanassche@acm.org>
Subject: Re: [PATCH] block: Simplify blk_mq_dispatch_rq_list() and its
 callers
Message-Id: <174476522868.251510.10626913406347996264.b4-ty@kernel.dk>
Date: Tue, 15 Apr 2025 19:00:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 15 Apr 2025 13:51:34 -0700, Bart Van Assche wrote:
> The 'nr_budgets' argument of blk_mq_dispatch_rq_list() is either the
> number of elements in the 'list' argument or zero. Instead of passing
> the number of list elements to blk_mq_dispatch_rq_list(), pass a boolean
> argument that indicates whether or not blk_mq_dispatch_rq_list() should
> request the block driver for a budget for each request in 'list'.
> 
> Remove the code for counting list elements from blk_mq_dispatch_rq_list()
> callers where possible. Remove the code that decrements nr_budgets from
> blk_mq_dispatch_rq_list() because it is superfluous. Each request that
> is processed by blk_mq_dispatch_rq_list() is in one of these two states
> if 'get_budget' is false:
> * Either the request is on 'list' and the budget for the request has to
>   be released from the error path.
> * Or the request is not on 'list' and q->mq_ops->queue_rq() has already
>   released the budget (ret != BLK_STS_OK) or q->mq_ops->queue_rq() will
>   release the budget asynchronously (ret == BLK_STS_OK).
> 
> [...]

Applied, thanks!

[1/1] block: Simplify blk_mq_dispatch_rq_list() and its callers
      commit: 6b702ed0630eb5f67e4284a72ad4812989feee1d

Best regards,
-- 
Jens Axboe



