Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0B323AE93
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160241; cv=none; b=r3rkqeGlM0daHHfD47HvpJctbt5y+vDI5xQbo2kBS7MWGtJJPIy3P3QWjret1vepplHh5TY1D474sde/txQgRrPIQEuibaTLyhxbBBxpw+eMsyJu4XNANMEoYOnFFDFMzPZ+Kaj8JLeFqS8W9COga5qiOpIgjT4Cy/u8NzjdYl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160241; c=relaxed/simple;
	bh=ZPewgPLefZDXOWx69JxVHXK+Ssrm/2Gt5VEh56b2P2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1lG87HYNpupXetbdVoYoWbVLVmvehYaJ5jR8VuGvh9jj55kDJXmS4at8j0/+T0wdokdP1xQ7tVUeHbWcd297sMgUA7Ks8ZXOkZGaAKXWdWTeFhbMoKLHeGVOrA6UaKRp3JeCUhhHDlbFa9F2Kxs4BAwFScmy9BIn8XS/DnL+vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GYGiNpPg; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GYGiNpPg"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2697051902fso985205ad.1
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 18:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160238; x=1758765038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sujA/Mwj2kDqTmjgWypKS2wV8GGpmOhayMT/OiS8xA=;
        b=GYGiNpPgtrex3QY5hwSgKW3u/1UD2BdKyd0cr1dQWV5/f75xqbrPorzjl//1HYLSsB
         yTEqlp/KeGq4V5nm9olfiZscsa4cFrladH5eq/+gPlyonxO4WQQlJf6QRZvsA/lyr7gA
         BR8VQpXXDbgSqPYsMjX121ydJW9MKcZfWF13udN+/kkcU964kjqpRijtSieWGCV1vOEl
         lZJBcgjhV7HdIqVV8LB9CT/B6h4Rgnq86izF9/hrPPtIkAkRFaP4b4M+WSLuSrUZU+2U
         9C9JZ0mLa/nad+T8p50TVTfq0FDk38y8t0px6DpCSOTcQrBArEApFLTDGEmnD3clQCAK
         s7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160238; x=1758765038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3sujA/Mwj2kDqTmjgWypKS2wV8GGpmOhayMT/OiS8xA=;
        b=WE6mMtHYR0Lq6wyccwbtqLyEMkzLnFJC1ivTAeMhaXdIXXayObmb8KaYAIgCBgMPWE
         LOoCTuMfZgPE98nNpKz9WOobHbOdY4nABS6MmkJyUqDtcZM5IJbnmUOVblB5/Jx/a2Dg
         8nRrUEgGp2b+eYr3UWnBM05iD+sA1M+pHUKRSh1YVShX2Rzq6i555UWKTefVuSt+AZ9s
         ObPnTz8r+9V6s3IezOiGvcp2gwR4Pi4kHuDHJmCbAQ3qWgHoswzJp4ksQyqUrjAryBQu
         64GHMUH6Qmw/kYj6X7+tlzDxmXVT2/0fA7CF7olMLfzcb7+MW8/4thwgaR6xfsZmqVUC
         1+SQ==
X-Gm-Message-State: AOJu0YyFT4AEFMzriVuEPqIf0Tgb617sZnTzG2EE1K9hSVecQ1x9VxSE
	zzEqjQfGrpkR5/Vy6T+st9mWnSDXkGQb5A7PeEZhYNWMEf41JsXyOjbJLgJ5/DgQbyBJCInQ8Ae
	PzCNfFrWVP3g+zkUpbuDkAyLun0qvqxUZZ9p9
X-Gm-Gg: ASbGncsvbqhnZ9XeVRVyAJajY/RT36dtQvxX54ObkluvT4YNlkvuVLXogQNij10gH2j
	cyGHsu6eQDdf9nXnpfGlIjWwAuZcb21Ho1gpcV589w6xZaBLTJ/PqEemXI19KuLr6d7lA7ZDh79
	F1mMhze68QiuL/0i+2OmlRpwZLyz6tm4ufKyX3tAgoGak+cccbMF81dpnLxyqdteyQPh0kA0pfO
	Us9bUzMSYyj5Okv4e7FOeBYD3h5nQ7Xg9laOQMMqbHB0N8tx7AEdF83sr8m9281R8WQYXBuHcER
	mN5MlPHoN7e4Q1sHwmDrkHEyzrFg1GqEaLyFmzPDCSZzVp+DtSFxKOP+nDkJQz97ft6OR0ei
X-Google-Smtp-Source: AGHT+IEfGwi5Uf/eDYuTDYKzX2zNObQ7fCQN1nE67W9r2agd/jqP5l+mN1MTQRTMObFyfNU2YBGdUgBoSlJ8
X-Received: by 2002:a17:903:1c3:b0:269:80e2:c5a8 with SMTP id d9443c01a7336-26980e2dac9mr9818105ad.7.1758160238076;
        Wed, 17 Sep 2025 18:50:38 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-269802bbe62sm940235ad.66.2025.09.17.18.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:38 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6950E340325;
	Wed, 17 Sep 2025 19:50:37 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 65ABEE41B42; Wed, 17 Sep 2025 19:50:37 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 09/17] ublk: don't access ublk_queue in ublk_daemon_register_io_buf()
Date: Wed, 17 Sep 2025 19:49:45 -0600
Message-ID: <20250918014953.297897-10-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918014953.297897-1-csander@purestorage.com>
References: <20250918014953.297897-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ublk servers with many ublk queues, accessing the ublk_queue in
ublk_daemon_register_io_buf() is a frequent cache miss. Get the flags
from the ublk_device instead, which is accessed earlier in
ublk_ch_uring_cmd_local().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 751ec62655f8..266b46d40886 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2167,11 +2167,11 @@ ublk_daemon_register_io_buf(struct io_uring_cmd *cmd,
 	new_registered_buffers = io->task_registered_buffers + 1;
 	if (unlikely(new_registered_buffers >= UBLK_REFCOUNT_INIT))
 		return ublk_register_io_buf(cmd, ub, ubq, io, index,
 					    issue_flags);
 
-	if (!ublk_support_zero_copy(ubq) || !ublk_rq_has_data(req))
+	if (!ublk_dev_support_zero_copy(ub) || !ublk_rq_has_data(req))
 		return -EINVAL;
 
 	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
 				      issue_flags);
 	if (ret)
-- 
2.45.2

