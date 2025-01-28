Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A681DE4C8;
	Tue, 28 Jan 2025 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082112; cv=none; b=BcV8nYI/KfpO/MUDDsnOOdu+RiaNs6FcLlnEC9uDL0Hd0PyP8MEXPH3TehJpgx+P101SFnBzMG7iAw+w1B4iKBQPohPICY4eDOR2delft9/uPUAQmnyHV3MYe8bYKvBbPZaKi3gmvyBfT4mo3BY4sdM4t6/mpW3AU5bmwMhSBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082112; c=relaxed/simple;
	bh=BYg80m4FjS4dU3qsCOeFHzQpyGsVbs++H0+ZTCLs+A8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LQYTBquzdZu3LmXMz5T+LQ3WWvhqmw63x7f/zQZgGVHUy5rXSso/dX1spn1Yf5bZbRf8A5WmhR+QWNgrHRWmN2JEuoj/zuwGNhHzjVvDt8+tOPikZTpbSm1QQIuh450N1ckREyqvhnyKKxg3yvXhUL/BUkV2ocqhn51N4zrPxCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZVm6473; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZVm6473"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E22C4CED3;
	Tue, 28 Jan 2025 16:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738082112;
	bh=BYg80m4FjS4dU3qsCOeFHzQpyGsVbs++H0+ZTCLs+A8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YZVm6473C6+7opfNH14rx5dnUkBlj4zhaAjUpsEQNDNTCnLLu/Rzfzta8vrarHLqN
	 ZhGz827rekIWDNSPJqNcymJJTpVgANY8F7FXelNfiwuTGbuhooeCZf2GU3vPabISq3
	 J41ena74J/NVAvzzX+1ON8SQxvNNTuGNwZtbm3qTDG8IYEkjvZsFviB/FyxPAIhMkC
	 IHsztiFrrgcIL8rTVupJJutOZk7BOPcyHLRMy8OOFYIIwit6Be6gF6tw6kygbAET6o
	 oFLpQGww4yPZjTvx/oEyw9IrCmZhRP6emPlBSyNeS2AoydB9O5kjIpKagY+xc1Kqge
	 ZmjbkJYkNDsqQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 28 Jan 2025 17:34:47 +0100
Subject: [PATCH 2/3] nvme-fc: use ctrl state getter
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-nvme-misc-fixes-v1-2-40c586581171@kernel.org>
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
In-Reply-To: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Ming Lei <ming.lei@redhat.com>
Cc: James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

Do not access the state variable directly, instead use proper
synchronization so not stale data is read.

Fixes: e6e7f7ac03e4 ("nvme: ensure reset state check ordering")
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 55884d3df6f291cfddb4742e135b54a72f1cfa05..f4f1866fbd5b8b05730a785c7d256108c9344e62 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2087,7 +2087,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		nvme_fc_complete_rq(rq);
 
 check_error:
-	if (terminate_assoc && ctrl->ctrl.state != NVME_CTRL_RESETTING)
+	if (terminate_assoc &&
+	    nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_RESETTING)
 		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
 }
 
@@ -2541,6 +2542,8 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 static void
 nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 {
+	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
+
 	/*
 	 * if an error (io timeout, etc) while (re)connecting, the remote
 	 * port requested terminating of the association (disconnect_ls)
@@ -2548,7 +2551,7 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	 * the controller.  Abort any ios on the association and let the
 	 * create_association error path resolve things.
 	 */
-	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
+	if (state == NVME_CTRL_CONNECTING) {
 		__nvme_fc_abort_outstanding_ios(ctrl, true);
 		dev_warn(ctrl->ctrl.device,
 			"NVME-FC{%d}: transport error during (re)connect\n",
@@ -2557,7 +2560,7 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	}
 
 	/* Otherwise, only proceed if in LIVE state - e.g. on first error */
-	if (ctrl->ctrl.state != NVME_CTRL_LIVE)
+	if (state != NVME_CTRL_LIVE)
 		return;
 
 	dev_warn(ctrl->ctrl.device,

-- 
2.48.1

