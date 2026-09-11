Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33D841168C
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170741; cv=none; b=XuoRNebThaUvSnQFctZRQbmfwcC8GvSatKtT3BPkTvdyS1aHgDbtzbqIsMJfzfeXBMZaSnZEqeZm5OCkjqehQNVMrKWsLkRCqDoyGDActTcKXHb6wmQmHodmJI2TPR8wjEFW3zVgAhqnNCJiWuDFXypC/OVednqcqeHMEl4ntbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170741; c=relaxed/simple;
	bh=NLfkjv9faIkTJMq2TGBRHXTLsZ/UKSDRRr3QY8/uJBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h6PNOI7Q12G/I85IOEJmgfVUsoE23Gqa0Gdqt9JF3aEXTt5su/zXFRqttkw8wfh8au0FkhL0RZfknUgZjD+F5DS0GM6uCAwo4A6gq0kNj5/1ySPeSfCKfaejhij+unhcZy45TeTSeoN1Ws7jFcfOpLUoL2FtGuyTGGftE2tA8Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tFEI2BNi; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFEI2BNi"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso4933315e9.2
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 16:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789170732; x=1789775532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9gzBA68e/UQ9eClJUYWDu7lTd9NTGyQgxOmDDFm10T4=;
        b=tFEI2BNiAeCXZo5pLjm3eCevpSXVIJX/JyvQ9WY77s5FNtUP9502N/Fv+gyEDn+BH3
         cyxX0ezJoB5EGawHLsYYZzLvMqlgDkfCLWOl4FbUtGyUerYgvEzJhV+U+F4tD3BUzC/V
         0hC4xMs6HMdKJu6p+8LPlgeUOhVpLrpglu2jZxhA4mAxemwfEqMHmiOOv9JPh6K6wO/m
         WZDMmU7XbmP3KdjUqDxE5pzrokOjer6NalGmqnHAzCvojm2XtLdVHKCAjUtX7LNK71Yy
         Q4WiLLA2DYvKJX3YUG7vDzA8bX+BQZ7IBX/dCkcS4ikEa3fa1KP3ACSNDul3RbEvWRpN
         4UnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789170732; x=1789775532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9gzBA68e/UQ9eClJUYWDu7lTd9NTGyQgxOmDDFm10T4=;
        b=Af+wYPiBsQcEWg2Z378fFgavx0Uw3J/wQs6kddOjwXr7hQ91wvTt5EoEIymQJ/8D7i
         L4VEWtIqapg/mHaY9RIs7L38/j/R+mOFyLV3ZL3P5HgIPULV7GQRB4CV5RH2TwoDkATN
         AUsBL//SnGU1gSDq9NWNsUmseWngRGGpIneHenlLFq4cQ/oiK7szYPDTp3lSqKVfdRxb
         kTY8JMsZTESeGzx9OKMbKc3vvHfbyNjQaSZn4fEYy9dSH2cC3BUmeDjOocHU9o0q9TGK
         TOjyRpmYddvgDqBZUydOxAQLyUxCsCSwRt4EjF39vqSfApV4k+/i7+wx0D719WTEOMqh
         X2oA==
X-Forwarded-Encrypted: i=1; AKwUvBwZCnqaVu8a/lGJYNbiJkJJPQdEL/yc0OkMz40hyNJmALDZfohPuEdCUvAYOYrTA5ue88WCdZ2qTWuJZQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lmrOs9zc+2GX69FCSt8dQ4x5anp/8uGU6bv8nMorJ2WmKrkBoq
	uzSDxl1raoAI6g2Ip6Q2wzkXcqbnZp9nAnZSfr/VWn5QEukrZisU595X
X-Gm-Gg: AYBFou3z96RvNCBjWPnNWesDLqg7Pqy6D+I3lAhuqnwc1q+WW4q1v3uWDeJZWuOMLWQ
	EvQetb6hirlJ1BVcgoZJ61U0c4Q6NMt9xS+DlLMsQ//Gpn+AgXC1Kbv95pgbSwigj1PXPP3WBqG
	4ssu2JhafOiXWRbfcQdDSkkEMxPsOF9rRu+NgKSXF1BtGfZnsyeu1jrqs1opU7dK3hIoRErGmKm
	FzlfVGys56Tzzvb4LEiN5cLhe9LKPNhNVQCEQ0a5c2LCdbf8izTqpYe7pmUd7I4TUaB8pLx+wZl
	sS7QQDZkbmIt+fmA4Jsms97+Gl4qgKDrgURgQkbhkHmnB64yhJlsbplwdj68LXEt4unqCsQNTBa
	+aVfoIbt+p8Ocn24nJSoaoGN1jjf0Cj7HI1iEd+O7V2nuh66bMwplxCCbrCsxxooos607ZpTq0T
	aazG+nYSVjNTmDXozlUG1LCbPxVk/NdJZ0KoRl3GZ0pYSWZflNOXlgNU+zt6j8oIxzrp6teP0d4
	t/3YPbAqRehW2jXTbtJFqA0aYUCg3XRWb1Tc5Mr3cqc9MuqGZciFDBoar0SfIRGFXmjKi6cYvmJ
	KQPaT6ZuSGvGCIlrarq7ZgAwO3EM6WBqu8Bg
X-Received: by 2002:a05:600c:a107:b0:49e:663c:c69f with SMTP id 5b1f17b1804b1-49e663cc929mr93902905e9.15.1789170732019;
        Fri, 11 Sep 2026 16:52:12 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ac411asm107308135e9.8.2026.09.11.16.52.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 16:52:11 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Tejun Heo <tj@kernel.org>,
	Andreas Herrmann <aherrmann@suse.de>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: Fix the blkcg_exit_queue reference in blk_sync_queue() kernel-doc
Date: Sat, 12 Sep 2026 01:50:51 +0200
Message-Id: <20260911235051.34004-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blk_sync_queue() documentation still refers to the former
blkcg_exit_queue() name. The helper now takes a gendisk and is named
blkcg_exit_disk(). Update the reference.

Fixes: 9823538fb7ef ("blk-cgroup: pass a gendisk to blkcg_init_queue and blkcg_exit_queue")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 196bccf27f58dc270ad080470d70f846b864d4d3..867e7205c11e74f3ec6356a247bd8a8daa4964de 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -257,7 +257,7 @@ blk_status_t tag_to_blk_status(const char *tag)
  *
  *     This function does not cancel any asynchronous activity arising
  *     out of elevator or throttling code. That would require elevator_exit()
- *     and blkcg_exit_queue() to be called with queue lock initialized.
+ *     and blkcg_exit_disk() to be called with queue lock initialized.
  *
  */
 void blk_sync_queue(struct request_queue *q)
-- 
2.39.5 (Apple Git-154)

