Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90551A9F90;
	Mon,  2 Mar 2026 02:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772419873; cv=none; b=Il4iXyZMcM7EMBGayK+Hq3PwGM/reGtJdcJH4RGsMg4iivWt4E9lK2l3uhFBt+jQJMuoJTvgwgJzyufGCl6CRTKGwwqYgndy5TiFe/5dCD7hiqGD2X6AYOKLrYyHu/cIDZAsi8V3XUM60oaX3Awdks2LAC0w408OTYAXzCnZtUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772419873; c=relaxed/simple;
	bh=XYjomkr0dTgWjwPjF8o60Bhsgl0frYza1cTvZQthwv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZR1LE7uFzR3LLA226gXH3RPHyzCxuWlsgtaLaF2iY9Ro9na8CFvXtVrBinFyFbkYcuuhdbniUO/IPdtNWBqzoxvwRY2r5sAGVBXrbkhcdS40Q50qek7LqPuusoEcwFhYmUaLG7K8WAg4RFiHRIAiIlivrCM+ZXSRWwEtlQUNC6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOShjZZv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOShjZZv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78429C116C6;
	Mon,  2 Mar 2026 02:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772419872;
	bh=XYjomkr0dTgWjwPjF8o60Bhsgl0frYza1cTvZQthwv8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=OOShjZZvAFifyg0sFjaestiRUxm0YP4LTQ0++TB0MZjeQW25/XjiEQPJAECHA50/w
	 rMbi2OuitMfVCxsgqOoJHeKRPM0HfYCqcbD2nPg9uYQ/TS9mH12DKYQh68XAD9h559
	 JzBSGWw66LBFJs0eW3nedi3TIR/sHtefgSdRPzvlTDbsObHiI4mVTg6jUeqzLPbNPg
	 F9WgBInQ9hNRw3pGrML451x4i1qarqHDB9CE9QhYuoqCXICXQS+yBFvVLcuzoIPg/u
	 iTD5/f5Zz057eAUG+y3J4QN5k+bvvWZxv9l03SbHoQUlDFDqFavGE6PztOiQrrSoiU
	 PlLfbyTXmkaUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAB7D58E4A;
	Mon,  2 Mar 2026 02:51:12 +0000 (UTC)
From: Jiucheng Xu via B4 Relay <devnull+jiucheng.xu.amlogic.com@kernel.org>
Date: Mon, 02 Mar 2026 10:51:03 +0800
Subject: [PATCH] block: avoild hang when bio_list is non-NULL in
 submit_bio_wait()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-for-next-v1-1-eb9339e8dc99@amlogic.com>
X-B4-Tracking: v=1; b=H4sIABb7pGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyMT3bT8It281IoS3ZQ0szQDo2RjM0uTFCWg8oKi1LTMCrBR0bG1tQA
 I0PQ8WgAAAA==
X-Change-ID: 20260224-for-next-df6f02c3694d
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 jianxin.pan@amlogic.com, tuan.zhang@amlogic.com, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772419870; l=1659;
 i=jiucheng.xu@amlogic.com; s=20250821; h=from:subject:message-id;
 bh=umq++sfYBrcQgzncaR6KD4RDdLQo6hXzgnvNht92JHc=;
 b=X4RjgRRm6Nf1/IzXU5/a0BXUn8bhim1Iv+n8TXxQpemJztwPBKYqS1YR+PYAsHBQI8wb+Ky9E
 e7RVwpTFwg8CPn//V6Q8dE0FjNN2kt+krfZ6ZZLFPp9hSxEcEzWQ9zw
X-Developer-Key: i=jiucheng.xu@amlogic.com; a=ed25519;
 pk=Q18IjkdWCCuncSplyu+dYqIrm+n42glvoLFJTQqpb2o=
X-Endpoint-Received: by B4 Relay for jiucheng.xu@amlogic.com/20250821 with
 auth_id=498
X-Original-From: Jiucheng Xu <jiucheng.xu@amlogic.com>
Reply-To: jiucheng.xu@amlogic.com

From: Jiucheng Xu <jiucheng.xu@amlogic.com>

When current->bio_list is non-NULL in submit_bio_wait(),
submit_bio_noacct_nocheck appends bio to bio_list but skips IO
submission, causing submit_bio_wait() to hang indefinitely.

Fix this by temporarily backup bio_list, setting bio_list to
NULL before calling submit_bio(), then restoring bio_list
after submit_bio() returns.

I've trimmed down the call stack, as follows:

f2fs_submit_read_io
  submit_bio
    mmc_blk_mq_recovery
      z_erofs_endio
        vm_map_ram
          __pte_alloc_kernel
            __alloc_pages_direct_reclaim
              shrink_folio_list
                __swap_writepage
                  submit_bio_wait  hang!!!

Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
---
 block/bio.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d80d5d26804e32944bcfe4506ca190033308844f..22c8769722cc89620c239310a0f3d4924de68cf9 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1505,8 +1505,17 @@ int submit_bio_wait(struct bio *bio)
 	bio->bi_private = &done;
 	bio->bi_end_io = submit_bio_wait_endio;
 	bio->bi_opf |= REQ_SYNC;
-	submit_bio(bio);
-	blk_wait_io(&done);
+	if (!current->bio_list) {
+		submit_bio(bio);
+		blk_wait_io(&done);
+	} else {
+		struct bio_list *tmp = current->bio_list;
+
+		current->bio_list = NULL;
+		submit_bio(bio);
+		blk_wait_io(&done);
+		current->bio_list = tmp;
+	}
 
 	return blk_status_to_errno(bio->bi_status);
 }

---
base-commit: 8c5f40a3ba43ae9a26991f0e4a01a3a06e8958fc
change-id: 20260224-for-next-df6f02c3694d

Best regards,
-- 
Jiucheng Xu <jiucheng.xu@amlogic.com>


