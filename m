Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DD021D3EC
	for <linux-block@vger.kernel.org>; Sun, 27 Jul 2025 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753634840; cv=none; b=dAPGot1Gwe11OiGgqXAxsPzI7ZVVaFfzztJybgJulSvJkbPjGj5VNuBLiPsjtKx/NBHodwUdVQIPCpbYbBXJ4JEWRKf4LKLFynLipfv2YjPaXaM7HoHGj6K9vRGGuQWobpMe6+0VtX603j/QIYqbwjG+U6G6p47Dtb3YPMpo8uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753634840; c=relaxed/simple;
	bh=KNhhtUFnmbc3jeA4XTRDlg8RlDWWWyXCaaLU5CW08J0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G/bqKCsQVh2F+zhI9Hf+SuUV9rK4SO4CZisaF0LHY4r28TBJswIWJDv4Nkm1hGd7Ahc0A/IglN6DebKjOTnw1AGLEnpwn3uQE8w4cxTz+3pZvVa6Moo436BM/hV9ME+2WM8xDdvLdYmVjWI81ZZvRBJCGFYsC53xYojvLHCbNmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=IziFUJru; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="IziFUJru"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747e41d5469so3954787b3a.3
        for <linux-block@vger.kernel.org>; Sun, 27 Jul 2025 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753634838; x=1754239638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMN9tLLmpGB9BsvzAxacdUhrheIgM1fafrpYT+r6ug8=;
        b=IziFUJrurw2GIHdeNgOWBtIk5DAtdsO3jkSwrW6Bkhi6j2ZmTNF+BBLDSvh5vAv04j
         fPSGeG7qYXPsg3+xBlUHa9V7QNAlE3/ChTtffEheu12Ce/mqNn9jYupyZhEdarM1yYQd
         U34IXRJbtZsh+yw8aJ3Mo7GOjYZsez7AFTsS8/nPP3+bKrxufJr1vWiCXHFLqob9O3EF
         89xcqKXPECzQZQdwbTilgB+FW/Mnpb7ws/UEw1TWXUn0cEDYj0nIy3JIct85kruAq+4n
         19uCR8xekgGg3F8jiHCt8v9L0OE9ox1N6Re1RE2k3S8BjZqgvzs2+GbnBhx9R2aUymCZ
         qe+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753634838; x=1754239638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMN9tLLmpGB9BsvzAxacdUhrheIgM1fafrpYT+r6ug8=;
        b=DvBNRBcLmcyTdkZLsjeH7lFErkbclezAjKmJrh4eaTS6F1IzJDlAJjMQDGOTqI11Ov
         Z6vD0WCCmw9YUztC3S8xEdVmz9kPwzoryuB9KhqMTAWwhZWIellR3yX9TKKvlqrbNzyc
         f/6OEEiRW7fmETzHqAK0Pixks9r3CNTyM1VHMG6O3coaDxQeqtN39+nIgu7mE7clWJph
         0oNpsONv6Z2/7WWalql1PVhsXkpe02qV+igHIebax8htphjeVhxKmY6Jv7xJ10Y50gbx
         Lw1o5tNoJSwtMJULVvgwD0qa1eAWvXDmFgEi3Er8Rpu9U+OyTeLjTq7rCKhhJWQ/yD6D
         JnjA==
X-Gm-Message-State: AOJu0YxoRksu0LffayMCejpimAozDN8jI6puvEKAy3He6Z4tuIDVRfHo
	crLjZiSueARQMbX5+OSxOilibtBVH1ArNQcw0/SLidhkUIvEYPs/A5+857ppKgh8BcE=
X-Gm-Gg: ASbGnctq9JgNKxCmo1CjUOUHCGt6DOE7/Dh13ZxQmoeY4qIGwxyyumTtmu7OGdqW73L
	vRVTUwXFVPKy+XnmE0iBmIbx+Mg6TtvJDVP6vIBlarpGWg7aX/Iorm49lLpISHsIw75Z/wfmEtX
	IwzcsTvzibwnygE6K9TLVewDPQ1w03Zsnxhp4fKyxnmUnq2rvEpX3bGTyi5luAXVR7noiyYdEzA
	L0g3SzvA/0nQn1LRDM9mzmcGPkcwjbQGIluLOUL6IHhRd/QPykxBQI1YJVgTOEXMxsD/vtU5cdL
	ltb8cYH/iFcfI4o5avj9hiqUQmSKSLzwbBwxHo4bf/BJt6JA5oR5LdNkvff/msHMMChT26Fy1Bf
	e9n3ske/rwlkgOmwj2A==
X-Google-Smtp-Source: AGHT+IEF24zLRrvUbYzwpV5Zjh1HPgLaykm25/5HZNKSbJYH95HEaBtQmdE1+eWOfcS5Rglv3aoXiQ==
X-Received: by 2002:a05:6a00:bd85:b0:748:ed51:1305 with SMTP id d2e1a72fcca58-7633562970fmr12389282b3a.5.1753634838365;
        Sun, 27 Jul 2025 09:47:18 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640baa00a9sm3402878b3a.140.2025.07.27.09.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:47:17 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH v2 1/3] blk-wbt: Optimize wbt_done() for non-throttled writes
Date: Mon, 28 Jul 2025 00:47:07 +0800
Message-Id: <20250727164709.96477-2-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250727164709.96477-1-yizhou.tang@shopee.com>
References: <20250727164709.96477-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

In the current implementation, the sync_cookie and last_cookie members of
struct rq_wb are used only by read requests and not by non-throttled write
requests. Based on this, we can optimize wbt_done() by removing one if
condition check for non-throttled write requests.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-wbt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index a50d4cd55f41..30886d44f6cd 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -248,13 +248,14 @@ static void wbt_done(struct rq_qos *rqos, struct request *rq)
 	struct rq_wb *rwb = RQWB(rqos);
 
 	if (!wbt_is_tracked(rq)) {
-		if (rwb->sync_cookie == rq) {
-			rwb->sync_issue = 0;
-			rwb->sync_cookie = NULL;
-		}
+		if (wbt_is_read(rq)) {
+			if (rwb->sync_cookie == rq) {
+				rwb->sync_issue = 0;
+				rwb->sync_cookie = NULL;
+			}
 
-		if (wbt_is_read(rq))
 			wb_timestamp(rwb, &rwb->last_comp);
+		}
 	} else {
 		WARN_ON_ONCE(rq == rwb->sync_cookie);
 		__wbt_done(rqos, wbt_flags(rq));
-- 
2.25.1

