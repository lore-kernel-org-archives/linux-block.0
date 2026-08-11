Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207E83DD51C;
	Tue, 11 Aug 2026 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786482216; cv=none; b=rgv+K6aAWW1n51xEmM81eSnt2cjKholSFhWvRcaH5ud1yt++3mqunYpirkQS2sXse4CTh1JouBZF51ed/bExxhik2hNIwXowu4aLFro2sLifU89h7TzdUqTRf92g4mn0Rz81yYWxjGityidOzj3FY1YS/k/QgTU+wRQPPxmUJNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786482216; c=relaxed/simple;
	bh=kvVWDTGld4E/6qeqqt5GF5frNTiyJZJx8rUPjudQdnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IQRxCiMRHjQU96i29MWViYi1lbT16xeRQ+xkw37iqzdM8otS6YJirWUsookyJVFLBEJHOj5nxV3TXcbud1W3HJUP74662esoHkHnhwJiyIL2q/uhwcbCGRaX5o6GFg2WG6dRffNGaVbjHK8mSloX1dHe3EEaCRHZi182rTpYXqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA8YwUKw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA8YwUKw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5151F000E9;
	Tue, 11 Aug 2026 21:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786482214;
	bh=A8MPMX1OsvbgkcvbeyoIR6VbMqRUTPP/gBJR7syTG1I=;
	h=From:Date:Subject:To:Cc;
	b=RA8YwUKwLtVzxas/nOCaKXec33mk1UnYTZfJHy6dQqrcUrl8ZZqUkg2jBcALLgzZS
	 gKMaacUWjzE0wSM/+yBBjftEU/gQ9H822LP40L/1sSQGN3z+8JLsp7Z1oWuUmG6cgA
	 POiM07YpEpPHwOLBZImSBPEnI67SwhOP8JWKDh0Kxh3zixmEEAsLiELlQCIVx1omxl
	 gIeuhCeMpqYbhfXA5o/vDGtpgj1+f04xe56m6498unnefl3v2cNlo+NxtZ3IThmEX2
	 MpC1sHllthoehRw8VpwzjF+s1y2k/NfxwFlesaAkASnr6YIOmJfFBwqTc1PaHPfVWT
	 22p9suY/0TOUQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 11 Aug 2026 14:03:20 -0700
Subject: [PATCH] swim3: Add missing MODULE_DESCRIPTION
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-swim3-module-description-v1-1-28398c5a0e32@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywrCMBBG4Vcps3YgSUWqryIu0uS3jtgLmd6g9
 N2NdvktztlIkQRKt2KjhFlU+i7DngoKL981YInZ5Iy7mMpa1kXakts+Th9whIYkw5gjrit4W17
 9OTpDOR8SnrL+1/fHYZ3qN8L4+9G+fwFsEOj5fAAAAA==
X-Change-ID: 20260811-swim3-module-description-b8ea139a4d20
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=nathan@kernel.org;
 h=from:subject:message-id; bh=kvVWDTGld4E/6qeqqt5GF5frNTiyJZJx8rUPjudQdnA=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFnVfapLvgudcXm4wGte2M1bDXMPpU7PFD5VlnNNTi2+7
 9bhm6UrO0pZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBErv1gZPjP1XIxMPay0U0n
 mU0COtsXc29+aj2Hw+9tyJl9e3+fcixk+B/Wt9GntfzwhNOHeD6UtorHyWgpbvFbu9n7WbLkdvu
 9lbwA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Since commit 6c6c1fc09de3 ("modpost: require a MODULE_DESCRIPTION()"),
modpost complains that swim3.ko is missing a module description.

  WARNING: modpost: drivers/block/swim3.ko: missing MODULE_DESCRIPTION()

Add one to clear up the warning.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/block/swim3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 01f7aef3fcfb..d4f0d43e0a72 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1290,4 +1290,5 @@ module_init(swim3_init)
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul Mackerras");
+MODULE_DESCRIPTION("SWIM3 floppy driver for PowerMacs");
 MODULE_ALIAS_BLOCKDEV_MAJOR(FLOPPY_MAJOR);

---
base-commit: 7e05769f1a6cd14735f1702996eb2bbb161f41b9
change-id: 20260811-swim3-module-description-b8ea139a4d20

Best regards,
--  
Cheers,
Nathan

