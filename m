Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF741DE2C9
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 04:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745729896; cv=none; b=rE4uDJcgHjgkOUDx/yh/jIdO2flikCHk1Cjc/Wd6GVrLIoyDbXZyd8rHfSsl14hZQLVUrBnqVosc39MMlAanQiTDJGyffTtqyJ1c4GlPevWNXqu10+2IBFQ5XFdhnycjYySaOTzd5+kBfM7GrXZERVnVa3Rk4S2FyEz/qjPp1uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745729896; c=relaxed/simple;
	bh=EGjGvQiLy6/0dGH0rf4vi2XFjxP0Q7Nii+w2OPcP1UA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nswtXsgAN514YExdoNiQIbLtg/2R3KIJCRNeJP7Pl3fNHV84KV9el2xQahBFslxN1akT63/chUCapRzJsUYNXsKHIbstq01y/dK6kH3EWu3ziYTi2MCgY+H0cqNBNBsdHe97yXgsnzK9++ZVSA+TLsEzZ/5ycl+4oRCdDEJ8cCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=S83+vAxh; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="S83+vAxh"
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-85b39b536f1so11930439f.2
        for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 21:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745729892; x=1746334692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5jjGLpUlxlPMxngVK27jDZo+zNj8tC/Y3I19hk9qgLM=;
        b=S83+vAxhEMrtxrw8U2nZBPIUSR6RLn0G0sA5rs9rh0GAdn86PGtZA59OQcgm3/Jhd2
         P0Ei0cMUyzr9rc305IQ6gRAm5hUKlwF0raQRb8krjwU90TDI2wXYYb8JQoXC2Zn0U5fH
         xkzIwxR47syc0lNIbhxYWdVYdykpS/pp/04M9Eyt+eUSv4KIWYkNeavJ3dJCN51/XGIy
         QOF3EBgy3odIJhxM7XOU+0oq7HSPvt3WBIkUmuiIR0Hn3E96s+1e1TuxeiymBSavGku4
         zwUYFId/39r4cNK0CIDR/6bZh7JcXQ/3GxzJED5yk282vDXLsmVF8nMSkL5B9FaCykDo
         NFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745729892; x=1746334692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jjGLpUlxlPMxngVK27jDZo+zNj8tC/Y3I19hk9qgLM=;
        b=P+TZwGtuk//csOJAQ3LNutq8ipnaz+YQhMW5Jz3LCbu3kr+KdgZdZAHavcvEdi13Dv
         RoODlvNIyWTlTn6sGreGty0Oslrz/u2GPHJe2srFM9pXIeZEzYpvMiQ0vN7wlNSILrq4
         OFQdFfjGwARIrvBBZiEuuZz5i8kJ+Q00MmIeiuIgDKrRcemCNo9zy43KLZMWYi1ZGGf5
         PCjrXPGBMzf2krgXLgj286Cyh+wQXbU1R1DoZVnuFPe1xSX3OeizEUUq2SEQZ0Co0yBJ
         7V0gb1U5hIL+qYi7L7Wzc0m6I6SB/1qDIyuay1k6hNBLYU7+ZA4tYIP1n3hXuNbn7m+j
         XslA==
X-Forwarded-Encrypted: i=1; AJvYcCXWBNrzD2MNv3MaMo5Qmd24K4FTIkcnB6y24O3G+4nmlLQl2fJDS/JBEjkJ7CRwDKL4Mn5aFSaezNY2xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTD0i0fQjXzhi4UhSOhx5XJQn0oPGMdOvExEiscJQVaTJloUm1
	kNQrvmzLU3znzFwK6BvTBN6o6fVOXLLf3Btn2Jx8CS7hM61inIvQ0/GjOgUu6wes2bLtL2nMr5b
	FNRhzCKWvBVk+y6ZG7xYI6iQvnNK9XHdU
X-Gm-Gg: ASbGncta3A8Nftqskm1+qNHbtiVfJpFosDQSKSiOFT3tTCCk9zCtEx/pxgIG+vdiSk5
	xSBFk2SoeDtCRz35CNgVPpuYe1g/GZlzw4sjiNbk585fsJqmo2l9YYudbRlfEksYPk1TLHwh7iG
	5i3PpHu8QDZBAcEgOzUyf4A6P0mFy+sZILRRjj8IvWGEMVCkoBJ0p8B2ys8bfkt+kZ6uhC3b/+Y
	FTm/s+OyNCgl7aLJlYDGlkr7oMTZSXhsTlThB5zkmXhhi6hA/9gzjYVh7Tgsy5oHdvDsGy4VwA2
	ntbmy4pkX66CjIkIv2phajxdxdBvtwsUpOM91ahE0iCM
X-Google-Smtp-Source: AGHT+IG2J65M6dtSAjI+IJQgRVi+gn8BXNStjIyp+ZYP3gMTx6RgPkWkqcYi/uYG2PVh0DIwISZ5NfUuzbB3
X-Received: by 2002:a05:6e02:2195:b0:3d6:cd13:8465 with SMTP id e9e14a558f8ab-3d93b3a7d1bmr15346875ab.1.1745729892592;
        Sat, 26 Apr 2025 21:58:12 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d9314ffa58sm5643105ab.6.2025.04.26.21.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 21:58:12 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::418a])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E6A2934031E;
	Sat, 26 Apr 2025 22:58:11 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DFF3CE40C3E; Sat, 26 Apr 2025 22:58:11 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/8] ublk: simplify NEED_GET_DATA handling and request lookup
Date: Sat, 26 Apr 2025 22:57:55 -0600
Message-ID: <20250427045803.772972-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove accesses to ublk_io's cmd field after the I/O request is posted to the
ublk server. This allows the cmd field to be overlapped with a pointer to the
struct request, avoiding several blk_mq_tag_to_rq() lookups.

Fix a couple of typos noticed along the way.

Caleb Sander Mateos (7):
  ublk: fix "immepdately" typo in comment
  ublk: remove misleading "ubq" in "ubq_complete_io_cmd()"
  ublk: don't log uring_cmd cmd_op in ublk_dispatch_req()
  ublk: factor out ublk_start_io() helper
  ublk: don't call ublk_dispatch_req() for NEED_GET_DATA
  ublk: check UBLK_IO_FLAG_OWNED_BY_SRV in ublk_abort_queue()
  ublk: store request pointer in ublk_io

Uday Shankar (1):
  ublk: factor out ublk_commit_and_fetch

 drivers/block/ublk_drv.c | 234 ++++++++++++++++++++-------------------
 1 file changed, 120 insertions(+), 114 deletions(-)

-- 
2.45.2

