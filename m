Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400545;
	b=pQi3o9+f31xXXVtdi65GzXKf54JBZHDf285QS+4tes3oNXdsIUls/8lZ+GsMty0U0xus
	 un1MLTA8cTK8wXHbaiYaGSMK3OLsiklq2o9+Orp/6KXgUlGELXcgCsSQDOfqG9hbipmhS
	 WEytI8rzZTQnvKogLjTWDeo2unwEkygbCXqXTuy3SZsdnrt7Oawb1/Y5eilJKQKsa6fpX
	 NNxVL1NrBBnzul8sQRp2UdMk6sFiMAyMpoF06m5iXL53fd32aVCuTZBZ3jAG+GnMnMbNq
	 wUwDYwW+GTH5c/qE8VXqFG5sjR2OfUYtUDiOMzBbomXMhtB+mSnhlOOoeHlVNi3yr3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qEns8j9TNQ6X545oefisWAHMaLi6RDahAOhPC5RfDi4=;
	b=wfTR3xUaU/ImLXukiN2yDFdmjCInd480nvJAdEG3++EFj/lI2u4mpKUQA5V51uG5w8uI
	 oc5lhSZ3O0kWkxpqJd97sn2wmzB39ZWyT+R3kQYUIkVk/V3LGFCljbBXGjiAumAD0d7//
	 jvQPkqmEZrA5aM3K5e2EO0EiFttc6djM0l2pvoFESvBZn3wmnXG/Y8JWOPywP/kGSld3t
	 Fsz2lXD5TOAUrGhoB8huiUCulwKylSx3VSR/HxNSUvp0qZjt9jt3BnaeCCrnh3lpcUTuz
	 60RF2CPxn+zonNey/whNiaSrjNVDtesEd4sFAUEHFlDTOSbQNMvzgoGFS7vvBkPc4kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMO6Sf42;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A2F606A324
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 12:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83A2F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMO6Sf42
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso1184165a12.2
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 04:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794400545; x=1795005345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qEns8j9TNQ6X545oefisWAHMaLi6RDahAOhPC5RfDi4=;
        b=AMO6Sf42HMxpa/RUtsNsKu9oaktHRowsQ1OjLfufSbUd0H/O0bVGuGJFnKUj/kMcE0
         L43cgNELZGL1x/unT80EVCikKU6iWTVCoDRY2SwfO2ll4Ptxw67R6bVko8s9Wtqoaztp
         m/MTROlVppiphLCrdWLtwz1X2FSxcUUDStFP8ygQHfPlp+wSXq2MKMJe7RFX1msSa+r9
         YOtAOhIC6zg2UQthwdjD6Rj+r+6em3LVdGQyvzj/Tqf7VBEnolw7CZ3iDFnuHT5bRfr7
         hBf84SgQ2TW+DVT8kii5kKgtG/lmvDwvtZesONwtOnjfwzqUeuqh0KUrFRBQ1TbfM7GV
         e8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794400545; x=1795005345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qEns8j9TNQ6X545oefisWAHMaLi6RDahAOhPC5RfDi4=;
        b=KJfM22ZB9inOa9zF7xgp7hJhxUFqANjY9Z4keyl6XkX30QAG9D7uex048s+W5w2k+6
         XnAaEQ2VwdrTnSqToxJr+sF+Mjqd7o13n/RfjGSJ/yJfdQomeEvf0R8YdZjmhyLyKeZ7
         SWOfS4DylBs6XrlUrczQz1tJMj/cOOt7T7FasKddtj0zlZZv9OxsmOHiq7wbVzr0qAaI
         MZ+yS+2rZyDF2olUMVNRXlgiIJ8TfhAVzLrWc9Skn3zsTv/Tiava6ARYGhManN0sWcHD
         CFx29Nab/W626HhoZTA9pgLUtJ3LbGCekEbAGf49tVTUc++o1tvmuvOqWUPg2AhNNu33
         nGpQ==
X-Forwarded-Encrypted: i=1; AL+hErEYQ3yVTpvzLpddk6AUtxTrMgQBftaOMtYIyRQ2fQPWINLNMhieG3O4/QcXXOOPYgH30p85pVZQEcTq5w==@vger.kernel.org
X-Gm-Message-State: APuU4Z9RWecBVlltgVXiw4vJLKvFUMYAcVTXCKKINADAUFQzShW/ubFA
	HStbWROfw/QuHqhu13/D6tMNt/ewE2wQx6gTm3YkJznbnMttRjXySj7S
X-Gm-Gg: AYBFou2Bx0sMwU5xfQNqYIPDvlk9e6aDKm+TT5r/jFmqzLqE2auAUeGp+vebsK8Z1/9
	Hm8W5/LkjuTYAr1YMze90lyp67EtOB0CM2Oo/X8kPyxAVnMt2Pz0bQJnTydw0wwQupfvjVFCDPx
	Pk8y2ACbEDnzrb9AgTdY20t2verE1fdowE8R86rCXKZCujAu8tdMOoNDgtZO0C4yw4QzBdW7jCa
	19U/RWOO2FGSJB+wH2iGFeAZs+I1kJJ1SgobcWe9BqUTsKqNYqAJJU+ekE3u9DC7eBEmBkGB+6x
	msqY180HZFMMjjS4DIP85q0RzrLwcwCLk07V5M0XA3z9oYURG6i1v5PlKZytmm13wyxpb+7HokW
	TzbiLYNP8XVvqjipGj1vxa+0dyT1EWbJxcogW+mMdOK9HqXurchlmucp3HY8JfR66QF71EzrXS4
	30JO2xVe+eVWO7yxd7TkiUiIu1elYdgDUPMUxt608hkUoCnqXMxC9N29/RUaDfaBYHvlmY+N+BX
	wBoewpWwbhfISnuKWBSwrV+mtroGq9FYSYzf94ZTaLg9z7T4TdjSxc/XmiMKvE1U8vnTpckO+xM
	ttyJPoSEyNLb9zCUItTCFXFBBz3Hazj0GpqlXF+CLP/2IzbPzlDk
X-Received: by 2002:a17:90b:2e83:b0:3b0:ada3:b505 with SMTP id 98e67ed59e1d1-3b182efad80mr2416852a91.19.1794400544724;
        Wed, 11 Nov 2026 04:35:44 -0800 (PST)
Received: from localhost.localdomain ([152.136.45.109])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17e0d550dsm4364082a91.8.2026.11.11.04.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:35:44 -0800 (PST)
From: diasyzhangqing@gmail.com
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: jack@suse.cz,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	libaokun@linux.alibaba.com,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	syzbot+d4ecb9a1e5b3dcf8baec@syzkaller.appspotmail.com,
	diasyzhang@tencent.com
Subject: [PATCH v2] block: make bdev_freeze() mutex waits killable
Date: Wed, 11 Nov 2026 20:35:29 +0800
Message-ID: <20261111123530.871952-1-diasyzhangqing@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261110132118.11265-1-diasyzhangqing@gmail.com>
References: <20261110132118.11265-1-diasyzhangqing@gmail.com>
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

From: Qing Zhang <diasyzhang@tencent.com>

Concurrent bdev_freeze() callers may wait a long time on
bd_fsfreeze_mutex while another caller freezes and syncs the filesystem.
Use mutex_lock_killable() to allow fatal signals to interrupt this wait.

An interrupted wait returns -EINTR before bd_fsfreeze_count is
incremented, so no freeze reference needs to be dropped. This does not
make the filesystem freeze operation itself killable.

Reported-by: syzbot+d4ecb9a1e5b3dcf8baec@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d4ecb9a1e5b3dcf8baec
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Qing Zhang <diasyzhang@tencent.com>
---
 Changes since v1:
- per Jan's suggestion, move the killable wait from a new ext4
  per-superblock mutex into bdev_freeze() itself.

block/bdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index f20f91b3176e..e57be2320423 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -301,7 +301,9 @@ int bdev_freeze(struct block_device *bdev)
 {
 	int error = 0;
 
-	mutex_lock(&bdev->bd_fsfreeze_mutex);
+	error = mutex_lock_killable(&bdev->bd_fsfreeze_mutex);
+	if (error)
+		return error;
 
 	/* A device being removed from its filesystem refuses freezes. */
 	if (!atomic_inc_unless_negative(&bdev->bd_fsfreeze_count)) {
-- 
2.43.7

