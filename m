Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92469291873
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753792040; cv=none; b=lP0c2P4Yob3CouQ5/lv5TsHHVNyodw6z1yJwh6eTRMgyADVFKRmR+BeRRFGZw94KQefaiChBvC/zyJr0dnbQEEMO8yXzZ66CYvGtjkTnlXyQdm0mtxKcgbDF/QzjvTeoFAWOUn0/Eg/qzJzTJftqFysg54ORqDD5v0mC/vQdppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753792040; c=relaxed/simple;
	bh=TKnKjXQEBljQ3Moyn2NGtUB7EUlIC1Y7U1SPuVvyKxE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YlHeE8EXo8nXkZxV+LTnfGMCVOU21C8BWo4LRXa2rn730OZAdViPGLz5uTDE8hj8x8U/VG7hd4lwOpt5pkJCppiFUNOebWXBfeAjyln8Q5I3h6AbJWzBcr4H/envt4JSGbzNnwNDHpn136BP188paSQAnNsywyOInEGbvHjacbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2kzj6q5+; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2kzj6q5+"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3e3e4a5715dso6057085ab.3
        for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 05:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753792035; x=1754396835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBoPwxvF5REE1oiYskNxYL91+a+mNha3bGxiDN/ilXw=;
        b=2kzj6q5+lrgCupoS/NHvwEO610qo2CAfinn7IwhF1MX1PicLlXOd7L5OK68dLRJnKa
         6g+nZNbRWRmIxl41DgHt7/kMJJT+i2Y3zKUK971dkLb5ikF4OBMeGvixBASD4MmuSO4/
         t3ssnT+XIxSzkmXl4oAiz5RLqpYC9bVnrJVMei9341RvdyA8YrpxFUGqht5q9U55/nEO
         Jidt9sQ7nHF4ciRY3HN+3U/44b8DtrCV80+ayB4BZujs3wA+cdE+t6TAYuoByN3DERSk
         3vLPrSv2QuQ/cBGhnDwU09+vFC2xO+31T8cE12RaIV7Fl8ZqFiJEAK3kUOfCPqZ2ct3J
         pu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753792035; x=1754396835;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBoPwxvF5REE1oiYskNxYL91+a+mNha3bGxiDN/ilXw=;
        b=XEJOlVCfl2S0mCbea6UHk/l1PDStVm+ZcO/seLwizMilMDulJ0zKC2gohQswgg0sRU
         w4XEz+W7LVcpOPHdRuN/Nkoc3oTbE3W51wN78MjV5S77igTtbyzhQsfAh/IMsFXuBxO0
         X17oLyjTZPvGR4rk4tL8x8iCoyJ/n5x/vnRQpQPh3UnrQNjkSkAEL7GeQ55dxPh3mIWc
         QajxpuTVTZGJr89gD+W1z9t0rxP9U34CnjwkQkURU/uf/9sB5Gd/JznPpLb9PNOQmC33
         N46EAhQ/oA+rkNQpmZvPAWF09lqUcB8eu8pEmHeme9sQsifHF3gtzQEJzyyYh4lSndq4
         /0LQ==
X-Gm-Message-State: AOJu0YwkwTHxWg9PMSLLYgAveyJPqulTPtNSjLGCaashLE2l7QoFQqAQ
	nP6dzvB0D0CkxIu7CA1h0v9du+qLOSc5UJRkByZ9oZDklzglFwMVblyh2VSWEbDcMR0=
X-Gm-Gg: ASbGncuRBzuD1Bh72EXeq2sAwlfexYlfXq1JVqm/hSkDd3l66wBTRevbimRNBEvA6k7
	6uYAAiVxMiXjDeJyIyDgdHofbMqGuUFl8p+VU3GL8MQTd5euU4yzKLnll9l2l8HxGabmGQizQ8R
	jF14wmeCKYKFyKn5Ez9fkebqDvbdxJDNlU5ODHEp4vNSh99BfM19tVM+OunteKV66Yfz7YWiKo9
	KueNCh+WtGoGKRfbmgNVq6NEdJ7RVQYz5qMNqhjHdHaewi57AY1DhQQOFoYOiSYv3bRr7NhlnO1
	pejPDsaOv+92qUmIWUo7O5VpuC/2Y8f423L5tAL58HKlwfNGE9SrISnq1g0vKMAH5fhn4PxE0pp
	AZ6aAdssEQPDNgw==
X-Google-Smtp-Source: AGHT+IGHcaKjtZEYlhGDJrWLhQcx1+zeJk9eBT7KKy57mJTajg/qBo5smTbYEzo+iUzETQ0V7vpYPQ==
X-Received: by 2002:a05:6e02:12ec:b0:3df:3598:7688 with SMTP id e9e14a558f8ab-3e3c5314102mr256829775ab.21.1753792035564;
        Tue, 29 Jul 2025 05:27:15 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-509002ae794sm258067173.45.2025.07.29.05.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 05:27:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: jack@suse.cz, dlemoal@kernel.org, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
 johnny.chenyi@huawei.com
In-Reply-To: <20250729023229.2944898-1-yukuai1@huaweicloud.com>
References: <20250729023229.2944898-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v3] blk-ioc: don't hold queue_lock for ioc_lookup_icq()
Message-Id: <175379203368.176672.14343982267949571023.b4-ty@kernel.dk>
Date: Tue, 29 Jul 2025 06:27:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 29 Jul 2025 10:32:29 +0800, Yu Kuai wrote:
> Currently issue io can grab queue_lock three times from bfq_bio_merge(),
> bfq_limit_depth() and bfq_prepare_request(), the queue_lock is not
> necessary if icq is already created because both queue and ioc can't be
> freed before io issuing is done, hence remove the unnecessary queue_lock
> and use rcu to protect radix tree lookup.
> 
> Noted this is also a prep patch to support request batch dispatching[1].
> 
> [...]

Applied, thanks!

[1/1] blk-ioc: don't hold queue_lock for ioc_lookup_icq()
      (no commit info)

Best regards,
-- 
Jens Axboe



