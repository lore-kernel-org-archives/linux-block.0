Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE002C11FD
	for <linux-block@vger.kernel.org>; Thu,  9 Apr 2026 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741441; cv=none; b=i72swJdS2IV3d176FHie3kIqIl63JXZCExsSu2i/+LzJloX/IPkMxaebyifUQTYFSjmBJV9cM/0iQ2MJJyy1TwXaa46/cR5Ycjdff6SctaZreRcZpZ3zAH3GvuU38KKH0ONc5+r8pJDgxGYKKFsRwdc3DqRinyxO3X9MuCIrWeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741441; c=relaxed/simple;
	bh=hNoYfRfTH01oflc9UzkcxGZ48tEqFZv6H36DwUg70no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGRlkx+gYiPzn/E79fTJf2IfoUy9pz/+kbn3UuFPBJbKUj0K65QINEe8f/nAnyEiRw7n9NkUTFNFaq+8vDvOHvIIgq8jReRpR1YfKgQasCYjpuYIZaHrkInRBWC+tlb31rx8uED+rSx3+cZgICnLLMkcPe9eUm3QAmhvhPQV+s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LX7t9b0C; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LX7t9b0C"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so859487a91.1
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 06:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775741439; x=1776346239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVm6kN83Pf5g8LGKvAJBiPdplk9IeuEltPFsklHaiIA=;
        b=LX7t9b0CU5Yxgd1o+rd9V9fLtHCJnfyozHpW9JD3aDnrP2p2VUickQkn06BB5EcCcV
         lZSXNqo9Dp+dxoGEU8W5HZk0Q+LAGKGkVR2LY1XPZopjoBivADl5dzDh0K90HrkXEhMj
         rEJQYciKHMWqhufuBapnXH30Ji7YPGpFrWcu5O6GKUmmywBP4omBIysxtjhwZSU6M2IV
         VjbSMzwDxLngayRoKePt7m3MwQ7LugBF+mAl/Sk7JK8q02OcM43bB4b+fZj0WwwhpSQQ
         GVl45tfhY/W3XetIm3MkPSw1iqiJsCkXZuIbHnsXUA2qqVo9eSnuEPcGT6KUBcK9ys3f
         2rfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775741439; x=1776346239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BVm6kN83Pf5g8LGKvAJBiPdplk9IeuEltPFsklHaiIA=;
        b=O3egfPJP6WssBtJZPj36bx90mmYT9+JEoFDRWqs9yO33NEO7JzijYxTDfWRBcL1oMA
         oqj3V76Vf+GTvggNE9+2on3cDCVzBu3ElrVi+PWxwfRHznTJCC9tfeMTBDCV/MsIirwQ
         iX/AfwDUD1BoIczSJw3jTAkzkZV3SHfEIQwpR5/Dz6FqjRV03ecTGNB+vLNa4jnlLPSd
         C7udmrzMpL0i/ih4N65SluyhEHuYEJbSYLujaEq4IEtGe+CFgIU2crJEln1Bqqh+MKd3
         WPzcGZ3Pv+tOnjvy50MZUCT4gqZuGfZSsjJqDkDkSRuA2H9kKi6OOBK7oPjR87t6+dzI
         zrqw==
X-Forwarded-Encrypted: i=1; AJvYcCXY0bWipAgAKZ0LB3j0CtVfPE46GffGzrk68NRgXnkrCom9s80wFIIS7Jg90nSuRvi2dLKq4lvWgRNPJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUCXZHu7NdIl9LIamDhqizyyBZbUZd1OqupUno+1/ckfYk3jiI
	KdkSXrb4WTJPFXeSvsna/sjWW6xHYy138Dg+ZH9Nql9+csg7zLkrszRA/amuSV4z1plmhQ==
X-Gm-Gg: AeBDiescugYZZOT3pKdsoDpJuaITw1i2Bv/eBcJGtzchA4qBmtN6LGFxSNY6rzdqdgV
	9tyfz9aS7sEY4SN3wUXGWNGuMcC7fPQv9h/scgliltHcRnw2/tvlW+kl9nkq/skshwdr981550n
	u+MVUyBOa+17SVu+iYR8lmeBm3S59pXzUfzDbtdt1YgFy3nRRfTHf+2BPi8JMjYq3+PEu4sbY4l
	LB4P0uJ8lI5Ma0PYRMkpp7Qqyd1SXvwdkSjSfHDUUJ+iW3IoECWQUIlLbIAstlJZsMaP4IAKEOM
	zAR8QvGoby7knASpiuN/zkTrQO7BtQtMB7tZq9QiHOA7gHoSUDriwz9RpOuTi7Mgoz4REF3RckH
	iAYYsPkkfS9YsLdWRoksvn+8mlOZqwPgCLD5hF5a4mWjcFIqGKBtQXt+NulgACDBkuEjKcPK7yA
	dSV1IxNYS/vwukONcDJtQU/BaDi7liQA/rct9zz9vTOhAIOqc5mzMhhL2pzsdssiWttw==
X-Received: by 2002:a17:90b:4a48:b0:35d:a861:36dd with SMTP id 98e67ed59e1d1-35de691b2fdmr24777780a91.25.1775741439293;
        Thu, 09 Apr 2026 06:30:39 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm21021166a12.24.2026.04.09.06.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:30:38 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 1/7] ublk: widen ublk_shmem_buf_reg.len to __u64 for 4GB buffer support
Date: Thu,  9 Apr 2026 21:30:13 +0800
Message-ID: <20260409133020.3780098-2-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409133020.3780098-1-tom.leiming@gmail.com>
References: <20260409133020.3780098-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __u32 len field cannot represent a 4GB buffer (0x100000000
overflows to 0). Change it to __u64 so buffers up to 4GB can be
registered. Add a reserved field for alignment and validate it
is zero.

The kernel enforces a default max of 4GB (UBLK_SHMEM_BUF_SIZE_MAX)
which may be increased in future.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c      | 9 ++++++++-
 include/uapi/linux/ublk_cmd.h | 3 ++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2e475bdc54dd..ada9a2e32ea9 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -63,6 +63,9 @@
 #define UBLK_CMD_REG_BUF	_IOC_NR(UBLK_U_CMD_REG_BUF)
 #define UBLK_CMD_UNREG_BUF	_IOC_NR(UBLK_U_CMD_UNREG_BUF)
 
+/* Default max shmem buffer size: 4GB (may be increased in future) */
+#define UBLK_SHMEM_BUF_SIZE_MAX	(1ULL << 32)
+
 #define UBLK_IO_REGISTER_IO_BUF		_IOC_NR(UBLK_U_IO_REGISTER_IO_BUF)
 #define UBLK_IO_UNREGISTER_IO_BUF	_IOC_NR(UBLK_U_IO_UNREGISTER_IO_BUF)
 
@@ -5351,11 +5354,15 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 	if (buf_reg.flags & ~UBLK_SHMEM_BUF_READ_ONLY)
 		return -EINVAL;
 
+	if (buf_reg.reserved)
+		return -EINVAL;
+
 	addr = buf_reg.addr;
 	size = buf_reg.len;
 	nr_pages = size >> PAGE_SHIFT;
 
-	if (!size || !PAGE_ALIGNED(size) || !PAGE_ALIGNED(addr))
+	if (!size || size > UBLK_SHMEM_BUF_SIZE_MAX ||
+	    !PAGE_ALIGNED(size) || !PAGE_ALIGNED(addr))
 		return -EINVAL;
 
 	disk = ublk_get_disk(ub);
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index ecd258847d3d..66d93efccd51 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -89,8 +89,9 @@
 /* Parameter buffer for UBLK_U_CMD_REG_BUF, pointed to by ctrl_cmd.addr */
 struct ublk_shmem_buf_reg {
 	__u64	addr;	/* userspace virtual address of shared memory */
-	__u32	len;	/* buffer size in bytes (page-aligned, max 4GB) */
+	__u64	len;	/* buffer size in bytes, page-aligned, default max 4GB */
 	__u32	flags;
+	__u32	reserved;
 };
 
 /* Pin pages without FOLL_WRITE; usable with write-sealed memfd */
-- 
2.53.0

