Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C9715AC4
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dm/jM6Bh"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-360412acf3fso2318745ab.0
        for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 08:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704988950; x=1705593750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QoXkCz7VGH6mnW3+WIFfNlKJqrgl9Wm2MRG8xUPTDtA=;
        b=dm/jM6BhyW2hEGEGuuZFKLifk9K7q6cWf3G8B51ZnKIwriN5rwBuFcyf2mEfVRBlKI
         FAvYYsXh/wVN7tUt2bbm1Ku01tiOGpejb3w2CJzzEmLC+lstQ6qZ4BtVmP+Vn1hYvjz4
         kBpdncXZlvRLISew2ZAI9SAcu1MuruWSNf/HbJZVdxeQTZep/ncfDHH6qjxXtjmHPet0
         rBu/Qjnhf196pKw8UHqNFgnXLlXFYH/Rt8ZcqrWK4QcaFBn7TLNup8Cj6bSSXRB/392I
         YIjd9wE84qsIp7aI1kYIlI88aR6/5+J/mUtcI6JeXU/3bwpjVTa/jr780v7S1t7TYgVq
         gBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704988950; x=1705593750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QoXkCz7VGH6mnW3+WIFfNlKJqrgl9Wm2MRG8xUPTDtA=;
        b=ebwyqv0golxFTX4QiBic2EW5KaDrO5aWg9QEWMG/d9fGo9NcDuIr22/5kXjlVh4uvN
         Dc+U3rcdDhDLMIwDJWnjCzG0KE/9rsl/RhbZq6M5EUSUWd5yeXmP22UtgmZWheE0Pd/K
         R5u9VhLHeS5eH7ASdqUgHphv4Qq8VD3vP5MFTizcxS0URC4c941aB3LuwF8iwoA3WcwT
         k2prbCBXQMhWzw43dueIAFNGxwAqPwmDl1KYpIWE5jLHuFP20EUByQ31dxkVVlc1MYU0
         eNU7Ht6f/DyXA86dfke3oU2AQFXG7PYDNcDTKdOr+EwdfKCAFG6F1zP4Z7SaeYCjTvX5
         XdlA==
X-Gm-Message-State: AOJu0YwoL3kzqvCNfIIbNuON/qCNDOolOSqAxpV3vtgw5k7hHd7QOHlL
	hcq8jFYTgyNKKtaV493EZr3Ti4jSQLW3NR80WgEt+iuluAz2Zw==
X-Google-Smtp-Source: AGHT+IHIxcq+J5oIDTRHnwE0bSCMnN5StS3WLqQNpCsW4xDu53HLmfl6F+ibemWcafXo7C+fvJA89A==
X-Received: by 2002:a05:6e02:20e3:b0:35f:fa79:644 with SMTP id q3-20020a056e0220e300b0035ffa790644mr2734507ilv.3.1704988949563;
        Thu, 11 Jan 2024 08:02:29 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id cl15-20020a0566383d0f00b0046e564817c1sm285450jab.33.2024.01.11.08.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 08:02:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: martin.petersen@oracle.com
Subject: [PATCHSET 0/3] Integrity cleanups and optimization
Date: Thu, 11 Jan 2024 09:00:18 -0700
Message-ID: <20240111160226.1936351-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

1 gets rid of the dummy nop profile, 2 marks the queue as having an
actual profile, and 3 avoids calling into bio_integrity_prep() if we
don't have a profile. This both reduces code (getting rid of the nop
profile) and reduces the overhead of the standard setup of having
integrity enabled in kconfig, yet not using a device with an integrity
profile.

 block/blk-integrity.c  | 38 ++++++++++----------------------------
 block/blk-mq.c         | 11 +++++++----
 include/linux/blkdev.h |  1 +
 3 files changed, 18 insertions(+), 32 deletions(-)

-- 
Jens Axboe

