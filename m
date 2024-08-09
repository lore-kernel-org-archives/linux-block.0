Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB17E197549
	for <linux-block@vger.kernel.org>; Fri,  9 Aug 2024 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211648; cv=none; b=dXRbXarC9iHltKpLZ+7lBkKxzIpofPAwK5eb8tUYqumL0lTEvMSBBAQYoQiL6JCyTNEZdcmcnPZZ3L9wGgWubCwBtmI143QJuQ4nxia9o6eRFEr2AnGPNNT39BwPx10WnNtgFK5NxNMJ37Io3uPBubAQsIDpscDCYwsV924uT24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211648; c=relaxed/simple;
	bh=wb2H8LXCtQm3rmPQGZqDqB+UQaTy7Plk58G3H8COpcM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iGX/qmpg+KaEyPDhJb4IdfmLEmRCp8kWTS3Sx6wF4s/iN8UQbhuOe7/V7GqP0QIPKJQ6zChJBo4JKJI5hE2sCySmPtfOhhHL/EH6RBA1563G3KUQaGPoXKEnv1OrvDBcfncvUj/o3YpoicxiQ6rf2PvNqM4GTfojXTSkiFAdYR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cHAQNle3; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cHAQNle3"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-369c609d0c7so1583620f8f.3
        for <linux-block@vger.kernel.org>; Fri, 09 Aug 2024 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723211644; x=1723816444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RG/tP5hyJj5FvmvIHghD0+xuIqwyjsENrdzSDblOPb0=;
        b=cHAQNle3BOhJ22WLXWM7WDrWxnZ0FmN6mCu/KgX4F7id36saqBhA3ezvJBzTuOiJsF
         nTT0QYWYUCxSveGeMFAwAXq+T1T00aqeg90/ItpzYhH4wtqY7RyJlJMUN10ZHw+qu+rF
         vXVwVWzZbrYkIBXmbVX1qykbvGCdkUhyvMsXZphI4pwVsxjupjCL+e7Ddx3vtOdGQGaD
         LdK/4SkpqyLhdpMPmwzsQImDxllgQcnZdQqH8ilsaem0o19+6kyX8bRmCHCWRKJ4cMXF
         H1CziUUQzeuHgPaKATgQlF234aMBv08X60UhzHbeRAaa1cm6FqvnhjdYoGKf5e8SAuKA
         4Uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723211644; x=1723816444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RG/tP5hyJj5FvmvIHghD0+xuIqwyjsENrdzSDblOPb0=;
        b=hVMaH5sgc8SPGAp6zLvq9Dg2AfGmyNuy+nGeIxiZY4OLyOfkJ6ZgSCqUuyWeVaw+rC
         wSkFzZGnKUU1Kh5ek5HCQMlPYZHcGq0h6wXiPb8xMVUuT/ZjF3BAFgt4vKIHX09LSBh5
         C7DHX8iN0+vMSFnKvRRIKtkTaQIHfXhzJTj3+FTSpfx4NreGvZA1GeRWMQFvT4/toAuD
         LMkoOjl01M0EzAaF5CKwMOtu1fzERpaYHjf2cIegJqHD8+MkuylCoOJwI+83Ec/nNai2
         1oWBtAug0XVtZPMQAoK7e4cbWeYMUQRor2tor37lH3ECdWDyLQXIlCUtrz//y+hyyaHN
         mvDA==
X-Gm-Message-State: AOJu0YwpjpUKdUEpvN7Z4Ui5GYvqIZMSePw+ZLKG56DPx8zwR3+j76Cd
	UVC2/DLpGaRdV1zZwwQYrDo4g8eo4JfbhtwUr+KQq+ON7kRPpdHLvXenN17usVq3SlRyiOXQW3r
	a+P3s9Q==
X-Google-Smtp-Source: AGHT+IFxz7+Egi9wV3uhJxmSJ8JXmfyhJP2NnCIYuUZe8/iz+EIhUggFlAV0w2mW2wyuE1KbiXSKzg==
X-Received: by 2002:adf:b189:0:b0:368:7f53:6b57 with SMTP id ffacd0b85a97d-36d5e1c73efmr1287525f8f.18.1723211643905;
        Fri, 09 Aug 2024 06:54:03 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2716c93csm5406588f8f.29.2024.08.09.06.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:54:03 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@infradead.org,
	sagi@grimberg.me,
	bvanassche@acm.org,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next] block/rnbd-srv: Add sanity check and remove redundant assignment
Date: Fri,  9 Aug 2024 15:53:46 +0200
Message-Id: <20240809135346.978320-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bio->bi_iter.bi_size is updated when bio_add_page() is called. So we
do not need to assign msg->bi_size again to it, since its redudant and
can also be harmful. Instead we can use it to add a sanity check, which
checks the locally calculated bi_size, with the one sent in msg.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/block/rnbd/rnbd-srv.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index f6e3a3c4b76c..08ce6d96d04c 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -149,15 +149,22 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
 			rnbd_to_bio_flags(le32_to_cpu(msg->rw)), GFP_KERNEL);
 	if (bio_add_page(bio, virt_to_page(data), datalen,
 			offset_in_page(data)) != datalen) {
-		rnbd_srv_err(sess_dev, "Failed to map data to bio\n");
+		rnbd_srv_err_rl(sess_dev, "Failed to map data to bio\n");
 		err = -EINVAL;
 		goto bio_put;
 	}
 
+	bio->bi_opf = rnbd_to_bio_flags(le32_to_cpu(msg->rw));
+	if (bio_has_data(bio) &&
+	    bio->bi_iter.bi_size != le32_to_cpu(msg->bi_size)) {
+		rnbd_srv_err_rl(sess_dev, "Datalen mismatch:  bio bi_size (%u), bi_size (%u)\n",
+				bio->bi_iter.bi_size, msg->bi_size);
+		err = -EINVAL;
+		goto bio_put;
+	}
 	bio->bi_end_io = rnbd_dev_bi_end_io;
 	bio->bi_private = priv;
 	bio->bi_iter.bi_sector = le64_to_cpu(msg->sector);
-	bio->bi_iter.bi_size = le32_to_cpu(msg->bi_size);
 	prio = srv_sess->ver < RNBD_PROTO_VER_MAJOR ||
 	       usrlen < sizeof(*msg) ? 0 : le16_to_cpu(msg->prio);
 	bio_set_prio(bio, prio);
-- 
2.25.1

