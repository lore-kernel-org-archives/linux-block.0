Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0929B158533
	for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898367; cv=none; b=cUjaSB/UfDHX+0kJFL8CTfKaLAveFujas6KlK78l64pIb6gf0Y5GolIg2tbPzPYGD62zLh6RGxkuZeyJPIE2Rf2kq87wMJbn1Z8otVafSnpzCoo0Nq48ccha7K9htJOWvmbBG+li0qB0u+l8mHCLR9hpnNJ7HWduYRvnGN5KtwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898367; c=relaxed/simple;
	bh=NfYRJbO+n9KlpHo78YK1kJWVU0JEHSyMKcCC/4kPv2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=frP6Wv40e9abZaNxlJa9tAS8C9IZ7e0mbUrnW7LNuSGqf5NpYX6wiU+Q9tl7dmbT8MjoURJ5Z3RLktuUeWvl7NHnLh6Sirc+3axiIFpPvmzl2SQhXyGeGpZ/f97v++ye3xPEiqz2yWUw0UkDSSGxx/aQ/b+HX9LPIxbjGC/R9I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NLeMvb2y; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NLeMvb2y"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so1152188a12.1
        for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 02:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728898364; x=1729503164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqOMUsIf1mnLDxR4ticuxNbonVeXyKT1mpHNVeoepzQ=;
        b=NLeMvb2yBzSG8eZUP/gDfCqgwz964RoyZQmaBmFbFFkgltJE08UchU+dP24QeRjtBz
         C6ssdIpVvsRHNfiFqze05xdlTGuR8hoyaACIeW176g4q9vmLTCV7X9f+GTd98A+/VLqJ
         mOzchmjUzsXMKlslYbwd5DY+WyBlzEU9yoU97/ev5/3uyrUUvd5sczuJqzI7wz3u18kV
         7KO67n1rhuPntn3zoPfIIT4i0LyriN3qt3wSQFVhxGLNk6h3+YYe0i1iS/hrRdFs/RfU
         cTAPlj+smTWEvw6UCI8/nGu09fW7htKEPsMOWUTNPkxI5cnFd3CqSZOJvNAMaeJyprsi
         KsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898364; x=1729503164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqOMUsIf1mnLDxR4ticuxNbonVeXyKT1mpHNVeoepzQ=;
        b=OYxP8sdbgMocLv5dmr9j5UAyIjmX2xPenwTUqe5RFfY9D1WNsdsdJGEkeRGGpf9EDh
         PT7YEk7u+n08Hrnsyn14cp5u8YrhItyN71Libq/vsA1ghiuB2Lydpcy2ieURXg6MwZzq
         dFq9xit8jFxol2T/tvL8Bv5iU8sg5LuWu9fwkAtmakRqKJ8v+gyzQM6zxujxNaJSSA5H
         Cbi48Bnn7i1Q1ZboDtlV7kQOrz4fP8zqdSdiJ6L5aC6AAKOER3/tGxWb+aeAxPNP4+b0
         4KoABOC63tq44L79baJZ3HaAj0eNxU/XnUDQG/Yl95bG4ekzGnP/s63s6UphnMaON+ok
         In6Q==
X-Gm-Message-State: AOJu0YxK6dEApXJPuMhWlWKtY2/koKFRXZMcZ80B5eVWxiVdU3FBDDFU
	cBhpeeAn5Y2F5lZvvtlgw31DmRR6PNDAvYDq/v1l9jFe0sw42JmO8tubGmyGHLY=
X-Google-Smtp-Source: AGHT+IH7VtBvUAAZgB6HP5fFbXK+2fGQ13rySBnusn/ESWnnKcB43BkdzjpuHE4ZCqlmXOG/LNzLHQ==
X-Received: by 2002:a05:6a21:118a:b0:1d4:e523:b67e with SMTP id adf61e73a8af0-1d8bcf14960mr16946376637.14.1728898364362;
        Mon, 14 Oct 2024 02:32:44 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e60bbec80sm2339338b3a.95.2024.10.14.02.32.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 02:32:43 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH RESEND v3 1/3] block: fix missing dispatching request when queue is started or unquiesced
Date: Mon, 14 Oct 2024 17:29:32 +0800
Message-Id: <20241014092934.53630-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014092934.53630-1-songmuchun@bytedance.com>
References: <20241014092934.53630-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supposing the following scenario with a virtio_blk driver.

CPU0                    CPU1                    CPU2

blk_mq_try_issue_directly()
  __blk_mq_issue_directly()
    q->mq_ops->queue_rq()
      virtio_queue_rq()
        blk_mq_stop_hw_queue()
                                                virtblk_done()
                        blk_mq_try_issue_directly()
                          if (blk_mq_hctx_stopped())
  blk_mq_request_bypass_insert()                  blk_mq_run_hw_queue()
  blk_mq_run_hw_queue()     blk_mq_run_hw_queue()
                            blk_mq_insert_request()
                            return

After CPU0 has marked the queue as stopped, CPU1 will see the queue is
stopped. But before CPU1 puts the request on the dispatch list, CPU2
receives the interrupt of completion of request, so it will run the
hardware queue and marks the queue as non-stopped. Meanwhile, CPU1 also
runs the same hardware queue. After both CPU1 and CPU2 complete
blk_mq_run_hw_queue(), CPU1 just puts the request to the same hardware
queue and returns. It misses dispatching a request. Fix it by running
the hardware queue explicitly. And blk_mq_request_issue_directly()
should handle a similar situation. Fix it as well.

Fixes: d964f04a8fde ("blk-mq: fix direct issue")
Cc: stable@vger.kernel.org
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3c3c0c21b553..b2d0f22de0c7f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2619,6 +2619,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
 		blk_mq_insert_request(rq, 0);
+		blk_mq_run_hw_queue(hctx, false);
 		return;
 	}
 
@@ -2649,6 +2650,7 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
 		blk_mq_insert_request(rq, 0);
+		blk_mq_run_hw_queue(hctx, false);
 		return BLK_STS_OK;
 	}
 
-- 
2.20.1

