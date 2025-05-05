Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EFF284B48;
	Mon,  5 May 2025 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483937; cv=none; b=meaelUYz5zoOk1WMLHPUnZZm5/Ecm4JiHn/ZPfi+dOSUGtJCtKet1CIOPW+JcbjXjbS72fgPRZl+z8vJSjfl0VQetAicINJ2lpFSF3etZuRfdD1kbPzjdS7EZZvto6tPtrqPk1UhoDG71+nlMDqL8wwjOeYzK6ausjVy5oMkpds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483937; c=relaxed/simple;
	bh=z8RjzFlBz44QCR72XHWW9v4ESJlYdjccr4zV1KbxREw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EtqN+KDQeSXxZx6p9U9dm1fqPnnrcO14doK/bAbM9TR2JHi33InvpJmL9ozE9cof7/nQ+E0I2tSpo6gHTO8nsxAkeM4B39rSaRNOYlehMiArAmehU5cshCSx77FclGROHKecFvx9gQ4prsUPWsmqraMC9Enn2ILl9G50yAOISq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOxWaFll; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOxWaFll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2FBC4CEEE;
	Mon,  5 May 2025 22:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483937;
	bh=z8RjzFlBz44QCR72XHWW9v4ESJlYdjccr4zV1KbxREw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oOxWaFllqdtEbE4JxMxOCszIENEDNLKGZwaXh37VN7dx0/UlNAvVXhtlQhDONWDuQ
	 tAqzqzjrQzQtSzixbt+Rd6oLcSmsGohXjgatUt86QdmyG2RQvgy1QnfaLt/cC9grKq
	 MU/l2ON2wlv+o5pibk69BgJZPKQuXkNrCmrUZ5Ej90koXiZ5y9TmxMnt35Hh4jF1zx
	 eweKOQjiASHkaoe7T1UTW0mlLq471eAsQZTnlJZbBliHibGXKjORi8jIsPSxmnkm+r
	 rR7EUiTJfXEqj7T9Q+gSrrshlSlCpuo6npN1DM2QdaA5B9WX0HmkGrfmPnBBxZKfSZ
	 ockgeInqFiijA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 278/642] ublk: complete command synchronously on error
Date: Mon,  5 May 2025 18:08:14 -0400
Message-Id: <20250505221419.2672473-278-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Caleb Sander Mateos <csander@purestorage.com>

[ Upstream commit 603f9be21c1894e462416e3324962d6c9c2b95f8 ]

In case of an error, ublk's ->uring_cmd() functions currently return
-EIOCBQUEUED and immediately call io_uring_cmd_done(). -EIOCBQUEUED and
io_uring_cmd_done() are intended for asynchronous completions. For
synchronous completions, the ->uring_cmd() function can just return the
negative return code directly. This skips io_uring_cmd_del_cancelable(),
and deferring the completion to task work. So return the error code
directly from __ublk_ch_uring_cmd() and ublk_ctrl_uring_cmd().

Update ublk_ch_uring_cmd_cb(), which currently ignores the return value
from __ublk_ch_uring_cmd(), to call io_uring_cmd_done() for synchronous
completions.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Link: https://lore.kernel.org/r/20250225212456.2902549-1-csander@purestorage.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/ublk_drv.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index fb770b8b09412..7e2c984cea732 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1972,10 +1972,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	return -EIOCBQUEUED;
 
  out:
-	io_uring_cmd_done(cmd, ret, 0, issue_flags);
 	pr_devel("%s: complete: cmd op %d, tag %d ret %x io_flags %x\n",
 			__func__, cmd_op, tag, ret, io->flags);
-	return -EIOCBQUEUED;
+	return ret;
 }
 
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
@@ -2031,7 +2030,10 @@ static inline int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 static void ublk_ch_uring_cmd_cb(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
-	ublk_ch_uring_cmd_local(cmd, issue_flags);
+	int ret = ublk_ch_uring_cmd_local(cmd, issue_flags);
+
+	if (ret != -EIOCBQUEUED)
+		io_uring_cmd_done(cmd, ret, 0, issue_flags);
 }
 
 static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
@@ -3169,10 +3171,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	if (ub)
 		ublk_put_device(ub);
  out:
-	io_uring_cmd_done(cmd, ret, 0, issue_flags);
 	pr_devel("%s: cmd done ret %d cmd_op %x, dev id %d qid %d\n",
 			__func__, ret, cmd->cmd_op, header->dev_id, header->queue_id);
-	return -EIOCBQUEUED;
+	return ret;
 }
 
 static const struct file_operations ublk_ctl_fops = {
-- 
2.39.5

