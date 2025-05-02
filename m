Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEF425744B
	for <linux-block@vger.kernel.org>; Fri,  2 May 2025 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746199534; cv=none; b=usU9MMGfliuNQRact2cJhECwtYJuCPrheM2pq0CypTdw8cck1V8WYTCqPyXJezQAY+/6owWMXFM3K0A0hiDOqxZd/zxg5wUsqUR9obbvis/62CWO0pLzDrPM/clavfXkXvFtmAzdt0R2KvHVXcJXOl/wxhAG9sFGnhqaQAz7Tmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746199534; c=relaxed/simple;
	bh=QEVaQ8hifIZFBz0rVFqoScpf42YWpaUx83D/o0Kkscs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KQh/H3gAk/jILpTozom7D7ZJZxiMCWwZPhxTUgr27AsS7f/MKHp/hW4L0VkrDCs/sL57pxIWX4n42dHCF/qSQ/XjNuPoBcSID400hVEkWZJnTogSi40bO1XdMONnYhglK1SU5vHC5N8g7ULBfNXISSTfl1c1RC3ZJpi4Tcn/eIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kMUVTIyt; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kMUVTIyt"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-86192b64d0bso212158739f.3
        for <linux-block@vger.kernel.org>; Fri, 02 May 2025 08:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746199530; x=1746804330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ht0Wss9NyJF6H00dXB/7b2Zl66sjzwkYRly7lnLnnR4=;
        b=kMUVTIytm+WxaUFkbmlA3/wPY1/PsP6RvJyjTiZYBvRqtOhr2A9/QnJQWXApmSbPAh
         H7pK6Jpib3EuJQpOwMRf/Ti6RTrVaXmKy0gBtw1h/PZXOeqFx0Y6I4G593SxTrbG02v5
         GucdolxUCYJaKDSjLbfmoIer8cAceJA7SH/Izbwh5Q6fKLTroQZat30j+XH8qyV7xhJf
         vro2rPCaiN7wGCGyhttnEH5C7IZTUEZ5KeHfvhv6VMP1/7t90oxZti+ctuABzKuUK6EQ
         onvJJAOfXOYdD/9e1fWVHzN0Yke7w7SudPF0Qzmkxf4CIfty3dGVF3IGmiVi0mAqaAgW
         d14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746199530; x=1746804330;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ht0Wss9NyJF6H00dXB/7b2Zl66sjzwkYRly7lnLnnR4=;
        b=gBFpm15YX5F0t9ZhNNkY9DPhynhnTelNmL1HnuyHlEsjUF1CFPA+v+NUsuRJolfE0o
         F/FFzMrTXhDtZPGC2nX5ATH++zcbTjtfFJ/qcnsl7osu6SyWGljALQWAfp0h/XANefZm
         dwS524q3o8bLSnmm+4tDstGpSgdNTP/OvOnd3dhXOOKMG8bU3DjaNPWh61NPu/I3W3YV
         DtIgVQ4uulW9VKy52xvEJ89Ez5HdEHQcEMA4ryTEAwtIVw+68/cBPuJ0aZaBPGm3v2EB
         xosenNaef+ulH2zGQjTBO9RCBm3OxvP7MjXK9F3AKl+l2MuPjW7HF3yQRniwN+z0JxW3
         lAAw==
X-Forwarded-Encrypted: i=1; AJvYcCW6n4GbPFduWSAZQ9lkmkuZWWlQ3KzYLgPvwuNjga+jbaDU5u9CFbj8sWF1TtztPseG9eVeBDBOy9Aeeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRosiQog3qInz6QJO9fSLoae3DLVhEqoXJnbYEhciyG2iEpzWS
	UfWk7I/Cx3EbpMeD9oBpNlr87SqLIH9Yxa9p4WpsrwwcF7RBo7hPU1/10f8fPwc=
X-Gm-Gg: ASbGncvQfbq3s5hCZweEQG1M7T8doXaFRvn00NMRjeU5BdNl4ySQB2ucB5GjEpCKzuL
	oxNj7g1174Jwns5xg5+B6b8CH88nZ0SossxNo+frKGvYdL9WhlUQMiOKRFY9yyUeRLcWCBPqNyi
	EY6ZY2+posO6IymWZxLGQNNDMOSoZuGw2VLsYmo6/ILvPblZhkqZR6IeG2pKcwI6weh8COj3DPs
	9jkIAIx/hmiC1vGisIYfsQbV0IdHo1sJeGRkKna5DyYDhT9dWRB/rF3A5I22AZGAOfzyVVRQgfq
	xoTEJBQbjR5juxMmRJsc2bNycsnJEznLvP0XjjmVyw==
X-Google-Smtp-Source: AGHT+IGmGtJrlkTYA0am4TJuLz3eEpTp071t/1y4MtVFt5gMTy2hRkI4Kbwl9Q1I2GzWXhnL6/B14Q==
X-Received: by 2002:a05:6602:3687:b0:864:a3d0:ddef with SMTP id ca18e2360f4ac-866b343cd04mr445080939f.6.1746199530264;
        Fri, 02 May 2025 08:25:30 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88aa8e1f7sm429300173.121.2025.05.02.08.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:25:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250426011728.4189119-1-csander@purestorage.com>
References: <20250426011728.4189119-1-csander@purestorage.com>
Subject: Re: [PATCH v2 0/3] block: avoid hctx spinlock for plug with
 multiple queues
Message-Id: <174619952950.748556.3719586120129055173.b4-ty@kernel.dk>
Date: Fri, 02 May 2025 09:25:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Fri, 25 Apr 2025 19:17:25 -0600, Caleb Sander Mateos wrote:
> blk_mq_flush_plug_list() has a fast path if all requests in the plug
> are destined for the same request_queue. It calls ->queue_rqs() with the
> whole batch of requests, falling back on ->queue_rq() for any requests
> not handled by ->queue_rqs(). However, if the requests are destined for
> multiple queues, blk_mq_flush_plug_list() has a slow path that calls
> blk_mq_dispatch_list() repeatedly to filter the requests by ctx/hctx.
> Each queue's requests are inserted into the hctx's dispatch list under a
> spinlock, then __blk_mq_sched_dispatch_requests() takes them out of the
> dispatch list (taking the spinlock again), and finally
> blk_mq_dispatch_rq_list() calls ->queue_rq() on each request.
> 
> [...]

Applied, thanks!

[1/3] block: take rq_list instead of plug in dispatch functions
      commit: 0aeb7ebfc7e3d4bef3542aadd33505452d2f9b82
[2/3] block: factor out blk_mq_dispatch_queue_requests() helper
      commit: a5728a1d1ef2d927c67e73fda94946c2c15106df
[3/3] block: avoid hctx spinlock for plug with multiple queues
      commit: 9712c57ec1117d6b5fe1cc8ad420049171140b26

Best regards,
-- 
Jens Axboe



