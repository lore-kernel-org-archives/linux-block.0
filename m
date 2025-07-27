Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F1922370A
	for <linux-block@vger.kernel.org>; Sun, 27 Jul 2025 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753638017; cv=none; b=kk7xaUmWE2hx7INg/qXqpHVe4TWiux8wsSjs6uhOpkxXkastPwkh1qH2LGh0GHrAJmY1pAY+Fqz7ax+RHlM/XuUa4EKQUEDvJ4DRSad16jBByq8T9M3AqnSBicIzLtdx5GHmM+G/awvHI+f1DLXxS/Cn31e9CRwbHpZHO/p+twQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753638017; c=relaxed/simple;
	bh=eUp8rkkrj67E940zx0z9wttZ3qw6F6iVPZKFsp8IVnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xepm+DdeNbXLxJcuaqhlcXM4tjFnNvfm/WyjzBHkHweiuHh9H4Enkk9QJq6mc3tMDiyfE98sJn4YugIW2g6RSu3zKYNLXM8D/MzH9vd8rnyY4s8rNb6otJAfKY9EVhhRIAi9lsRyD0srvtrJkCp0y8zUjZPzXnps791YaUkTNlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=HXQSE/Bj; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="HXQSE/Bj"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b390136ed88so2754182a12.2
        for <linux-block@vger.kernel.org>; Sun, 27 Jul 2025 10:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753638015; x=1754242815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4v8mNNgB8Flu0S6Coiw5A84RBTfZ1/sa2qSDgqs8HE=;
        b=HXQSE/BjHlG0DC4jffKIu/Lz9lO9Lx3rOORBBDfOa431XEVd4M0zoByuYIh1+Ie4pU
         0q9GBmJtPUgLDFOFDIAmS4B9UKZdsbw/lbDc28lQwv77Fkl333BBySDL95kIRcx6dDUJ
         9sQIEMsfWMvVjQ7MEnXtwUlz5O9+vuEerLLzwe9JO+eQhRfechGXqhOwG8qYmrBVfTMl
         zC9infnGZrsDwhnrbh1DV5oaYmSc4nbj7apxbTLguB4uIEwgIRWr/tcp/ijg0lTwYVwC
         e0Blr2NlACSwRm5/GYfH1+PHtYwA1IMCl3acZUV/8T6hQcILWq+O5c/JBeyou/POO1dv
         2BTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753638015; x=1754242815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4v8mNNgB8Flu0S6Coiw5A84RBTfZ1/sa2qSDgqs8HE=;
        b=wkxDgRROaw0wIhHCGGZUoh0gsZdf+kcr43PbIevCVBvXMm96PGIRWw2c3qf+cikW2a
         0BC/24tJzA7FXiIUkL5R+hH3a2eA6vl5yu14od3zJ5NI2Abk0qAIjqR8ecapWjOiqc9C
         9SSHjpfsbJs2Xc8NKsGrtdrzvjWIgRa+xGkB8MpMaOxmcsQ0XzJmt+fXYnMRNu6GXV08
         9w1HBu5eF4kVhePWbLF9WaR+v+c99QrvYwfb5CFvTTBncLMkJw+Dh6uWQPwKyVUEmPXn
         m2LFzfVOsm9SP3zP7mD3ZTnYO9+EeFiXydlqf3dMESJk6HJ7b/Kr3J8ddz8XT8Ak29Pt
         55zw==
X-Gm-Message-State: AOJu0YwFL3iHhCNHSkmQU78tM5PgE6WGBWcHf/LB9AfcWBaJsv6L/5Pk
	tnAQGjX5HSEYPIZNvHLCujEwYVqUCPQuLmZFkydsDsJqK8GI+lN6LsEAuQlc2IqjOsE=
X-Gm-Gg: ASbGncvcaaHNQB/BuBTaBKxwbtGYKkOqrLPINyM2F8+CfLA5CGGnekokidOPLlG8Bgl
	MSU0PLq/lqoM23nkbjExydG+6WEkc6Eol72o5YaAHuSwbz1ieHKSLuzS9fP2natLIXP2A0ZD+dL
	0vbzaxZGBY8yUzXZhqNyiOEL7OeXjJ+Z7U0UFk9v30W9z7azKVUaQetSiwqnNOT38X3PAZIU3cS
	ShSIEzK7Fc7HVoaAiWWNYxN0k5uB/BXvpSkxMYdsn05+Wz9UEmVeRCNPexQQ+Jc9l1H9/YIgmGK
	GtS+LELLexRGWLX33FFzL9sAzzaEyn8p39fDQpd4ECq2bLVGnplRB3NZNUrmkeF6+8/Gm1OzaNs
	mxWrVyUQ=
X-Google-Smtp-Source: AGHT+IGv29CtskpdwrG7FN+exNQheeZ5lwmlkvuf79A3488Y9t5W8AEZTp9o7Z0NNsaBrqCcG69rhQ==
X-Received: by 2002:a17:90a:d40e:b0:313:31ca:a74 with SMTP id 98e67ed59e1d1-31e778f7826mr13735566a91.16.1753638015093;
        Sun, 27 Jul 2025 10:40:15 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e8350b724sm3924224a91.23.2025.07.27.10.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 10:40:13 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v3 3/3] blk-wbt: doc: Update the doc of the wbt_lat_usec interface
Date: Mon, 28 Jul 2025 01:39:59 +0800
Message-Id: <20250727173959.160835-4-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250727173959.160835-1-yizhou.tang@shopee.com>
References: <20250727173959.160835-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

The symbol wb_window_usec cannot be found. Update the doc to reflect the
latest implementation, in other words, the debugfs interface
'curr_win_nsec'.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 Documentation/ABI/stable/sysfs-block | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 4ba771b56b3b..a3cf841ebdff 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -731,7 +731,7 @@ Contact:	linux-block@vger.kernel.org
 Description:
 		[RW] If the device is registered for writeback throttling, then
 		this file shows the target minimum read latency. If this latency
-		is exceeded in a given window of time (see wb_window_usec), then
+		is exceeded in a given window of time (see curr_win_nsec), then
 		the writeback throttling will start scaling back writes. Writing
 		a value of '0' to this file disables the feature. Writing a
 		value of '-1' to this file resets the value to the default
-- 
2.25.1

