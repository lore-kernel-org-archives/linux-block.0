Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABFB30EF85;
	Wed, 26 Nov 2025 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764161326; cv=none; b=fjMlKjypQUPnDSWH/LL1wvPadgHbh2vHaEBt95hHXEH26fG7xY36ZJ3IzzACLscxxl0cmNpkNL8V2osdCqMy3ub3fjmIGTzybYxh5MJIKz8yOASiai/AFUuOG9u6Lj9OcouaFxbY9/HSaPXQ6Apa4YrFkKFyO7pNk1kjLfN/SGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764161326; c=relaxed/simple;
	bh=/Xm1X1BUjzRmFUV+A5jOmP4KHHBSuIG59uEQl4KZrI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=umtMEHzcUUp9PN4MLSnkfGg0gfyDZak9GOQrbMY3e5AfCKaj30jAp/lFhSBymL94XqkrG+YXh5TqTt3erE41QAHrfqFqSmcGgai+NfNM/jO2dSiz54l2g6T3zC+VLAyq5V4aUWXM9MaacfCCKGjFGAIR+67y6mTpfB2zUxrFRgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E266168F;
	Wed, 26 Nov 2025 04:48:36 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A40E83F73B;
	Wed, 26 Nov 2025 04:48:42 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Ali Utku Selen <ali.utku.selen@arm.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] ublk: prevent invalid access with DEBUG
Date: Wed, 26 Nov 2025 12:48:35 +0000
Message-ID: <20251126124835.1132852-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_ch_uring_cmd_local() may jump to the out label before
initialising the io pointer. This will cause trouble if DEBUG is
defined, because the pr_devel() call dereferences io. Clang reports:

drivers/block/ublk_drv.c:2403:6: error: variable 'io' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
 2403 |         if (tag >= ub->dev_info.queue_depth)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/block/ublk_drv.c:2492:32: note: uninitialized use occurs here
 2492 |                         __func__, cmd_op, tag, ret, io->flags);
      |

Fix this by initialising io to NULL and checking it before
dereferencing it.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
Cc: Ali Utku Selen <ali.utku.selen@arm.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0c74a41a6753..359564c40cb5 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2367,7 +2367,7 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 	u16 buf_idx = UBLK_INVALID_BUF_IDX;
 	struct ublk_device *ub = cmd->file->private_data;
 	struct ublk_queue *ubq;
-	struct ublk_io *io;
+	struct ublk_io *io = NULL;
 	u32 cmd_op = cmd->cmd_op;
 	u16 q_id = READ_ONCE(ub_src->q_id);
 	u16 tag = READ_ONCE(ub_src->tag);
@@ -2488,7 +2488,7 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 
  out:
 	pr_devel("%s: complete: cmd op %d, tag %d ret %x io_flags %x\n",
-			__func__, cmd_op, tag, ret, io->flags);
+			__func__, cmd_op, tag, ret, io ? io->flags : 0);
 	return ret;
 }
 

base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
-- 
2.51.2

