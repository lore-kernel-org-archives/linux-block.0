Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82641757FC;
	Tue, 30 Jul 2024 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343346; cv=none; b=TefX+Kaw2uBc6WGSUyJO9v4k0yBhHSUgEzF13pkojLyjWOXBAc86XyjR7P1e/56QTcjb/Fh7KcgXQZm3qjDpPDp+dQcTNnHst1bpQFg1EReyjEhwcqGdgKQjaglSaSOONgpkEMKFLrJ7czpgcvUdza8QMOYP/xEFDCC8oBr8KQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343346; c=relaxed/simple;
	bh=OX7gXcQNPCvmHTvgcG7NfG9PhoIqqO3oQ/laTGMlWFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDO2Uqj6eFd5wGRAnS2aclHV9chNVcA1qala+Abp+A+rU2l1OhfWEvC3w6wjE3fTA335iVrmHvwoqHNJoP57jz4yfZ56Qyw0Nbr+pVvvv4WgCEt0N85m+97l5SQkrkkVN5qQ8R2r+m6tk/k7/IA6hZXLWuTzRRwhQtgbLhyoClE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCi8btfp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCi8btfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0829AC32782;
	Tue, 30 Jul 2024 12:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343345;
	bh=OX7gXcQNPCvmHTvgcG7NfG9PhoIqqO3oQ/laTGMlWFI=;
	h=From:To:Cc:Subject:Date:From;
	b=iCi8btfpZmMmoNrYlDrhSuGluxOfeClACuaAEioHJd07u4DcnQSLQxyGKGDzcmoob
	 cSSRdLIJ9XrrrAcIJ38g5dXEHSUrtMHdD+KTDQpJFA9c279uvgghBezBlG5b+k9cWR
	 QUhwsuVOxKQSC5xn32N+8kqoylRqv+QLaypFrwQVsI/ZlZaEvczptnFBQHgo4X8dLq
	 eVF537Dvgpbqvs4EVFwHBBJlLXX1PKJeKqqVLSSXG04J1C1SsCUlWe7sc7/9/7pjcs
	 afzX+3xWEkIOeg3XhkMDp7rHkakoqCk7V3p2xkB4VmrhJDezxCINatcN++q14xs36T
	 GacQGIKC32K8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 1/3] block: don't call bio_uninit from bio_endio
Date: Tue, 30 Jul 2024 08:42:19 -0400
Message-ID: <20240730124222.3083443-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit bf4c89fc8797f5c0964a0c3d561fbe7e8483b62f ]

Commit b222dd2fdd53 ("block: call bio_uninit in bio_endio") added a call
to bio_uninit in bio_endio to work around callers that use bio_init but
fail to call bio_uninit after they are done to release the resources.
While this is an abuse of the bio_init API we still have quite a few of
those left.  But this early uninit causes a problem for integrity data,
as at least some users need the bio_integrity_payload.  Right now the
only one is the NVMe passthrough which archives this by adding a special
case to skip the freeing if the BIP_INTEGRITY_USER flag is set.

Sort this out by only putting bi_blkg in bio_endio as that is the cause
of the actual leaks - the few users of the crypto context and integrity
data all properly call bio_uninit, usually through bio_put for
dynamically allocated bios.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Link: https://lore.kernel.org/r/20240702151047.1746127-4-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index e9e809a63c597..c7a4bc05c43e7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1630,8 +1630,18 @@ void bio_endio(struct bio *bio)
 		goto again;
 	}
 
-	/* release cgroup info */
-	bio_uninit(bio);
+#ifdef CONFIG_BLK_CGROUP
+	/*
+	 * Release cgroup info.  We shouldn't have to do this here, but quite
+	 * a few callers of bio_init fail to call bio_uninit, so we cover up
+	 * for that here at least for now.
+	 */
+	if (bio->bi_blkg) {
+		blkg_put(bio->bi_blkg);
+		bio->bi_blkg = NULL;
+	}
+#endif
+
 	if (bio->bi_end_io)
 		bio->bi_end_io(bio);
 }
-- 
2.43.0

