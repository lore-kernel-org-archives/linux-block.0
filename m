Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE8F3B059D
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 12:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759557; cv=none; b=TW8UVNHIzQWAMhXTuslQn0wvac7HvITUFfofRORtFbvtEtKCL7TD/+FgqH50QSaqOrvZD8+Agpollfwu/T/huXx6GjxVHtZKhpVvirHr+XayNDs8Wulqhu75pkL+rlAHBCk6gsYA6UnLtk8t/kKrwAE9K5BPRPMcGIL/ZYqcuUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759557; c=relaxed/simple;
	bh=jMc1kWl0lMdopBRcqxlg12MQFzVQ4bdk2QUHpHtRBL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KALXm8+i5dJzB675RxCTVPXyw0r4e5tLkFUFQG4KAtU1Y/OFDH2mqgNHYyj33Q+6DuFfGlB3//7rnySwlhEQL9qHRegx3/+5H9/IzhGHeavOnOAq1CggpSJSvat80NXx+ol74b9YjlviSRjAPA42bpEM+1NpD18hILSuX/Bzdj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXf8t81r; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXf8t81r"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso3791929b3a.2
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 05:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785759555; x=1786364355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xmQQAqncBkAOFca+sP2unvrmUPp0+y1Qc1lknJb9bQo=;
        b=aXf8t81rgIl0psogx0Xvv/mc4YlutBvftSbG9QaryZjOAUlNPT/27pQPx7xzmlciU6
         czWP/0n19oB2531zT89J40lk5S5vY3dvtX2cHrVfwC2VUSd4folJE3DZJpYSxxUfaVYz
         sZrsRiIpUvgW2MtheO2O/FYjMOZ8u1LsVGDPIShD9Wc2HIEfx7i7j0PrvCZLzA++WuiZ
         OOPZUB5l38vKwLGCQ6smLBYEW088imLIFMp/50yKRKAN7L2Nt1xZALU+Klipsk5VHvBL
         M7ufPyvlsQaqftT3KpBF6N29XUCmFhcEFQNieObHVCx1XliUjq/7vOMVLIQCySXtQMqa
         YudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785759555; x=1786364355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xmQQAqncBkAOFca+sP2unvrmUPp0+y1Qc1lknJb9bQo=;
        b=bUS3hKl+DWJsGYjZFMX0DY7Kaw67mXMJXNCqWlI4ObUuyoNDhqCq9VPcjoFY9EjlkQ
         WFL6aCRusydxxZuq021aFdvC07jqLhXSzhP4sDjFsmYXGmnUphcfOi0jpG1gdjKjiSsZ
         tILK6fUZuQ8jb7cEyJ/6eaHZ4TgHxHZfZ20yQo6kMpBUVgj3lQNJ8ad04K9fqLiqbaXy
         yRgRvuRfdQCSYKNV3vH7D5sXFOccAiYKGHBwvl7H2nW2EGEL3j6RAiWllNtYaiYr8bsZ
         P1qdv3Bul7CIR8VfXsii3QDiQmwrujCeyxIg9yLtkd/MW70f6F8pdN/AcyAKLZP8Vae3
         EbGA==
X-Forwarded-Encrypted: i=1; AHgh+RrePh0YZQC60pLfh2NCZUF+TTSp9TpBzeWBFzX7DrZEky8zv1f9qDCnGR65RAwiI890l/SeGakuwZrAjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YysqHjvbx59fs4ZdXAZ/qkCiyqT+lKxEhGZTWlHSEuspXqMBxfR
	OnTkK1pVDwYkEYa1m0siFXwokgYZpWxOM59H+7pIoX5sWs6v1RmR7+68
X-Gm-Gg: AR+sD13Ti9JRi+UkeEkN6Mshp3zV5uuS4YhAMCqMsT8Pm3NM1ZkTv3QiksIyTFG/Emd
	1vL2VqtHmFrotn2d87/HTmyrmAPnhwgH8I+n78+U5ZIejJiFr7sxk5Jg+0HQ7oDh2wkjOOMId4T
	1QI3jtjjAoC4qTCOystpikSnJgrI3VqR9wBzoCFHIX6kcgihq2kVIx81dny0y66dsvNWQR82Dnv
	vPbVcjRdxN9HXzFgXs4kOFjhCQSBgE4Qnxy/vwdObk1G9Y/PvUF9TRu57JmN0WtItHzdU/SHwYJ
	4Mdx78A/AOk7k0YiZygD4qwlBDEbn3LViHhlWe6sQPIsPDYBTr0yFtYQnZzfZOIDLF4ymzMudgT
	nP2a5H0aeZMP95BUelLqGJS2UcNZrfHy9eBU+OmPsHYuqlkyvfYNGy0o/OvPoXaY8fi1HbAUnnZ
	bdPEcMnwIhDi+2VUt4FgNad2GmnEymtDUz2e6476LyDgcSHia9rS2eIpKEdAzIMcqlVmwT9Re9+
	ilUHI4RC2IXDb9xYg==
X-Received: by 2002:a05:6a00:951a:b0:82f:9d21:d352 with SMTP id d2e1a72fcca58-84ee482b8e9mr9200192b3a.9.1785759554921;
        Mon, 03 Aug 2026 05:19:14 -0700 (PDT)
Received: from wokron-navi.tail1fe8a3.ts.net ([113.215.198.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29fac3sm3580399b3a.31.2026.08.03.05.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:19:14 -0700 (PDT)
From: Yitang Yang <yi1tang.yang@gmail.com>
To: Ming Lei <tom.leiming@gmail.com>,
	linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Yitang Yang <yi1tang.yang@gmail.com>
Subject: [PATCH] ublk: fix misleading FETCH_REQ comment about cqe->user_data
Date: Mon,  3 Aug 2026 20:17:27 +0800
Message-ID: <20260803121727.51043-1-yi1tang.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FETCH_REQ comment claims the request's tag can be "retrieved via
cqe->userdata", which is misleading. The kernel does not set user_data;
it is the server that should encode the tag into user_data.

Signed-off-by: Yitang Yang <yi1tang.yang@gmail.com>
---
 include/uapi/linux/ublk_cmd.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 6991370a72ce..0db3de7b5194 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -106,9 +106,10 @@ struct ublk_shmem_buf_reg {
  * IO commands, issued by ublk server, and handled by ublk driver.
  *
  * FETCH_REQ: issued via sqe(URING_CMD) beforehand for fetching IO request
- *      from ublk driver, should be issued only when starting device. After
- *      the associated cqe is returned, request's tag can be retrieved via
- *      cqe->userdata.
+ *      from ublk driver, should be issued only when starting device. The
+ *      server could encode request's tag in sqe->user_data so that after
+ *      the associated cqe is returned, request's tag can be retrieved from
+ *      the same field.
  *
  * COMMIT_AND_FETCH_REQ: issued via sqe(URING_CMD) after ublkserver handled
  *      this IO request, request's handling result is committed to ublk
-- 
2.43.0

