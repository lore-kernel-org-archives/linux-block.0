Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD222BDC0C
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432218; cv=none; b=PWSW4X/+bfKADm+XtvIMk5fcKMoVmj5NdeiDdQb9IiNVMWBeLmKBkL5meft2d5UihIZuJKTdcwPAUo5qfIrwDz8wJnv+Ccnrp/1BjMv5Cl0TIRgP8opnHpo2AImrbnQxwGYS8jByYZc9U9YyFSH7WWNUBaLgO8GhvJkYNFPguMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432218; c=relaxed/simple;
	bh=OlPwykWb3a2cpE6y+UWUJIWjijXEQ5gKNIek0BEO5Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VI1gHZwtAHlQ+jAO9CnH7Y4ZYGp6eFMuubbABQSXjLGkZ+pfpSfm5mDsLOz0U1PfJ1u5kSwKHxBPcCd51pZjBuSJJt5mEEbYlr2VhpDZgXFSMh6uLaTJrxXGOxuPH6hXzDRSBJtgx5rw/9+YYKMHsrNjW1KQK+kcNkoFwwaTUCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FGbuvqaY; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FGbuvqaY"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-234d3103237so3003985ad.0
        for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750432216; x=1751037016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YT9QwCiEHA7j28o1QebG1GgNjVO67iJMOooTY2VHBdw=;
        b=FGbuvqaYLR0jr+U0i6FggSLl32qgcbmcefDq+qkwY7IK8yxKMmeHFJd1b8FiO0fO4y
         T9wWtNuJffAGk6G7DcDmPvl93rZ64yI2ygJvxFkYhEViQ13QUfZStw+ac+ZEeNARfEFu
         C5U8mUWgVQMYQXv9TB/1AyCi9ysB+IgsLIRjNdUKYaj6yDdaiEwouKJqnqz1bz341zju
         4Sm/enCawyO6yMtDiQT2TPUrhOnZY/kXnBI+jy3l65VzYZPNalb6aU4SVgU+NubEyn61
         l2c1NffdAO6JVCj1jx27pWnp8W1OzAWiohmLFWHirLQzyhMSdg7QoUbGHj98innyFw95
         m+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432216; x=1751037016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YT9QwCiEHA7j28o1QebG1GgNjVO67iJMOooTY2VHBdw=;
        b=m7WtfP5s++Q/aYPHtrKLUI9uQwRLA033MOsMcFBdwofwZDaNWpBl3mmFgpn44HfAhY
         CXJimKhW5IShvg86XkgOQydw7OUB2VRLBgev93/6eas2I0xXhGJRZtZgtd2hTfBXrf+p
         ZFz7UrRKKF3zKEu1c3uAM+4JQ4kHxCjs1ZdoFbceagM7Cetczcccmx2vD/J87IWdDT1r
         RF7OG+ThBojj7CW24MOQCjz5j9mExThBJlLsoCQSbqgPn9YLvC39tcJZ5veBA8+ZFzO4
         AQWq6gc7U2rZk20MVsJpEVtwTzzmjFhC6kgG2KeagWuNWFa6nkwRt25wnTYJNlI9etZY
         aYgA==
X-Gm-Message-State: AOJu0Yw+rkC7vrgPOkKfdJVHbov7QGMgUeDQ0XahOlb9/DVCrUjw1xC8
	U+OiLhJG339NCHSY4bij/n+dM2AlljsrBPtFNbouoE5Q6ir8cn3syVD1CuBbjyxGiGkNfWweKov
	Cq+sYrDR7a8yalzNHyIAMmIXWKjJZ1t6K8VvXjLwSiywbWiAkthzB
X-Gm-Gg: ASbGncueRqTQSi5ROlZkwxVGO5m2vzTIl2eKgmbcVZBTypIHzbsDe80l+wwxfhH79I7
	+jwmNvA8aqudugzTK37gbDSk6gOE+hLjllunimzBcCS67ynwi5ytb2ZFQ3+wWboCHsyQH7kV0Ju
	0agMZLP6J8yQ6/ZNI80eTlNIeUN7Eo3XbHwtAxZnNF1MybEDDjl4rSyaHX5DmhhRy9adKpKEwxG
	MG4xYrOTYuj7XnQVjNG4QCwhDH8zBV69PzA1qNOeuzu+sqsJEEuSO4eIYdPdEtwK5YcpEruJMwd
	Orx28BGcKDFw4lzaxR9LRuL/w75b3sXSAS21PQuN
X-Google-Smtp-Source: AGHT+IGiw58ZzHn31w5xCiabOWrRlwxXb+f6Z9nkxxL3A7V6oiXDbrNl2IwPYYSnYtT+dyTR/V5pxifrMod8
X-Received: by 2002:a17:902:d4ce:b0:234:db06:acf with SMTP id d9443c01a7336-237d980c58amr17719205ad.2.1750432215946;
        Fri, 20 Jun 2025 08:10:15 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-237d86251f4sm1175205ad.128.2025.06.20.08.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:10:15 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 69099340747;
	Fri, 20 Jun 2025 09:10:15 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 67BA1E4548E; Fri, 20 Jun 2025 09:10:15 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 06/14] ublk: consolidate UBLK_IO_FLAG_{ACTIVE,OWNED_BY_SRV} checks
Date: Fri, 20 Jun 2025 09:10:00 -0600
Message-ID: <20250620151008.3976463-7-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250620151008.3976463-1-csander@purestorage.com>
References: <20250620151008.3976463-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UBLK_IO_FLAG_ACTIVE and UBLK_IO_FLAG_OWNED_BY_SRV are mutually
exclusive. So just check that UBLK_IO_FLAG_OWNED_BY_SRV is set in
__ublk_ch_uring_cmd(); that implies UBLK_IO_FLAG_ACTIVE is unset.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 7635105c1596..9bfccee3c2b7 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2210,18 +2210,15 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 
 	if (READ_ONCE(io->task) != current)
 		goto out;
 
 	/* there is pending io cmd, something must be wrong */
-	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
+	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)) {
 		ret = -EBUSY;
 		goto out;
 	}
 
-	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
-		goto out;
-
 	/*
 	 * ensure that the user issues UBLK_IO_NEED_GET_DATA
 	 * iff the driver have set the UBLK_IO_FLAG_NEED_GET_DATA.
 	 */
 	if ((!!(io->flags & UBLK_IO_FLAG_NEED_GET_DATA))
-- 
2.45.2

