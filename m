Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500072080C9
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294359; cv=none; b=oKmprGgURhbXVSl89OZp9TPgGCkI88fHZxRVQW0D88NwfUI2jSUIHcjaHagMwxvyDTAxKwngx4OZU92AWMn1uAgK8zaVbbeVxNRNTwuerkWa91byvs0tuDa2UotYHmh3KvzaibFEdUat0KnAKRGbXReHM8xQ/FlOqozBKbZIkUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294359; c=relaxed/simple;
	bh=r7jj1Iz3OaQlWfOS8KfVwRN5xuHs4IMQmFDHGZqZI+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UU6EEN+LJS/IY0+Zkusn8v8NCzt/MyC/4ICpjECIIURsBMajUsvM6KFwx5BxmQfdCau30lKrJG7i/glnGTKmBL4wXJ5kgc6ts7BHSnAWHB/f2xGqLLzfsqWU3y2/QJEo7XFECo3oV3IF8AM1Aq4ld+TxT0QK1Gwq1PTAZfPIrww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOfzPjg1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOfzPjg1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7244EC4CEEE;
	Tue, 18 Mar 2025 10:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294358;
	bh=r7jj1Iz3OaQlWfOS8KfVwRN5xuHs4IMQmFDHGZqZI+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BOfzPjg1KfVl2ibzrldjDb1Jjlmlwa7GK6YcDWzsFrzz3Pcr39X6PCDEnjibfAXv4
	 NUY14FYk2hcZciM9xvW1f+e5oavg/WNK0SE5F/G2WmXN/Cxz6A2qCzPrSCqMD5m32z
	 4Etnq6BItcdpIDzkX2afHYaKTMXwznDrs2gv8HjhjyMCG63isIzvbMVVol7W7Xx3P8
	 wG2rfWAWVOXQdWDOgmosZvf8sWmZaKD6SHHm94c2DzR3ZulLWK6o/S1S64StcOYV6A
	 yD6/E1bWc7kRa7IBholpCR1+lpnomG7iwlGBMDot1ZPSTZwjE23esIBCbiNkOFSSv7
	 3SMcQ/LdsDmfA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:38:59 +0100
Subject: [PATCH blktests 1/3] common/nvme: add debug nvmet path variable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-test-target-v1-1-01e01142cf2b@kernel.org>
References: <20250318-test-target-v1-0-01e01142cf2b@kernel.org>
In-Reply-To: <20250318-test-target-v1-0-01e01142cf2b@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 common/nvme | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/nvme b/common/nvme
index 3761329d39e3763136f60a4751ad15de347f6e9b..a3176ecff2e5fbc0fbe09460c21e9f50c68d3bce 100644
--- a/common/nvme
+++ b/common/nvme
@@ -26,6 +26,7 @@ nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
 NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
 nvme_target_control="${NVME_TARGET_CONTROL:-}"
 NVMET_CFS="/sys/kernel/config/nvmet/"
+NVMET_DFS="/sys/kernel/debug/nvmet/"
 nvme_trtype=${nvme_trtype:-}
 nvme_adrfam=${nvme_adrfam:-}
 

-- 
2.48.1

