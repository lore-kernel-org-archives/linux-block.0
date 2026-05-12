Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831BD393DC8
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577354; cv=none; b=DuyPa9EhpQPB5qzJUt3v4k4gQP6IcHjIsGuYzrcONwQbUdaBIixZ+KMFtU3qtk5bxnz6lMl/o0N88JXkzLPPQmjWkauRmKL1jUMiBW+WvNh/DxD7gGvAHfl128V9P7L8fk3nY0S0kQOX5XlxprK+r1hp+KZir+Hkoa7s/qb5rsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577354; c=relaxed/simple;
	bh=lu8hchuaqDsIUO9hn5PRnzyxGDMSR8q2l5bEZBtlhQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jdnm7EW7PNeXpf7N4habMvWpB7Fl2B4PYvxEyVqPgRXKJNwi1dJs8DWYcecVRVl704DmFn+r1dfSjwD+y16dj963ju8+KUPIn4Xk3+9XU62MRPINZfCzfXT+uOO/Pg4jBIMsDMO2neE1saNoj7Ik/oqY2s55b1SxnnQbGHdWO4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xg/D4S7z; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xg/D4S7z"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-83ea84df1d0so861134b3a.2
        for <linux-block@vger.kernel.org>; Tue, 12 May 2026 02:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778577353; x=1779182153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rl2+33aQeJ7tiQvDxp9qWQ3PnuVQ5CvjUx7DdqBX/Z4=;
        b=Xg/D4S7zIu9V6xM59xl0YmRfvWvjxDRUThlqcxsYZfjH9gT//7Ow5Ym4sFG1bTMFhC
         UQrTG485TtRsyHMu9P+MxooSzrkLS5qwo+hrz0XBbVhKtAYV+5aGY4EGz7g8jY9qMaVh
         9yEKwU4Wesr1kiwXSmdcK516KcXal/9Ol0lPIvKSwdtdsZk2T3qnfbd4WZQnWKc02XoR
         heHolc4I8VsBLc4o+9temuSttqPme4+sxPn/bNQF4mhL9pAy68NK5AX1U4l892rdiHXV
         8L326mO1TNwp2d/LnzKT/P9YM3xNINLOgJrQTn5ffuJ+kPtN6L8SzVbgjB+lmbeIYXjW
         fWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778577353; x=1779182153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl2+33aQeJ7tiQvDxp9qWQ3PnuVQ5CvjUx7DdqBX/Z4=;
        b=L1ZMLcfz+7t7+m0Q8ojh+vY/tP0AZ+ovZTUckh7/ZMOEj2JRD1LPxtWUuOWGQLDGcD
         ch47MXZLFBl5Z09iwwuefWfZskg0HyVAovrLtP5wZ5mAE3S3IQe3Sv2rNRJLLyPP1Fsl
         5j/UAE+rtn31/R2dR5XVBRWsdC669hi4hwN+qg8bfHxT679IvmMeAYEmdXcxxeMqTQ7Z
         HF+ugOma0maaCEiOFZSDk26xU5WQmeYOkQTgvgPyjDtfjuX76eIYx4U1z7ow3awdZ5/E
         Wjf0IvLPxa4iuo7SgSwTez3ZMho0LLFqlztwad0OWMDuQueW7D91dp5cGtjmujgLf/Mz
         liEg==
X-Gm-Message-State: AOJu0Yx5k2gWb+OuQGxDBerfYeZLh1cBsmUi8F8YhFSPXaWLDERaKNZE
	0cM9JpFpzJvftq4RsAsX0GiuPhogqibr0Tqn43tHcxUHxlq42SC/MYqj
X-Gm-Gg: Acq92OE4pHBsP7k4YPq3LSW9cn+jFJXrbZbnFixS9CWn5iP/TruF2nUUyZiQlH1VpcT
	DFL6teARAika/cBESMVSfkioSqzM0LFjEk59sFafrPR3SKap0lhSdfddvBQvGirsZm6Q8o9n03N
	OrY4yRZay9CsYoNFKYdjGEnIHJkPs0JwLWPkBADxCsV8u+V82BzJEpGy68Fc7WvX4IgN3PPZLk+
	dNhaxBrI19rT/pVTz2AcCE5laUDCCN+d7xxh3/YZCtWXjqn7esuKzoGzyzU3+0qBr3hQ3JEqrfe
	ZA62h1Z55HgZI/fjs/hp9DZq/w9vpEBpiZRbu+y6MNfiAmh57k0GBfdvtdcDt7YtoQMCn1ABcl/
	FR04Mn8wV2dYIF9WwnNZ5Iv/eKg65emvmVjbW1jkS4jp1ET9QgO9jcmaq/6+WeFoP3Wz6WVlBUy
	f9ZuDqvBqGyIdhtckoHNMmmsg2dK1K8LtV7qW3EVsrpm+f5msz7vUGbjBCbAsMIDgOYA==
X-Received: by 2002:a05:6a00:278e:b0:837:e9cc:d46d with SMTP id d2e1a72fcca58-83a5e24add1mr25873987b3a.44.1778577352519;
        Tue, 12 May 2026 02:15:52 -0700 (PDT)
Received: from gmail.com ([103.172.182.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83962e7e3fcsm27815791b3a.0.2026.05.12.02.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 02:15:51 -0700 (PDT)
From: ZhengYuan Huang <gality369@gmail.com>
To: tom.leiming@gmail.com,
	axboe@kernel.dk,
	ushankar@purestorage.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	zzzccc427@gmail.com,
	ZhengYuan Huang <gality369@gmail.com>
Subject: [PATCH] ublk: clear server ownership before aborting in-flight requests
Date: Tue, 12 May 2026 17:15:28 +0800
Message-ID: <20260512091528.617022-1-gality369@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[BUG]
A stale UBLK_IO_COMMIT_AND_FETCH_REQ can reach the normal completion path
after ublk has already aborted the in-flight request, leading to a
use-after-free in map/unmap mode:

BUG: KASAN: use-after-free in ublk_copy_io_pages drivers/block/ublk_drv.c:946 [inline]
BUG: KASAN: use-after-free in ublk_copy_user_pages+0x83c/0xcc0 drivers/block/ublk_drv.c:1013
Write of size 4096 at addr ffff88800ce2a000 by task ublk.fsfuzz/275

Call Trace:
 ...
 ublk_copy_io_pages drivers/block/ublk_drv.c:946 [inline]
 ublk_copy_user_pages+0x83c/0xcc0 drivers/block/ublk_drv.c:1013
 ublk_unmap_io+0x2bb/0x350 drivers/block/ublk_drv.c:1076
 __ublk_complete_rq drivers/block/ublk_drv.c:1188 [inline]
 ublk_ch_uring_cmd_local+0x157c/0x2180 drivers/block/ublk_drv.c:2477
 ublk_ch_uring_cmd+0x42/0x640 drivers/block/ublk_drv.c:2561
 io_uring_cmd+0x26f/0x570 io_uring/uring_cmd.c:263
 __io_issue_sqe+0xc2/0x760 io_uring/io_uring.c:1826
 io_issue_sqe+0xdd/0x11e0 io_uring/io_uring.c:1849
 io_queue_sqe io_uring/io_uring.c:2076 [inline]
 io_submit_sqe io_uring/io_uring.c:2336 [inline]
 io_submit_sqes+0x806/0x2390 io_uring/io_uring.c:2449
 __do_sys_io_uring_enter+0x5c0/0x13a0 io_uring/io_uring.c:3516
 __se_sys_io_uring_enter io_uring/io_uring.c:3455 [inline]
 __x64_sys_io_uring_enter+0xe5/0x1c0 io_uring/io_uring.c:3455
 x64_sys_call+0x2419/0x26a0 arch/x86/include/generated/asm/syscalls_64.h:427
 ...

[CAUSE]
commit e63d2228ef83 ("ublk: simplify aborting ublk request") removed the
abort-only completion state and now __ublk_fail_req() fails or requeues
the request without first revoking UBLK_IO_FLAG_OWNED_BY_SRV. That leaves
the tag looking as if it is still owned by the ublk server, so a stale
COMMIT_AND_FETCH_REQ can pass the ownership check, reuse io->req, and
call __ublk_complete_rq() after the request has already been ended. In map
mode that drives ublk_unmap_io() into freed request pages.

[FIX]
Clear UBLK_IO_FLAG_OWNED_BY_SRV as soon as abort starts in
__ublk_fail_req(). Once ownership is revoked, any stale
COMMIT_AND_FETCH_REQ fails before touching io->req, so the completion path
can no longer copy into freed bio pages.

Fixes: e63d2228ef83 ("ublk: simplify aborting ublk request")
Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
---
 drivers/block/ublk_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 57ec900f0ce0..4f16a1ce7d2a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2673,6 +2673,9 @@ static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
 	WARN_ON_ONCE(!ublk_dev_support_batch_io(ub) &&
 			io->flags & UBLK_IO_FLAG_ACTIVE);
 
+	/* The ublk server no longer owns this request once abort starts. */
+	io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
+
 	if (ublk_nosrv_should_reissue_outstanding(ub))
 		blk_mq_requeue_request(req, false);
 	else {
-- 
2.43.0
