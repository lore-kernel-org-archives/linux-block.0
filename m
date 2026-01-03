Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1412288D5
	for <linux-block@vger.kernel.org>; Sat,  3 Jan 2026 00:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401137; cv=none; b=GOtTaFiBYrMb6a93+FfgkR9WWWb3TZmg6RHkKI8cCZbsUjjKX/1Q4EGVbBYRUEYjndfV9YnowSNfPALOtzW6v/Wy5ZlxcATBY3kF5mInksB9/a5nNdKhE9VOdZ01uHOx553WrhfsWj14FzIyholRBSxbCVY57Fl+ym82TvHxWi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401137; c=relaxed/simple;
	bh=OHCvRTYKVhIoqJ0IbwNbmP3S0pPDKsYwK9/NPEhFebY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwGFag65GytxQQlcQRcuU2bB7+LWUuzVCg06bRUVT2dKyTAWS+2W2Q1mh+MRa61OBpY8jke0hdnAUvrg2PbwNwXf8Jw16LyXoZ22EwmuBM6LNYJfpdI1WVI9GTMWswn2PiSOvo2+NVKcpF9boSiVhtomQmtJnSuMExApiGgb/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ffhtsnKb; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ffhtsnKb"
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8b1c0dcb3b3so195106385a.2
        for <linux-block@vger.kernel.org>; Fri, 02 Jan 2026 16:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401133; x=1768005933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59cCDgPfeatMIS2T54XZ5qKYRlkQDNaFxzaUv99tjXw=;
        b=ffhtsnKbL0bACNDUCOPMTDm1xPo7TQsU9JOGSFTV4HstCVXXMejFVw0Hxz9PDrCEO8
         Z5rsmYl1vtSJyk7lWOeJx2fZ66qj7PgAmm0aQ7Q1/zmI/MhKbxlQvmotWr+usUPMx7Xd
         RaC/Q1YDSWvXFk7tstcoI8+ApoIDbjHFe0LzB/sGX8GTcVUdvboY1lrOa0cgx9pAoPZP
         jBjMP20P0HQG2JWnf4kdIyB/3X4ci2s2Y450GI3HfSi21Oleu4xj19udCBrc8q5Edc67
         K4C1jyrHp23RVTglh8J6q5VPicVrWnGNyHqK7d4to8UxoD99ov3LshW9CTsX3Uco0Utp
         zBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401133; x=1768005933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=59cCDgPfeatMIS2T54XZ5qKYRlkQDNaFxzaUv99tjXw=;
        b=Bv9d3e/KbeWDXyCs398LTxAdmkvKQb85ivZvjLMR/njK7N+OqmNTSpptQtxroPnDMl
         VcjmBCqk5SG+j0dMaeYeWdrEFBFrBsy0YatFZtVFQnAg0EddwYVNtUWDIwVBJ80Cyw5w
         DwGY2iiT08UvZUOR7TD5KU4hRVDcXpy7wQ1hStRySLRo8PQmujh1B30kc9oMUgPYPRf/
         uqkjcVQcgFXOesa5RRREV4hHIuCfMY5KoHzX37GQj3fmfgI+9dZ7Et+kzVPW1SvC2Wws
         qiasQHheFV6+ae6A4W7zzr9zQOwEIgtom/cET8jmcParBaKN6Fc/8xw3UHsJjEI0TjeX
         TN2A==
X-Gm-Message-State: AOJu0YyjIAgOQlkaiJS2dXXOicoyfNWQHl47IuOxRqjFHlb9xCs+4l1J
	qDgp88FXO+2YvRHOv4+pka8BL5pDuzzcDxkHSjoYy0ErsfWUfrdZ0OrqSc6JxCjaJJzus9t/o7j
	4yNxtt15OXWV7EjUbbJpcDACtRr/aVadie7Oo
X-Gm-Gg: AY/fxX6cCQKOoxBcwR4agRplMtN93CjASs4RymNsp377RLLpxvKgfTa48T6iRz9h8AL
	aAZvD+/hH21YS4F4+J4FdYE5wZZx5/KcX3u+L98Vwiznr63/GuY7RybeRwEv+LiN+j1KSaQeiF0
	BNdL6sDb15Oa8M5zuBMgnwaBMwfhNFlQ5PwS3KV16SHDXaNgprJPsSm5bfMh+dJTgEtdcirGmrk
	rC1YmohFss3iIi7xJ+SBWU8DcwRvOagAmMl2OUzwT98fXazZm2GBVG5HLLlVwD2ZICDNO7+zkXB
	Aq9oJrgZWpiT2in9cdJE0n30ec7FW1Yn84ZWAweA8YH6nEBqm5r7bXw1GYi22M3sz/adTW3smlC
	9bvxa9rBcDtCgVqZnPJLqBqmbH0BpdlLYrrTlxhRgOw==
X-Google-Smtp-Source: AGHT+IFqMJoRCOhorEZ1m5a1GSBNb1Nq8U5gwFI3EoZHHVIsX+lo7hsl8u2Cg5Ps5OOYvTTwO9tanO6Feto2
X-Received: by 2002:a05:6214:415:b0:801:2595:d05d with SMTP id 6a1803df08f44-88d83797f60mr536526336d6.3.1767401133182;
        Fri, 02 Jan 2026 16:45:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88d98050c97sm55962466d6.25.2026.01.02.16.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E36283402EE;
	Fri,  2 Jan 2026 17:45:31 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DFE06E43D1D; Fri,  2 Jan 2026 17:45:31 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 01/19] blk-integrity: take const pointer in blk_integrity_rq()
Date: Fri,  2 Jan 2026 17:45:11 -0700
Message-ID: <20260103004529.1582405-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260103004529.1582405-1-csander@purestorage.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
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

