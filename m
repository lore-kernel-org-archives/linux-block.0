Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7EE30CDA9
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764591918; cv=none; b=f6yZSpvjRGFKDLVtgfD/aeD1j/JmpiUqF0QJGlRvuX+9iDTb5dxR/R7FbPEXOnxYZxX5vPOTk65EoswaWhLPANE1yzcHenp2EcihhIKeXdttv0VF75BCRKSj4s+UbiA31B5zaC+KCvlbsw0o78N6RQ9DqVJpFQdmIF7kxt9JOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764591918; c=relaxed/simple;
	bh=tZmC1jBCUS3/dajA3d/Cd/19RXACIa7IotDV2+WvULM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uO+CXtbRzNcex41pLd69IkAeEWi3RfS+XANXRQZHIHQu36zSEMAMfmX1BEp3ljMbRFjmphZg7yjuR0/oW68J7qH0h3gK9IxW2JaBMdOkwrpoDTmhvWCPIULws/BVs/h/8QnAvbBxdAQHoyo953bbzcMzuTKjPEWz4lwO09m8NYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyW6wYsC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyW6wYsC"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2956d816c10so43836805ad.1
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 04:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764591914; x=1765196714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgbkwJ+a8ihUAfVEJWDJzoZi3lsV6jhcPpTREHA6WT0=;
        b=CyW6wYsCUS8y9RK9WndgEXbAVS65N1LZ6+PZMRF9snwyN02AT2Ac6luaubIA4kcxpy
         3UQc12YdBg+SbW/wEDKit4fh8c3ozDyZkJ2I4Ui4fTW7wg77Lz7hZOVcZUnr0gjUd+cu
         erzLDn/2zFOgiNRYauWTDWYYoPCQLHXsbGCvLdjiw+f264XRmfLympFsg2W5pGhiEZZ9
         hRMPr4mX4JJzpzs7Kz8BqwdRxGyeT6qb1EDcf9ICDmAFE0BuyqP/XXo2bhLItQRuEmJg
         anWMChGuDjA+002SZ33UHd4PiIwGUFEjzFlRt8Us6rJbR3jNBkRdULBxsQ08QmTeoLI+
         jjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764591914; x=1765196714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgbkwJ+a8ihUAfVEJWDJzoZi3lsV6jhcPpTREHA6WT0=;
        b=GZks6VWPeXwsHmOhaEBaNuYJWfyfnFh1hECSrN3E/GJDzo6Me93VfZDNwlFZ/YeXZ6
         2/X8/AA0B2lC/Of1O6MbuvWT/wijM5qpTdaYUqG1PQJ5IHoKhYxVfc282211uFX17LyJ
         Quh0exQR/+UlMPNfkQSh1to5P4IE5n4x1HYi6Ue/pwon1iQwR1twJhQPgWceg/bMNlvQ
         plz4jGgbN5VVTFreLpgBkcsXQBRv+0xuRj74z6CYm67CPpxh6pdg7pWzFJTNT0IrBpU0
         b7Gi/p8RebySICxNpIIBPXryrELtSynHWDBYxVZOaSngtKuO8p8aLMj6I0yDVhyJMTpn
         FhPw==
X-Forwarded-Encrypted: i=1; AJvYcCW+OhzXPWZBPutzZeBcFcAn+fNA8jghI15G/bv57xhU2nEKpP1KmTQx6oeuN7ZIkmcrKenqp3WDtywP8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu9a5QQnid1OKjLszp8k19wNazdUKl8Q3U4r8FtncqaZIzbn5j
	sYnf8hQ+1lZsSQF81VLnfdo8srQneLvQGYQks4CzOOb+24l+NQ+LaGGl
X-Gm-Gg: ASbGnct9g/KNxrPrybAABXqPpSFnyrPq6u7fLplvbjrqcsdgj5uXeqNUqxNOpqRwAWM
	imFYJBBYJZBKZ8O3wgOc2GyyGfFj7Z/iaiUwbkrGjU+6A+LNVwdO1rqfxcDfVliuhFaLRknfnFL
	S5zvy8m8Gvn9cftmXFw2QfIqKF36piL2QlsawJoQz0Rz94DmDeK6gPluDk9oWWLi8FEQNphYEH/
	WF65+reHiRpnu1Ux5eF0DNAwsvPvxH7LkEbF8OeogP8rDkxmytcRM4jZrqU+BTyA5kOdd4fdSlA
	FTmFti0GObT26CwJtN0Q5Rx7oCN2S5ckfRJadhP+eaOPcTp41+zCv9UVQdsj6DhlCbYAiKCvrtb
	we6na9tTnvLZf30/96PQfq9IP5Odnh1RTsiA2O3T4XSHEPCTAZp5ycrtEuOvQmlbqLoFO8DQrTL
	+AoYjvFnfXOvJVoSc55iWTj2+2EvMtNqnZSsKlRlwG2r5M
X-Google-Smtp-Source: AGHT+IFbdmuiYT/9MPvQKAYlUdoqLqWTIcNsgpHVIB6PLGxFz23zTd+JwUjGoZgLTHc7j1WXIapNvw==
X-Received: by 2002:a17:903:2f88:b0:294:fb21:ae07 with SMTP id d9443c01a7336-29b6bec579fmr401342405ad.21.1764591914215;
        Mon, 01 Dec 2025 04:25:14 -0800 (PST)
Received: from localhost.localdomain ([221.194.171.226])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29bceb277d0sm124381745ad.53.2025.12.01.04.25.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Dec 2025 04:25:13 -0800 (PST)
From: Fengnan Chang <fengnanchang@gmail.com>
X-Google-Original-From: Fengnan Chang <changfengnan@bytedance.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	hare@suse.de,
	hch@lst.de,
	yukuai@fnnas.com
Cc: Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH] blk-mq: use queue_hctx in blk_mq_map_queue_type
Date: Mon,  1 Dec 2025 20:25:04 +0800
Message-Id: <20251201122504.64439-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some caller of blk_mq_map_queue_type now didn't grab
'q_usage_counter', such as blk_mq_cpu_mapped_to_hctx, so we need
protect 'queue_hw_ctx' through rcu.

Also checked all other functions, no more missed cases.

Fixes: 89e1fb7ceffd ("blk-mq: fix potential uaf for 'queue_hw_ctx'")
Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 block/blk-mq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index 80a3f0c2bce7..aa15d31aaae9 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -84,7 +84,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
 							  enum hctx_type type,
 							  unsigned int cpu)
 {
-	return q->queue_hw_ctx[q->tag_set->map[type].mq_map[cpu]];
+	return queue_hctx((q), (q->tag_set->map[type].mq_map[cpu]));
 }
 
 static inline enum hctx_type blk_mq_get_hctx_type(blk_opf_t opf)
-- 
2.20.1

