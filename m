Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205941;
	b=2cvpHxV6t6x43TAYWozHbvzW5wcKqkhNB0L5yV6rsPQJmvNiGxhcnxn1YkgLYjbvZBV/
	 p3qcrEalIA2aiQGG0NY9jNrSVuQBdv7EaQEBlnTlieIFdGBmmNCJxu+QcUlF6ljCAin8G
	 Ll9Srm3mJV5QUf5ugFY6QPlW3HkGP4XphnBRwKL15NyCAnuGpcp1t0sp7AUoi7c0J2k+o
	 EfaKij9kkdpc32Ghtm26IHkUB51fucZRnmjiX4iBWlL0pu1iaOkjHIYU4WYZxLAP4/gpq
	 RRns+LJlpgRUWmG/FMW4A4DHeYyCunB3GqZANtUvs5LGAfYDuvd6jGT4XTIBug3HRfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=c0EuqZGn4EM1x+nQS90pL/x0tFrGFKRPiGbkzFWgq6I=;
	b=icgoUTjyY9zdhHtDs7JJF10uj22aXZwkYcoFSTF0H9Eyz175M5HgL9sqrrqnH/sxFJh7
	 AMCWKnHd55EYXnECAf47TaslUx/Qt3pB3XZMJa9d+engXS+OAtE1lFBfSCIgdyEf2YCmq
	 gmaStD1u37hQGBvVOredsm16kiNC1r79/nI+0KpTyYgiQDk4zU4Q7QS1zi2UcvgvjV1sR
	 rplOz61bLvMDLRWyWWkQJK+IiAd81P39Fl95WS4QcCTNEEUWEmLJ6AscNu6aVdHcRbEky
	 WZjGGsRbdNbh7yruREW3saR4AWdMBGx0VGl/ZLxTtV6Y55nGIexHSXZrqIZYLcRPzAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=A14mFwDP;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69638606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69638606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=A14mFwDP
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-84a2bea315dso833938a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205940; x=1793810740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c0EuqZGn4EM1x+nQS90pL/x0tFrGFKRPiGbkzFWgq6I=;
        b=A14mFwDPUQSjEutsqlaWVKOVD42mNv6ha0Y4sMjMBPgYlZbcmUjLQ7uNF2fe0G3ga3
         9lEsnk+g67c6X2bm6XkwTe01oLIyuXJvnR0w0CqCQthiL+eBXIjKouOZli+WOrcZLfeL
         l+izSFFOgn6gJ0LpsZHIQ3BYx7AGlc4q3sN9mOy/6GOXg7R/DdP4cVq2wDn2ZlzDiwdW
         MkENB3jtYLWiR1FQJkHs0+k65l7A/iuVONxhFv3cr4AS3T/MucGnxf9obewu2gd+PceP
         NdLERm51FugQNwjeEYR+kZ0DtWlh2N9qpXajrqwve6jK8BSyh39odPK4FBcyt/OWL5RV
         3zuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205940; x=1793810740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c0EuqZGn4EM1x+nQS90pL/x0tFrGFKRPiGbkzFWgq6I=;
        b=vnJh8YaQSPVHIdhInRSh0YrtTTeoOdxb05384PChQZdBKKAHdQrKKKahXlK6d1rwVJ
         pgw/5LEf+CY756BYeu0Gr/uXMU960UE5NceWI2jOjatDdXxGedduMLfBslyTDMDqt82a
         ExB8bDC8xD350Bc05c7bfFxP6EDacKGoQzUAHXpLshGcPknjc9Bzb6v26TJAWrI49s9K
         JGRoz+ogwzpHmmyz1w40iOBpKqtgu5rUPpQ2LE1HfTps8+9laOvP2YeVnKIG8W+mt/iV
         jPlzlJ5U6TUAewQlk9VQHsWFy22Ql7T7wNXgDSn1f5exL5jwaSWwKWEN+QCFceN65+/q
         sKgQ==
X-Gm-Message-State: AFq9FYIcpNs1S0v1VTqyGG14OpjgINqNsLkKTYWq8m8KmfdwRfa28xrj
	30xn/UPsh8vl+L+icl8x46ZnebCrLIdPrxEN0PmtRFhCFD96eZ7+wnH1/51PXxFXYxhhw13l380
	XItpdneI=
X-Gm-Gg: AYBFou0GwelfHp9WaODywKEOLzxDBUWJcuso7+4n2hr+4Ta8XGJ96Oh5VT++5FYXQav
	dATMQ0+gmMV9K/QZgMuNlckuIhhk6ATqtA/FtpPGP/JJ5ZZKqgRGlIIIUAO3wqSHTMAaE7GZgfs
	bxTlq1P8JsZUw99JYpts9h5OTNzIUCV/4xvF3e+fMxpwVkV0Y7gg8doAW0+0V1LuMJyN/FpPV0R
	H6vV5/K9QOnbs2eaNM+6JeWutnpH2P3WCuJavGM9d91bVH9bhxuXrSe4gP9LnizhtYiRrKBJMXx
	X/eOuyELYe5w7or1rT5XbFMzFB2tw3UXSUSAsUO+lK0+DstiAUXV2d9Ibcrfq3yUnzV6bwj/3CI
	6MSw7+MHxSPOBFZib6Qx6O4v8ynowZvpJpc20hAYRQD5YbDLZtRpXgvr/rIkAZfS6b9tV9aXQEY
	EN2kIytBgCeUiWcvAiDDgdkcRZ4hpFG7MCD3/11hjTAQnXLMZxClCHSLnqzf9cr3kHRndwW5LtM
	RWQFv3QaDMaAYrIT/HyCODbV/wmfb6Nng1w8FmbrNqIeUI22vEbxxa+Nm8QlIP41XhFLmiXEUDU
	hqtdNCbbhPm+vJXB8qxjx524KhgIHNf2ibyKVNmxkKusUsEPyvnlRox4J0As+eKVMn5a+ZqxFg=
	=
X-Received: by 2002:a05:6830:2b08:b0:824:5be1:f47b with SMTP id 46e09a7af769-85ac0ed51bbmr2814081a34.26.1793205940394;
        Wed, 28 Oct 2026 09:45:40 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 66/98] nvmet-auth: free the old data on a new AUTH_Negotiate
Date: Wed, 28 Oct 2026 10:42:09 -0600
Message-ID: <20261028164415.1262013-67-axboe@kernel.dk>
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

A host may restart the negotiation at any step. The challenge and the
session key of the abandoned transaction stay in the queue, and
nvmet_auth_challenge() and nvmet_auth_ctrl_sesskey() overwrite the
pointers with new allocations, leaking one or two hash-sized buffers per
round for anyone who can reach the port. The controller challenge stays
too, and if the new transaction brings none but asks for the
controller's response, the old one is hashed with the new hash length:

  BUG: KASAN: slab-out-of-bounds in nvmet_auth_ctrl_hash+0x2d5/0x4b0

Free the old transaction's data when a new one begins.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 5ab943256f38..665c56d29d07 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -336,6 +336,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			/* Restart negotiation */
 			pr_debug("%s: ctrl %d qid %d reset negotiation\n",
 				 __func__, ctrl->cntlid, req->sq->qid);
+			nvmet_auth_sq_free(req->sq);
 			if (!req->sq->qid) {
 				dhchap_status = nvmet_setup_auth(ctrl, req->sq,
 								 true);
-- 
2.56.0

