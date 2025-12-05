Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDC4330D30
	for <linux-block@vger.kernel.org>; Fri,  5 Dec 2025 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764938869; cv=none; b=A/5xgiO9krKNGEx8ownrKB8HQUrkkFaLqrbsmzCcCrRLCzay11I+3axmZdQMMyxZe7+QWkJ3PBo1I5z2VaYib5JJcZNuWckct4kszZj/8V5gAKNGV6k/GHaEpivz9f463A3ZzsAPXAN091GqIA592/dBGdXl+Xh7wrIECg/V6cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764938869; c=relaxed/simple;
	bh=DS+uCzpPTVnAyDzCCqG+veJLu9+IfpvbHaMTGzIyQ7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKbAS+f72y1U6OMlhAf8+mnIi112Fm4Pyf+L3+v3wbl4Z9vrNqr+AwfhfJWcF1dRjuBqOq6hAsPLNK77E82QvPo7hefdQZRaJqP9YarquimruDHhJbtsqWlGFA00d9R0qD5NmXmrWJMJcL/p+KzngYke8kQqE6lwTkvnhprPvc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VT6OuTBT; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VT6OuTBT"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42e2ba54a6fso825950f8f.3
        for <linux-block@vger.kernel.org>; Fri, 05 Dec 2025 04:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1764938860; x=1765543660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bNHbkVAdqZRgf1tpBX5cu5waW6cQL+UIUpj8vJVoVg=;
        b=VT6OuTBTJo4ueNP3xDPes/BkdBhd4y+GlzQ0Vi6odvApioID8iV3AmWRpDEpAkWkQ6
         mSJ2jbPp8CEhsw6GCNd3CpqMwi5xE19GW+1BQVWD9JZys1kpiRi7N9pAnyi1XORBIRCM
         AbhufOwW9qke6Dz01q68KjW9GTtCYfg1b8goAoW4EFJJ0Y6alLyi6lMpw6woEztbfUdv
         CEVcf+YNsgnCkSQ9RdtQJAq/p61O2/fZuJsFqH9LqUlNTx9Fd5QVmbGT29wesLKd8V79
         uVm6GkZ7kjtPqzBLIranWRhwZY8avNFc3E2RUWsaOyUYUqIiNxSUSfUlSbOvuEweMPUT
         gAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764938860; x=1765543660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7bNHbkVAdqZRgf1tpBX5cu5waW6cQL+UIUpj8vJVoVg=;
        b=lGRA9otIK7z8srOS0q7fhfQdVoXavZJbBeQVKWAX18OInrNcmbuOxGMbMktz1XWqwT
         BLM5JlvLIc9cujPLRXjFbYBoO8GrW0Rb04VYSXETNhKDK6Q4KlKL6BfOe4OnyyGLNEOn
         phTMWrd6vNLa7klF8VDk6cLr2Aq4XonEeRa0YGUuuD0+DG2RqhMNrz35jsIe+C/B1RKr
         aYfV/OkuMXe7rqa+TEnkS5lHQ13b3mNKHIEO3IpdeFwpgWJkyegbFGLlBlvZrUrX+UiL
         275TfKCaCiX6dbvwG5w6PSGbWJPmHVYMUNukPUyp7DV0xD0ymmN4Xu6ExZAYZ4m0Atnh
         mJSg==
X-Gm-Message-State: AOJu0YxzqbyOFgxHdwmUw6J+meSq9WiDVFbLqA7dS1Zsi2C5VMNanCv/
	mOi4UYGo0q74bOzLZBTnpHFd5WqUW9PO/62FA0XVnWfL1zpWLqBZ9Eaz+ESH4R8df1SOFOIHUwJ
	gFDWt
X-Gm-Gg: ASbGncsP1lny1LlIC3KvRBMjMqDP2etoqJGMHOUQ0Dmo6HLY8sqv8eeFg3IvhsQBBlk
	FFYz9ySI1Bgbbpw/4qMIzdgDP0nzlRPr2Qf8amx6AxPXAmZ6e8cjm9KLIO2yw8JjGz6vn+Umh6K
	E3Qny28lp3ZNmB4AnZUBHE7cmCTt3qoDNFAq+8rAQx94V+XFiLgNFPHJf7RVhROrWWHJGuXJ+zX
	Od7OlkKCOHBcNxPi8u1Ne43cfFSyXdYS/fvbBOXqiLPYeRAeOzbGW2VvQplSVk9rasU7gB3zsdw
	3r+9U43frWJMiws7aMQHBas3JcH7cdiRw+l3+snX6wtmdyuPiDUDd3BJlUdO+kAx60InBD3962C
	cRP0kfOvLyvL5tmmt4IYu70DkkSvTE+QSEcrDhWW+dvXah6zB+2xlAVV8vMLOqIcsxLXpd2wJiT
	MAe6xBkusYDNTmqL+zodPUPc1u4RtlvDrskNSwA3G/e0R/SwNeBLZzp2SOCmmv6MbCwrnQn6DAH
	tO1/5Mp5FEnJg==
X-Google-Smtp-Source: AGHT+IFYP7CNFySs3Ru2rSFmialMbNuZMfcFQS3vGWokIN+RqJORkdMox6wu91ZUm0mNY1BJRHtVww==
X-Received: by 2002:a05:6000:1ac8:b0:42b:3ee9:4772 with SMTP id ffacd0b85a97d-42f731cfcd6mr10207120f8f.52.1764938860543;
        Fri, 05 Dec 2025 04:47:40 -0800 (PST)
Received: from lb03189.speedport.ip (p200300f00f28af70a31ee45bb042915f.dip0.t-ipconnect.de. [2003:f0:f28:af70:a31e:e45b:b042:915f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfee66sm8540037f8f.11.2025.12.05.04.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 04:47:40 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	bvanassche@acm.org,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com
Subject: [PATCH 3/6] block/rnbd-proto: Check and retain the NOUNMAP flag for requests
Date: Fri,  5 Dec 2025 13:47:30 +0100
Message-ID: <20251205124733.26358-4-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205124733.26358-1-haris.iqbal@ionos.com>
References: <20251205124733.26358-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NOUNMAP flag is in combination with WRITE_ZEROES flag to indicate
that the upper layers wants the sectors zeroed, but does not want it to
get freed. This instruction is especially important for storage stacks
which involves a layer capable of thin provisioning.

This commit makes RNBD block device transfer and retain this NOUNMAP flag
for requests, so it can be passed onto the backend device on the server
side.

Since it is a change in the wire protocol, bump the minor version of
protocol.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/block/rnbd/rnbd-proto.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
index 5e74ae86169b..64f1cfe9f8ef 100644
--- a/drivers/block/rnbd/rnbd-proto.h
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -18,7 +18,7 @@
 #include <rdma/ib.h>
 
 #define RNBD_PROTO_VER_MAJOR 2
-#define RNBD_PROTO_VER_MINOR 1
+#define RNBD_PROTO_VER_MINOR 2
 
 /* The default port number the RTRS server is listening on. */
 #define RTRS_PORT 1234
@@ -198,6 +198,7 @@ struct rnbd_msg_io {
  * @RNBD_F_SYNC:	     request is sync (sync write or read)
  * @RNBD_F_FUA:             forced unit access
  * @RNBD_F_PREFLUSH:	    request for cache flush
+ * @RNBD_F_NOUNMAP:	    do not free blocks when zeroing
  */
 enum rnbd_io_flags {
 
@@ -212,7 +213,8 @@ enum rnbd_io_flags {
 	/* Flags */
 	RNBD_F_SYNC  = 1<<(RNBD_OP_BITS + 0),
 	RNBD_F_FUA   = 1<<(RNBD_OP_BITS + 1),
-	RNBD_F_PREFLUSH = 1<<(RNBD_OP_BITS + 2)
+	RNBD_F_PREFLUSH = 1<<(RNBD_OP_BITS + 2),
+	RNBD_F_NOUNMAP = 1<<(RNBD_OP_BITS + 3)
 };
 
 static inline u32 rnbd_op(u32 flags)
@@ -247,6 +249,9 @@ static inline blk_opf_t rnbd_to_bio_flags(u32 rnbd_opf)
 		break;
 	case RNBD_OP_WRITE_ZEROES:
 		bio_opf = REQ_OP_WRITE_ZEROES;
+
+		if (rnbd_opf & RNBD_F_NOUNMAP)
+			bio_opf |= REQ_NOUNMAP;
 		break;
 	default:
 		WARN(1, "Unknown RNBD type: %d (flags %d)\n",
@@ -285,6 +290,9 @@ static inline u32 rq_to_rnbd_flags(struct request *rq)
 		break;
 	case REQ_OP_WRITE_ZEROES:
 		rnbd_opf = RNBD_OP_WRITE_ZEROES;
+
+		if (rq->cmd_flags & REQ_NOUNMAP)
+			rnbd_opf |= RNBD_F_NOUNMAP;
 		break;
 	case REQ_OP_FLUSH:
 		rnbd_opf = RNBD_OP_FLUSH;
-- 
2.43.0

