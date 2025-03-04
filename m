Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B91E3DF4
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124082; cv=none; b=lHqr1RT31Oo8vWKGIAwQtWkWh7iSHgFRhCKeCzZamhH8KmLPn73J2fy17cp2ax0CdgJkUfTsrNxC5J9whhhzbiQn4imhdZTbQFGuRLM7dElEkcNgOYjWZqrP8Bsn23LS6/95XvwTTg7K9BvfQWlAhAK6nf6toqU57Gc3L/R5rLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124082; c=relaxed/simple;
	bh=zOOXNqmAgBoTiYd6BYQuX8ru5CUcBkcrr6LGf0LYfiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A9wyV2RjNMrHrTNT5PjOwB/UGzRuqc6NWvHaSs9/2etopr9369ma9JMQ6mvZIAgUKWIMrwCAonaHPkSRcK/0/gfyfiIldw9qkBYKbzyIGL6qbrVA046OIQFFQxflhBDE6tJBrmdUDOMBBnCRbsCVfycB8D9axJQwsrS6L0Zmyz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Sy/2Sl26; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Sy/2Sl26"
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-2b3680e548aso92755fac.0
        for <linux-block@vger.kernel.org>; Tue, 04 Mar 2025 13:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1741124079; x=1741728879; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dwuHRNF7YtoUCBjSIwg/Xt3R431SEdDoVS9PHQ6Bbus=;
        b=Sy/2Sl26bEn3YwxIU2ogirOzuQwFPOC8jEHWgb7NfkY93AjujUf9sDRoOCvRppoaZj
         kpoHSuf2E0aw3kUUyuV/HUfBKH9M1U0e1dWrZ6q5NrYQ2YOl5lPWLFC+bl2jO8cG4hXp
         3EO0MUr7xdDkN0JWwpkNhmMS4vmi3khgVugwmYlPnv7zULvqHTtgID1Jbs8O8IRocBjJ
         RZwiMhWCZQ+My4pa/V1ifRyOIhN9204iFXTNkv1s9ldG36Eoiul6iJxbNnQVle+pX9A2
         wjiGFzW+nXc7iIqUgZygpbIgD4GWNGxmYIUT0z/11VBT+g4b2WlQtQvvXAVgTy46Kmce
         9Gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741124079; x=1741728879;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dwuHRNF7YtoUCBjSIwg/Xt3R431SEdDoVS9PHQ6Bbus=;
        b=NyLlovN8MjW2rAQ9ALz3YUF+aZoUSMu+wyWVuQiQ/u9gZf/6MdalM2ovVFexEeVUc0
         H+BU1DiG7ogstPimV20BlFvV5+L7u/zFDMWqsmOlkmn72YRWZxDWbC7I2Cq+9MHXgvId
         lCabq3xc2xN4R8OQAnBibiZaGIBLCAO0FUJXlBNr0VAGm2E0whu0Vqhy8jwEUzzgSGPm
         f61L9uWaETPYoQ1XsXsbuQvPVFrV/SeTGdDEho1A2jbsqyhPCeaoqIIkRLRvJGpHfPUx
         XdAmvxurIoZRdd2I4+EDX+QAPEnVpHhSn+hCmsf1D5sN0hSBul7OKfow/6IRw0j9mGlQ
         Vctw==
X-Gm-Message-State: AOJu0Yx/ZJ5mMWjXu/eeHJ1K+mJrdHFK+h1jOxt3ifg/qV/sEk99TX40
	BWXCDFxMtP6Oc1p72bfhOFoalAMewaS1M720bo09TmkoQWvh+Gz/dCq2cM6ogxq8SuZMY5nwlIU
	96QSK+uIT3xcPIYSXUysaUbbjyhagXbjBCfj+yz+ZmXPOTLxs
X-Gm-Gg: ASbGnctfRfIzw6xAlIl5gVXsZgV/ZG24GSrReqeTzh27Aj3jdgaYoJg8hXpV8XNULt3
	FASdSjqUAk8bGlb4nrIkpZk2nMcAXbMs48A+ajXfrF/2zZl6RYQuZDMbEKnEnB3PX8XcAzkMZiy
	adQcSx64przt78Ht5/cEIoBifj+Awt/JUEOCkSIobZNkzRKfvuiP0nTP04G2H5bWjXcqxdO5d8l
	gr95Kxdy9bY5X0NNth7KCRT/T8xcnp6fjF30IggMOfO7+Lenmol+sg+bB1qOcL1fUEUFAfQb8xc
	p16FJQQHp64XDb5kt43fwS2pLD+apA63MO4=
X-Google-Smtp-Source: AGHT+IHAeEot3462VoxtiT3aH8srBiPyH6XMDxibQV6tSz0YjEEb6wleTYDWi2wKAV04YmPYFUz9sZ+8l4OP
X-Received: by 2002:a05:6870:4693:b0:2c1:539a:6071 with SMTP id 586e51a60fabf-2c21b6c6953mr545473fac.10.1741124079238;
        Tue, 04 Mar 2025 13:34:39 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2c162e2ad2csm645283fac.22.2025.03.04.13.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 13:34:39 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8FF1C34039C;
	Tue,  4 Mar 2025 14:34:37 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 523A7E56F30; Tue,  4 Mar 2025 14:34:37 -0700 (MST)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 04 Mar 2025 14:34:26 -0700
Subject: [PATCH] ublk: set_params: properly check if parameters can be
 applied
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-set_params-v1-1-17b5e0887606@purestorage.com>
X-B4-Tracking: v=1; b=H4sIAOFxx2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwMT3eLUkviCxKLE3GLdFCPzNGMLkzQjS1NzJaCGgqLUtMwKsGHRsbW
 1AHNaSMtcAAAA
X-Change-ID: 20250304-set_params-d27f384f2957
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

The parameters set by the set_params call are only applied to the block
device in the start_dev call. So if a device has already been started, a
subsequently issued set_params on that device will not have the desired
effect, and should return an error. There is an existing check for this
- set_params fails on devices in the LIVE state. But this check is not
sufficient to cover the recovery case. In this case, the device will be
in the QUIESCED or FAIL_IO states, so set_params will succeed. But this
success is misleading, because the parameters will not be applied, since
the device has already been started (by a previous ublk server). The bit
UB_STATE_USED is set on completion of the start_dev; use it to detect
and fail set_params commands which arrive too late to be applied (after
start_dev).

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/block/ublk_drv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2955900ee713c5d8f3cbc2a69f6f6058348e5253..aa34594c76ad02b1480b9ef4a2bd52a095ca6f3f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2782,9 +2782,12 @@ static int ublk_ctrl_set_params(struct ublk_device *ub,
 	if (ph.len > sizeof(struct ublk_params))
 		ph.len = sizeof(struct ublk_params);
 
-	/* parameters can only be changed when device isn't live */
 	mutex_lock(&ub->mutex);
-	if (ub->dev_info.state == UBLK_S_DEV_LIVE) {
+	if (test_bit(UB_STATE_USED, &ub->state)) {
+		/*
+		 * Parameters can only be changed when device hasn't
+		 * been started yet
+		 */
 		ret = -EACCES;
 	} else if (copy_from_user(&ub->params, argp, ph.len)) {
 		ret = -EFAULT;

---
base-commit: 6499457f08ac23a1ad16653b67af7f04ff5dd9e2
change-id: 20250304-set_params-d27f384f2957

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>

