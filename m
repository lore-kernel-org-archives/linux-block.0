Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F041C68F;
	Thu, 12 Feb 2026 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770916706; cv=none; b=MbfJ0ySRUHNsJ2zD2hru+kjuXnKvfmymr4zCGKgMCrQxUX2ZzqgPMmhemjvxTogsrivwCXX0xD5E9VsUpjWCqmAea8ffA48HwXf6RILriygxFoSYzqQngE5Jb4OEA3HH5K5Elem8cmGIrEamYCwyaKGNFyoy8vXYC4FVeqnbMjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770916706; c=relaxed/simple;
	bh=UKjPidlR9/YlC/ddsZmw7c/jcFg+HNbrldewT/YjE8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IT0wfoULcZX4FzYNdixhmm2/X0gbJito6r9Ea0FFj6DctVtfU0Ku1LKZOBC8CZ+DKzmh2SNA3MYz7kJGOwl1d2UvnNzkbk0IT84gr93IFixeRGiY9vWuwnl92t6CfbfqvQVqDn7B7pDc+lH8nb5elETSDdgpPdzHz9vm12ea+wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlhLhl7M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlhLhl7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2F5C16AAE;
	Thu, 12 Feb 2026 17:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770916706;
	bh=UKjPidlR9/YlC/ddsZmw7c/jcFg+HNbrldewT/YjE8M=;
	h=From:Date:Subject:To:Cc:From;
	b=VlhLhl7MZ5VijE7ho/ecds/XjqMDQ7reWiBAJSHdQDzSz3Psyid6s26X5BQXCBEx8
	 mjAqUSrqCCfsazleyWq8xlw3puU1nMRccMM70qsxNsw8Qwo2p3z7eoOXr0B6UGJSqu
	 Ev5n95y6PVJgZlPcX9leO77BxU1odKJkxtSAI9TM8Cv+A/Oxl+a6jBLaQ/Bt6w+NxS
	 tVmPVzhWftbFxtcBgReH/ajqBhjRwzRabAK1227CteNDrcl96OU0hpRBOHEi/Fm33X
	 f5tr4NT+uESNpD6Fg4PC7ZuIt/lDfhQT/oo4urj38OAuJkfLy08+Juf1AL6MrrrFyN
	 pmfzLObZUJBhA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 12 Feb 2026 18:17:03 +0100
Subject: [PATCH] block: update docs for bio and bvec_iter
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-bvec_iter-docs-v1-1-888607db0ddc@kernel.org>
X-B4-Tracking: v=1; b=H4sIAA4LjmkC/x3MwQpAQBCA4VfZ5mxrjEJeRRK7g7mgGW1K3t3m+
 B3+/wFjFTbo3APKSUyOPaMsHIRt2lf2ErOBkGqkkvycOIxysfp4BPOB52ppCNuINeToVF7k/of
 98L4f1FHGv2AAAAA=
X-Change-ID: 20260212-bvec_iter-docs-ceb3f7208d06
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1484; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=UKjPidlR9/YlC/ddsZmw7c/jcFg+HNbrldewT/YjE8M=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpjgsVBKAMTE9xd3x0RnRRBAfygDFDqOTRp1lE8
 tw97LCm4NaJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaY4LFQAKCRDhuBo+eShj
 d/sbEACHidEClKS5/KZ3nyTRw/mU4K1v0KeI/DlLAPAfffWUUsP7561NTEPgVXzO6hPunrN23ex
 fAb0rqtkykjq3ksin4lJZp6UiT15CkUkJ1zvcX4RwBmtNy5hddVNRxGUlCT57HI7LIfjJo4GDrr
 MEBMyZU41ucqfpAO9hN0Y9cKtzTyUWngQw32QLkV1JFNQ2R8XESdhGZe3UYrhHHDUM4HplgAZHg
 rNw1A+/Sru915AcZv9i3ZeEzmpU+9AfMK4Qlur6adJcsXsFEWSaINh+vcJGVespk5l61U3JEAK5
 L0+blczOliKv/mMY0bOHEtKN2hCMoJutdMLkOSN02rZ9NIZnjgCyaAvdMpkMQ03K//rsIZNZvvP
 6N3BRS119p0+BYxH2gTSqHlDl4LcUMUZZ0in39Zbp62ExqA+rzAwiPZDh0l21IqCBy15GMXU7JN
 Amg4jV0UHkOIDaYkVqTWeoSwYYCrA+upNBUkBk8BnBlqCxPx/wUHQB19DP94qU0pM1m61V5o8DU
 sb3CsorioholWCVcy6DMGgAVogE3u5VNuXETtKoMqU4TDW++zzD+VTrvdr6fXVyUhUhku7M2w6V
 cscZV7jDGjz8i+y4TJ+J5cdAMh/VOMD37mY6OAuGnfYJPBN2cC61wVJznyrb2OgDscdX8cXroJR
 JOpY4Of2xYNFLJg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

The documentation for bio and bvec_iter refers to a vector named bvl_vec.
This does not exis. Update the documentation comment with the correct name.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 include/linux/blk_types.h | 2 +-
 include/linux/bvec.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 5dc061d318a45..10403145a4510 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -271,7 +271,7 @@ struct bio {
 	 * Everything starting with bi_max_vecs will be preserved by bio_reset()
 	 */
 
-	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
+	unsigned short		bi_max_vecs;	/* max count of bio_vec we can hold */
 
 	atomic_t		__bi_cnt;	/* pin count */
 
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 3fc0efa0825b1..a05e792e6c216 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -79,7 +79,7 @@ struct bvec_iter {
 						   sectors */
 	unsigned int		bi_size;	/* residual I/O count */
 
-	unsigned int		bi_idx;		/* current index into bvl_vec */
+	unsigned int		bi_idx;		/* current index into bi_io_vec */
 
 	unsigned int            bi_bvec_done;	/* number of bytes completed in
 						   current bvec */

---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260212-bvec_iter-docs-ceb3f7208d06

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


