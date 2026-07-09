Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388673BED06
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591739; cv=none; b=mRlbmk8EQ5pftd4yi1jxRSq+5y8u2cLqbR+5p+p/ShzEbgPPzN3IKSjpzqkYu8/5igr5FYqB5J+r9auTk8WgVZdDxF7SEzrcETco5cWDBmaXEs+5nv++NpkLr8Rn11VA46lyR8oeHiHYYzKLzBITgcuKaPP3bYocH2xkya5wDCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591739; c=relaxed/simple;
	bh=7Qq5DbnLoYr/W1fIrmxtolNL3bgS+VtLSb8S0g3pu9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aMvLr0c4zLTdkB3cZBXotfceX0sywrvVcm+TAAbUSe1wiQ1xxbNn5fh19I5NWbrAK9qYRbXjl+nyO2NoNCXpz+b+L6stpS98pLv3zhrd2q+gJTDU+7HNRbp1mulJfQ9O/PXiuoVkQJVmEJuExDrLRCvczA5VjFvyF2rnjOqrTF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=0G2XNAv8; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="0G2XNAv8"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-470174001a0so955218f8f.0
        for <linux-block@vger.kernel.org>; Thu, 09 Jul 2026 03:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783591737; x=1784196537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R38Rncr/E+UsAEWrPcumXybq6cXHOZxrmRPFJ81xA0g=;
        b=0G2XNAv8YUWZjRYWVQUAhDhyFhdWVA10nbf2zXbuBkTKPj72xwdpjWVGQLmK4EkL24
         VmfypAEL3SR1/9j+UxLY0JAz5BhngsVbi2PAYe/foVaR5p9klYf8xp8wRf9lPS8Vfwqv
         ISjw1azVXbfVVPfVcYKgA/c0vzu/oirAMLFZA9ABvyu3EgTOCRX8+TFbmEYxCuh68g6v
         7DeglNtnYOt/eNzCYJfq7oC8Npxf2qcbQRBz23dOCif1GH2D7lrTT0nQBHm6O8n3eUM8
         +3oMTpIG6IGcfSFpL1Q/CZcZuDzxgqt99DTRGrKdD5oONjPNZugqoXNoby8Mlu4QqE5w
         2aaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783591737; x=1784196537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R38Rncr/E+UsAEWrPcumXybq6cXHOZxrmRPFJ81xA0g=;
        b=D/zkGHvNKa+zZQF90eITCZIwhGPtlL3QI8iANRQNBxs3lq0KAzRHI1cPNQMXv7Go4B
         eET4UaDLC3KoT3hRXU0pEtcLzMOks7Tj6Wkto4R8aihmaZSVWLTxkNNhShfhFASTYZy3
         B5QvZ5AiJ7GAmnNAjU0vBWhx6sPmJGkj1RUy85a4s4tB7NdHI444WD4EVfp+AF6mIvEH
         GPHLvhAX4k2K6BCOrRUGP7pj6SuMjyIDTibIcd4ln4qWvvvnzBzb0hKHZb4OBijFtGla
         Hk43QtIXX887ZrnBPkPDvm/9hWBoGE/LwdeQiaOlydqWDILgFc+0KaUKzCoWUW/DFSWs
         wEnw==
X-Forwarded-Encrypted: i=1; AHgh+Rr1QlcwJSFdg50Bj2UVMx9b+vsWOGh6mzpPwaMUdpJRfmmHOdLJ72wvBHvSSOJak0ZE8GaDrLf2i57wEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFh1ZF9GC9CcjJ2Re3YkI56Ay+kwS6IrOFoo4NiQGRpr/LpLpb
	W0wUhTGhqMRVcla2fcptkfLyVpzEeKlbrw3cIVm1YCtWwMVsWe8Vcn11sDn0vJiC54Lo
X-Gm-Gg: AfdE7cl6R7/0Or/Gtd4/5gtRK22GXANAXO835qVpWdRlKZpOgPmFU6CfymVV9Ipl3uW
	GFJnhRp5cYVVB+tVEVBmiRHLD94u3VOpGB4rPRbeiKOlKzT0z/uGcd+mFTPSiDgV70U44gsr865
	0HZGNJHP9snReCrK8R38ZHnq9MsviU+vKDxaAHmng48oWfYq3XCsY4gQopnnYOC20tOnlu+ZtAf
	5hZb46Q0hA25yAxeTfDtNO+9qkRq0ZmxaggWcQ+fj2VI0g/asYd86ubr8JniOsOtT/NeRuaNCXX
	ohW8XiasSIJy9YQK9iCZ72af18Io5TBFL/HYGGc5s6uT+5PNOgf4qR8ZfP4bXGwP/BfRUdaYoKG
	zlmLEhVW24RuYB6GG8mpKqnbBtKPhQQ23UKkTo0iBAk0qahcytapKf53OC4BY2Jc0ArYMniVvqs
	9jQtEvIXI3wrvysFdhB3I/zgUYQNx+kCO23eVM6FfcY/hwIOcSOb15tVRW+bYzNFdAUsFj4m2yC
	U4SjIm/R5kZeC4XZZA3FHnIWqo81g7Jqys=
X-Received: by 2002:a5d:59c5:0:b0:475:f0f0:9ec8 with SMTP id ffacd0b85a97d-47df0813a82mr7441246f8f.51.1783591736321;
        Thu, 09 Jul 2026 03:08:56 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa09608d4sm51513868f8f.25.2026.07.09.03.08.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Jul 2026 03:08:55 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jens Axboe <axboe@kernel.dk>,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH v2] xen-blkfront: fix double completion of split requests on resume
Date: Thu,  9 Jul 2026 12:08:53 +0200
Message-ID: <20260709100853.7489-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a block request is too large for a single ring entry and the
backend does not support indirect descriptors, blkfront splits it across
two ring requests. This only happens when the frontend runs on a
64K-page kernel (e.g. arm64): there, even a single-page request may not
fit in one ring slot and must be split. blkif_ring_get_request() is
called twice and both shadow slots (shadow[id] and shadow[extra_id])
point at the *same* struct request, linked through associated_id.

blkif_completion() collapses the pair on the normal completion path,
recycling the second slot and completing the request once. The
suspend/resume walk in blkfront_resume() does not: it visits every
shadow slot with ->request set and calls blk_mq_end_request() or
re-queues ->request. For an in-flight split request it therefore
processes the shared struct request twice on resume/migration -- a
double completion.

Skip the secondary slot of a split request in the resume walk so each
logical request is processed exactly once. The secondary slot is the
linked one (associated_id != NO_ASSOCIATED_ID) that carries no
scatter-gather list (num_sg == 0); the first slot always keeps the sg
list. The bug is only reachable on suspend/resume or live migration of
such a guest, so it has no local reproducer.

Fixes: 6cc568339047 ("xen/blkfront: Handle non-indirect grant with 64KB pages")
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/block/xen-blkfront.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index f765970578f9..8dad7bf5f664 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2079,6 +2079,15 @@ static int blkfront_resume(struct xenbus_device *dev)
 			if (!shadow[j].request)
 				continue;
 
+			/*
+			 * For requests split across multiple slots, process the
+			 * underlying request only once: skip the linked, sg-less
+			 * secondary slot.
+			 */
+			if (shadow[j].associated_id != NO_ASSOCIATED_ID &&
+			    shadow[j].num_sg == 0)
+				continue;
+
 			/*
 			 * Get the bios in the request so we can re-queue them.
 			 */
-- 
2.43.0

