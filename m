Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738FE22C35B
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744129570; cv=none; b=t7fe59zKRSL8Fv8h85vjIp+ohSEYsrUiMXwuQ9dEBuaUbAPEuTn3y5GlonPHR5C1uLMfZdyUhzXffkb/VJnvvkoZNnRJ8X/y//CGUI5GDLaefsQwHKSinWM4cMxobFyaUofjDWLxfZdT2DT7M4nOn1HyGk22E4vHvZbW4/c2nBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744129570; c=relaxed/simple;
	bh=pHwq1vbxRUPFEuWb6uI39nP+MWqTRePdK8lKMaNxOC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ps1GlrA67WNNDfMJS852BR2yUGbFiCE6RxTWtvwgSxjcrstUTRvCbo4bthkqLBxvivBBG2kBWdGFL8zJehoEmPfYG8YdI0eS7Cb3KFkGyJBoR0Z31bq89bcfPG96JwxDdpu43qMo3AtqrJW14T8y65Rp9oTmvO329rGRg9NCcKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCv3QwGk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCv3QwGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33536C4CEE9;
	Tue,  8 Apr 2025 16:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744129568;
	bh=pHwq1vbxRUPFEuWb6uI39nP+MWqTRePdK8lKMaNxOC8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZCv3QwGk/c15mTsSknVFYdcVn8RTegIodp+3gZol/xxES6xREjdN+HjUk5DZnR5Y9
	 OpHjm+7tljNu6UbM1pg62wWl0jDNr/cslR5kFbguZDNz0IqbKlskRxAn6zQBK0Eu/Z
	 I5T+JE6NNu10diI4tseXsTZXlRGiisK8Z0VnG7IrVzOXiFCCZPho0Ooopsn6Lrvema
	 BjaKzegd9x1aZK2XUIhbYINcW4H1uYBwPXl0Va5sxokwtxCOVj6KgD5QmE+fR2+JiX
	 znqoNeDMlu9l3W/+Nc/Qyz317g4pv/xPcv/pGuObdPObyM/G8QhnFuflgu1m/XZnth
	 K5DTUsFAOLJVA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 08 Apr 2025 18:25:57 +0200
Subject: [PATCH blktests v2 1/4] common/nvme: add debug nvmet path variable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-test-target-v2-1-e9e2512586f8@kernel.org>
References: <20250408-test-target-v2-0-e9e2512586f8@kernel.org>
In-Reply-To: <20250408-test-target-v2-0-e9e2512586f8@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 common/nvme | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/nvme b/common/nvme
index 3761329d39e3763136f60a4751ad15de347f6e9b..04b49c2c1f9edc6de516398b537502fc30a92969 100644
--- a/common/nvme
+++ b/common/nvme
@@ -26,6 +26,8 @@ nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
 NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
 nvme_target_control="${NVME_TARGET_CONTROL:-}"
 NVMET_CFS="/sys/kernel/config/nvmet/"
+# shellcheck disable=SC2034
+NVMET_DFS="/sys/kernel/debug/nvmet/"
 nvme_trtype=${nvme_trtype:-}
 nvme_adrfam=${nvme_adrfam:-}
 

-- 
2.49.0

