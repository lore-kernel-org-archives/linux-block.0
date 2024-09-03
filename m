Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C15F1C14;
	Tue,  3 Sep 2024 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384140; cv=none; b=UwsnyEzzdsZqCjzvAepMju9TLdEHGSJA3FiM22Ihkp69dEHCPJxSOoTC4VsGPk6m74Zhg1BPiZNb7JpbAL9kdQLWi2m5ZtBMlw0N2RUUm7UoeEHEMK9DkPYbKVdQUbXGEGMrDGf1feCXtrNVVASPmU/j7P0wR4hk0OFa6sZ3NX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384140; c=relaxed/simple;
	bh=JtchMB6ysO7d7aYpaMR9SNpKvbkunLZLXZmiNXb5bfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PI+iS+/YKWEcz+Pr16L5DVE8/j1E/CxTktK3ZJBPn1tLFydeVe69YmBjxbJ0kYBzS6JqYMyQV47uKA6GREVdbAvgQ6ZgBJc8TQp57ijZTf0DsAakCtjFIkNunsRL80QRjO4ikOmGp2gewPGgEGckMOkAyoCbm9Rg/a0q4OlgnlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiXUiXi5; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiXUiXi5"
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-3df0c4a65baso3366227b6e.2;
        Tue, 03 Sep 2024 10:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725384138; x=1725988938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=plRf9YzuYN1gjw1i5Gh/kOX9C6eGORzUHoTA0sJ55PE=;
        b=jiXUiXi5W9bXSpzjEYUWwsMOuArUfWVrCSl1cJveWJCyMnjkBGLGET33qY1/ybZd3g
         YFhyolJX6WEh04+L42UP1skx0CPjIc+U3kcBwTFMUzkdl4T/h5UZa2/D5MimgbkN8My+
         6Z7m5eAEceWcB7PkI2dpPKzoo+p6VL7ITiUSL/z8OO19fM340gKYNMdDfLNc8NJQyoot
         GshYV9vDENq8Bmb14f/4fFXT0oPkQrVH3X8ggd33WAa/KkuyxgvQZ4XNpRXgL5WvXO6n
         RdMG2hyyNixXXYPGEab2CjdpF/z715PiqB6jw8L5GQ1BXh88OPsAfOa/2EOlxvXqnbjX
         Y/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725384138; x=1725988938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plRf9YzuYN1gjw1i5Gh/kOX9C6eGORzUHoTA0sJ55PE=;
        b=xGVfKXg5kXdsjVsRFSYwGUD3vwS8F7cG/akfKfe1hcq1XRFLxhcppWsKxbsZFsz0BS
         d4Zyd3TuDNJjC/m7XAfjBsTXHj/pgT4IJVNdtW82CoAIz8ynZ1Tw7JMBycSVetVStyId
         UkSjzj8/enw9X0Np6ATN/m7szeDssu7oJHW03d9U9aGcX8VPSqZ5JnrpHm+v92GBXx6i
         1LN5C0g+ppFMIHxf9v0qmPxcG1W43rTxujb1xEsBmWXIusMtY/Og97PqPnw8ch4C2HtF
         kGkJ8ZM/lVuJpAmj0+WDg0Yjh9qUbkpWyJUOzdKz6L88fHd4OA1++zTYlzozcpllT8FX
         4kyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWiPEYJQpO3Mm+ShYbu+2+z0AF2BsNmzZlhwfcEc87oCUii18xiJrSyyUOjOYSpUHEwOS6cYcQ6kqr4Fq1@vger.kernel.org, AJvYcCWfVACjFRnw+sjqAv3UVJz08POPYttXKPJFivbMDihG8Fv/eyVKZEgYawT3MxiqjPTdz+vpvvzlacgtvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxACaOSNA0XnBqynDS9qSd3/Qqwm7jeBWBEn/F50xmyLoHH9Hbw
	281KJaWf064pAmWHL9yyIgAkQA8vvL7bMnNwT/in06Lt57/kLBCI
X-Google-Smtp-Source: AGHT+IFxGMsvQbGaIYEjb7iI0WRWlXdSuqrfyoTpqQTmc8f2VZKTZ7rIlB/x1qp7MIojafV8hhn7Rw==
X-Received: by 2002:a05:6808:10d2:b0:3dd:cc7:959a with SMTP id 5614622812f47-3df05e8a24bmr21582020b6e.47.1725384138082;
        Tue, 03 Sep 2024 10:22:18 -0700 (PDT)
Received: from localhost.localdomain ([102.38.199.6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-846be3f60efsm1400886241.18.2024.09.03.10.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 10:22:17 -0700 (PDT)
From: alparkerdf@gmail.com
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alvaro Parker <alparkerdf@gmail.com>
Subject: [PATCH] block: fix comment to use set_current_state
Date: Tue,  3 Sep 2024 13:22:14 -0400
Message-ID: <20240903172214.520086-1-alparkerdf@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alvaro Parker <alparkerdf@gmail.com>

The explanatory comment used `set_task_state` instead of
`set_current_state` which is the function actually used in the code.

Signed-off-by: Alvaro Parker <alparkerdf@gmail.com>
---
 block/blk-rq-qos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index dd7310c94713..2cfb297d9a62 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -263,7 +263,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 	has_sleeper = !prepare_to_wait_exclusive(&rqw->wait, &data.wq,
 						 TASK_UNINTERRUPTIBLE);
 	do {
-		/* The memory barrier in set_task_state saves us here. */
+		/* The memory barrier in set_current_state saves us here. */
 		if (data.got_token)
 			break;
 		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
-- 
2.46.0

