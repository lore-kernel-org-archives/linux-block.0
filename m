Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA791E0E08
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949714; cv=none; b=rIX20R/Egovdvqh4i/NhgKdiDKdflbZaehiVpGuGoJn8yUyYnFyH7ZXM5eVxllB4h3sP/XQYgEhPOR4ID2HSTR++WbuQx/TV7TISEuaOIwl2/OBCKYaAtUS9dNxviSvXD4DVDWfEbhXugfYsu8fMJHHifJz4R0gEuOlrT55evVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949714; c=relaxed/simple;
	bh=venmX+xFUUA0UpVlm0dl+mDk8JNjcEjxZwCydjYWYrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHYUICAR8jrKxsQT9P9VG+oVCtdqL7XRrCIDTHmhyp3dnZyOOcOPj589d6GiviRbi75/ycLa64tRt4z/EPLrLA4pmhg7shska02wpUUjl3pGTgbvaJs4dDwLmqRqLxCyYUcsrcV12FCzCve02krK4yzvYx7f6Ve/turp4fH55Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RtgLSXZW; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RtgLSXZW"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a07fb1527cso9975345ad.3
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 21:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949712; x=1766554512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6deGWS+C+ZX6CkDTMG90zDsqNjHQte7F2hl6ze0/JAI=;
        b=RtgLSXZWwY9bYQA08x+/+In3lvdMQ/ijKXjtWz/27ugbLog5uKyd+QnPz9W5Dk0OG5
         Zg2XMekCycmimBLKAkN2M2dpFky5f2BvHMJgN9JmLm3/0fEEwjkltmRIPMIZpFUKNYwu
         aQvWpedglkurTz5tP/y7UNEms0Xs5oh3TVPHMk8IZyfsjcQcoGdnqed16dlM1ShdyA/p
         V36qWqEUg4CkOBEf8f96XOTQhns9/k5YdvISjF+AFbmqSWODKMh8SQUvrZf6B1/pArW4
         H6MUipu1SCZc03hUGPeZ3NYOE2b5IndS4gAdp4fmLn2z/O4HlCgKdC4LNIQoSjqxjAdx
         HKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949712; x=1766554512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6deGWS+C+ZX6CkDTMG90zDsqNjHQte7F2hl6ze0/JAI=;
        b=jrMIpgaspTVMAe3EEpwcQIG6Qa7g6aPB89UTfiSGS4bSC9ZHnk50SUePE4J/qjlQwl
         O6eZxmd5/tKAKvQx4ouc46T/2t1Q+CRAYpZjvFzrBytSvBdWQ7NSozIuprYfi7ITNr++
         7GjhpWmzMTWSXPYpI+0KKYNX5oBAUf4/YcEfvec87X15dKF350v0h6fvL1EgXEjAcY9o
         uiDyTb4NCjqqXuy3hbreKgJyGzTGPfWIeOYjnrktMLsRh9frNiU7sRp+nt9izJWWsJsj
         CI//QV7w0kpipzw80witmAqfFb6haZ/1+tybNhJh6j6B+MdLrdMTjNpiEeq3mYuv5y2O
         ZkDQ==
X-Gm-Message-State: AOJu0YyaWUvcVmtUy9+80hizM8eJDNMjzKgHc3++ML357GFOB/5T4ziO
	JXOOoD257K0a+B681JiyX5lT30lDXJSCncyQ8YFPsv/e7YtxaV4634v+KVfieq3TsYUBIfsvFIt
	RsfN45QLqsebdLRmJVJM51oXQEqLfHifRib53
X-Gm-Gg: AY/fxX5FR81ZkxE4LNmaTNH6zG6TZfHqO3ZgYFdzbefxgyLHXNP1coPO8NsLd+hW7HH
	z3qJAJ/A3q9KJOPIGmQqlvlDHzUdKPvKBMqrabgKsqzzHI7d3P7T7M+eNXRQN/NojKUoyO4JPkw
	R8t14Sk4kAyr9XEWrDm3s48ctegEkK7/L181e5izY902HlwYaHczdIdUal+/9r9l/vVuYxP2trQ
	3S02evVCzNkATrAncP/49cU4GR/9agbYt96IjfhyovXQvYDFH/mZzXIR7flu03SSCrMJ/pH+Iqu
	5Jrsc0lihQ2iXbMM+ctAY2HQys9pqwFNdKfuRUM5gVtmesMZWTQxkai8N9psw+z7gY+gDeOks+t
	kn8jsQNzSULM0N3zkIDl11FXjj8AROwH5Y83qvmWQSg==
X-Google-Smtp-Source: AGHT+IGN6JHAHDS/K6rl0nUyK+Z/ER5lvYDtEq56HR7i2Pc/7hcthk8RgG5mE7Ltq0iDaECSRtWvto2Z+B2u
X-Received: by 2002:a05:7300:d213:b0:2a4:3592:cf89 with SMTP id 5a478bee46e88-2ac2f395b31mr5118805eec.0.1765949712106;
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2ae5e423a86sm96829eec.1.2025.12.16.21.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id AA4A23420E8;
	Tue, 16 Dec 2025 22:35:11 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A81EAE41A08; Tue, 16 Dec 2025 22:35:11 -0700 (MST)
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
Subject: [PATCH 03/20] blk-integrity: take const pointer in blk_integrity_rq()
Date: Tue, 16 Dec 2025 22:34:37 -0700
Message-ID: <20251217053455.281509-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
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

