Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F453AEB2B
	for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065582; cv=none; b=YSH3G0GxP4Gh+nn620TbN72DsQfMD2UptydsZ3X7d9O1+XW0Uu3YcC+3iWnDjNob3ICa3NhQ8aJ0eUHAIDyIUjBDrl9T+PlheafSof2jtKzBGtTqq3CogID0FjdSFus4m7TwB8POu1+V6O6U0nm5JJyPsMlPgfuaeQ5hr4C0TEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065582; c=relaxed/simple;
	bh=zFBDec2TRFEalsjq0AVcfDV7Wl85mnPHWjbfYz706rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0XaqTezILfTMmpMZEJPql2S2uMFhqP3dPyUEAxoEzkapa5IJBF98OnfFAtyR3e9URTj2hGw6xBAH63DToFaFj8lNHgsHGMRVlJ4I/fUFIPheqBoQ5Z+j8EY44mWzHONsjBobDiyWGq17BSJ/RBH3TjafXBUxPj2A/Z/RE4Kn2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=iATe8DHP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="iATe8DHP"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so19407515e9.0
        for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 04:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065579; x=1785670379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q14+SU3ApPQKeuQJQq5srmD2x1GZ50vyxARH6EmniXo=;
        b=iATe8DHPHsEM5s3ocUncNSL6Nw/3pJ3sBRQoDcQDMvhQEndIEXKmHcC5HiRfyBr+S5
         wVye1TLuoMAJWPoKi7jxbcztOt1HybUlDvmQZntEURXL8hZVjYUFm/vD7njk0BfJM84h
         YHyMmA9iwBebLQIxQlDIsBmiqe//2z7dPzMW2eDlNfB44yEtjc/qUPxkN3x8R/suBpe+
         u9639UuTLzAdwem5dd7RW4F45JA2dok5+zZx/r75SuiRg6yebB4fU/maVC/3MuTlYgd1
         gm4Ao2w39D80itQyIB/ETTn4lmbChoFTsXdRzoBDxwK+IByQUijEzhrTvA5kxUAiJ+D2
         YNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065579; x=1785670379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q14+SU3ApPQKeuQJQq5srmD2x1GZ50vyxARH6EmniXo=;
        b=MZN7zKoh0sQ1wmBvuhpdwxfrQdEZzAz8RcFkcMbVlhwUE7eSO4TnUBo9zGuhBeIc1H
         EyhVAOKYsfS2FHafwdArTDF3jD9I/T3rDYgKrJiT+EJX2JQJEv0NzktAHgampX23MIiO
         jMlvUG6Rjn6WGcZ5/TK1tuKODUsPOLcXq/pC9THlfpLfJ7BjgtE0mljQtNWDUh+632Xp
         SZojCQ/0WUp9xcuGUPgVavdXx2M5tDBmccYzWS5kPWNGsLIrx9AsOwBvxYFif7SB6NsY
         SVkOh0KenhpppBRHsX9mjjS4ushWdSx17boo36jqzTyL0SOHt8EbnaVtFf/nk1j4/FBE
         8Pfg==
X-Forwarded-Encrypted: i=1; AHgh+RpYW6ZHqRbWFowXRejQ9V+kOR4kkGfHzi7RIs9/Q4oX+XhlwYkqHUKD0eg59gseEZm6ERtbPbhu/AXaxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCNMH7eHN+EuOweaROc6sqy58V9nN2cS+CHRmb9kPbfoOEw8aH
	YtOeDCW5TBgT1cQX5YrzVo870hgc5vPxVm7jjzgEeViqH0EsGN3pX8YjOBM4LbCq0w==
X-Gm-Gg: AR+sD13N4oPm3Hgy4SLcORO1/oMlKMQNQAdN48bqRE2GcQg83SAw2noTSyKAKDX0Pf2
	LHGX4vEo5ewCMOMHBA9WRC8aO7yx85QOqAR0dXaYIIIluKioyAP8UI+E6+yy5ZsZJVp1UiSyAO2
	wGHpKWXh7kmWf2l1P5bcWi2PIZbsZ+ridOAucBSaJE1sSbuAa2inediCVe7tJOh6ywur41fv1YZ
	azWcMBgTKxEzJTwQ9G1gy/s13bVDHO3OPws4Fq2PGhgJzGQqAIXkzb+abLNHbwdSnzV/L4Qycml
	VSj1ikl9JefiSJ2OtsDWdG5RAQ+zNtQTGDU49sgYHg3GyfBjS3uV9lbE0seycbt+HCCk/mw8EPA
	so9DS9fbQRz2wbLBSXlvaBNLCNPWbjqhLZU17DHrGELCRuhweKApZRZuvyGG9ZQx5U0G37VDO5G
	ImdJoLmrUmdhq2Hsuos1PqmIx4iO0uYs4x2fWxRHU5rjBt51v8n5TTJaCMc/DMoP4tAaAM+WGfq
	hoEQorlqHOCzVYCwNVsCRVIZ+mqoPEu5jNaaKifNA==
X-Received: by 2002:a05:600c:c87:b0:495:69eb:27fe with SMTP id 5b1f17b1804b1-496b56c58bfmr55527435e9.11.1785065579344;
        Sun, 26 Jul 2026 04:32:59 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:58 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v6 11/12] nvme-rdma: ratelimit the map-failure error message
Date: Sun, 26 Jul 2026 13:32:28 +0200
Message-ID: <20260726113229.2154269-12-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A mapping failure is per-request and, for an unroutable P2P transfer,
deterministic: a workload that keeps issuing one turns this into a
log line per I/O.  Ratelimit it, as nvme's per-I/O error logging
(nvme_log_error()) already is.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/nvme/host/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index c38d949502b7..2f50509a7a61 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2040,8 +2040,8 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	err = nvme_rdma_map_data(queue, rq, c);
 	if (unlikely(err < 0)) {
-		dev_err(queue->ctrl->ctrl.device,
-			     "Failed to map data (%d)\n", err);
+		dev_err_ratelimited(queue->ctrl->ctrl.device,
+				    "Failed to map data (%d)\n", err);
 		goto err;
 	}
 
-- 
2.52.0

