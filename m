Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792650329;
	b=CNqZDksi1FpylhAPjn+PIibQJAkxjdlDr59b/XtZNk2sSFb+2z33RJ3ufqpwghcgZZPs
	 kpuOAKdji4DCBS1VZXN36HBFDxJtAB60X2m/Tf9PEIFHI/wxBYC4NToEAWT6jjJeRAJA3
	 INxIZZDsaN7NjQO7AaRx6pLb6h/8UiTOmkE21WrTzmqPlI5EDESgVTr2tfNv0PzzaOTD0
	 vdWG0QZVkWwNTbF4dNt/6DhPClJHR+jFKhROJbWXFkHDgXBSyzwkJkm4mKWqNMrPwG4v4
	 kP2CiCq9hVxeIeegA95MBQZMboCfbsoqJcNscCP6tIfblFooIwpTd8NvkW0/iB4kiIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792650329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Poj95iKUo4QyH3/5kwdW6qIr2kOr+yFV97wGvMkSdkQ=;
	b=k26ZhrruuBqcsTppeGf4LhUHF4S1sLHPTvb6RLMUgfQaM3VVk5be85cLIw5x+lsXfVV2
	 50r7Gn6TLiKv/Hz5MGIfaOBSH++eWnkZhbZMmaIXt3F1fTunZ1xJH8eGo1qXBLLWrfr1b
	 F9IXMWi11JmLKuFScpoE+Uoh2Q3CmiJz7JCtBEHwJL22/tC/8MJ15cmNWstyHlCZeHQEO
	 zrAE8QAQo+k6HywBdojNdIC8NypYxu2OTBytBOuVe17XQmoH197xUpzpr/Y3Bj+24uRPp
	 KUePVcQ31IXCn9x+YSxoLEl6Ian5+6TDFrqEL+cwfM6g0Cc3mZ//Kf4C/00WgFEWmyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lJCd4Zvv;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BDC606A319
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 06:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32BDC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lJCd4Zvv
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-3abe4fb64d2so712554a91.1
        for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 23:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792650328; x=1793255128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Poj95iKUo4QyH3/5kwdW6qIr2kOr+yFV97wGvMkSdkQ=;
        b=lJCd4Zvv3zzg2VsvpemySDQFCSU1TyrrnhaJ5VQDsk2ZSjmlLn5sXJcIe+XmiD57xy
         LlzrilIsG1z8kv5Ti+OY/Xvd9/DFrIAcum+Ss+6sSNtZEOFFgtO+mmbWpqIAMarlmXmZ
         HOWWvbnRA7pTaa6Xttauig/ad0sknE0ggVvG9HHBberUEoxOPO0HcVg7AT+3lJVD4Nie
         NK1XFtgVHkeWOzC7k8cNmIQqsqMr7ytDB/g43hcZRGdIZVm3iE56MO+zMvGe1lZyqjXj
         WKw8rfFfY+VovxZkwyFXuQEPsty07vjadt+YGwl0G+6xekYv6HmoVDZ19KwRF8KtnKGk
         GRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792650328; x=1793255128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Poj95iKUo4QyH3/5kwdW6qIr2kOr+yFV97wGvMkSdkQ=;
        b=nkRioa2gp66gikwrI1QE04c0pcJMCMHZ0YqhbfUkxu2wVkteQC4jyWXphDkfZe6X5q
         5wofnKJXl2+O5KuQ6ck8egu6Ecu7BDWRk4cseVP/SU38Pdv3EXMUi8VCBB+Eb4vAytfQ
         Dw1Sv8gcUuB1LFb+FJExGy21RjHdGimldE4GW7VxEcddk54qAaXm0hOJBtnilwIpyEv+
         B3dEzI82fLtDGi+evEabYza1aYP4bMl9rtMlUKPei+tw7PqxWr5WfL8zIHAUIe3/QCFK
         XhbbiguoOskPNKOMvhj3ksjZ4++cDX2OWst+uSSZZM1XEjjEU3sOaNPr1+DbmUp/3cgx
         GNnQ==
X-Forwarded-Encrypted: i=1; AKwUvBwT9EfVYV+71PzxcSgRKTxc3c4ZegO0Gc3hrTMPnn1/PG9LiUuJpSEpeafYM8Hika0LIrnWV1qWhNzCZg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJuwRK32Gdx4HBL29qmjhMzXKGUZTPN4aOj4HXPUZ2x+qCKO7rx
	qGeaWaBjlLp1KFKc1sxgOmZol0pcq/jGabuMSbMRx8hQdu7MS8koUPc40petcGfR4bY=
X-Gm-Gg: AYBFou2R7Dw2du+rc0j9yUCpadJPuEzBRsssUdVJFIOj1Q3NWAtWlixR+Y0PRD00hU2
	0Vt/GU3hoAQTjumOrWCX/qUKdh8WHFsk1q/sTk6zaV6E5J8Z5iT/pIyDIJrw6sBdwwcAAnY9NrB
	JbTYI2aCy9kuhZyFwTe1/GxUYGME7aW28L8WHfZCUgs0Ve4n1mJmpKPXAYm0smArHEg1GjI0KxS
	HYt59avF1A9LFfNPue7JNGmabvtBIeRrDAv6LVyOAL77C90owvsx7bhabrFzAb6pWB1/I3m2Uxv
	383yrmxyESpNJYneNBL6P+540syIl/5n4iMvOdHCQDHAdy+Mizmi1TyiC96rwHw6kXyuLGnRyV6
	+BsxAPom2csnvgxSCgxixXVmiGJpiOmPuSOZstt0Y0TNZUqwGKWmi/YdEh9/CvU8rM+9rP/uS/K
	CjI6/niH4kHNNqhtzjPF+Pw9Kb04g5S3bC7tdx/+n2fftWUHBoM77/rFlScrKBjzarI+ckRZWoj
	Igl1U9Jg+AtsDUjPIk3eEwSNM65LknaUZ/rf8ivFWPPHO/P3bEir+k+b4m0W8VyHlH917ZYdWSd
	2zbYwbF+lg7RIC0NBbQTsvhihUM=
X-Received: by 2002:a17:90b:4410:b0:3a8:1a1a:7895 with SMTP id 98e67ed59e1d1-3ad86e97863mr3315519a91.18.1792650328451;
        Wed, 21 Oct 2026 23:25:28 -0700 (PDT)
Received: from HXYG4FPMGD.xiaohongshu.sh ([61.8.202.163])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6b85e8c9asm804909a12.20.2026.10.21.23.25.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 23:25:28 -0700 (PDT)
From: Zhenxian Ma <mzx199711@gmail.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: hch@lst.de,
	bvanassche@acm.org,
	Zhenxian Ma <mzx199711@gmail.com>,
	syzbot+bd975ef54294bec73f0e@syzkaller.appspotmail.com,
	Tal Zussman <tz2294@columbia.edu>,
	Julian Sun <sunjunchao@bytedance.com>
Subject: [PATCH v2] block: fix recursive i_rwsem locking in blkdev_write_iter()
Date: Thu, 22 Oct 2026 14:25:13 +0800
Message-ID: <20261022062513.77372-1-mzx199711@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021093332.17334-1-mzx199711@gmail.com>
References: <20261021093332.17334-1-mzx199711@gmail.com>
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

Commit 2fec4fd97cc3 ("block: take i_rwsem for the direct I/O write
fallback") takes i_rwsem around blkdev_buffered_write() in the direct
write fallback to close a race with set_blocksize().  Commit
1b1be9ea4e34 ("block: take the inode lock for buffered write fallback")
fixes the same race by taking i_rwsem inside blkdev_buffered_write()
instead.  With both commits applied, the fallback path takes i_rwsem
recursively:

  blkdev_write_iter()
    inode_lock_shared(bd_inode)
    blkdev_buffered_write()
      inode_lock_shared(inode)

syzbot reports this as:

  WARNING: possible recursive locking detected
  syz.0.40/6005 is trying to acquire lock:
  ffff888024956f68 (&sb->s_type->i_mutex_key#10){++++}-{4:4}, at: blkdev_buffered_write+0xd7/0x160 block/fops.c:738
  but task is already holding lock:
  ffff888024956f68 (&sb->s_type->i_mutex_key#10){++++}-{4:4}, at: blkdev_write_iter+0x6c5/0x810 block/fops.c:815

rw_semaphore read locks are not recursive: once a writer is queued,
new readers block behind it.  If set_blocksize() calls inode_lock()
between the two acquisitions, it waits for the first read lock to be
released, while the second inode_lock_shared() waits behind
set_blocksize(), and the task deadlocks.

Drop the outer locking in the fallback.

Fixes: 1b1be9ea4e34 ("block: take the inode lock for buffered write fallback")
Reported-by: syzbot+bd975ef54294bec73f0e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bd975ef54294bec73f0e
Cc: Tal Zussman <tz2294@columbia.edu>
Cc: Julian Sun <sunjunchao@bytedance.com>
Assisted-by: LLM
Signed-off-by: Zhenxian Ma <mzx199711@gmail.com>
---
Changes in v2:
- Keep ret2 so calls appear in the order they are executed (Bart).
- Explain why taking i_rwsem shared twice can deadlock, since
  rw_semaphore read locks are not recursive, and include an excerpt
  of the syzbot report (Bart).
- Link to v1: https://lore.kernel.org/linux-block/20261021093332.17334-1-mzx199711@gmail.com/

 block/fops.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 0e4c42c8b74f..373667c6b65c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -811,9 +811,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			} else {
 				ssize_t ret2;
 
-				inode_lock_shared(bd_inode);
 				ret2 = blkdev_buffered_write(iocb, from);
-				inode_unlock_shared(bd_inode);
 				ret = direct_write_fallback(iocb, from, ret,
 							    ret2);
 				need_sync = true;
-- 
2.39.3

