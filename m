Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205940;
	b=QBg3V9PsvNRZl2pGhoIz2HpCihSlOfT++5zaGD5CvZLIudqErvug52VXJHUBJVVu1ZxS
	 jtIz7ccRG1Ii9gAatEq4pEqUqpjTCyRsSNyXyekf0BQ45gAYG8pX6Il4b7Zf+2AY9NkIW
	 v8jvvcjFSGmk7oyCVzic9VMX3xRDtUdywj0QjP0Xk7MCvmbWq/0k5k5lW+S6Tl6i4+CrF
	 lSZOa58lkbDUX/vZ0kF2V5zwgxLHR8vqpkuOwNAW+udUsjBY47ECl/kgCz25fMhtOX/LS
	 qYO6FefMeDwmyalrdJOkhFfjDsf90X7dfHOuUyS2rLbJRFHo2GfbcRrSMMo97eGGnvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CLTAQTbufS75Y3RU4VktmIg1yCKF7DgDtiX2zzR72qU=;
	b=MyDHbTInPR6hssQCtE+4sIg9xBDxxt4CUknLR5bOcPBxuLS3sLGfdhpNNJdVVKiisPMq
	 QB5okUrjGiqXmAeXg5R/0r4iUasYGNU7jTCYkBcQ2hoMV3coUNMnWOl7rzOioOXjQwgGN
	 7rfT6iHFRDihb009hVlEqKWN4PvIKbaPbI4S9Dg6iOGbY/rP8yL25CtI4SdxMGSiMSuwN
	 nj63tmKX+saG3aJ/QGGJfO6MWMsLDvPv1jVmyxNi6hzJLDi4z00guWKS3Rv/r2SnNT7oL
	 iMoU1EgSb9p2gM2iBEVfS1p09cN1odeaP/B85u76PFmiBaQkl2a9lmLZM65RJnFgugw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QwncizWB;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFFD606A31C
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DFFD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QwncizWB
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-84e513877a3so1112312a34.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205939; x=1793810739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CLTAQTbufS75Y3RU4VktmIg1yCKF7DgDtiX2zzR72qU=;
        b=QwncizWBdLyBhvFg8iyA0mNOtFh3WE7qDasVfYJHsaxYBHfcPoyrzSut6UGSr7DlYI
         1FbMF4JX4C5DgG17ggMebk40TYCnlPlSqSKiFhJ0uzAFFkkdVIPON2eQfUGToRlBfLyL
         aWenvzy96Y2jEXE8zioZ2zMFnx6+xHnn0iyUvXycPMvv3GUagVp5cGRIQrAS4SXveVom
         fUdosQt355D0FSiZXJnWyT9oTPKDyc5jK38Hjfo2GmwsBXF7XTdR8gro1hHq74IXIgOq
         AfPY/Lp2AClvB780AIqZgUEl/bvWiYdDtvxtGUuawsGbj2Opd9rY/4F2Zn11QWB3787j
         9AqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205939; x=1793810739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CLTAQTbufS75Y3RU4VktmIg1yCKF7DgDtiX2zzR72qU=;
        b=gmyKMkdKPxkPmReNrKdbg6zWAjQ6kFCsy+MCIqTw/uBLjSJszW04OQgt+T1uiHJ8/q
         yiW1fiq+3z7vXM75rFuHVpRChGUXpFpkcJ5QIaz1shJdXq8XN45fYkah5hx+3M00+rtQ
         iTD8QS1WAYZDOK/ImaSobnUIva6oQfU8WWiVL6IxNhJ1v6WJfCzHTZLM2hq16rIWy+43
         D0kDElYPRdeyDzYe+k/GaEY2PK9sFYUYH2YGGS1mFtT+gH/PbJ4Yh7Y99C30UUj0MGy8
         dGXjj5YrOyABcIS/dgM/o/RrHbsz6TOqYQHR4YvENmHYYAOkDQNmneg9h/cECGkv6ECh
         Lc1Q==
X-Gm-Message-State: AFq9FYJ4AXfcxbob2bB6pXqnOKa9W7Xf0tO12HDcTwlPao7C+o9yEhdP
	He+iNtQ70U3IC44invoPsmayu/Iwv7YJ9lVzO4LOWAvc2uZacO+WfFP6NSSojZbZ9evpLfFQTh6
	v5++xBcI=
X-Gm-Gg: AYBFou01gbA9hj8J1CVfTr2S9kC58vIUhJf86sS7CzAjrinw781JOCCSIk1kn2Fi6o7
	+sXQB01Kx57pQWaT8f8FNSgRu0J+c0ImRkgDgGx8ipa0Lnx4JOZVXgqxBVgEYchmJqpbCrXH3A7
	GuJyvZkekyVjvfUwKrUgMHi7SjEbv3SyZHtP5I8gmQfNVJ6qK7weR94wFvKfMkbRlDU3HhkS+vv
	NhpcLD/ZhBZ7rSgEdagwxxbLNxvfggvbVbQ4Fit/wokTnIxEINdUogiaX0duRO9ou3sf4lR64St
	0yrIIWA1V3GYbb1kTD26ZFZDSxvML91MMhkDrMs8pSj2utB4Rosk9pii4FMhxQLUqR1PR/Ubeey
	tmImZCahy9oLYESRAREGRDQD6YkOfkrAlKq+q2hLJ3disUu0nAm/B2r+zrI4idbQ6vIS2zabuAW
	9smBBqfyjb/RgRxdoVQjBuiFcCJTPLzjIFuaXAqUFdi7bPuDWz68SZt+WV4zcZd2GDkh8NhIm6c
	Ej0psboAXQY8DOBOxTWDn6hPnjUmYSxwo1unelKJiGJ+yyt0jT/dYIq1mtCGWk6HIoSvb7DMAkT
	5T546jPQc2lG84R0gI9rgCQDU+41mANBL655cyx6+bwShwjNkm2SXUH71gBiiHEGffX9Ny7M5g=
	=
X-Received: by 2002:a05:6830:4112:b0:826:4ac6:e5dc with SMTP id 46e09a7af769-85c2149baeemr54920a34.17.1793205938974;
        Wed, 28 Oct 2026 09:45:38 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:38 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 65/98] nvmet-auth: take only AUTH_Negotiate for a negotiation
Date: Wed, 28 Oct 2026 10:42:08 -0600
Message-ID: <20261028164415.1262013-66-axboe@kernel.dk>
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

nvmet_execute_auth_send() hands a common-type message to
nvmet_auth_negotiate() if its ID is AUTH_Negotiate or matches the step
the queue is in. The second case is wrong: the only other common-type
message a host sends is AUTH_Failure2, and no queue waits in that step.
A host can name the step on purpose though, and its message is then
treated as a new AUTH_Negotiate without the work that goes with a new
transaction, like reloading the keys on the admin queue.

Fail every other common-type message, as AUTH_Failure2 already is.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index a559fec3aa65..5ab943256f38 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -350,8 +350,9 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			}
 			req->sq->dhchap_step =
 				NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
-		} else if (data->auth_id != req->sq->dhchap_step)
+		} else {
 			goto done_failure1;
+		}
 		/* Validate negotiation parameters */
 		dhchap_status = nvmet_auth_negotiate(req, d, tl);
 		if (dhchap_status == 0)
-- 
2.56.0

