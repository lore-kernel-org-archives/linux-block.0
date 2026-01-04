Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685C4254B18
	for <linux-block@vger.kernel.org>; Sun,  4 Jan 2026 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767545659; cv=none; b=pkkLwdW0K65WF0fE8jFyfSYV4MIaDT52U5knINhMPOkjp+vmLhYyVHOJ4d4WotEhs54RMKnIA7p4wPRLApZUFOmnc2GPAmJO3ZMQqRcYuUC6WdZQDGB4olstgb3mcBc5OCtkdW8dJ8e+8/HnLf4kBZHNkYNh06DnpMjo8U/39zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767545659; c=relaxed/simple;
	bh=x28E5yt7ezS4k8PM6aROdVSVIU8TQ8nffABefAV1VCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MHc9B13uaOJeZHX24jPlzC/7pe0E7Pl7WSrAr/GNJ9a4iAA/uV3xaB/2X4wNevCpVYLBlUlh3IxUgQTLW19fYXhsBuODIYgOQZFSLxV4VO4y4RtnnUNfKWkpI/wtK1i8QkYHsM01v8mna+6cvHvp9apAaJpM/X2qZQiU6z4OBeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlekuV3z; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlekuV3z"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so10995215b3a.3
        for <linux-block@vger.kernel.org>; Sun, 04 Jan 2026 08:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767545658; x=1768150458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h4wzx0QjNYHmMcnbzoklLRWyBOWFDjQWK58mjz76Amc=;
        b=dlekuV3z0WiaxientqEC59ntftxXguXew/oeY424JzR0a3ASjmd+0yxvqRHVgx/b9J
         UMt3FjCalX8hjyEAP8pMBwn8mWIZ3utFFNa5LwG/R3Ww1gi90jePct2fooD8GlOnjxmp
         BQVoCADx0GSLMpu/qd6hpJ87VZn7DD65OZhbMt5qSgttgeaOvMGretYRlEQb0TJ+9mQQ
         FLMnjssYuEoPNYMr9BTb9/DyJwZs11QFyFCOoIH1ShMJA5TsKwIFsEpBDhC+McUqZU+s
         wQvHH4zFiXnJNixVT62oG0qW7CjmGrk+RCZRmDZX6Pxi5DNumhbJE/gd7d/E185GQWMU
         r95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767545658; x=1768150458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4wzx0QjNYHmMcnbzoklLRWyBOWFDjQWK58mjz76Amc=;
        b=a9/rp67EjpCqc4wcP0bA1UEW+Xg2emIXwiAPsDSggrvSun/xx4ZHBIkLlSsWl/zZRR
         xVZXrV7il5Eln6zkqDw8ppFZFcc7dbi3kFJQ3GfYMafb8yzLSLKxboB85R37GxgpFOQS
         NCKHwHk5fsf6RHokqXdfhIaSRYmtjl1luvJmjZ1mVjJgJ2f/ZWX/xDWTBsIb58LUQ6+d
         HyaH3OcSGcwja8f/YcEVzUs9Fe8F3ZNyJE+sc8MYpC0j+3CfoxEY8/jVwBf9IZwZjDcm
         /brbIBfnrXzs7jDZJg6aS8OaAQUKLypeRC30UyHEg8xZT7r67XY/VPQWgx/yzxHcnuCJ
         8r8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8IlhO2is/Czfceb6v7BGnh2cW4OYWI0sjOyZbDxl35b0L/82TwnqW7wz6UByaxRc2WATqE3TeBJeDAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd7rTxo+DK8GfrYDIgdAeqGOzWLIzTDvhOVvMA7hkrGdr+2NKh
	+S9WqgE46PzW4E3kRDGgP2HqeUQW8CyPQHMwSORYQSelh+k7001ac3QnHFJ6HuGc
X-Gm-Gg: AY/fxX5xfFvUBjxMNV6WvHkj6pD6Tv4oz9jTN9mFehvcB+SUJx00mTClxLRzl2Ne3kW
	M886mnJxWyrLnsZg0pnOfupSb4oTqG/q2vdnnjK8Rz03bs3krY1kH9Tke3ZMHtJsG1aGc7SWiZq
	+npp1OdHGf8jX1aX3eeg7wXZt1GtBi1YBx49mQXYubtfmG7ias/z7eahuIKdInKtAKODLwTjsPA
	0n3NLo+35HQKbYC9/4mAdsNNNAIII8Y1kPu84EDPJsEKn/TSViiY5IECMAODQbBbZtehRx+JboW
	r6mRvfy8zqLYpnMGfrVVP+JvcN51LQGwaaJfITFguv400sWyqXijU7trhFpo2x5BJcT+qFrVFw+
	P0hypXrul2eIH3jAhWK/pQl4lTaLXRPF+vc3hqD19W9O0cRSYODmcnZxndLH3QNJ8MxjohfE=
X-Google-Smtp-Source: AGHT+IFqAajYDM9xpB7V+TTg7NNHeCTt4UbeUM+Gej/hB2IL8cFrRKaGYgKk/bBQT3fRJOAZV5tbUQ==
X-Received: by 2002:a05:6a00:8186:b0:801:ee55:a2ef with SMTP id d2e1a72fcca58-801ee55a3c0mr28211971b3a.8.1767545657617;
        Sun, 04 Jan 2026 08:54:17 -0800 (PST)
Received: from oslab.. ([2402:f000:4:1006:809:0:a77:18ea])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a843a18sm45972843b3a.14.2026.01.04.08.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 08:54:17 -0800 (PST)
From: Tuo Li <islituo@gmail.com>
To: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	axboe@kernel.dk
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH] drbd: fix a null-pointer dereference when the request event in drbd_request_endio() is READ_COMPLETED_WITH_ERROR
Date: Mon,  5 Jan 2026 00:53:55 +0800
Message-ID: <20260104165355.151864-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In drbd_request_endio(), the request event what can be set to
READ_COMPLETED_WITH_ERROR. In this case, __req_mod() is invoked with a NULL
peer_device:

  __req_mod(req, what, NULL, &m);

When handling READ_COMPLETED_WITH_ERROR, __req_mod() unconditionally calls
drbd_set_out_of_sync():

  case READ_COMPLETED_WITH_ERROR:
    drbd_set_out_of_sync(peer_device, req->i.sector, req->i.size);

The drbd_set_out_of_sync() macro expands to __drbd_change_sync():

  #define drbd_set_out_of_sync(peer_device, sector, size) \
	__drbd_change_sync(peer_device, sector, size, SET_OUT_OF_SYNC)

However, __drbd_change_sync() assumes a valid peer_device and immediately
dereferences it:

  struct drbd_device *device = peer_device->device;

If peer_device is NULL, this results in a NULL-pointer dereference.

Fix this by adding a NULL check in __req_mod() before calling
drbd_set_out_of_sync().

Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/block/drbd/drbd_req.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index d15826f6ee81..aa3da2733f14 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -621,7 +621,8 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 		break;
 
 	case READ_COMPLETED_WITH_ERROR:
-		drbd_set_out_of_sync(peer_device, req->i.sector, req->i.size);
+		if (peer_device)
+			drbd_set_out_of_sync(peer_device, req->i.sector, req->i.size);
 		drbd_report_io_error(device, req);
 		__drbd_chk_io_error(device, DRBD_READ_ERROR);
 		fallthrough;
-- 
2.43.0

