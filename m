Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4515D3093D8
	for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 23:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776294191; cv=none; b=uHXSa2QC39prtHrNVHsseVLUrdUdnZ2P0xhSqhm3jF+Ut3tmpRbSgR8q/zebKZHxeN0+4GORv6SbpklK4a2tlN/dbof/BRbjKyziiAzwSnxUvAWJM7EmnuI7BC9wEOEUcuxNqxmdFAYLwSj+o/YoPxFQtX4MAB0v3YPvKG/7k8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776294191; c=relaxed/simple;
	bh=tOF02Ltvr2Fxxw8nXw4s5eXtU4fsmk8lfDe0vEViINU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e/R7lYPijj/ZllZJDDTMVlxzQL8girlnm0W+HICsSmYmNP+CAvoOO3qfn2RicI/x0mnbkPAVewiDSpGh4kTVdy97h4v9Ug9SokUE4Rx2tgaHv1zzSNvLHo9s3GIve9qaioZBZB+DXLgmpQlW6r/PS/kPBDJbZs88jaqqSBh8GQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idS4Lz8a; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idS4Lz8a"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-824c9da9928so5012364b3a.3
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 16:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776294190; x=1776898990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3/nZZ11g+qJgs+aEgAlORhode/4t5Z8MGx2W94OjR8M=;
        b=idS4Lz8a5xu6uFKR1ERUx0fmL+5BLFRwMOelA2KLFmc6ZTELxSKnazBBmvsSmPA5TT
         LBAl4vKw9ADITuMu/RNjCQxiLc2xKFYowjVfnRITAaQ5ZdEwoXPjEksonT60y9+eNf72
         SVl2gWYu+3mgh80AIWSYRu+4Te46GeUif4IkiiujZydTHSlEvQPmD9Ir5OxFVKP4/oUY
         Ql0ZsN3GwLP1Vtd5gHLDJz8uAu0i2h3YtzzCYCh5GGAXD4/rqDe9iBJJtZn/R+aFsV7T
         jIVOLnpAQkH9+CXHcYEDUTIDPogirp5DrY5BayRiC1RHpnxg9US6TgTk5PQvw1Nw8Iyt
         Wyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776294190; x=1776898990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/nZZ11g+qJgs+aEgAlORhode/4t5Z8MGx2W94OjR8M=;
        b=XLdcJrW3fcJFWI7lWpiIRxP5SSO3MfMtCv/6u7H4yLsRTtyZXVAwCoUOdD6J5rBrCL
         v8YqUOeSM2tUgf7Af3foiu6qJvJKWwln+BLE8TxMg+96aMvHaI6IEMlIylnidWzUVa6p
         DHaR97LYxnjU3fXymLT8C5xFdJcWtwKbcmSYy5hEeuHf6xvKEwhPuy4nUOpPR9uXq+Dn
         AbeLEAkyiARple0eLiZetyKEKkb0SHgHOLnPQ+YWpdqtDpmJH9H/R6Vfy6JvGW/PK34t
         K8/hoHZ1v+pKHf3vSlo6/VuKQo/8GZnXr5Mo2gbOMWI1lDtqzBkJg7x8mRU3JJqIHZ8e
         UiYw==
X-Forwarded-Encrypted: i=1; AFNElJ9JhreuOc/Vyh7pm74pn/u/7KWL5x84LnhILitAmCXtk94bkoKSbWiXjM1yxA2hS/4tD0ix4bXmjTjMSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwW5n8sOBU9JuDADn+wSg5N7GPHROmdRoosHST4DaLKrh74Oyuo
	XbXteZYd2USfSV2c/YNyzlug0d/wvJRbKawpF/MfalZ1FtzWX2ysoYqUJl+8qg==
X-Gm-Gg: AeBDievxDwF5e8gIt3ObEjwayb/xZGTp+t3Ppx03Tt0uTWhxLPaAPsk4LWmHBNSoy7+
	hSu4jmnAHDIZ3OA02uuRnYUIX4nDhsXFfGHfZ3yVxccbxzfbJegTxTyWStJ9W3e5Dk4pi28hPRI
	Dk4Ef1N9b1FxwOCOpsDyGmtAF6KPmCiZFC5Kb1KZTT0wl6h3WV5ronW3AS5ugzHUEjgRVQNAzuI
	9lUm/5IrhwDKeZKq6MpMqb9bjgHNd5LSfDuEXqXLVAly0ayDa/7HZKD8woh+QUuyAJqkx3M0JLm
	IzqHhFJDsPPdfyhYPXtCbZfWZVtUBnWuihHwdnNtWkSiw6Vj1+WYHmT1O7rfANtOMf9Gqs7SG+1
	eY6UC6xzgtpieL0xQg0vNfO7O8WoBgv1TMR8YvoG8e+VMm50PDrxRQqgh9+EOyn1cYdau+4JdQG
	qv7s+xtdB9p3dhldHoyvOmSTk+sjHMSWht0gURnqcgZg==
X-Received: by 2002:a05:6a00:94fa:b0:82f:592f:2eda with SMTP id d2e1a72fcca58-82f592f35c4mr7956907b3a.43.1776294189477;
        Wed, 15 Apr 2026 16:03:09 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f694a422esm3482261b3a.43.2026.04.15.16.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 16:03:08 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: hare@suse.de,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@redhat.com,
	mlombard@arkamax.eu,
	linux-block@vger.kernel.org
Cc: alistair23@gmail.com,
	shinichiro.kawasaki@wdc.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] nvmet-tcp: Ensure old keys are freed before replacing new ones
Date: Thu, 16 Apr 2026 09:02:50 +1000
Message-ID: <20260415230250.2783414-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Previously after the host sends a REPLACETLSPSK we freed the TLS keys as
part of calling nvmet_auth_sq_free() on success. A recent change ensured
we don't free the keys, allowing REPLACETLSPSK to work.

But that fix results in a kernel memory leak when running

```
nvme_trtype=loop ./check nvme/041 nvme/042 nvme/043 nvme/044 nvme/045 nvme/051 nvme/052
echo scan > /sys/kernel/debug/kmemleak
cat /sys/kernel/debug/kmemleak
```

We can't free the keys on a successful DHCHAP operation, otherwise the
next REPLACETLSPSK will fail, so instead let's free them before we
replace them as part of nvmet_auth_challenge().

This ensures that REPLACETLSPSK works, while also avoiding any memory
leaks.

Fixes: 2e6eb6b277f59 ("nvmet-tcp: Don't free SQ on authentication success")
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index b9ab80c7a6941..58185184478a4 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -412,6 +412,13 @@ static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
 	int hash_len = nvme_auth_hmac_hash_len(ctrl->shash_id);
 	int data_size = sizeof(*d) + hash_len;
 
+	/*
+	 * If replacing the keys then we have previous successful keys
+	 * that might be leaked, so we need to free them here.
+	 */
+	if (req->sq->dhchap_c1)
+		nvmet_auth_sq_free(req->sq);
+
 	if (ctrl->dh_tfm)
 		data_size += ctrl->dh_keysize;
 	if (al < data_size) {
-- 
2.53.0

