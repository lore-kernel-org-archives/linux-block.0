Received: from mail-yb1-f227.google.com (mail-yb1-f227.google.com [209.85.219.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B104F1A9B3D
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749246031; cv=none; b=FrAQfp9OOgYAu3/pSePN8lS0bCmHZg9MrauR8ewy8C5VL+6aywdIDYX5mGqSrne8ZUiqQYu6ROeq5qntm+aXDJYBtuRNdWYPwfcP4BPh5lYxchB0t2mrE9cJzmK59fFHnmuSFxj3dkZhmIoQEuO/JfzqtyLqOFXEOoLiqVanyvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749246031; c=relaxed/simple;
	bh=74xITWQ+JRvXuucx/Ag9JveFc6Zwv1gDzZfq2q6p5t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNm3fl/Lebt/5VVYOLgmfwyOALtoKvLmWQ1k2Yw2kV4IETgq1DO7GlE6QiTY8cSgKVv3zuyITy1rmCsimwCn+aHgsHbBcqNMw5IYT2mOXxM/NvD2RcvolbwZqIZQziXK05NOTn09ZaviZaOFrCXYvHgEZ7p5xnyYW1r2ijRJziE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FCCAZdYB; arc=none smtp.client-ip=209.85.219.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FCCAZdYB"
Received: by mail-yb1-f227.google.com with SMTP id 3f1490d57ef6-e81881bdd55so355759276.0
        for <linux-block@vger.kernel.org>; Fri, 06 Jun 2025 14:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749246029; x=1749850829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHtZiRaqt942glaYo65uZ7klnNaUoFKylPFydqClNPI=;
        b=FCCAZdYBDh3BMOrlZsb1FWzLWRVu3Zm1iCB0+sYkA6qIrNzIBDQVyaBzYqzrc5HDNi
         J1MPg3EAFTA2ODpdG153o4O7/EPE4OtWQbRsII+vi3ETjbNZwEGyUy1jwJLOzD5NDh42
         e4PZF3nEM3G6uctnNIV3t1TJKV6h+vnEq/GZlOzXSmdqJTh/V5JlKo7tKNYxnSb/Ewqe
         xtmlCDqwQxr+gBBpvXA/7Zs0lpLP+bXX93CvgeryK5xVecnHlfPJj2MNl3ethzGdOoe/
         8bMKJUAq+rsiNtuXlNB6wAzvlme4k371lSs/wHRgJTpLePweEEhC2+qeOLyrAVduV4Z+
         b9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749246029; x=1749850829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHtZiRaqt942glaYo65uZ7klnNaUoFKylPFydqClNPI=;
        b=E5wAVWgo6nkc0mJaYy5csQcWzSYxbjYQjs5n0DFP61TSCFRRyPuBZRR80DenIQZvEG
         sXCk+IyrT+sM1iNq188GXB9bzvuBBX+jJVNYrYmHx0GkM9I1w1rreAecXKQ4QotKKUTB
         YhzbyQqdfyYDAcqSfJ/Rzdp/Ukj7npuL7KR+mfMhrgTFCfAzm3gNVQWp+2H/u8ALt5jd
         5rwJi31HGIKJsKpYhb7+k6vQjnMzK6qPvZDEgmbB6cMrW6yP9NJF4ouGhaKh6yDZ7PSl
         fYfi+mHF1KoEd5PSE2lLydwcajOfMaDZIMHXWJ45ClPsB6o4lrjY7bZzvkLvZX/twreq
         a2DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkg37WrMcg3pUSFJfPQfavsLDIbziSNl1H+yH31M2CRmZSa/ym8m1BTiJ9zGUlECsCZUdHsvL3qWhaFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNJF7H0GJy40RTKbn7BMnNbfI4UW49fGKv+LF931ZmZcVT6g46
	AuxsCS/xelMHO0Xi9SJkfpbpead0xodEhQWWsupuVfG8LZMHRf5XijuKDGASWSHcSukY5C5njHV
	CKgcExCObw9MxX7K/RyD5Sf7qFDmOjGa7wpdj
X-Gm-Gg: ASbGncuETpIgeZwGEgHuAfWZvyMDa9aJ4KxcQdUNuaCrWHfR4SCe4vqtjdFvEAzxt9J
	MEEajtVz5lH7TdPoiFfsSPM1NUBRFctnGtVlUrqmyMPG+LqcSlrqIL3I7VZNh+uZWy/WXNJ/95E
	9ZVDkltcFUTg29judajSy+nvapSb1vtNg9g2LQBnZ/ZFUf+Vpbl96I1UDSwXXeiyNKgDl+guiU6
	wx/crWEbBmq15gy8DbK8Kl6jsmGdA7udZnIYj/R2gqOhjLMoPxgfM7kKNOag7JoEzHCr9Q/xI5B
	Mz0/5OIjNUGOiFi6qfRj+7PuT1ZEidx3pXr/pKfS0C1Hn3CdCerIuRE=
X-Google-Smtp-Source: AGHT+IH+gOlXGBWP6Cud9IbH2eMV5MmWsxmOw3SrohtaOXwI0fI+zUXo2YS5QX+0DmGxhG/QZ4oIOiNQPhBT
X-Received: by 2002:a05:6902:e0c:b0:e81:7e08:64cc with SMTP id 3f1490d57ef6-e81a91929cbmr2440614276.3.1749246028591;
        Fri, 06 Jun 2025 14:40:28 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e81a400215dsm64597276.5.2025.06.06.14.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 14:40:28 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 10BEB3400F3;
	Fri,  6 Jun 2025 15:40:27 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 06C54E41EE0; Fri,  6 Jun 2025 15:40:27 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 3/8] ublk: remove task variable from __ublk_ch_uring_cmd()
Date: Fri,  6 Jun 2025 15:40:06 -0600
Message-ID: <20250606214011.2576398-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250606214011.2576398-1-csander@purestorage.com>
References: <20250606214011.2576398-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable is computed from a simple expression and used once, so just
replace it with the expression.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c4598f99be71..76148145d8fe 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2170,11 +2170,10 @@ static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io)
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
 {
 	struct ublk_device *ub = cmd->file->private_data;
-	struct task_struct *task;
 	struct ublk_queue *ubq;
 	struct ublk_io *io;
 	u32 cmd_op = cmd->cmd_op;
 	unsigned tag = ub_cmd->tag;
 	int ret;
@@ -2205,12 +2204,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 
 		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 		return -EIOCBQUEUED;
 	}
 
-	task = READ_ONCE(io->task);
-	if (task != current)
+	if (READ_ONCE(io->task) != current)
 		goto out;
 
 	/* there is pending io cmd, something must be wrong */
 	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
 		ret = -EBUSY;
-- 
2.45.2

