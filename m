Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDD92D6605
	for <linux-block@vger.kernel.org>; Sat,  8 Nov 2025 04:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762574781; cv=none; b=ln0hbujokbZlKuYdv4fH/55bjjCnpbdtEMS8ZJAjpjTqvTiGp50QdzotFw+bHpOX+OLU5qMF1z875wEsoxRw6+/r/CfOCjNHQSOElV10+9VRxnjK4I+HPubrSUfUSH9iHlrFUq2Pj4vkokVddcDPPRS+8RICtT9riI5sBQDds5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762574781; c=relaxed/simple;
	bh=kllqw3vYwAHqncxZVgKJh99mfSbrOMjUx98TLgBkaco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ChmCPLAumMwssd8vIbq+STA+W1++Q0a38EoRtnAGxbkI0C14KN6uCtjYJ0wfjeAyq3WcmTiiGkgVjahyyRqeJjhQU0aFreK9R/5yGoOQU8JLxQXQLBSA4AEd5pJw31MnyIPSgw9hkiZuPF5i6ac2GTenAx41nkavP12J95sWp6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JKEkkBaL; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JKEkkBaL"
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-3e0c6807ba3so439835fac.3
        for <linux-block@vger.kernel.org>; Fri, 07 Nov 2025 20:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762574777; x=1763179577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2QOxa9RiAax4comSiCFt4kjXed0teImN5yBE4DyP0AU=;
        b=JKEkkBaLZ95XFPzefyrdClNw5ZzaVpSgxdmbkCkspxj1k1gcaKDD4anT4vMEeJkUif
         H69+xcPc5RlMcCHFooGykri4+mX4SjLpR4cAMniPmUJlXxiFcD3yMRxYksp6Gvrevpjj
         XuSEes5xEXUoFeW8hqseEbrveMvBCKzG03KxuiJUiLXtJqhE2IPD4hYjr71Ge8mhLhPf
         qIq+6wu2qklXRqYyflN5BtLfyNMhxcZDwJFHyq1pGZxNvAdQxAKAaGcV1B/z16nXxTOt
         /2N0aOeYJsIRbkjUnDIsLCQ50XlXzJmd0NWWXDD/d5YEuTDQiX0vHTKlkTmyVzA1faM8
         mm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762574777; x=1763179577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QOxa9RiAax4comSiCFt4kjXed0teImN5yBE4DyP0AU=;
        b=MfqziloQqKyYWAia23Ao6VzCvaZFnBoj4cBE2KyaIJBDZw48D31elvxocB57EinWdq
         6QHT0nWThyoRD5qq7lbfTEuN17T2Sy0jGPrxI5fHniP1rcjTb0FxfeDbcnH+Ub0GKHSK
         XKafmpjAmxAOPCQlFC6JcmIDTUS1tXd9jT+6qo1/7tw5neSdxaFQry3ubSb6wWak2f/N
         epqkqvXYU3Op9ZummEgYab+OJMzjIOaCYq9Z4jV4IH7WyflHwfKLjxiBAblE5VhtyAze
         WKyS6jTAfu1RJ+1xzQa6ZMQdHh5199V4D/BTjxzHlyRvZV+FMM9wdPG7nQprSOTYOTc6
         ZaTg==
X-Forwarded-Encrypted: i=1; AJvYcCVUnGjE4ioNp6l/iHZ6jKR9s3d+VEaAO0zgLA9VOV3oL9AiZZ5d+Qtel7XNIOXef1PSk1E6AT+8ZS3tJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZRVQXC8V3WnyxJVDkqQwedmg61I+t5nBm6bJYkyWMAMUhBymi
	zwW5XgNGBB38jWVjlKcDYWSDzYS9LXkXCO0QfWiBJiYpa6GGlsVSscEUnrTDQTTeiAEHV04Ydaq
	MdHISlZaagqrbaQipW+2sVbQgTHWBQvYPrVXzZgZhbbhBPSCjdYsF
X-Gm-Gg: ASbGncsm9RW+UQxhHQN0YRFCdRa2lufYS58Yur/2NQoE4Q+5qWGU54/vWC6ZSET755v
	SK+N57d5ZCrVykYUe+sNuVvzVb0zeUM1TYU+zj4veDv5WgvP4XHHbJ3Ce8WyNNwfH2/lTWPce3h
	45pdy21e7QuMqJEdGjFJeR9ujke3apx819eEyISGp2RdXcT4PL96pz+X217/BgbexJgpEV9aZRh
	rKjnFlnJ8xE/m/v3I+IIqN2fH/RbWbckUTHZePX1ra32lyhvwim9/B4ubti5qljXcal1ubGHsGe
	ZFtgNmMNtELseylbURq0ebuUnAlAAjuaSly5rw/XaiPt2NybPjg+B+I779GyRMdJOI/bRmt2TTs
	5BggckCObVko21xgt
X-Google-Smtp-Source: AGHT+IG0bM+TCpLC3NDIap28uVRmyRqq1neqkqX2yuzzFXVGs2q3ZEM8ig4eQNblkTcqI6iwmqTa/ycMd/kF
X-Received: by 2002:a05:6830:3487:b0:7c6:e92f:41e7 with SMTP id 46e09a7af769-7c6fd833997mr550945a34.5.1762574777116;
        Fri, 07 Nov 2025 20:06:17 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7c6f10c45bcsm374351a34.6.2025.11.07.20.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 20:06:17 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 71F5D3401C9;
	Fri,  7 Nov 2025 21:06:16 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 6BAB2E41BC4; Fri,  7 Nov 2025 21:06:16 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: clean up indentation in blk_rq_map_iter_init()
Date: Fri,  7 Nov 2025 21:06:13 -0700
Message-ID: <20251108040614.3526634-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_rq_map_iter_init() has one line with 7 spaces of indentation and
another that mixes 1 tab and 8 spaces. Convert both to tabs.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/blk-mq-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 94d3461b5bc8..a7ef25843280 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -140,19 +140,19 @@ static inline void blk_rq_map_iter_init(struct request *rq,
 			.bvecs = &rq->special_vec,
 			.iter = {
 				.bi_size = rq->special_vec.bv_len,
 			}
 		};
-       } else if (bio) {
+	} else if (bio) {
 		*iter = (struct blk_map_iter) {
 			.bio = bio,
 			.bvecs = bio->bi_io_vec,
 			.iter = bio->bi_iter,
 		};
 	} else {
 		/* the internal flush request may not have bio attached */
-	        *iter = (struct blk_map_iter) {};
+		*iter = (struct blk_map_iter) {};
 	}
 }
 
 static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
 		struct dma_iova_state *state, struct blk_dma_iter *iter,
-- 
2.45.2

