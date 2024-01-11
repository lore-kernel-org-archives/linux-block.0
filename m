Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8054F1E6
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qQqk/c/J"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7beeeb1ba87so21988739f.0
        for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 08:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704988954; x=1705593754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYe192ZhHeWYGGknBv+DYVuizUAzlkdUcrVhT1/dBe0=;
        b=qQqk/c/J8Dq6PvxuFJjxwBvyJArSLdVGhh7I0xBS5qJWfX4iItNAoZDWsrHysjRxZ6
         rPJv+RRZveVEpX41ornl50+Jus1z3GL1qAX3b81SX5iVjB2qcuAKMc8rqEX3KsDuTOqt
         OjP5U54LL3unB2PW6Rhbnt/KtrnhsSvu6yYxF7+xxcX+trIvXoITtrjZwsRrnAZJKoyF
         aEg6vgz2ANQMi9w8HtiDyxIaSXhFstjGSVWJxoBQTH9ny/VOhZhs7YBiGcEeySihIHOC
         vqREm4RJfRyexdZLZ+bXXgqr4kk9kL9a5hYvVi8dzwp4DmjHi3F+cgTk93OgsxBq3cr/
         1dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704988954; x=1705593754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYe192ZhHeWYGGknBv+DYVuizUAzlkdUcrVhT1/dBe0=;
        b=qlttua1U8jkk2vn8aP2M4z4jC/trFTqRrr4c/aGm2Bj0lo6R/AKMv4WXoxn0K+fTho
         0b/85wraxh+k0twDzPwFPVShdD9wlDdAdcvdq+35oLLR0roWtc/Dk48+dPxA69uVowWb
         +7l04X/Xm2A5e/1ADJ0WdxBFpuGCWZp1mispC8DKoKXF3bJmZhi+kcWWqBCq/jiEg5bk
         U+JdadEq5pmHGQrk6k6zrQDjEU2wnYcPqaLt/VbGh9BDPz2SOMY1RYEK8thzNMzoBctK
         5cvC81W0mLIo01ZM+cFKg1yfjosbckmdKoFqvUylNiSUIfPyrQX8VoiqNKkzmWe9V6p/
         t3Xg==
X-Gm-Message-State: AOJu0YwoFDY578I2xpImpCorkpKKHzeCb731YAkXGdh9i+xsyNX+8qU3
	V+hQGZLQF1x1Dy6JpmYn1bcIp2jXT5yXUmu5rAbQUiK+XkM3mA==
X-Google-Smtp-Source: AGHT+IFpsk8Yy1x1miYM5rbQ64K11ggNvDAbSqhOn/iZ8jIyfEpZCAZbFlRVbVb6nS8no1dAuliT+A==
X-Received: by 2002:a5d:9b05:0:b0:7be:ed2c:f8b with SMTP id y5-20020a5d9b05000000b007beed2c0f8bmr2673482ion.1.1704988953757;
        Thu, 11 Jan 2024 08:02:33 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id cl15-20020a0566383d0f00b0046e564817c1sm285450jab.33.2024.01.11.08.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 08:02:32 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] block: only call bio_integrity_prep() if necessary
Date: Thu, 11 Jan 2024 09:00:21 -0700
Message-ID: <20240111160226.1936351-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111160226.1936351-1-axboe@kernel.dk>
References: <20240111160226.1936351-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the queue is flag as having an actual profile or not, avoid
calling into the integrity code unless we have one. This removes some
overhead from blk_mq_submit_bio() if BLK_DEV_INTEGRITY is enabled and
we don't have any profiles attached, which is the default and expected
case.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 37268656aae9..965e42a1bbde 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2961,7 +2961,8 @@ bool blk_mq_submit_bio(struct bio *bio)
 
 	bio_set_ioprio(bio);
 
-	if (!bio_integrity_prep(bio))
+	if (test_bit(QUEUE_FLAG_INTG_PROFILE, &q->queue_flags) &&
+	    !bio_integrity_prep(bio))
 		return false;
 
 	if (plug) {
-- 
2.43.0

