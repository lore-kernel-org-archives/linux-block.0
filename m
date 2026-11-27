Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795751043;
	b=jdhhcoCVRe6ssCDDLlP79ws/ljSmUdEWSXbM6ahiLmsIYQZ03KH7X0H/N/leZXEp2voS
	 LYPy+CpCjOLH/4h62trtiU9wGtm6Oqs/p3npRwPYTqbTC1uxVeAWBY2sORg6KCcBpfIVE
	 NMfUgjanPeFeSK8sLk0WELXtd/EdwWB4u0A1xc9St0lvD38D6o3aojrYIzS4o2x4sMGpL
	 b3L8KaG1cj6FeAIqC7D2QwswJwstFvDj/il+wsYJmFv72fBQUMU+OeA2zQrZ2/AD6gTCX
	 KhElV/YF/H4CjZ0Jgs8vKL8YupuZDX99+z8gJDLJBdeftnSJlQpOPcsGsjN6uQGMSxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795751043;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer;
	bh=IznVA0eFcJsWhjSMeqWoDYFtc1KjUFt1FtjhDGbT/OE=;
	b=tB2mPDODSTzVpiVW3xfTyS7Cjo1FGW+w2+GW58XcDWelbw6Q9zPFgB4I1GoSnB8VNYQ/
	 H8vepQMuHpNH9i0JyoulBRyJlKu+jUlHeleuJIk8o9n5At8ZzatdeZ9lPYfFb1zJOEhWt
	 joe8zQe8CPopEhdR/yZFUgK93W5FEo33+WwBcwSCrKS+n2nrS/EdrUMF45DGrkWRDWzN1
	 iYOxRJF0kAEnWqNcukkrRQsfWKfJ9nE1EWiP9bGI49jZBkGvJ+Z4NCN/FnEtmDiM2tVC+
	 /Adi5/xgXEJPiBAF0ShCyDegU7Li2izLBkGgu3/1bvjViKB2M7pp9Oo/U4Xil88oH7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w1d6w+jT;
	arc=none smtp.remote-ip=95.215.58.33
Received: from mta1.migadu.com (out-33.mta1.migadu.com [95.215.58.33])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A20606A323
	for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 03:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46A20606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w1d6w+jT
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8qcdPhfHbBr/yGpf6hhMm98EAWA3UvDYG4L/YL0AuL0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795751040; v=1; x=1796355840;
 b=w1d6w+jTbx7N4GfpE5EDurv6gpx+JA+VFPq28sZ3LimYtCDrdeYwqRF2ziTJKbtBMbwbBLGG
 YGhnMu9hnb6rrJnhORtfIcOF7Lk/1LNYE5hNIRDgaafyAwoF2CIE72itmJ86hOMEZQHVmNUFXht
 SZmNm/2IFGAlGbYpt8razlhU=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c65825dab8d703af;
	Fri, 27 Nov 2026 03:44:00 +0000
X-Mizu-Trace-ID: c65825dab8d703af
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Subject: [PATCH v4 0/2] block: skip rcu_barrier() when releasing zoned
 disks
Date: Thu, 26 Nov 2026 22:43:49 -0500
Message-Id: <20261126-feat-blk-zoned-rcu-barrier-v4-0-a4ab1d2162e0@linux.dev>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHX8CGsC/33OQQ6CMBCF4auYrh3TDm1RV97DuGjLII0GTIEGJ
 dzdQmJCXLD8Z/G9GVlLwVPLzruRBYq+9U2dQu53zFWmvhP4IjVDjloI5FCS6cA+H/BpaioguB6
 sCckI4OyJS0k6NzZjCXgFKv2w4Ndb6sq3XRPey1YU8/XHii02ChCQa33MlVWoLF2evu6HQ0GRz
 WzENSU3KUyULhAFGnl0yv1T2ZpSm1Q2f8XzUitriCuzpqZp+gJezG4rWgEAAA==
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0

Releasing a zoned disk calls rcu_barrier() before destroying its zone
write plug mempool, which waits for every RCU callback in the system.
Patch 1 calls it only when plugs of the disk still wait for RCU
freeing. Patch 2 frees the plugs left in the hash table directly, so
disks with partially written zones skip the wait as well.

Removing 32 zoned null_blk devices goes from 848 to 428 ms (-50%), and
from 865 to 433 ms (-50%) with four partially written zones on each.

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
V3 -> V4:
- Call rcu_barrier() only when plugs of the disk wait for RCU freeing,
  instead of wait_var_event(), which did not flush lazy RCU callbacks
  (Bart Van Assche)
- Add patch 2 to free the plugs left in the hash table directly at disk
  release (Bart Van Assche)
- Drop the Reviewed-by of Damien Le Moal from patch 1, the wait changed

V2 -> V3:
- Initialize nr_zone_wplugs_freeing in disk_init_zone_resources() (Damien Le Moal)

V1 -> V2:
- Keep the original comment above the wait (Damien Le Moal)
- Add Reviewed-by (Damien Le Moal)

v3: https://lore.kernel.org/r/20261125-feat-blk-zoned-rcu-barrier-v3-1-707f65bae05a@linux.dev
v2: https://lore.kernel.org/r/20261124-feat-blk-zoned-rcu-barrier-v2-1-6d2212a48c5c@linux.dev
v1: https://lore.kernel.org/r/20261121-feat-blk-zoned-rcu-barrier-v1-1-766875b525be@linux.dev

---
Qiliang Yuan (2):
      block: don't wait for all RCU callbacks when freeing zone write plugs
      block: free remaining zone write plugs directly on disk release

 block/blk-zoned.c      | 29 +++++++++++++++++++++++------
 include/linux/blkdev.h |  1 +
 2 files changed, 24 insertions(+), 6 deletions(-)
---
base-commit: 5f22fb20497f4983094131f00a734362300d22d2
change-id: 20261120-feat-blk-zoned-rcu-barrier-cb9044e67ab3

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>

