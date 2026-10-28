Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205926;
	b=2SUUEwGlW/4T4vZ/ja5ravRFf+qKW3qJXmparhc5n3xGovhCVTw+sbrv3xDLh8tQ+zdS
	 lt0+rx4h84LVSQ6BVS9qWpTx0+wrlQTZPz4mw4D17LoUrgSGFM8Dmk/2SFThb+FteoMox
	 JV7VXBgQP/Dp8RhYJX+INwruSwfLTFFq2m31zYZIzkrFowj1+k1DnSutDjQYbRgk5E2OA
	 vU4z9cXQTHdJ55BvVYF4VLnrm27tJyWfpGspcCf3X0El3RoCRQFWBAcVJu5XZMVRwSGow
	 HjRQLHYXFxz4nkDPVgKhpJxf3QIFNHSvz2tYOIkjylt/CHqAh9vfnr/2LCPiZt8GaIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dQporEqj/P4YbnFT3HYO18G9vkGQB0g3raFAzR3lvPI=;
	b=yFqVT873EOQUeFo+elnvpUNAIdnmuuQxP2VcFz67piOWnnakrGAlBkiXLnGuFb9DfxX+
	 k9/KB5dODVbFVp/tUSTQCQfv4ABiOzczvysms1/8++R9pkEhqUbi4c5GKMSTT+Tf0h5ex
	 cypfSGFF/7vkdh5gyahAWo2JP140JO+zYAFjfhjfP0EtDretoD4NRILffDOFoE4VTos7N
	 5WxzuobTt0NPs4yMpPgz19tHKlfNzbU7lVWcwHmgzU8zjrQ1ojFlRBVQ1tQZU+8l+DC/Z
	 o81UXrotwSiKIG5IzmnbWpuGUvJifQwgA0HzmdkqksfLYpkp/Nr/c2JOOHmL7wfz0nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZToa1eJ+;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39847606A326
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39847606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZToa1eJ+
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-82380b0f55dso617840a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205925; x=1793810725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dQporEqj/P4YbnFT3HYO18G9vkGQB0g3raFAzR3lvPI=;
        b=ZToa1eJ+7sTSddzQsqYjMKrsy5fqi+Ob+fRY9QNG7pwW2kzRAAn0l0NO2BD/uL7fjE
         IqaFo+Ox7EBKy9NFKZhOB1N9PuFSCA8vymSbbnUTBf7Q9DsEce9Vf4bRhou/sh6k0B6q
         ISW+lJHXew/tq4B1hQNcbmk8NOd2v5skj4kiMTq/Et1TMGlEl7BKc+vZ8kiRsIAHyOEN
         o1MLHe0xt2RLOznlMp6jJL925soQtX26x2thnNzIXHpa/zN7vYAFsiIaoD4SmjDxZS95
         DremcuoeuNPyF2XVrpK0tHuxzvgf/lIYDJTjSoxOiLP0iClnbf3ofbNdulgbZXqk9bxn
         90EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205925; x=1793810725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dQporEqj/P4YbnFT3HYO18G9vkGQB0g3raFAzR3lvPI=;
        b=u1k/9hPEbCPQDcxInMZ5O6hQofKEIopqTRUKYSbgG+bJblfZj4ozQsA1uNetGxY7+x
         rli9a7WjI3UHAw9ZKPR3sLLrx9jVNnzpyap8E2XBhPPgkEqP2VYVc6ID0plm3shtmLa2
         zyDpexAvum/IcBIndipdGyKUSmtl21W/2KrpQ4cuKLgm5Md3CAH07FDRvTOe4OqqLKDF
         99VbBBVsTlGLliNGxV+lGFl7wHH75qjEqiyQylsgbBQjxdZlalY0B4gNdGqmV4rqNvxf
         Hlo+Xm8Q7lvAPZp4kiqW3m0qfVB2Mk0ugWPlcGy6ZqHiFWHqk122PLLD2J+736LpELMm
         kARw==
X-Gm-Message-State: AFq9FYIm2txgRO6eprWCxptWQsNBBedM77Qee6kU79F+6UXqyDUfE9ve
	2hgPibD+9V9+QxJfQ2rs+T5KnGrvqFw5206P03923JtiPlxyq4hwBsflcE/mDITlBrhWQCcvtQw
	fvw5K0UI=
X-Gm-Gg: AYBFou1AZzYYZyA+c6NQMZHe4YQrkOX8uZmQWvpv1m30mKVB8AQLpACDyIHbKDfs3Sp
	opbEpWct4qhN71U4e/zl27fgurO4HDZsy9AqadPhGL9ul+bdiqOOWTfnufebK1QaKl7dNrQLRIK
	uNtj3qzd8zWicI/lnrG+SIpwyheSSRiJZsoVwWo3VPzODEqRU32AooDwR0yeWRXua8D/NVSECZp
	XYvEIYgqvUOrOgZ6p6gx8ZPMUXIPFMPxTrDzbIxy38SwI2/qWDmPQcFHZ+DSMtMn2mfz/chqmW+
	DnwO3gwPwwpICtleOF9Ep8/RTMHgFOY6SPY/gnUg6cilM8HC9nxkccp3fKxSqK3sfQMHAs2JYn1
	hs3M+RVJD2qNg7GFrvDk4TsDlAOJpY5L57Dtuov5zipkjYhw4u8It1Rm6C/aJ23dThjwT+TlAQl
	GUZ7KJnYHd16bQBg24wH/bydb4Ua5RQ0NUzRmhUOOPdAfnDNGnF6apkUsehYEqIPQLz0kFukNHv
	A4htZbUAtBVv0JniJwfdDftsuvuQUx3DiDKB4Ku618FP8uvvgBBzc3W2BRobD4WYI9Nl7bsq5Sg
	IWo2NTd6xo4skexCU099+6eZ4bwqQYqKpVeaaHk+j9JZEyhMV7pJyxhw3qZo/JV6rvVjnmj2Qg=
	=
X-Received: by 2002:a05:6830:7190:b0:81f:2b74:7fc2 with SMTP id 46e09a7af769-85ab9873afamr2763249a34.8.1793205924872;
        Wed, 28 Oct 2026 09:45:24 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 54/98] nvme-tcp: start error recovery after a TLS KeyUpdate
Date: Wed, 28 Oct 2026 10:41:57 -0600
Message-ID: <20261028164415.1262013-55-axboe@kernel.dk>
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

Once the controller sends a KeyUpdate, kTLS fails every receive with
-EKEYEXPIRED until a new key is installed, and nobody on the host side
does that. nvme_tcp_io_work() returns on the error and the queue is dead
until a command or the keep-alive times out.

The connection is unusable at that point, say so and start error
recovery right away.

Fixes: 0471b1093e3a ("tls: block decryption when a rekey is pending")
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/tcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 87ecee0665c7..64f563686938 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1516,6 +1516,14 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 	if (consumed == -EINVAL && nvme_tcp_queue_tls(queue) &&
 	    queue->rd_enabled)
 		consumed = nvme_tcp_recv_tls_ctrl(queue);
+	if (consumed == -EKEYEXPIRED && queue->rd_enabled) {
+		/* Nobody is going to install the new key */
+		dev_err(queue->ctrl->ctrl.device,
+			"queue %d: TLS KeyUpdate is not supported\n",
+			nvme_tcp_queue_id(queue));
+		queue->rd_enabled = false;
+		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+	}
 	return consumed == -EAGAIN ? 0 : consumed;
 }
 
-- 
2.56.0

