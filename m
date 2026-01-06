Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0245121765B
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 00:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661092; cv=none; b=JTLYOEEmunaCKe5mQ5LMFgiyhCiAcaodoCegKbkmDJOYC9qO4IxVA+Njngp5/bGaeEDEfEkO9Fn03pOU6xcZ02c5N76/OSpCBTVjGPw/Wbxh0dZEAOgrlb8FUn9iG/GFXRYbDC4QM5pueQvymIuv+uGNjMQJu/UVrbtjFT1lODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661092; c=relaxed/simple;
	bh=MFrMgizmK5MaIPV+Gko7o6kSYnpBboKUcVmDmAwyHCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W08AI0nSe+WIhP1pcTlL9Ghv2KU783VLzCNl1YoL0fJW74fu4CdFOZ0qT+HCSYVq8UaRhPQG57Np5RT9CoMiDVTsQnBYsDLkfm9karK2f3ZiBTQSlSIVGfttx8SuCzX64Ogvm/q2a+quL1c+9T9f/algvBXUkAnv+Rv/sFES35k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PMp2pu3A; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PMp2pu3A"
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-5599b119bddso17810e0c.2
        for <linux-block@vger.kernel.org>; Mon, 05 Jan 2026 16:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661089; x=1768265889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNQyNIuF0YsgyAJSwbc/xgpZYuEtibH5Z0ga5IDU7gw=;
        b=PMp2pu3ACjn1sCwdWRqazeoN7KrK1cWNvEYCk9mzn0Tk3UeXs/U72J7hmmcA4aYTTK
         iMJL8SMCA8YWRT2PWb5eb6vk/bHU1pbF4tIaZ6oCkBtSUMuwGM/75s4/UPWy8MWpTUi8
         ay+lqlQ8HpLX1ztZt/lKlRpBvvnSbs1vQBml6paaGrBWR9Q1L7SkZXtfR7AOKTOcAWka
         HgH1SCSbBHyyxshYB+4jqCZLb3Pf7Ha789aPHzyGD+Y2w8KcxxDgf4CelhWT57SwqRjl
         HM8DH2n047Z1JfVKzi4Ihbp78fJokt9oJ79+DbhC/p2iHOO7tIu+7Y/mBi14CN3kIZ0o
         Gjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661089; x=1768265889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MNQyNIuF0YsgyAJSwbc/xgpZYuEtibH5Z0ga5IDU7gw=;
        b=T3TnmTduxoZCDNb6LWXM0P7QjSnOMJ/FbiVbSLGYHS2qpZVXE9+h0ZxNQh/HWZUp/q
         KRHwLuPdqOeuJKQkpIGaGvKCHxk7zMLTVCAPydu0+I9ZYRJZswbJ5HRRdyws2XVAhrY3
         wWY+G80tFK0+a+zZ+sOi4fm9jUhXaYm5QZp/owdEtEMsJi22qCPHcYodWmWcMoYQrbKp
         V9CE/flZzhQINDxxwgDa0zItLiFu7PmQEdpZk1EARgXwIUnjzx8SJ226GlMfdQ/dX+OU
         VpNbbHYaT5Fkm3XBvnfYhpoQRMX7vDWcyI0aQ7uYBHZXPdHjCZ2G/McRnx80/Eh6UXMp
         rJDg==
X-Gm-Message-State: AOJu0Yyj9AwtaDdgfg5V7uyWGfuiFnuxpOeNyJ7oSHjflM//hANySRXj
	vkV9Z79dO2ok6CNV7LPeGcBeIBC1OCSJNyVz7DDmtQJotDDVZnO+G5M8GR05G3dpnppQuoveyFm
	pIg/7uZSmzOrgNF+ZdaURX8OyO0vAUqc28E4CHTTlh2OzXbN1Jcuo
X-Gm-Gg: AY/fxX5qT2AddDDOk+pj+g7m340PYeNrFVEy3yYkSrbmMD4MVAfVnm7Isj4jSSME8Qb
	KE6Is7lVPj7bymBdXlDwtKYuKxIJZDQWg1Xq/ER9dVuxrn0Qw8OsIcOVvDZnZSNvi0/zlmLQpF9
	4xU7u9+x9OPEDMdN5UP/O5lRaCjy478iP0dXWwSDKe1vp+YbSz6b8n+p19Vd4jXw0Y6roSonrk7
	gVNPwKzR6BoJkLj+zblvQ1iXKXc6J/dHqUWTpYVEp5DZ+fvw0MKkjT1gdG9lL5o7f3BFMSbr2Vr
	tdKbFP9NGpw/UAd8CX9dUWCJTyCPcJd15fdanvW2PhSOUA/UPrd6+Hp6f7RspuucNRd32zLzsXK
	d2QZFjkPBsd0ZdjIOvKXmLHRT6OI=
X-Google-Smtp-Source: AGHT+IE61WlaoTEdEojd+c8ZwUjfNjslPkPW4kBvumfbC08CESGGGz0wA+YeAH99IQPcIB5gAPU5IWfKHKOH
X-Received: by 2002:a05:6122:ca1:b0:55b:1668:8a76 with SMTP id 71dfb90a1353d-56339524d92mr266941e0c.2.1767661089325;
        Mon, 05 Jan 2026 16:58:09 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5633a40656fsm84914e0c.7.2026.01.05.16.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:09 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B942334084D;
	Mon,  5 Jan 2026 17:58:07 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A8E81E44554; Mon,  5 Jan 2026 17:58:07 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 01/19] blk-integrity: take const pointer in blk_integrity_rq()
Date: Mon,  5 Jan 2026 17:57:33 -0700
Message-ID: <20260106005752.3784925-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260106005752.3784925-1-csander@purestorage.com>
References: <20260106005752.3784925-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_integrity_rq() doesn't modify the struct request passed in, so allow
a const pointer to be passed. Use a matching signature for the
!CONFIG_BLK_DEV_INTEGRITY version.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 include/linux/blk-integrity.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index a6b84206eb94..c15b1ac62765 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -89,11 +89,11 @@ static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
 					       unsigned int sectors)
 {
 	return bio_integrity_intervals(bi, sectors) * bi->metadata_size;
 }
 
-static inline bool blk_integrity_rq(struct request *rq)
+static inline bool blk_integrity_rq(const struct request *rq)
 {
 	return rq->cmd_flags & REQ_INTEGRITY;
 }
 
 /*
@@ -166,13 +166,13 @@ static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
 static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
 					       unsigned int sectors)
 {
 	return 0;
 }
-static inline int blk_integrity_rq(struct request *rq)
+static inline bool blk_integrity_rq(const struct request *rq)
 {
-	return 0;
+	return false;
 }
 
 static inline struct bio_vec rq_integrity_vec(struct request *rq)
 {
 	/* the optimizer will remove all calls to this function */
-- 
2.45.2

