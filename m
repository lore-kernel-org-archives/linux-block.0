Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795874806;
	b=kegm6VB+ZygbXxPi+PO382q808cOtMXQYiNFXDh8N/wmHxT+R83wM4lmAFP5DUH3pNYg
	 R8Jt+52gIWDoMvXWo/HCRwvZvgO2MKYuZb0LvYv+/294oFcNABBbameu8YwLUqlwQ6Ggk
	 4FZzSCmoQwbcEnSJM6XLicZyK6qkZohpbb2VaVns9QRrHRHB8/lXGVQRTh68dKs2Miqvi
	 zePAHYHBVV3Lqn1dDhNruoQTHI+1FNTxB+hSWW01orP03UfIQRX2DpgNW/JvrmFX8QmjR
	 5zM2TExqdiZVFmNGRG0N9Hn9xytiInVh0D+xxuhMoQwbAJCc/K8Dr73esG19LzlFt9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795874806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=f0hioqx1j+KUgblrL2ZDwN/5Mn/iMyAHXCN5l/EZKpw=;
	b=lkfPlmkCW96YtjZ8sFI8VDkM9g9+Ju6DKkd7xYPoKBmbS/68RPC40t32MDRbbca/+/n8
	 h/8EMGg8iiVglQRPMDBTGhvHs5DLuO8RTU1hyI5/Ldgabvd8ATC7Pl0RU620niJ3Rqx18
	 DY+lnANmv7ZszNTTkbC3jEsHvFVpeewmAXPEtEQtIHAIsDXgjG/rHaE4Cx1n2othlLvP4
	 piDyoibT1ruyxNefGvsPAXOlPscLn9oj2qwpz9EL+s6aIzrrUV/mNKKj6QyBiClfW6nmP
	 CsiCbRow+RxZJVDiaBZmFPKFy6FDmuvh2ks/9eMLPsEcMKILKO0j/gw9jQ2bCvyFGnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xeoKZniw;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E54606A337
	for <linux-block@vger.kernel.org>; Sat, 28 Nov 2026 14:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41E54606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xeoKZniw
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-94961ed97bcso895750685a.1
        for <linux-block@vger.kernel.org>; Sat, 28 Nov 2026 06:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795874805; x=1796479605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f0hioqx1j+KUgblrL2ZDwN/5Mn/iMyAHXCN5l/EZKpw=;
        b=xeoKZniwi3Fxx+vnNKT7mtaC68WAs4KWt3ivJMAk9YhSZGrrOCX3Hai/RZ+lLMT0dK
         1Nj5JtUYkbHIGbg1nDWGqu5vfl5BR6D8I1QW0VXM16owsNrfeaI4rsT2Zyj6sup5iS4u
         9W/V4sTkd36pA1nLZ/PwcFZoHsEubC9rS3udNp25AfGV4/mykb7J9PC3tyR5OO3DjwY7
         ZfpSvwGx+/JtaJdDwoK3Q5Gd69/7oIK/yc4V4bccydCQ27qF+q1b/Y3Idmr+pv3tCIoa
         /Hoy/2p9aeqyfutvstRE6F8p7R9kQYBmaj6Wm7Fxf3kS48taV0PKXGW/xjNOgx3DHLG/
         g99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795874805; x=1796479605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f0hioqx1j+KUgblrL2ZDwN/5Mn/iMyAHXCN5l/EZKpw=;
        b=R5aNOdz9Ny6Hrw+PB2leaJRE1k5SxRT8S8pVcsIHr2K4Lqbr2TUvHuDhyp6pVZIp/K
         cVZKblyf8U+hStMw30UkYLeyGCV2+0WH7R+r11CbVlw3mJB1SPsVarR9Xb96qUUjrEkM
         WUxBR/mAPZrqIaTlmZBJX9d8YpTMYGv7FmbVvub3UdOgQ5LF3Hp5NuU8C7+tMqDEM4Bx
         v72ulWZxez9O8Uol+B4kxFCErnKor84B4tlUfxG6whP3vKf3DlU8NJ2fZkap1Yj73z7w
         klMXNWt1s6KhdI4ueAMwqH4T9TKgvILYNJ8j5XzOdcGoHhzdcyhclRGel8oIHN9slEA0
         uBPw==
X-Gm-Message-State: APuU4Z+locSFBYsb3ZaGOWKreANdTdjyZfJf0K+hXdmPQanB2GNFGxJp
	kvuAi+hGNSjiwvlx+n7aUsDN4Dd826SToiHLJvftHA8122kYNifgwl7s
X-Gm-Gg: AZFdTZdPITq8CNyIN43SOa4MdsZj4sZ5DB87x2Te6wBVXD5wJaBZoB40FEpnWRUpu37
	dR/68xBEg6MnBs4ryaoHRhFUNPib/YoVCgFj1tdq6LwODCEfcrEVNMlCP07N5zsQwmzYQp9PofT
	FIu1mbw9i58eb/sgFuheUxVdEtmne/cnkgTa2GtdH2V4ZImIwR1mou3AMgWDAZSIK8WjKX9rppA
	gpDBNoTGSeVTzDhKWohinmOMDBqyGVP5XEoFV83VaXL798NdLsREiBNLRa7XBi6Rn/nXwzeyFxx
	2gIMFJkBOF1J5pRV7B2EVYZWyK1YctiLR+0G9w1JR+J2OCtd08o1ro1UVnt1VxVDBHqKGI3WlsU
	GtkMLSzSsX61XQbR0q+CupWsERK6296UXiRvLN/6As2Cbjf+sSpMbq4uuf2MAFriXksBHCvNaoW
	149T1KmJY6PxbX5Nm7NFL8ldvWCi3WEwBzbdYkMyvnav27gH7X2QTJcYLdiIgHoLb0MEZdFzHdP
	0PGip+7fNrgwmRgBzfz8tKimYB0WUGjZ1RmMCxOHay0s4UrpDDEqMbBbC2mc5dCcFPRru2M8ays
	lGaDwpg/sD/hODmr2eRgandRsCYn+5JDrQUKjtDGSXTjTCiwjpfdSFn5xTp0g26Y9cEe4+t+0PE
	Z7Suk
X-Received: by 2002:a05:620a:f0f:b0:949:57b4:388b with SMTP id af79cd13be357-949bab0eb6cmr5353856985a.41.1795874805196;
        Sat, 28 Nov 2026 06:06:45 -0800 (PST)
Received: from localhost ([138.197.109.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb34ac11sm2086323785a.14.2026.11.28.06.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 06:06:44 -0800 (PST)
From: Nikolai Dokutovich <ndokutovich@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolai Dokutovich <ndokutovich@gmail.com>
Subject: [PATCH] block: use READ_ONCE() for the PF_EXITING check in set_task_ioprio()
Date: Sat, 28 Nov 2026 17:06:42 +0300
Message-ID: <20261128140642.57-1-ndokutovich@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set_task_ioprio() can be called on a running kernel thread: ext4 calls
it on the journal thread from ext4_fill_super().  kjournald2() records
journal->j_task and wakes the mount path first, and only then calls
memalloc_nofs_save(), which does

	current->flags |= PF_MEMALLOC_NOFS

without any lock, while set_task_ioprio() reads task->flags under
task_lock(task):

  data-race in kjournald2 / set_task_ioprio

  read to ... of 4 bytes by task 103 on cpu 0:
   set_task_ioprio+0x17d/0x210
   ext4_fill_super+0x4954/0x5600
   get_tree_bdev_flags+0x218/0x320
   ...
  write to ... of 4 bytes by task 251 on cpu 1:
   kjournald2+0xbc/0x3e0
   kthread+0x1db/0x220

task_lock() does not order task->flags against the owner updating its
own flags; here it protects the io_context handoff against
exit_io_context(), which runs after PF_EXITING is set, and PF_EXITING
itself is set under sighand->siglock.  Mark the check as the snapshot
it is.  This adds no synchronization.

The racing write sets PF_MEMALLOC_NOFS, which this check does not read,
and flags is a naturally aligned unsigned int, so the snapshot cannot
tear and the observed race does not change the outcome; the check only
decides whether to allocate an io_context for a task that could be
exiting.

Signed-off-by: Nikolai Dokutovich <ndokutovich@gmail.com>
---
 block/blk-ioc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index d15918d7fabb..a3662e709bd9 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -270,7 +270,7 @@ int set_task_ioprio(struct task_struct *task, int ioprio)
 			return -ENOMEM;
 
 		task_lock(task);
-		if (task->flags & PF_EXITING) {
+		if (READ_ONCE(task->flags) & PF_EXITING) {
 			kmem_cache_free(iocontext_cachep, ioc);
 			goto out;
 		}
-- 
2.43.0

