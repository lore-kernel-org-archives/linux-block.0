Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672141F8AD3;
	Fri, 29 Aug 2025 03:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756439116; cv=none; b=WuIoMGoCNLST59pe5gYM4EEEjcepsltxfIaMQq5nNjPaVDEzvcdeiuiS1s3JDXSYIyo4LRCpB+nReZVifyt1Po5Kfxluj7Wq8WCNEukW2ef4XS8LhXwd/7VwLh8y+H5hP7CdrGgdKaDm8tulXjbju+F29pRbh5gdJn07AtGPy4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756439116; c=relaxed/simple;
	bh=sFRGqNwDzLG6df4FTEP0hLUu6oUGZ8+CvWZa0iRhUKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rw2zOg4ZzQ6H8tJXfWWrobjDQPxqB56Y3pVQx3t8HF1SmeNnRC8Mlk1hqPRBT0tWUQX6ddW3rHixZX+5SUI0ogvMJk/r+BEI1jm4Bi90Z0c5DnRbjCYVwYvMcaKyrOIkqAmPJWn2FzrAHF5QqEQxcWkhOsgJ+wU1MYVErGnEX+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbJhddI/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbJhddI/"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2487104b9c6so14897985ad.0;
        Thu, 28 Aug 2025 20:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756439114; x=1757043914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OrrQ5wluAv2utQVvOGjtHrE8+3Mh9xM7qUaen8Vi6sQ=;
        b=TbJhddI/tx5UK64BAOsCDFbH7Eou29xd5mi+xk/f+d8w96pQjMoywnQV93Q+qOJb7s
         m4Iu0J8fiINC1OjXv+ZZdyC8G4AcZ8hSxqmG2m19i01KU42SJMvDf5fwP1p5PDeGVUnj
         ZvqZxWdwUaF6BX+67WxbOtcG8VmSjQ7ROr86i8/fVM8cyyGrCtPTG9rnz0i+GDvg6AGL
         oEfL4PSzEsP36iDC++4iX6vFoWUxlp1YAyCqiYAfHqGX2nSpYIoC+LxxwU9dPRbpuxTI
         bEpZIxutSuldjkJESFnyyGXRmWAQwCa4UMCQoqYEnUpc0BykJ8CF49t6n8nzohzdT5sf
         w4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756439114; x=1757043914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrrQ5wluAv2utQVvOGjtHrE8+3Mh9xM7qUaen8Vi6sQ=;
        b=Z4mAt8jt1SHmC5ulSUHZGHPb1H09uXgkLUYOYKNYI3fU6eiiY8Pu8lClWdXdl/LwWz
         ZshimVx+Bui6FvSx609AWLtGOetIgTBzqFMm1/S8RslyhgkSkFXOWKR+i/4CGrmbUa5d
         9fF3MYdcYQ+dvyAfT7iwmpD0V/Qa2l0bq0MY9dB1YS/2ueRhtQ9y6klGpsoeEyghrlKH
         TU0UOjohENIAsJvMLksIAyT/qbl5L8GGQmYG+qwqYX2dXGUO7lDyeEo8IkVSECGwe5fz
         GTZy2KeUJVioLcM32duskf/vGWJCMURGraTKPDwzGOwGXg0SzKOGbT1a4ypVNmaWzIhl
         u5Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWz+HXea6Z3/iM/04evHrgv0nd9yCVE8yysYXHj9ddbfE8GOIR6hupFau0dj3tgcCSGz0W2/i+RuyV6JVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKRxmP5XdxRSYLz7Onc3pImFs578cPSapC6MCmjNXCs1SAYsn1
	YLPZptlrjIopvS4zhXeFf3EHEc6zX/nYNGIXPAeP6Wp8cQYO17AaxgyB
X-Gm-Gg: ASbGncv1gmW7ouWA/w5kPuFqpKW+ttXEq+YWLEypyfHlTJ7jKZMwgoCS0y7txbW8Cfn
	MCUN/WlwDjLYWXeNEgkcH108td1aNLwYMfn+dFrr7fpz4oDOJevsE0l0hCKoynrgpqkes94qyi3
	yH2UHT2a+FwWUChbVKfRsD7HokHTL0UKZ6CQ8OEeiAUo9PZ3bGKhkOtzuxuwN5emYyVHMbp4Mb/
	23+y39xfxdYAKt/QxJuEh1bq5pTwRHTtFeRJfbqIC/QO4kkTWXJXMv1WUo7oTnd2IWXaBMpUIh/
	Mu5PMn5SC0fJG4jHI0N+ylrOKGuIFKiWr3Z1SiJoIA07//mUnfNSYoNAfOhV8xmv7GGJaNoz6z+
	h3oaJoDVIXwEID5qR+el0qafMVUEETXWrGPDoWAgZtyHcBZPOlJn8HkinFb0=
X-Google-Smtp-Source: AGHT+IEZpcNEc4hSoqZKpEPB0qnFeHENhXzyByngVVhDH515HmMpl5rxGzfg50QEgHKPgtlEfKpQMw==
X-Received: by 2002:a17:902:f790:b0:246:a4fe:9cba with SMTP id d9443c01a7336-246a4fe9ec8mr296042385ad.6.1756439113538;
        Thu, 28 Aug 2025 20:45:13 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906395cfdsm10148155ad.101.2025.08.28.20.45.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Aug 2025 20:45:13 -0700 (PDT)
From: chengkaitao <pilgrimtao@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH v2] block/mq-deadline: Remove the redundant rb_entry_rq in the deadline_from_pos().
Date: Fri, 29 Aug 2025 11:45:05 +0800
Message-Id: <20250829034505.95468-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: chengkaitao <chengkaitao@kylinos.cn>

In commit(fde02699c242), the "if (blk_rq_is_seq_zoned_write(rq))"
was removed, but the "rb_entry_rq(node)" and some other code were
inadvertently left behind. This patch fixed it.

Signed-off-by: chengkaitao <chengkaitao@kylinos.cn>
---
 block/mq-deadline.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 1a031922c447..63145cc9825f 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -133,10 +133,6 @@ static inline struct request *deadline_from_pos(struct dd_per_prio *per_prio,
 	struct rb_node *node = per_prio->sort_list[data_dir].rb_node;
 	struct request *rq, *res = NULL;
 
-	if (!node)
-		return NULL;
-
-	rq = rb_entry_rq(node);
 	while (node) {
 		rq = rb_entry_rq(node);
 		if (blk_rq_pos(rq) >= pos) {
-- 
2.39.5 (Apple Git-154)

