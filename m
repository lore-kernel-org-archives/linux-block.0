Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9417547CC82
	for <linux-block@vger.kernel.org>; Thu,  8 Oct 2026 11:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459569; cv=none; b=VF4M4yvHhrUsTW2DeFNqmfhCTIBaJeY9Jn4xNcSHlIlJbZmUVmzd/dV46ZyRKwJx1gAlZRZncpoOCE3/ueczSUxr2JXgA7pglxYvhDg1hhXlPGmgEFGLKqGcKe7O/rM8zldPZzZVhcIyXAtRgV+F9oFaqEYD8Nc4AteNYScERnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459569; c=relaxed/simple;
	bh=K3Nto0c/DR2Vg4nQZ3+eXpNlfA3vm7ksYne+ObPDRUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFMe1ruP0Kz9U6ssKXMB+89fSakE93LudCswU+5z5kHMqRp7JgX41iY6+eqF3ojMHymIhetH7uvi0fhw1f93Ut3U+CR2I4zygc9nYpP/YeI0LhLQvJJASiLx/yPG8Vwi5eligHPeX81fSqYCxPJF5pKA2Rg4phUf05I/HKJuhyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qynN7RnD; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qynN7RnD"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6e560e00a86so1876671eaf.1
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 04:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791459564; x=1792064364; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZBaq7d4CpGfizgmaPDVZflWhdEDwoMCDcc/qsXL1OQY=;
        b=qynN7RnDIP+b6MUpLs+nYS3cTaty06syZ3MG3SFLqpgHc6WyolINRF86d8IichU8W4
         Rpi3SbkPHnzDa2ODkqmE+MrYzbnVoGDwDdKDFq6gIGRksTbcC19kxGTBjJY5wFKbLQ0K
         CWPpC4braJfshSR32BYVMf9apBM3SyQevRXdZJ4wbNhzhibvISuZB+Tr5zc39DydqAjo
         XVavMDd3jFOVXs7sTxQBKKjp6GzXw5iO9OWZAYvQ4BceX3uE2XXtlA2COlcEVFNlBpbP
         PletMaCYRgUVELeWRn9x4V5veeeky+Szh4OGqQ288KCsbm7i1EkdMdgxTpyW7MLT4/Ma
         Y18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791459564; x=1792064364;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZBaq7d4CpGfizgmaPDVZflWhdEDwoMCDcc/qsXL1OQY=;
        b=0kftgmS8Xn6G4mj7zEljXsdt67y626o1s5j+F1RdSbRvFLTQpQzPd0iRNOo7ljI7zo
         pmZepDf0NpF+Ruw0FhCUGEPqbvKrYBGNGfMV+Q6vs+sITOa+PyWs8g2W6uMPNT6Ey9uC
         RnBU1Otv1OJsXXdB9fZMscoCL+CFVvNnC6Q3vWjaK1kwcBlOn7MLSe9eTVE0ipkbqKvH
         MnxGGfr0JCXauxM0YZL3FIABi21H0DhOzgVbgQTgHeoM2kIA2wRzIfCq4LYIhq3rVo48
         xBUIerJN968Za7HPgSKnwtFyGDnb+FfY8JZ1JEk7jems/1SFLyvmby2mruwpxG07RgmN
         l8ZA==
X-Gm-Message-State: AFuF++l3KmvbARJeoK9Vevjhpg5k5f8fvtlYeaA5EKKom5vP9e1b5cy5
	nLwLhuBSpnayeZFRbh8gDW087KfMEZ4oLtua3KixD61soR/NwDW8U2wpLkiF/Y6T
X-Gm-Gg: AYBFou3vGpHnrnOtg5LR//bVHJI0QWZQARfN/6pFqTplmGD//ibQ2FCOe99oMG7gnUw
	IA+gvYWGo7y9cvoGRqF7B6k4KeyuCR5IzXM+adCGs5j+BuiVLGNJixT3HIYwzdwWdBWQSVoZtun
	UxZEwCK/WNRjhSfkw5fLHaV2NP/RpDlOrv7MBsZId7ERgRzobRzg8f7eY2pe13UnqPCJWBflsew
	Q/MPf/drsU5Z9wS146YtPGyvRINrfX3Os+C2O5JQtAf3Q/eJ4nJfBqgEuj9WZ9TBe0GxDZGAQl5
	ytkwFFhsJ4vg5Vxibf4pB4RDcIF19pN8acxSa703j2hbE0O4B1bfwyKjAPJEUY/1cQqe9UpnAWy
	/SOT3aIZWblgAeNpTm5+uFmLolpCO/FAAu4qV4kB0HAgvO7fLwJEjNtdpYV0FXtA/ruAL/CZtc6
	C3tLSf/fJRYl2k9weVpOZ7eYJDDrHavZunRGdsiRWOSgFY5A9Vzdc3Xql6pDWwG+BQ23+/3XG6c
	1nOlsaeRuFgBTDQK7thyX3jSEYSWUAgIsEuWO5OV+bAVvi1SNZs7jbRcRF+VvShZB7uBVSDdcNQ
	F9jgPAY2YSGNOPPz44Pfhf1kqFs=
X-Received: by 2002:a05:6820:298f:b0:6dd:9a5b:cfc5 with SMTP id 006d021491bc7-6e7a9cc1935mr4189839eaf.89.1791459564438;
        Thu, 08 Oct 2026 04:39:24 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adcb187c8sm6045154a34.22.2026.10.08.04.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:39:23 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 04/11] ublk: reset the FETCH round in release also without a disk
Date: Thu,  8 Oct 2026 06:39:00 -0500
Message-ID: <20261008113907.4000838-5-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008113907.4000838-1-tom.leiming@gmail.com>
References: <20261008113907.4000838-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The release of /dev/ublkcN resets the queues only when the device has a
disk. Without one it skips ublk_reset_ch_dev():

  server fetches, never starts;         old server exits
  or STOP_DEV removed the disk           release: no disk → skip reset
                                         ios stay ACTIVE / CANCELED,
                                         nr_io_ready stays full
  new server opens /dev/ublkcN           FETCH: -EBUSY (still ready), or
                                         -EINVAL after a partial round
                                         → the device can only be deleted

All uring_cmds are done when the release work runs, with or without a
disk, so the reset is safe either way. Do it in both cases. Then a new
server can fetch and start the device again, as the STOP_DEV entry in
Documentation/block/ublk.rst says ("ublk device is ready for the new
process").

Fixes: 82a8a30c581b ("ublk: improve detection and handling of ublk server exit")
Cc: stable@vger.kernel.org
Tested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5e37b8e9d9ac..8bf0739539c0 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2551,12 +2551,13 @@ static void ublk_ch_release_work_fn(struct work_struct *work)
 	}
 
 	/*
-	 * disk isn't attached yet, either device isn't live, or it has
-	 * been removed already, so we needn't to do anything
+	 * No disk: the device isn't live, or it has been removed already.
+	 * There are no requests to abort, but the round still has to be
+	 * reset, so that a new server can fetch and start the device.
 	 */
 	disk = ublk_get_disk(ub);
 	if (!disk)
-		goto out;
+		goto reset;
 
 	/*
 	 * All uring_cmd are done now, so abort any request outstanding to
@@ -2617,10 +2618,9 @@ static void ublk_ch_release_work_fn(struct work_struct *work)
 unlock:
 	mutex_unlock(&ub->mutex);
 	ublk_put_disk(disk);
-
+reset:
 	/* all uring_cmd has been done now, reset device & ubq */
 	ublk_reset_ch_dev(ub);
-out:
 	clear_bit(UB_STATE_OPEN, &ub->state);
 
 	/* put the reference grabbed in ublk_ch_release() */
-- 
2.55.0

