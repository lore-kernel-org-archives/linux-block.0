Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE9C5158AF;
	Tue, 29 Sep 2026 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790680706; cv=none; b=s1wwDLzdt6yX1MMTmMHFO06bquLp+znrIFQdKoJ9qgwFMHsQwQKQUw06WXe50ZFDS5et4Ak+hUw6NRoA6YjKTlGmXbrwBizvujGsjeHgoj17N7Br+AQt30uM8FPMU3TZywILahgGSdpXog659BT7HU+1xeOi1jTK1P4NElzRp8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790680706; c=relaxed/simple;
	bh=NGEx9KxbAfZBzoylEeZ0yrXje9UJXbfmebRwDKtF7R4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aNfu3Ldc8gjzQLdoxQFafjbKoO3wr+COIdjFlhiMU/Db98+LLzpVuNR1Nq+VEbAmA8vzimR1+OTcOpwYi+JohEERzp8Wr3+zPx82OG4oOlQsQ50ZV2AQrEBfXla/mKlMU+enUVtZAmiD+Aumek4U2WflHpinqD/UrokctMQUFfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIICU700; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIICU700"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7EC1F000FF;
	Tue, 29 Sep 2026 11:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790680704;
	bh=3hG7gAnNiiTfsBSi2PGyaiacLDUHRJtGARhFUalygOs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fIICU7005CFwRCBHi+lbdhnYaq4FPkr7yodrR2h1Ov3FQ1tTPttGNJthpWsDtbqAV
	 tjJEdM69F78T4NtCb40lKRwDl1ZdZqrh0LNrfzzSIJSIgU8SdIQp5y5m63QpgXsUE9
	 Dv1SgNC4Qa1hV7PXnw5BRO1HSeWC+AcHY+bpkXPNbhaiJoXZhZ1zzj/QckUGVLkT+d
	 cP6ffDA1hJJBShkgHNjFcjmmP8P7Af9nBcuwz1HeKVvRkkEo3w8PfSVt7CbYIw69ml
	 7r65Wr8T0BTrOI4+DLQ8wNn0Mg6xykBDf/uBzOtIQJDF9MnuTQ5isjy5X47uC5P8i0
	 Vc1q0FddD+TYw==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Tue, 29 Sep 2026 13:17:12 +0200
Subject: [PATCH RFC 2/2] nvme: enable multiple atomicity mode
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-nvme-mam-v1-2-48dcbe79cece@samsung.com>
References: <20260929-nvme-mam-v1-0-48dcbe79cece@samsung.com>
In-Reply-To: <20260929-nvme-mam-v1-0-48dcbe79cece@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Andres Freund <andres@anarazel.de>, 
 Pankaj Raghav <pankaj.raghav@linux.dev>, Daniel Gomez <da.gomez@kernel.org>, 
 GOST <gost.dev@samsung.com>, Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790680695; l=2913;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=ICRR4ZKLi0xfq5AAqBpnEFS2ZLtGWi6BUEH3zlKIjXE=;
 b=9tJ3uoVXscekgfB3b6UA8dq41RLoQfrI0/xg+EWMtki8SacbsnO9trRjqEpS4OJcgncF5ZYPa
 46MWafMb8OgDYulq33E244oD5iSzyKs32nlvOozBr3p0oRDA7s8H25S
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=

From: Daniel Gomez <da.gomez@samsung.com>

Add support for Multiple Atomicity Mode (MAM), a superset of Single
Atomicity Mode (SAM) where the controller divides a write command that
crosses the atomic boundaries into per-window atomic writes. Honoring
the mode lets contiguous atomic writes merge past the atomic unit
limits.

Set BLK_FEAT_ATOMIC_WRITE_MULTI when the namespace reports MAM and its
atomic parameters are compliant; otherwise fall back to SAM. Re-derive
the flag on every rescan, and skip the single-write unit_max and
boundary checks because a merged atomic carrier can exceed both.

Assisted-by: LLM
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 drivers/nvme/host/core.c | 23 +++++++++++++++++++++++
 include/linux/nvme.h     |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9bcab3dc4c118..69a565ac0da97 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -993,6 +993,9 @@ static bool nvme_valid_atomic_write(struct request *req)
 	struct request_queue *q = req->q;
 	u32 boundary_bytes = queue_atomic_write_boundary_bytes(q);
 
+	if (q->limits.features & BLK_FEAT_ATOMIC_WRITE_MULTI)
+		return true;
+
 	if (blk_rq_bytes(req) > queue_atomic_write_unit_max_bytes(q))
 		return false;
 
@@ -2038,12 +2041,24 @@ static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
 	}
 }
 
+static bool nvme_mam_compliant(struct nvme_id_ns *id)
+{
+	if (id->nabspf != id->nawupf)
+		return false;
+	if (id->nabsn && id->nabsn != id->nabspf)
+		return false;
+	if (id->nawun && id->nawun != id->nawupf)
+		return false;
+	return true;
+}
 
 static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
 		struct nvme_id_ns *id, struct queue_limits *lim, u32 bs)
 {
 	u32 atomic_bs, boundary = 0;
 
+	lim->features &= ~BLK_FEAT_ATOMIC_WRITE_MULTI;
+
 	/*
 	 * We do not support an offset for the atomic boundaries.
 	 */
@@ -2057,6 +2072,14 @@ static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
 		atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
 		if (id->nabspf)
 			boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
+
+		if (id->nsfeat & NVME_NS_FEAT_MAM) {
+			if (nvme_mam_compliant(id))
+				lim->features |= BLK_FEAT_ATOMIC_WRITE_MULTI;
+			else
+				dev_warn_once(ns->ctrl->device,
+					"Inconsistent MAM parameters, ignoring\n");
+		}
 	} else {
 		if (ns->ctrl->awupf)
 			dev_info_once(ns->ctrl->device,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 91ce434a7e8d9..8fdc4b91cf906 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -602,6 +602,7 @@ enum {
 	NVME_NS_FEAT_OPTPERF_MASK = 0x1,
 	/* Since version 2.1, OPTPERF is bits 4 and 5 of NSFEAT */
 	NVME_NS_FEAT_OPTPERF_MASK_2_1 = 0x3,
+	NVME_NS_FEAT_MAM	= 1 << 6,
 	NVME_NS_ATTR_RO		= 1 << 0,
 	NVME_NS_FLBAS_LBA_MASK	= 0xf,
 	NVME_NS_FLBAS_LBA_UMASK	= 0x60,

-- 
2.55.0

