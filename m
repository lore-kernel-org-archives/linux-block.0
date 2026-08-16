Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5567742050
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786886140; cv=none; b=nc7T699CqGkbFlUX83FI2Z+b7SdBhMUebSNqBQ8He7tQiU5g4wUNyHqveiHyNnLBAMXRAEWrmBAjmbQrfGyvx78OQp00XzJ33D9I/vAJtDNnn1F3WbZAVeh1NdFEF/pnYCCNeDCt1vP9BCzj+nrA8Ziydnm6Y1yuPC9ePCPw7nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786886140; c=relaxed/simple;
	bh=BXac47jawx3iX5KRiX+sl0th2Nct+GIA+FieEpjeq6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dsGuSd3JZZICIgc9skb/jvei3t3/cIcJa7rEMI1Z8EJSvRxUn2g4AZi1BrpKu/pYjzLxqTQgpVhNfikZXxP4nkoF8HDjVdCp69OgU1FSGO1RD/FOhDpAAG1v2hfxLk8mtYgpmxRA+65zMOSUDzihOZoIA3ZOR+4fPzOBhgkJ0w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6gYs4t4; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6gYs4t4"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so1806052f8f.2
        for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 06:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786886136; x=1787490936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eq6iUASZc+iLA5Cv0/JGhI084DB8b2Fr3EMA+PEhPik=;
        b=E6gYs4t42QGiFIHx1/zgWn84yJCLpKhWsmnRFDduZnosJvxqBEze8Ib3N/dYJJQqkk
         p/WENxEWBIeGnyh5ap7IUg3CN+K9Y48+aDcb7fzOsMhbtG7IW3ZbVWxjbVV7tV+FDfmo
         r4FeQIayLSbBI5xGwXiKL7D86++TnE/GceWlb6IwqF/Uw9ZFgi1wpfVZBCoZ11nZ0aT0
         9N8lfPvMTUdHIBiCHeHUthwCmuuAvKOGJcAbxFQMjHxgazP1qt5je7k4W2Kc1mCnvDLK
         pGYcfYkN2fwJeooVH/AiUfS7mpYdQTYA3e7d9ZzCdhbVvcmkBbVyfVS3D1CN40gUM1Zm
         eJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786886136; x=1787490936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eq6iUASZc+iLA5Cv0/JGhI084DB8b2Fr3EMA+PEhPik=;
        b=Pml34MdRTRlGyh7Mol73mPhws4hsoiVYqXu8OLsPiphKKDHCY/oHBvEZ3Zeo3HjucN
         rqoR6zdTUm6mXpXVHdTrrZrUFu6tQCVWOPA8elchkjbh0Z2nZunp+RaqmmdFYMNizTK/
         2i8rEDcBObwMCMy6tCfIBlqfDaEPtUWObaibtITFbj48/o4DQo5OlLVAqitrGQdY09vV
         0rG2yhCi9c7c4OuQ8ErbXEbrVu2b4R29gT1nd+w9NoMJKVXO7LTrOpKkAb8fzOnHpCHr
         FbnnPvUF+iAcexrLiQpq0s9FUop0RksF7pgy0/41XR6lCrtndT4u18UpIZYmMy6k1/8s
         HP+g==
X-Gm-Message-State: AOJu0YwJQzbLvy8Lfp9VbuhWVNb1ZT50Kv8HlENy5vMzg2t4rV9op7Iz
	PY9neCY0vu2YHxpHrbF87O2xc6vH9/okSz8BL+eeIWFP/ei90V6pXBXuHa0Hspy9
X-Gm-Gg: AR+sD13iwcH2OO11rJ2nF8fO8sj1Xmkaur8SmUAJX2vYZNoDpM7hz/qNTtxMit3jGac
	gWwuCo1P2lQ+DqPX2PBNNGbtDZNZbd/4cjy3TSdOmRjXTXEZ6/eWrSMsxKp64OEsndKFk3Q5JO7
	zWxjlU+Zkf5rFg3AP/48/gMtLO0Yhc3+98vVPC39x4yVWBA5HfqHLKpEopR2vOfeOuZ6SGDPsk7
	o4j8KQp+jOnWgOg1Hyt8XeXDxalneB0mNdJdGniav4AxJobvcfPja9GtPlfl06hlFvBvniZsFhy
	QRQ7A0ar/IA++PfU8Q8HPwPe7nDeyBBwISC4Vs6SyHvM98yUGQip5XV0is6TVPI5CzMmixBUrSV
	qWC18yglXMcLr1/MzMs9g69bMOcBFaDAzI3USE1J10MRY3+J1cxCSeApb6EzXP1kAZ3Kt6oUjsc
	djYGcvPEDIHH1fcuenBozXdsLpmfjYqf8M+4Kd36/v9oiX+o3X3ggsVFEkqF74LvZ8poQ9P1MFx
	YiIoBKMQYJwzmPAjBCKRBW4377LS9zQQMI6NzBh760IxIGHoj7Gt9KOCoGvf4VC6d+sZbWYow+q
	Tp22u5KaAw==
X-Received: by 2002:a5d:644c:0:b0:47f:c62e:9cca with SMTP id ffacd0b85a97d-48160798113mr22090627f8f.22.1786886136309;
        Sun, 16 Aug 2026 06:15:36 -0700 (PDT)
Received: from macbook-pro-de-bryan.home ([2a01:e0a:d7f:f4f0:306b:5f99:5378:73e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2cc81csm24721295f8f.34.2026.08.16.06.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 06:15:35 -0700 (PDT)
From: Bryan Boquel <boquelbryan6@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bryan Boquel <boquelbryan6@gmail.com>
Subject: [PATCH 0/2] blk-mq-dma: kernel-doc fixes
Date: Sun, 16 Aug 2026 15:14:54 +0200
Message-Id: <20260816131456.16374-1-boquelbryan6@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two comment-only fixes for block/blk-mq-dma.c.  Neither changes the
generated code.

Patch 1 removes a @state parameter description from
blk_rq_integrity_dma_map_iter_next(), which has never taken that
argument, and fixes the tab-after-"* " alignment checkpatch complains
about in the two integrity summary lines.

Patch 2 fixes "ft" -> "if" in the return value description of
blk_rq_dma_map_iter_start() and blk_rq_dma_map_iter_next().

Per Documentation/process/generated-content.rst, disclosure of the
tooling used:

 - The defects were found by running scripts/kernel-doc and
   scripts/checkpatch.pl over block/ and comparing the resulting
   warnings against the function prototypes.
 - An AI coding assistant (Claude, claude-opus-5) was used across an
   interactive session to run those scripts, cross-check the
   signatures in include/linux/blk-integrity.h, identify the
   introducing commits for the Fixes: tags, and draft these
   changelogs.  The code changes themselves are confined to comment
   text and whitespace.
 - Verification: scripts/kernel-doc reports no warnings for
   block/blk-mq-dma.c after the series; scripts/checkpatch.pl reports
   no errors or warnings on either patch; both apply cleanly to
   for-next.  The series has not been compile-tested, as it was
   prepared on a non-Linux host; it touches only comments.

Bryan Boquel (2):

  blk-mq-dma: fix kernel-doc for integrity DMA iterators
  blk-mq-dma: fix typo in DMA iterator kernel-doc

 block/blk-mq-dma.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.39.2 (Apple Git-143)

