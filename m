Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795143494;
	b=L0VO3jNXOSM2gUMtt4noh1xtwJr5HFYT5dMl4Rq4LUcF+kKT6kfbBtFISOEYHPGnoCNm
	 hzJB/S2jHltAFrhMEgrPEwyKlLAfd4LBoNoJMmtv611xWgVANErqZBkTX6ArfwK2BKGG/
	 zxu3QFkwGwVace7URu0/JTa67+jfNeDdQGxPMPxzht4OkXRlOuTPkG+T8zOl/7dmdCsve
	 Ax/MugAyxShkdxHPsSFDdplOhf//sYy65eZMnn9/cSxS4cxLaOZmuxD+/P7M5gmYFOHg9
	 7o96G6Q2qyUSJjveu5Q5w2AIcXiib1YqAd/LwBHT123cnOuO+Nym5xdphyIyu+f1Zaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795143494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xk4cQ5w6rgcfSik2vkPhBRPqtZG+6WqFpZrQIqGQzLA=;
	b=qP2J3K2R+tSp3aNToCNxDeYhwkzSjF06Vx5ZEq7uTBIhw8unU+uESx4wfAuoNRAs68ET
	 UG6DcW9KraPKjBDb/+SnAMU1AE3shCkniaQtvx4afEiYOaBIxsz7lAv/KoRRvTBtpBhRn
	 CpthA5z99HHZoLICkygqgaEX9qgHjqe4DxQmF2Wo/JCbZ6ghbV2SG/mc5dyDkfGVIQZSR
	 pmlw1LvprYtmZfYJVGeTGlxB71+usknxdug/tGoIYM4UDbBWxvESmNhJ40o0+ALWtyxnb
	 j8aIA4ZzHOI/7HnuMQECpKz78aiftjSzaufzbhccIciT0Lq0HeTZ7/C76SXgg9v5jHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BUVPr5tA;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40316606A325
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 02:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40316606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BUVPr5tA
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so438774b3a.0
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 18:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1795143492; x=1795748292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xk4cQ5w6rgcfSik2vkPhBRPqtZG+6WqFpZrQIqGQzLA=;
        b=BUVPr5tA/GDGUvNmvkf9zBno8hsXhS2dof3oq2DgcvLjI72Xl1/iDHoAtKcQSE3ZH8
         Gzrv99TsRoyRzM/SGocDbJZcjZkiFZdc8tpGJWEgrroVFiXMEOJOvTXLq9h0qNpteOvK
         GSGic5dgZ3Y36HTIIncdM/FssiNbG/LHGXjETa2ZEme9NSZdLoOUYq7pkLqg0P3AHS2K
         GA9e50ANFu6kM4MuiEjB1s3bCweq2U0ehx2Uat8HvC1BDbHSLihC2H1cY0N96aEaHITi
         Y8PQ//lfppvRhx5P7NFpxhgDdmdKP0alSeeCnPkMgTbvRWQLRDc2UWYcfMXAr9pYFta+
         BmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795143492; x=1795748292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xk4cQ5w6rgcfSik2vkPhBRPqtZG+6WqFpZrQIqGQzLA=;
        b=xi1aIAn67R/utaughMzmwhtmr/i7Oyjp5NrfvzwFgTe6iqtWVIVOxBn0sz3m4wydcT
         GhFgLpr62q6aPJL8vU7unQy6IF4Z0sb+6qfTveg6fiHJz+3+jDnSidqKIJd0iCjx3gNM
         BaaEVtYDm7Uc4m1B/GLhVaoO58M2CO+5M5TEoZrouJXvrkP6c8lwHWViL4Hs8ajvspmP
         UmrII9MFnmDU7QS/4Qx7MffEGPPlEN1hJgJnNiL5hqHxmzdcykONJA+5F9SqSbOssEzU
         yhfOKS9WLwDO2Bm2E7Cv4sxSP3BlUI10gfdLZ/tqvW4SiRZhxZOYnsaCRUs+trwOCPqn
         rr3w==
X-Gm-Message-State: APuU4Z+zsAdezuzmtq2L7q3nkJgD3DjpmPxhuYdvdWQzl4gWfpRzQu4b
	p0AeennQsJzHId1OBKRD6V3ZbZGnyjnHVA2Nyhw+G0trNEzFrDxjpq68Tn0xSbqzP5JQH0gPJs5
	kBCckeNsPIA/f6oxtXSTp1S/LRTF44oPWXMCxHqs+bR2djlqa81pu1wn2Zg==
X-Gm-Gg: AYBFou0x94VgiQXeg5IdpDZaGKiP8wWNmcE+p2Pf2WwKNnr0J8UKCIDiSqyUvJVdhtG
	+so8BEniHWRVzVPz+OROd37+8nSAxMU/RFmk3XcB0WkIiEK+DRza9NZxwSitRXXurK9IRXZKfK1
	8Lhp+HYXY5xZXlKCyKRRAhd/rIji9bj0gksg2pyTfvjOKu38wxdtP1MaHoAGoJAcJ5eS7LRn68f
	ya2tht7/nn7GtYjepDVOiYRtDrviRGJJVJZ6Ydv3pg+oqjpSCTR6NcbKA//xzygbg7SjT8RD9Pa
	wjx1XStU0MjZzj29uNLY+U5aQjKX9TtKrx7kZDsAxDqnLWBsC37ytQY+dmwQdCU4GKkXa2ZBWob
	0x7ucX3giIZM/jNnQVX2Vhd33fbpi/l5VKSezGK80xCC+c3QkIymzxE1+v3hn4CMSK4qMlSngLA
	r0S4jJ5L0hpO97Tqn7GfmdLQxq8++UlgOUD05gBFUSDaUhtv9H8M+WhDYJgVWHUqfhjWvlp67HO
	8oLlMdC0k4Zskc47xNavOEkKEiUbrVDkJ1tlqyLo79V/QmYJJB/3ygZitjpXg6Vlh/Bl7s/mgYt
	u7JAl9L4zbxgE/KZroh1EU/aqvUEg/0S/El+BA==
X-Received: by 2002:a05:6a00:238b:b0:89f:5ac6:32f6 with SMTP id d2e1a72fcca58-8c87c387eccmr1558329b3a.24.1795143492408;
        Thu, 19 Nov 2026 18:58:12 -0800 (PST)
Received: from localhost.localdomain ([103.26.8.217])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-8c872e45eccsm749647b3a.31.2026.11.19.18.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 18:58:11 -0800 (PST)
From: Lei Chen <lei.chen@smartx.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Chen <lei.chen@smartx.com>
Subject: [RESEND PATCH v1 0/4] Expose blk-mq tag sets through debugfs
Date: Fri, 20 Nov 2026 10:58:02 +0800
Message-ID: <20261120025806.1065295-1-lei.chen@smartx.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009030111.57784-1-lei.chen@smartx.com>
References: <20261009030111.57784-1-lei.chen@smartx.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Block debugfs provides views of request queues and hardware contexts, but
not the tag set they share. This series adds a tag set view for inspecting
configuration, CPU mappings and driver tags, with links from request queue
directories to identify queues using the same tag set.

The series first removes a stale CPU mapping comment and moves driver tag
allocation and reclamation from individual request queue initialization to
the tag set level. This gives the debugfs tag files a lifetime that can be
coordinated with tag allocation and release. It then adds tagset/<id>
directories under the debugfs root and links each request queue to its tag
set directory.

Tag reads hold a debugfs active reference only while copying tag fields to
local variables. Releasing it before copying to userspace lets tag file
removal complete even if a reader faults on its user buffer and needs I/O
to a frozen queue.

Based on Linux v7.3-rc2.

Testing on a 192-CPU x86_64 host with KASAN and lockdep enabled included:

  - null_blk queue growth and shrink under concurrent direct I/O and
    debugfs reads, including 100 cycles between 1 and 192 queues.
  - Shared tag sets, shared tag bitmaps, three-map configurations, and
    repeated device teardown and recreation with old file descriptors.
  - Unmapped tag reclamation with 256 poll queues: tracing confirmed
    allocation, reclamation, reallocation and reclamation again for
    indices that became unmapped as the queue count changed.
  - Task-local allocation fault injection, including hctx allocation
    failures that rolled the hardware queue count back.
  - NVMe loop with two namespaces, 50 controller resets and data-checked
    direct I/O. These resets retained the same hardware queue count.
  - userfaultfd-controlled stalls in tag reads: null_blk queue resizing
    and NVMe loop controller deletion completed while copying to the
    user buffer was blocked.

No KASAN or lockdep reports were observed in these tests. A hardware queue
count change with NVMe queues already frozen has not been tested.

Lei Chen (4):
  blk-mq: remove stale comment about non-present CPU mapping
  blk-mq: manage driver tags at the tag set level
  block: expose blk-mq tag sets through debugfs
  block: link request queue debugfs directories to tag sets

 block/blk-mq-debugfs.c | 298 +++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-debugfs.h |  22 +++
 block/blk-mq.c         | 143 +++++++++++++++-----
 include/linux/blk-mq.h |  13 ++
 4 files changed, 445 insertions(+), 31 deletions(-)

-- 
2.43.0

