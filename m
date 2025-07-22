Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7155627FD46
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753226346; cv=none; b=J435ujLMYYWkk8BH9gXmVeRRzzPW9k5uuxli7MPmiws/VeAImwS5WHstSj2XKvynmoQfUTSdz+oqt41aLNZx9GWztI5b3XoJMy2Wkp3Ir54h6kqSX57jKs9uVb3xkGq+56f477CRU1z/ElNuMTkmlinW+PmpX1zihmWgQgsnjRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753226346; c=relaxed/simple;
	bh=xOw7iI6ZbULLqr7lanWlDJPJzxA95wPbkzS4yHOQb7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujSHk/CeWXFUoXvztyam7o5pK/0xa3+3WL+CmUM+UP/NIMhdEUwqmbpol/7Pw4Uc0frZ/myiTCEZtb7qjB3OxGo2rb5bFAZNDetQXOBbE2gzOv7PJ+JctRacp+VVrDEgETvXDMjU9geNpZ4pET8VZN1UUkHV1x+mV4ovz4qi/fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=TTK+XFwg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="TTK+XFwg"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45600581226so62204215e9.1
        for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1753226343; x=1753831143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggO7qL9xNar1GFF5gH1DmH5IdGWJZVwRZfe4+je2vjE=;
        b=TTK+XFwgdLD8IBVm3CTu8mbqGHIX79w/ad+OrPVVJKhkrOxOwsAzFoCHQEOlKlthJw
         Yv8tgxPouA4V6YOaD8swrap6bgdOFoVu2tI+lRgMm+ZCYVIGkNtBt3tpyTyAiBBqTiPc
         ArAZNjxxUdiRJvmUA3Wep3+qw1A26Xz0+5gTRGtsjfqfYyy7Va97TBsx55Vt/fI8aGzi
         m3nm1fuhjBqsn6905oK5wzt3UMXxmskerX2SGlPQ7NnqxGOkCHE9DxaAhL0HaTdNl8b4
         SB6DNNAtAxLnCxL/wtdXG2xko6hiCzAUnj/4y1unjUmvGvQKi4kzWJ0JwcN1S3AdzIgP
         aInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753226343; x=1753831143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggO7qL9xNar1GFF5gH1DmH5IdGWJZVwRZfe4+je2vjE=;
        b=nXLdRlNHHlDumnU88rB6aOkU514FwWS3E7ZhuJORAWRGdyiZQc49jnT+7BBWFhKxaQ
         Wooz7xcDYOZv5V/XHZQ9E7aR/PvV1tlij5YAXfHSUcRbA5UraScnD9/n0iYEu1qdVIqn
         qDrFy3P+5Cfv2KT8MsJ3dRcB8vhGUtUIaL28RYu2tIZxA8fKMj9gkDEBUgju+5FnfMZM
         COEQJY6QHorjeNkqq2AXn8WtqRvTaH1FgilGE3P7CV4+lCadT6OWk9iN1OWHGUMpqmvg
         JOntYyERVuVifiyn0M/mCwh4WDEbj01TOCbIebBKRAcmLbn+no4Rhx9fHDBTMC1n5Js8
         P2/A==
X-Forwarded-Encrypted: i=1; AJvYcCUx7VH0owOzqeSb4H3kehg9MYxaYXoeSoycdHdAzrRgoY6GWIoYEhHeCPZNlTpXwjxgbDWOn8cjzEKMhg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6wK+OmV+L8dtTNlSBHsSd7rmUfiOFL7OPdqgOE7c+jjzq9b9s
	UJLaEHMEJ6xv8+wAm9mZGzcG6oVCAbCgZ9aiWM3jKDw+DuhlYzF6RJVI8LxchZDLsfI=
X-Gm-Gg: ASbGncv40dgvjXW48r4S1BxEHK2s9WEoy0Ig0W6M5m/obk+Vi3lnGwnIvl8xr8exilC
	/OTLYSMpQ6MK8O9ORP8cfiFGhy+++WaYM1iIEP+vyLxK0iLLMTtfcp4GHXdKFw4gHeEsNSJ2aWJ
	JZSgRUfw5VnB4sOFQJR6m35r1mXvizHLthRwN1VU3vKXb2462LeGI50XAYKCLh6+hnuMD7DsTIq
	9ZUrvQhhu6yZmF8fzNBlqrCsufQTHGl/ucoiBbEzc3ZfvcJ/893MzkVkUAe4TPcw0NsQrWvYfoJ
	DDb2YJ9esKDLkAb7EMD/StJM2/nPwiE/HhjcLghqb8kK/FVv61izzjNGYGDVfH+UUzukqsXn0g/
	tdh+QGtrHbJ8HRjOuUwc4O03rv2en6OMBh6yroDHxg639PE1ErXzqiYo+eXvM4K92lkj2crXBx0
	yFwyx8vQ==
X-Google-Smtp-Source: AGHT+IGii/+pOcXiZYSkER6WSzImvqy+em+BdQz5lL69hbFi4LCgPqh1dWC4HHANl043boUxlzNxtw==
X-Received: by 2002:a05:6000:240c:b0:3b5:e275:86e8 with SMTP id ffacd0b85a97d-3b768ef6c3cmr696299f8f.35.1753226342666;
        Tue, 22 Jul 2025 16:19:02 -0700 (PDT)
Received: from KernelVM (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458691aaec8sm4071965e9.23.2025.07.22.16.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 16:19:02 -0700 (PDT)
From: Phillip Potter <phil@philpotter.co.uk>
To: axboe@kernel.dk
Cc: senozhatsky@chromium.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/1] cdrom: Call cdrom_mrw_exit from cdrom_release function
Date: Wed, 23 Jul 2025 00:19:00 +0100
Message-ID: <20250722231900.1164-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722231900.1164-1-phil@philpotter.co.uk>
References: <20250722231900.1164-1-phil@philpotter.co.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the cdrom_mrw_exit call from unregister_cdrom, as it invokes
block commands that can fail due to a NULL pointer dereference from the
call happening too late, during the unloading of the driver (e.g.
unplugging of USB optical drives).

Instead perform the call inside cdrom_release, thus also removing the
need for the exit function pointer inside the cdrom_device_info struct.

Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Closes: https://lore.kernel.org/linux-block/uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec
Suggested-by: Jens Axboe <axboe@kernel.dk>
Link: https://lore.kernel.org/linux-block/6686fe78-a050-4a1d-aa27-b7bf7ca6e912@kernel.dk
Tested-by: Phillip Potter <phil@philpotter.co.uk>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 Documentation/cdrom/cdrom-standard.rst | 1 -
 drivers/cdrom/cdrom.c                  | 8 ++------
 include/linux/cdrom.h                  | 1 -
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/Documentation/cdrom/cdrom-standard.rst b/Documentation/cdrom/cdrom-standard.rst
index 6c1303cff159..b97a4e9b9bd3 100644
--- a/Documentation/cdrom/cdrom-standard.rst
+++ b/Documentation/cdrom/cdrom-standard.rst
@@ -273,7 +273,6 @@ The drive-specific, minor-like information that is registered with
 	__u8 media_written;			/*  dirty flag, DVD+RW bookkeeping */
 	unsigned short mmc3_profile;		/*  current MMC3 profile */
 	int for_data;				/*  unknown:TBD */
-	int (*exit)(struct cdrom_device_info *);/*  unknown:TBD */
 	int mrw_mode_page;			/*  which MRW mode page is in use */
   };
 
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 21a10552da61..31ba1f8c1f78 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -624,9 +624,6 @@ int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi)
 	if (check_media_type == 1)
 		cdi->options |= (int) CDO_CHECK_TYPE;
 
-	if (CDROM_CAN(CDC_MRW_W))
-		cdi->exit = cdrom_mrw_exit;
-
 	if (cdi->ops->read_cdda_bpc)
 		cdi->cdda_method = CDDA_BPC_FULL;
 	else
@@ -651,9 +648,6 @@ void unregister_cdrom(struct cdrom_device_info *cdi)
 	list_del(&cdi->list);
 	mutex_unlock(&cdrom_mutex);
 
-	if (cdi->exit)
-		cdi->exit(cdi);
-
 	cd_dbg(CD_REG_UNREG, "drive \"/dev/%s\" unregistered\n", cdi->name);
 }
 EXPORT_SYMBOL(unregister_cdrom);
@@ -1264,6 +1258,8 @@ void cdrom_release(struct cdrom_device_info *cdi)
 		cd_dbg(CD_CLOSE, "Use count for \"/dev/%s\" now zero\n",
 		       cdi->name);
 		cdrom_dvd_rw_close_write(cdi);
+		if (CDROM_CAN(CDC_MRW_W))
+			cdrom_mrw_exit(cdi);
 
 		if ((cdo->capability & CDC_LOCK) && !cdi->keeplocked) {
 			cd_dbg(CD_CLOSE, "Unlocking door!\n");
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index fdfb61ccf55a..b907e6c2307d 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -62,7 +62,6 @@ struct cdrom_device_info {
 	__u8 last_sense;
 	__u8 media_written;		/* dirty flag, DVD+RW bookkeeping */
 	unsigned short mmc3_profile;	/* current MMC3 profile */
-	int (*exit)(struct cdrom_device_info *);
 	int mrw_mode_page;
 	bool opened_for_data;
 	__s64 last_media_change_ms;
-- 
2.50.1

