Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AF42C2598
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639557; cv=none; b=A5t/eDzXWChWG6CslnTHxhNaszcVo05EV6esk8jiK4CHuvcgkEq3DDMMElBLmW9i10RYtfyXOtrnuSZd5RjIXv1IqQwQ/xk9PwEEqbUbKTqBIz8uGKix43vfxjs5QqB1/pOCuI5OVHt0yYTiR8wME/065wcEfbZJDgrlSLutx4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639557; c=relaxed/simple;
	bh=pHwq1vbxRUPFEuWb6uI39nP+MWqTRePdK8lKMaNxOC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Js6bnB9TzC0gmVsmz5xdk0hIaDJhcAcUz+k7YE05z+QYKPMMuCIkXitZ7doiOWVjwec6g9X/pssEJ3WpDfpgzueFkL6sVT/tuGYdB8sVKW7+iOZ9/IbRRF663o2aa6MiZDg77BlM1vY90Xef0mk2pgp+CIiZ4MLDdGe5vzmM0SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dckQOyrq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dckQOyrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8934C4CEE2;
	Mon, 14 Apr 2025 14:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744639556;
	bh=pHwq1vbxRUPFEuWb6uI39nP+MWqTRePdK8lKMaNxOC8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dckQOyrqSjip+KABkMvpTqAbzTsi7BsDZLMTT44YncFbBKRpPkocR2JCtklcwDmn8
	 jIhLSdkQTr0wiAkVT+Hn5s1pe9dcN8qZSczqZicvyF8y74/amzgSB+WL7X3FwImGhe
	 csORJg/D4h1AIIWg/Sg3XJVXria7+1lKSk4ztzUnco8aIHtMP6OT2w88P4HdLoexMt
	 Wvjhr3eSQemZ0ktfwZpi+7mJODofUhH4yuGyiiw8L3Y7SVi5C8TI1yCAofV/kjyWD2
	 KUeZRe3zkJakYXeR4JR6VT+FYGFXttj45W1QCh+K0jZFdTJiuryHDlDwlLEYbXVNG9
	 v+2p4TKrscE9A==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 14 Apr 2025 16:05:50 +0200
Subject: [PATCH blktests v3 1/4] common/nvme: add debug nvmet path variable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-test-target-v3-1-024575fcec06@kernel.org>
References: <20250414-test-target-v3-0-024575fcec06@kernel.org>
In-Reply-To: <20250414-test-target-v3-0-024575fcec06@kernel.org>
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

