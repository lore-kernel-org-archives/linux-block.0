Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A4225D902;
	Tue, 22 Apr 2025 02:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288245; cv=none; b=buDexa0kKqg+y2tNUY5s+RdhiB5UqyRP7X1VGYD5JO2eB9CvE8RTC/RWb8F/vt9ab1S7hNUDr7bqfu42LVmXo0B3cKiJYSlxrm9xL/J2D1CLwixEtF/VCpYKJ428MX16l6AvQTOyAoFSvLd8VKPyrZFHwT7Tog8iev8OOAY6KM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288245; c=relaxed/simple;
	bh=o6+TexLzswYiY23ayHADrJcuBzKNsjBX1mjD8iM8aSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eZpCkUPcATvXG62cCGgX2Aqm7R/j5dwVBJg5lImfzhkNLUcJCX1Y9UJnFN6Hnu2elzNcsvF/i4611kaEsRUAwZxFoeewkYe+iLPNxDlm6ElaRzXckMncYK6dd95sE6LdN4RXGRy+S1ZP8/37W/ccdwgCVsjiiY1xyGtnk1xxTeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pz+xQzEc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pz+xQzEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE5CC4CEEC;
	Tue, 22 Apr 2025 02:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288245;
	bh=o6+TexLzswYiY23ayHADrJcuBzKNsjBX1mjD8iM8aSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pz+xQzEcMzlzO6NkPJy86hcS7xzea5qMk0juyRnIVlkC2paUlEO1LwX1AQjc8fZuO
	 J7ur7iX0tVCaK0DJQ9j2F3pM8cbKdwt0/N9xVDLgHtnSy4t58H3hDS4aM4DH0faLmh
	 VEA8SM08SWmQkEW5f2JP9iHfdXLf7W19NogT4XOeEknRUfzO1WwSfkuvUc+FKfLlvu
	 OkdaXiInrH2gsiwMv9w2gWaTawsZK9WhClvPHFRX0adRBbEnTCIpHrKE0BGI/iM514
	 q9lpZcUIO3ejTUQG+UrIgharGjGdntSV17IbPOiIC6zL2D509LpO7u+wSaVkbuXY6V
	 IVw5wqviYgYig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yunlong Xing <yunlong.xing@unisoc.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 13/23] loop: aio inherit the ioprio of original request
Date: Mon, 21 Apr 2025 22:16:53 -0400
Message-Id: <20250422021703.1941244-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021703.1941244-1-sashal@kernel.org>
References: <20250422021703.1941244-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.24
Content-Transfer-Encoding: 8bit

From: Yunlong Xing <yunlong.xing@unisoc.com>

[ Upstream commit 1fdb8188c3d505452b40cdb365b1bb32be533a8e ]

Set cmd->iocb.ki_ioprio to the ioprio of loop device's request.
The purpose is to inherit the original request ioprio in the aio
flow.

Signed-off-by: Yunlong Xing <yunlong.xing@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20250414030159.501180-1-yunlong.xing@unisoc.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 86cc3b19faae8..7e17d533227d2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -462,7 +462,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_filp = file;
 	cmd->iocb.ki_complete = lo_rw_aio_complete;
 	cmd->iocb.ki_flags = IOCB_DIRECT;
-	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
+	cmd->iocb.ki_ioprio = req_get_ioprio(rq);
 
 	if (rw == ITER_SOURCE)
 		ret = file->f_op->write_iter(&cmd->iocb, &iter);
-- 
2.39.5

