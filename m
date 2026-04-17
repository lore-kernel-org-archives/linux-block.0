Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65349DDCD
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 00:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776386913; cv=none; b=ZDTpVhCCSJ+SPVLNugQnDUIuZnytww5TBJXg6dQSezy888oTOBVefQwaAPtkmnK0wA81spwwJDGmW8Ljku/wpVdL1T68EE8gjnJFY8dfr1oQsaXNOm7eWSwC3a04GyuMRn0Rqb8jY6wZ538dOnGyskIPx+KwypJ4yWWbi1HlfII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776386913; c=relaxed/simple;
	bh=v7YU4IvXf2cywjpw4LrHIEyFD9s99pSKkEWjv3FLImA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKhENtxgL7CQZ4RknFfCXShB256kmqNAa0ofVuWRbHZPad2/IcbFve1h6Z9UkYRn+9sgRAJlexmyxAt10xuzngbiexyFXx2psXIrLl2XqIQrjVcAb10pMoNje41LZfxYqkF0jrjVPlo8G4ZocHOLACFjoTl7hfa7K6xYMx6ScrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeR6pi6t; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeR6pi6t"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso104600a91.1
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 17:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776386912; x=1776991712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4e764nZ1zj7blXpuN+ewxQc6AWfbbhaFsma2TXyWpHk=;
        b=BeR6pi6tKsOvlCmEG3LXPEQoorFIop9rHLuJyltjLYZcTKsRcGuPv4etstKpwV4YSs
         cs0HtZmNBdbr8Lhw/Nx8lZxe8ckWJK5gTydjFRnJpSoEgxrMCHHN+w2t5GAJdQEs8YC3
         oR+4Y3JG7p7OpwexGTWFsfFOBfV/0OI0YrzRJHMGptJDsmTPpdxZ8VFF1y2BSwqH32Zu
         kthSE9tocUSncdinmd1PtMm9hJsHlCosH6yiT5735HXqYUdB1XsA2K8TvnwUDEHD6fM3
         PtMb3caqwZnXd8h2SVvAujgTCxWHtcjDMBlvaWmtNA7X1w8RwitcMSAk5EGVZ+9F5H8/
         ocVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776386912; x=1776991712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4e764nZ1zj7blXpuN+ewxQc6AWfbbhaFsma2TXyWpHk=;
        b=tVQvJPaRkNPqelNf7fGTsHQJQyA9WcUJ9sJDrvvpxFXOv05dzWg3K83p3It4HWXhIT
         nxKeGsZRKBWyq2jUxk1wpC3ZliP6UaPCCUcc2O35rlF4HFiTbCnzMrFLdC7P5ECAohgg
         7VO27JzIQDCApUNnJ1o8IrSCUMyGnihNjV6Z8cN1uynYd02GEXv7bcJYc3DK8QL5fGE0
         Zg2m/8zTfwDm4npjR/Li7z0rvU9Y6nWzEUbagi6CI1dfk2bLlSEWDb3INJelqXGjgTdd
         tt4Db0mI3J9FgVCaOvKnDH/Xv8gOMQzsVIuwiPG8JX+iiq3hBXfRs0KxyB2rpYuhdzjE
         m8GA==
X-Forwarded-Encrypted: i=1; AFNElJ8AXDwpYU/0KX/2yQIS7zhFLhQH/I+M8zCD4956iQNpG35pVp4DEFbMmyogytBrZiFBO9B5HKziCtEbAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDBp15jcBgk69415FxwWNz/X7CKaYfsaPbK3SXWbAWpPGVAALv
	C87I8vNeHEiNkek+yr063jHE67Pk+GIjD72e8GQwh2TaSC8N7VgVvgGl
X-Gm-Gg: AeBDieuYXAk8dE0jklreq2x+I42kJ1UoZV3GfnTJGzxVcToG9efH59po74W6CXnWfsT
	ZN31h4L4RJEobC3s2UjrUsMKpzVqky2I360NNMDtCQUCG5SFK9h1DumkUNZCLWQ4/U8Q8N2PjmH
	muTcnY9/j9CQVvcAeZtdTVo+troE6885Cp2tMRUXEatezN1sZlr2+AQmjgoFH7RrJCSLeOwCu5W
	27/5n+XsYkPKkj+OwWra8vpwzeJXwONxomnHbJaFi8b3GbKjaFpPagbck5pG7MTfxrIDamBrgG4
	4fvHNM8GLRcUbqyeRsvVVi0sTfPZolE1pYJ6D2grWoRGsFdyjuhRZpDTAKXmfTZ+9lCW5DCRJQh
	71LfwcqSQIMGLP2E7WBOveu17OEuPn4l2cvOhqtpOklTjutwJcySQjwSWIwoPrngHyIRRHhm8Eo
	IQ5ad+IyAH1zZw3hMeWE8M7bJdL6+CnzIuQN+uXouJXnX/S1Yot5ZvBFdZRy9ccRs=
X-Received: by 2002:a17:90b:3811:b0:35f:c729:de9f with SMTP id 98e67ed59e1d1-361404c2053mr579573a91.27.1776386911739;
        Thu, 16 Apr 2026 17:48:31 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab3c067sm1057345ad.76.2026.04.16.17.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 17:48:31 -0700 (PDT)
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
Subject: [PATCH 2/2] nvmet-tcp: Don't clear tls_key when freeing sq
Date: Fri, 17 Apr 2026 10:48:09 +1000
Message-ID: <20260417004809.2894745-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417004809.2894745-1-alistair.francis@wdc.com>
References: <20260417004809.2894745-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Curently after the host sends a REPLACETLSPSK we free the TLS keys as
part of calling nvmet_auth_sq_free() on success. This means when the
host sends a follow up REPLACETLSPSK we return CONCAT_MISMATCH as the
check for !nvmet_queue_tls_keyid(req->sq) fails.

A previous attempt to fix this involed not calling nvmet_auth_sq_free()
on successful connections, but that results in memory leaks. Instead we
should not clear `tls_key` in nvmet_auth_sq_free(), as that was
incorrectly wiping the tls keys which are used for the session.

This patch ensures we correctly free the ephemeral session key on
connection, yet we don't free the TLS key unless closing the connection.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/target/auth.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index f032855b21477..1899e9719b12a 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -229,9 +229,7 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 void nvmet_auth_sq_free(struct nvmet_sq *sq)
 {
 	cancel_delayed_work(&sq->auth_expired_work);
-#ifdef CONFIG_NVME_TARGET_TCP_TLS
-	sq->tls_key = NULL;
-#endif
+
 	kfree(sq->dhchap_c1);
 	sq->dhchap_c1 = NULL;
 	kfree(sq->dhchap_c2);
-- 
2.53.0

