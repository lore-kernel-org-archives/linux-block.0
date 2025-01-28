Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E9F1DE3C3;
	Tue, 28 Jan 2025 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082110; cv=none; b=qq1lHiXEFCWf4SE2A8BMTy6Gl34o343jsdeD2bjIiYoVfi2PFfDF/FClpzYbrPpFi1UtW3HfOlLMN9FfV9tbgip2f86tbK2NEYK8BXamk+Js47NS6ORHPYKvA0JFfxRNBfHecyIBiRdiw3utaN/AGJoXaxJqXfjhS6w0BfN2HYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082110; c=relaxed/simple;
	bh=EqUhYMGg7r3msMj02LTUSBZGnT7L9xWRdBClYC5kDdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vk3EKCgOzcF+lyxi8j1pmtBtClwifQR88xFNFwdGM9DXEjo95HKAENPtEegLMLCubatvZuP9jq2fNxsnZDIwVII/9oZcXFtM8P9fypsmc0i0jQXhHLCM7g4riFgUZukMnv4JosdmpFVOEJGuMjDW58iVJIQ20yeR0rL0+CFApqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tChAcbq7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tChAcbq7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B3AC4CEE2;
	Tue, 28 Jan 2025 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738082109;
	bh=EqUhYMGg7r3msMj02LTUSBZGnT7L9xWRdBClYC5kDdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tChAcbq78A2IK8uEqwPSxE4qq5nLYDCicUs6lftYelHuJSJttZ3QmaOkxr4c0boem
	 a7G053D88tS6k46gqEaXmZzIH+mIn1Epwlo2KG5TClGaNnh+RVnwR6uEJxcZifIkSr
	 XgQAisD/9UMsTi674UP671qj/uwYiMEe/a4WY0RAqy9cMNZ1wIDAiZ7i4LaTzgGueX
	 0tTpSK2RS+IRaVAp3Eo5/No/D9H0Ndho2KVF1yDYFNIE59J5jjJ4m3kZwZHnAq7hy3
	 1ZptCHkBqdXQ4nsQSjwaCLGZXFZbldjFXDx6pAlK8fxoAFJIdqsT9MSNOCaB5lGd2X
	 dLxQlxdKaL8Wg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 28 Jan 2025 17:34:46 +0100
Subject: [PATCH 1/3] nvme-tcp: rate limit error message in send path
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-nvme-misc-fixes-v1-1-40c586581171@kernel.org>
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
In-Reply-To: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Ming Lei <ming.lei@redhat.com>
Cc: James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

If a lot of request are in the queue, this message is spamming the logs,
thus rate limit it.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index dc5bbca58c6dcbce40cfa3de893592d768ebc939..1ed0bc10b2dffe534536b1073abc0302056aa51e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1257,8 +1257,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 	if (ret == -EAGAIN) {
 		ret = 0;
 	} else if (ret < 0) {
-		dev_err(queue->ctrl->ctrl.device,
-			"failed to send request %d\n", ret);
+		dev_err_ratelimited(queue->ctrl->ctrl.device,
+				    "failed to send request %d\n", ret);
 		nvme_tcp_fail_request(queue->request);
 		nvme_tcp_done_send_req(queue);
 	}

-- 
2.48.1

