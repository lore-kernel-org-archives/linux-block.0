Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156E817A31E;
	Sat, 14 Feb 2026 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771060403; cv=none; b=QSzRuZ0e+DDCuXhHlcsTTDK2DH236yGFkvi1hqvcb0ewXVFMJm+8gX2w8Fwm3z0y92SUjs0tZFQqAWZGKN8lo0iY+Xk5q80uKBYyAIkz30631NXE1MthE9ztxyAyRQxh9KWDgMEgtUiJn2uvQx9p6mukXIOxbH8s0jKTiM55B/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771060403; c=relaxed/simple;
	bh=nTL06P+CPxRocA/4tOtEGg45F/CtcVK1YdQ0CMK757Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h+JCLNFA2pxh0A+hPygneBGUnmk0vdRULonEtT7Y6Cl19ibUv0+pFaTCnbh/h30UxkKnN5A/1Af9oas9eN3HRi/GrtOUky2BxeIv+cfDKVXeY31X1cUWuhxqKkGeu6d9t1U5SV2xvaOVlUOocZ7tbyQQUirAku2gfybsxDUSzpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0j9ehRr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0j9ehRr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E57C16AAE;
	Sat, 14 Feb 2026 09:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771060402;
	bh=nTL06P+CPxRocA/4tOtEGg45F/CtcVK1YdQ0CMK757Y=;
	h=From:Date:Subject:To:Cc:From;
	b=F0j9ehRr/Ci67KDf5pLm0uB80iTZASaZKF4t9swRhIqrpCC1iIwQfZ9AvypNLKYNu
	 IQalhYh3R6X2Q/4oPZjPhUfWHFdgyip4TNQybyWADJAtLwTKqfzHOo7yDfyfsgPV6H
	 c+YdWrQj1TU2Eq+6oJsNw7+njCBzWITe/U5SB/+r1wmEjoDYmLDVvge2QKzENcgPor
	 tv+iuQTYO6tmuPo5bw5rOPby/v3LlhsLzRvVy3SXysvinnUczn25W+mxrPSsqNnNVG
	 yunoRH2MAOR8JzQ4rsKbZemH5hC8P35UAlFZ164Dj67avrE5SNpCPnknrpGjpGZ1lr
	 KfLoztYQkQVUw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Sat, 14 Feb 2026 10:12:54 +0100
Subject: [PATCH v2] block: update docs for bio and bvec_iter
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260214-bvec_iter-docs-v2-1-1c82ee5900aa@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJU8kGkC/3XMQQrCMBCF4auUWRtJRmiDK+8hRUwybQclkUkJS
 sndjd27/B+8b4NMwpTh3G0gVDhzii3w0IFf7nEmxaE1oMZeo0HlCvkbryQqJJ+VJ3eaBtQ26B7
 a6SU08XsHr2PrhfOa5LP7xfzWv1Qxyihrba+H4HQI/vIgifQ8JplhrLV+AWBdeZetAAAA
X-Change-ID: 20260212-bvec_iter-docs-ceb3f7208d06
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>, 
 Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2901; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=nTL06P+CPxRocA/4tOtEGg45F/CtcVK1YdQ0CMK757Y=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpkDyYc7/pJg/ppBeUVu60QGflv9ijurHJ6dnp3
 xfltkT3//iJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZA8mAAKCRDhuBo+eShj
 d/acEACYDQv1USmztkMDcK1hgsJlT5KjuGbqN5LFFSG3+q7RzNFSV4U2+9DwaQUUbA3cL9XB5Qm
 KMY5+U1p0lnPYX01oe0yHe0j8tj2+7waAAPTVvL2cyTbL1sthD1VxXp3435bixfqW1vE/Lm1aV7
 yTquBtmM3+hg0/kJgwcIp2ZXqi3Eq2o7fLzKikPCWILR3+Xhd4gc0mrPxMJmYY0bpKlNm2f1HdZ
 6G6D02KVu30AM44e7Y5qtJYeILPRE/vq+kZZTUZcQnh2KySE6UccUtYfffDBBikj1xTe/Fpq1mN
 +IZFEFA5wnjhNnoHBx0CFCDdSAg5tIZWU3UViM3HiRo5WgOb67nOEwHPdULhA1ZpdYVrIRshvTf
 oOA7QIquZoKZ8MpWTOhhpWdw8AyfE7UfySjziuAVeYeWlTCfuPIJ9kCfPUSqNnxbQkfGNOjUhrD
 8CZXcxtss5UlZ3+v4v3TADESALDVmeKHWg8wIfWuk/bd5HEE+1O92ourPo/XhXOM9X76xHxsGpa
 APjKfVGFyP6Hz9oIigith0VtmhpPfpeO/u52z9Jhet8s4NHVs/A3yXv0Dldwk3E8PrSsqpfzIDr
 sZePykdk7oAwnuPqVlKDfwlxg0aJ+H5rKt+aKef0ZW7R1RoLdae/o0oMXUCwTVxNK7REMdIyu8s
 gXXqFcZs2zfFlpg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

The documentation for bio and bvec_iter refers to a vector named bvl_vec.
This does not exist. Update the documentation comment with correct use.

Also update documentation comments for remaining fields of `bvec_iter` to
improve readability.

The fields of `bvec_iter` is using a mix of tabs and spaces for
indentation. While at it, change them all to tabs, which is most prevalent
in this struct definition.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Changes in v2:
- Update documentation changes with input from Christoph.
- Change indentation of `bvec_iter`.
- Link to v1: https://msgid.link/20260212-bvec_iter-docs-v1-1-888607db0ddc@kernel.org
---
 include/linux/blk_types.h |  8 +++++++-
 include/linux/bvec.h      | 29 +++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 5dc061d318a45..261a692b10351 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -271,7 +271,13 @@ struct bio {
 	 * Everything starting with bi_max_vecs will be preserved by bio_reset()
 	 */
 
-	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
+	/*
+	 * Number of elements in `bi_io_vec` that were allocated for this bio.
+	 * Only used by the bio submitter to make `bio_add_page` fail once full
+	 * and to free the `bi_io_vec` allocation. Must not be used in drivers
+	 * and does not hold a useful value for cloned bios.
+	 */
+	unsigned short		bi_max_vecs;
 
 	atomic_t		__bi_cnt;	/* pin count */
 
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 3fc0efa0825b1..06fb60471aaf1 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -75,14 +75,27 @@ static inline void bvec_set_virt(struct bio_vec *bv, void *vaddr,
 }
 
 struct bvec_iter {
-	sector_t		bi_sector;	/* device address in 512 byte
-						   sectors */
-	unsigned int		bi_size;	/* residual I/O count */
-
-	unsigned int		bi_idx;		/* current index into bvl_vec */
-
-	unsigned int            bi_bvec_done;	/* number of bytes completed in
-						   current bvec */
+	/*
+	 * Current device address in 512 byte sectors. Only updated by the bio
+	 * iter wrappers and not the bvec iterator helpers themselves.
+	 */
+	sector_t		bi_sector;
+
+	/*
+	 * Remaining size in bytes.
+	 */
+	unsigned int		bi_size;
+
+	/*
+	 * Current index into the bvec array. This indexes into `bi_io_vec` when
+	 * iterating a bvec array that is part of a `bio`.
+	 */
+	unsigned int		bi_idx;
+
+	/*
+	 * Current offset in the bvec entry pointed to by `bi_idx`.
+	 */
+	unsigned int		bi_bvec_done;
 } __packed __aligned(4);
 
 struct bvec_iter_all {

---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260212-bvec_iter-docs-ceb3f7208d06

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


