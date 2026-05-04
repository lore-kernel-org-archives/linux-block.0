Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7E218DB1F
	for <linux-block@vger.kernel.org>; Mon,  4 May 2026 03:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777865163; cv=none; b=fXx/uMsEWMvVFlqbMzoipa9y6fSQ7JqdYFWxN8CwIePmn8OQ1isGZ6Y8/Va9k0RkPZntqF1YZJ56bScXVDS6KIdD6DDYXeCJpn7Yn6vL1q1neWexmaNfuIgdHZm29LjJ2KNVRV1cd1VEftN4T+n4lpn7XZ1mvEj2A62gbJV1NSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777865163; c=relaxed/simple;
	bh=lgP9nc8xg9Hh45JT0BP15Lj2a1lG76uxk3hmVagthBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kh1vDE0NhaWd2hdLCZUpRXeZVz/+2fYe8oQjxjJXH3Uh9LGnUbMD9xmDVT/T51fgWTEaCbiMek5hLTYb6vpD5cSVXm5+cFH/dne0LecRpBvi6ql1i0BPBhldFYqdwUtiQiOnLPf7nPlv6+hIhcqfVrcwM74ftHFY74KmUbWMINI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dH9rAMT5; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH9rAMT5"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c70e3eb3af1so105623a12.2
        for <linux-block@vger.kernel.org>; Sun, 03 May 2026 20:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777865161; x=1778469961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sHXTY9sLnF1K25ZmkWpIUiO8YMQuEQwzanxq/iB+EKM=;
        b=dH9rAMT5jvlx9Mn25Ar6ztuF/W2gRAIoOf8LbbDWJRuMXJkHF0KbDUaZbUMmsENnLa
         +QsKdtXpNoKAquRpq+Tp+wxWoOZRxFAX47VEAoZKtVM+TANvGKEbH604izdq3Q5qblEr
         YR8ImQQYhqh8lUSmcXBWM9A/aUAv1mGZ7b6rybOgFGv3bqvfJVLwEIbA0TdRNnk4/h8o
         djjY8AI88hVYtT6M6NdsfIRwwYr8bu1vVz1KbA9yjj3eSPocspU8lw7gsN0Nf0veWGV2
         TlTBUd5I4DPLmfnrTqctNXbN3cn5YsaFcXWR4GPI/pYF0SpsPPMyxDX3AzQ/DH2MScV+
         Jueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777865161; x=1778469961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHXTY9sLnF1K25ZmkWpIUiO8YMQuEQwzanxq/iB+EKM=;
        b=Unw8VvTQp9n3c4gWS05aLvZS1+souLUCogG1ulbHlivyIJRYNM+EDIAp8Oj1qTwvZ1
         BHodqqWN+9Mw9IikeXDfdy+oD3znPs0KNchbygynBFr1A7QhU+X8gk7KAq7CBwdi+5/t
         H7F58wdw3OJxykvvTlC0UDMvr9TQGU4IX1wqRKowU5lbWkL3FS97z1Z6My16Gnk1ZvlR
         Rgj/wZQxcUhRu+PglnAZGQAaf99YmeFc07lwAHQ7QWcnoXSXXnpc0jyo+Oa4F2RkWdOu
         Kr0l8kvDRMbalishyKp7dNrqYHrSr9lVFhYEtFFIRCtHg8hPs3g33EXHTpAOTP0xNrKl
         h22w==
X-Forwarded-Encrypted: i=1; AFNElJ/tLuskEMohBem1HW3N0d0S3LRA7lFHURii/Cf6n7BDBt6n9eMWKj7duU6lxSlNxzwUOdfYPaySyORvwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyej61lTDMN+edQrEWlNudGbfrHvfjIXHGta9FeIHvzetDuKrDI
	jRzvy5HMuXanBNhvm7F7m2RLaxJrCdVbZcnyo5y4iDtnYUis2OcZ6lBi
X-Gm-Gg: AeBDietXW59UkYk9PLThJdGh5dtHMm7cE2YzRFCh0D30YFLmSBuDDywuZNK/prNPVl6
	4zgKdW1KykNqTeO3sqgxBGx6RTIz/Lb9FZjtLecQC0TpeDhsrMMx/NPVCgSyxWqzmOz8W0E3hua
	kd6COOH8TgTJlL4VDiTSgcWm8In7RtecGQtVLfrDXvgN+Sg7pgAiAA3U8jITeC3Fl+LAIeFh3zg
	lLcZ+H6UE9em0gwl4F650/gs59r0tY+Z1sTDkoKDkHQZ7mYo3yueX2mWQmDlWl9Ij2IKNhh6WY+
	gnC5RNJflu1Mfos5jmMpBbIzzp3U1I+047gc77BPEKg+pGoa1XQLVpOvX3TlLfIBYTrkfyKdrob
	xYxwhr2xeGQIEeLbQA7wXAjIINg9lnRbTCovA7WUJpiCpTyGg+N7ivFJzfat4BBMedSBcDejBO7
	wX/F4UW4Tn2GDXUFN1Um1aA+e8L94WYEGptlm0hd0bvg==
X-Received: by 2002:a05:6a00:1490:b0:835:45bf:965a with SMTP id d2e1a72fcca58-83545bf98a7mr2082260b3a.7.1777865161249;
        Sun, 03 May 2026 20:26:01 -0700 (PDT)
Received: from b330-MS-7D46.. ([122.192.219.205])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515acfbb5sm10165651b3a.34.2026.05.03.20.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 20:26:00 -0700 (PDT)
From: Ziyu Zhang <ziyuzhang201@gmail.com>
To: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com
Cc: axboe@kernel.dk,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	gality369@gmail.com,
	zhenghaoran154@gmail.com,
	hanguidong02@gmail.com,
	zzzccc427@gmail.com,
	Ziyu Zhang <ziyuzhang201@gmail.com>
Subject: [PATCH] drbd: serialize UUID snapshot in drbd_md_write()
Date: Mon,  4 May 2026 11:25:50 +0800
Message-ID: <20260504032550.706749-1-ziyuzhang201@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drbd_md_write() copies device->ldev->md.uuid[] into the on-disk
metadata block without holding uuid_lock.

The write-side helpers drbd_uuid_new_current() and drbd_uuid_set_bm()
update md.uuid[] under uuid_lock, and some updates span multiple UUID
slots as one logical state transition. An unlocked drbd_md_write() can
therefore observe and persist a mixed UUID tuple assembled from two
different states.

This is problematic because the serialized UUID tuple is written to
stable storage and later consumed by reconnect and resync decision
logic, meaning an inconsistent on-disk snapshot can represent a state that
never existed atomically in memory.

Protect the UUID copy with uuid_lock so drbd_md_write() serializes one
coherent snapshot.

Fixes: b411b3637fa7 ("The DRBD driver")
Signed-off-by: Ziyu Zhang <ziyuzhang201@gmail.com>
---
 drivers/block/drbd/drbd_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index a9e49b212..6f835dd05 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3004,13 +3004,17 @@ void drbd_md_write(struct drbd_device *device, void *b)
 {
 	struct meta_data_on_disk *buffer = b;
 	sector_t sector;
+	unsigned long flags;
 	int i;
 
 	memset(buffer, 0, sizeof(*buffer));
 
 	buffer->la_size_sect = cpu_to_be64(get_capacity(device->vdisk));
+	/* Serialize the UUID tuple as one coherent snapshot. */
+	spin_lock_irqsave(&device->ldev->md.uuid_lock, flags);
 	for (i = UI_CURRENT; i < UI_SIZE; i++)
 		buffer->uuid[i] = cpu_to_be64(device->ldev->md.uuid[i]);
+	spin_unlock_irqrestore(&device->ldev->md.uuid_lock, flags);
 	buffer->flags = cpu_to_be32(device->ldev->md.flags);
 	buffer->magic = cpu_to_be32(DRBD_MD_MAGIC_84_UNCLEAN);
 
-- 
2.43.0

