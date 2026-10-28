Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205955;
	b=Ea/OMeXDKxMo1u3CwykqfIaPQnu0Xze6XLCvLtuDZNsM3pRa+4EwuYNB7cUCgB2tgeVY
	 i01sMOMRY9uB5napVEM5yQJ4a7FRxn96L7T+9rgrtUHef8+vLxhnPvWlYDlZrXWhFwOXJ
	 p870PmMH0n1HPCrvY156BFkqHSQAyjkL9FAPZwvBCm0wkcSJXWs6stYjO7xKlDjM9zQQT
	 HBlCmbcY6q72s4L4aVY6XT8tYIAQyhi69OwHlLpHae35E/cEWZ0z7tO6hroHaHu4SEyah
	 CVf21oGtrrQWJQZTtRchQEb/HYovan4Qg2XSSlyHTrXzIi4XJLiQHNiFBceslSOAI5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gpSJifuECydo+pAjpjFKHXvSJT9a+k5qSMYTi3fbugY=;
	b=LTIpr/iYfSfzIpWtUGV9QuoJ9ybBmHqVjhJXfFbqmedLP3P373RwTA/gyKV8UQKQGFz1
	 FraHWTiQYyqJsYVs2rxK3Fh3swxrKoL0X9vp9f2GW7wzQqqWyfuJoWVMCLjouUT1Qt3je
	 olia9u2uuiGZQpIlkLV7wBSRFcXvUxS7zgnZr85IwPfB9HE9xo+uJzyO+j5rL9fm6JdUN
	 UEPIpGLgfmapvezzdFQqLhgfrQI4z8SGE4zd3CoyDpBLUc+aLCXKovpF1HHDZf/gsU9bU
	 H2C0wm4owcNENEZbZtXC4X4njEA+b40ul7cncAgzhWiXbddS8BpH68QSYAVwnbUmIdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=a4sscyNR;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0871606A326
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0871606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=a4sscyNR
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-845788309b4so591546a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205954; x=1793810754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gpSJifuECydo+pAjpjFKHXvSJT9a+k5qSMYTi3fbugY=;
        b=a4sscyNRt+ghqlgT0AcgV1B3kxbzk7idhDqxwCQMUN26SWrIzvqgs72lg/vpX2zEQ7
         cyfElH2YBTIH4GQzwAcWyvYZz8MaJlGsKj1MI1xIWkndDF+Z4PKQkZrccadzjviTkJ54
         u2/WQHV5QNrCTS5GM98wCpOPGFOFbkuJFERFPt41Gt1aIrfyK+yjuR4qg4S6qmodX6wr
         NTsgndZhW8bD+XKGO2gFEfEuRGCCjoKM+LQ3mHrThftFGeTHk2WDN4fofsHrWWJrh3a5
         lLyQ1GfREhv2mv5UjKf5WRGuGzoWUtw5det0skzU857s2pZkQOl7W1jUTdYdrB/jCdbK
         wYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205954; x=1793810754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gpSJifuECydo+pAjpjFKHXvSJT9a+k5qSMYTi3fbugY=;
        b=h+paMkOY4BrWgbvZ+5fWaO4FTdagCWJS6YaYDlt1I5TNEDLlQpDa86xr8/3JOjpBta
         1dneihhTnCge+JIkPMHthdIwUtNkSHrggT2vyvAZQuo0Yex0Ua7hZQ11tWmUaq25jgvO
         MtJD3X2vdGwiVTh/EBFwk1iqbw7Evsn2wpfEZfId0M+3VICwjBrRsocIRtQwcfiaOvxe
         52XGYnGEYPL79Zydk8QM7FqEliM3rD92Tbhl9BCAgTXWHm/XmYwyIkI4bS4ep+1/sb7v
         c3ySc6xNbAhVaVMkBjAgoKsnWANRhO0MiDHl9GP4f70OmjEk0qNV+aPAbuuxu9ip/2lV
         Er2g==
X-Gm-Message-State: AFq9FYJOtamZ503yIIFavUmTEtkgAEB7ReMyRV/8mQkMMMft88/ZNAs+
	jgAqJXJZiDmM238cpFsRaZPKvMnJ/Pe3wqDBA42egrrfjfzMlM0Rssw+rjZldN7vhfX8haOjGpd
	eIEi+744=
X-Gm-Gg: AYBFou0pdCaAYGtXA/gADySMjGtKDXzNMwJUJLsKGNQdvHuL5PZnA5TJS0GGsddu9po
	lM6uFeQOhj9BvHWPMPDeFqAGatQfhL4dSBLc8PMIeWDM7biu+ADjB1lra34y5TqXnjXpZHPtlIT
	9A2sCEpNRABqnJtVlXmkuncGK2SFvMPtkOGu3IQMEu0K/lKHvFVO5yH96el+exZyIRxP9JshzhL
	Likm89G5v2Jd+2+3AegvA5RLdwYktIrUeV9DyTaobw/POQ8FlNy6x3uVN+1eCDJeq/G9kLuJKCz
	EjxM9JQvtzjluW6B6evSbkAPVuKp9IBOeIwCTy2s2Z2FEvlYvLjNGO8e/7YhCLOH/4W/scJyu95
	RVTnwK2UJzXPxBozPv/q6af5reGlNzi9qmeU85ZcDgoQamiQAt67JZoLOWJJ1vseHyJbEiECzzP
	1vngXHiYBLxeZNk/ijuz23X+0cAfW/8ybEbBNyVz0bQpjyP19fzTnfT9MuO2T26Qu1Z6rwwOCib
	BbA5yaY9QU5ICB02yUaRn8CIaKqvIuB2FmWr5kgN++8QHYFFso8GDrXQSZOcKGqPC5byddGA4de
	Syh0mU5FyqDUsPhdjCVrszXkgtqvsosICJe/+lROXgwto5mA+F0GDfl4sEocNNDQZ0dk2HzkxA=
	=
X-Received: by 2002:a05:6830:b12:b0:845:156f:58b1 with SMTP id 46e09a7af769-85ac0ed51aemr2424638a34.24.1793205953614;
        Wed, 28 Oct 2026 09:45:53 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:53 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 76/98] nvmet: fix NULL dereference in debugfs host_traddr
Date: Wed, 28 Oct 2026 10:42:19 -0600
Message-ID: <20261028164415.1262013-77-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
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

From: Josef Bacik <josef@toxicpanda.com>

The host_traddr callbacks of tcp, rdma and fc take the host address from
the transport queue around ctrl->sqs[0], which nvmet_sq_destroy() clears
when the admin queue goes away while the controller lives on with its
I/O queues. A host that closes the admin connection and keeps an I/O
queue leaves such a controller behind, and reading its host_traddr in
debugfs dereferences a near-NULL pointer:

  BUG: kernel NULL pointer dereference, address: 00000000000002e0
  RIP: 0010:nvmet_tcp_host_port_addr+0x19/0x50 [nvmet_tcp]

Don't ask the transport if there's no admin queue. Nothing holds the
queue for debugfs, so a reader that's past the check when the queue
goes away is still on its own.

Fixes: 7e5c3de3f2f2 ("nvmet: add 'host_traddr' callback for debugfs")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index eea67fba6f92..142df0db5208 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1849,6 +1849,9 @@ ssize_t nvmet_ctrl_host_traddr(struct nvmet_ctrl *ctrl,
 {
 	if (!ctrl->ops->host_traddr)
 		return -EOPNOTSUPP;
+	/* They all take the address from the admin queue */
+	if (!ctrl->sqs[0])
+		return -ENOTCONN;
 	return ctrl->ops->host_traddr(ctrl, traddr, traddr_len);
 }
 
-- 
2.56.0

