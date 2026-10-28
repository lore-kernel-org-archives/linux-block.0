Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205986;
	b=htM5BGKey73phj58/33HpnZ9oykZVG5hHIfQ0KL6NUpSjrYor8YmlXdLzw7tOPOJKAz5
	 C/2cogn0iChiXFNdMCn9Hon0lJhnvWY9mnZPzlVlLtULNEyD5wS+5MU975+klhXDGYcxP
	 Pds0vzQutK60mpsgwX6fNOUq97KsAWF3+kD8D/QS117VfcrYUjWlVQz4pEchBrmdRIj4m
	 C2GzHn9T4HM4isEsPLMMsqzGCiUoB/I37w6hC+kTWTWJq/K99+Zt/NYA4BSiEXKNmCffH
	 5E1aZDre3wmKZSO56Rlq1oQ76KMfXDbGZ2GbbXj2gC5d/RiCiFtLT5/EZd9a2dfDC2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VR2GONG4WVNQ3EFbUrt+wzYPw7dWLYE3NUVtoPlCoRw=;
	b=vCNzB6aa+DdmO3pQpxR2y+K6KPNxYU189xWnwGPOUkbdIU0pLDT2/aKv0UIN/kuQLw2E
	 h6gevFpvyNVwAqRULLPAboJll08TcikbzYUZ8TCe6aQWEI+thXb+mGQXFu8jCykZ+YmZc
	 Ng5u1PY+soU2z/F52fXCkaUSQtGU4666e70qt8BmtV0hJYdsBr0/3S+bIO2TMwkZ0e3or
	 d7Cx6U3qEogKFBMA1GP0O+hzx98quSKvpRVfDqbKDRqDHpiW4+rbJt9CLMeMJo0r3QnNi
	 Zy/nUKcgi+dM/33lOVcaeSg55PAs8M8rQrpk7djVwDg9dED+wg5zOW0WRFYGhTmeJWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QsjChizU;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D060A2600
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 613D060A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QsjChizU
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-82109f51565so597042a34.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205985; x=1793810785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VR2GONG4WVNQ3EFbUrt+wzYPw7dWLYE3NUVtoPlCoRw=;
        b=QsjChizUZvRLJ6DDvOjACbJZpZp60zAD5kze8m0qrVrkgly4LYI++/OISFFjp/T96D
         WQQWM2cz8FDFqHNwSjwoJO35043E6Ay8xjBWe7Da/Mtp+b+5Ah/MiSEzjPpqfuUZPLdb
         fc1vTroAI3/TOnDlnx1eLweaFoR7SlYbM7prprJCyD/wye0k4R04TomCUfLhaO+RBfyR
         zh+Bt/bpvyLsxJGyY+Tc+i6g8GCAOFYzR1Nto0SukGAOZkFwRK2tGHBnEKUrsXOalkV9
         1MRgjcOIP/+uasm42Q/f7Q7GZ5MlExhtNguYwhAzAJbOWF7miewwtc5sZKZX16vDKYLN
         qoqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205985; x=1793810785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VR2GONG4WVNQ3EFbUrt+wzYPw7dWLYE3NUVtoPlCoRw=;
        b=heQD0XE9c1c32Y7NL9n2R1JKYpsQ15L6CYAGj0zyB24bjwc7BoBrq/zzMD4xAcrrY6
         VFTsjFjxNmJBee+s7Gn5OeJR1Kn5rKnYIwk9ES6lFRQ+MKGbVvDf3FAxKpA+1KWyWYKb
         Skqv8r003wEJaux80jv625TZI7op5hAqKreIJXGah20j+IbdG9/B6S4BwB3UBUhGBJhV
         fHe6vRjo5+XFVyexHXuAKaclFOdVzQp/M4dA9i5qZmyWwj3BCkjWxxKA1/yl8eE6mvhk
         tfN8vj3l2jr+r/mhIAEz447rz56rsymrWixF5I0sKguGesfxgN4lkwT5PIu/2m1Fvsih
         sRvw==
X-Gm-Message-State: AFq9FYKZRuxTHS+au4pQb5F+VGUKr65QlgPx3xgWiJlxBebhfnyGD2u3
	fXIVbN6MCzdZ72v8Blkx5nRDgl3VPf55Mycsp/ALEQmNR0BDlXyZpU8OBWEcbbO+zbJodLq51FY
	OQSYhxz4=
X-Gm-Gg: AYBFou3sRwxi0zMK2jB2s9q+LGY9sEwCnD/ZEFr2CO9mj73twIyd2Qwq0MM1lUcEdKy
	41+bS8xKHdHE64uTghbjCEqeX3/KEZYnpVbtRu82sgBUuc5ONpiyMoAdzGS3YQCULVHmPTSQbR0
	eBgKUMtu3ntpD/OShXj9Jt/wrlF2HFhitMV/wqTyx92WQTY3B9nFYQosu1SaVotkNu3h+TvYyEB
	mPLscAmcxvRm2xO+YxpV+k3PPCkQnclmUR9WI8men9NeLcx1EaKWC6lzzp26H6LTiYW6sAbwH4z
	lO5QbY9p1zwYxezX+mud6nnlStMUm8W9HPUx5EFZiQJ69oAIRLzWbuFhs3kpGJAWi8IuLBIL8+l
	t0kuSzmXuM4htSeH96vIykdgsbuxC9HboMOZbeEhQH98P0mwYKNsJvUNbHmlHJ1soJqIJIgVh8M
	8esDgyTPgOksvtV3xdi28y3euTFG/1Uar//89sJf1zxXCtseFP5/o5RJI7SbZbvTf2OIciOt+YF
	F/hwzTN9kzbVqjkidhrHer/5LyTrCekocwrsfratCVobTzuvjH3UOopB6NJYVcmPEHO2PNof7wW
	RDCW34HnCtntSHWqwpJRZ8n+3/ZAOfY0plygiUu1FcZN/xA6Y2C297GxNRLY4Xa/IMZMuB+lxg=
	=
X-Received: by 2002:a05:6830:4aca:b0:7dc:c7aa:22c7 with SMTP id 46e09a7af769-85ab3f72a06mr3165810a34.0.1793205985356;
        Wed, 28 Oct 2026 09:46:25 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:46:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 98/98] nvmet: don't clear sq->ctrl for a Connect with sqsize 0
Date: Wed, 28 Oct 2026 10:42:41 -0600
Message-ID: <20261028164415.1262013-99-axboe@kernel.dk>
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

From: Chris Mason <mason@kernel.org>

nvmet_install_queue() checks sqsize first and jumps to err on zero,
where sq->ctrl is set to NULL. Since commit b71df12605ca the cmpxchg()
that sets sq->ctrl comes after the checks, so err now undoes a bind
that this call never made. Over RDMA a host can send two Connects
together and the second is parsed before the first executes, so a
second Connect with sqsize 0 clears the sq->ctrl the first one set.
The reference it held is never dropped and the controller leaks, with
its cntlid, until reboot. The discovery subsystem lets any host do
that, 20 connections leak around 10 controllers. A pending AER on such
a queue hangs nvmet_sq_destroy() forever, and a queue can keep its
"authenticated" mark across a rebind.

Return the status directly, as the two checks after it do, so err is
only reached after this call's cmpxchg() succeeded.

Fixes: b71df12605ca ("nvmet: avoid duplicate qid in connect cmd")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/fabrics-cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 089e3082c388..5614849edece 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -186,8 +186,7 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 		pr_warn("queue size zero!\n");
 		req->error_loc = offsetof(struct nvmf_connect_command, sqsize);
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_SQE(sqsize);
-		ret = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
-		goto err;
+		return NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
 	}
 
 	if (ctrl->sqs[qid] != NULL) {
-- 
2.56.0

