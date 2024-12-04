Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15EB1B81B2;
	Wed,  4 Dec 2024 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335356; cv=none; b=WaP9qfNpTPMUNi6hDQlmQRcWb/ddRQuxF5Uzo7zy/t51xOknJyfaOKwRqDfcl8nSgsNFdMC5zqXzHppqGOa4MWp7OSTbDToUN4Q0IOgc0og/bSYKMXEKHTu6xEztfpWqqXB/xYijEJvIeRJ0MPPN/dqY6Nx1D0O/OdoMc8+4L5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335356; c=relaxed/simple;
	bh=EWlGeWIZlGf9L/T7F3lAx08YDAcTTUnCbhcrX18fs7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6rfbqJIttM8DnjAY6jFz3SDZNSu6q4ee7ZYfOhHP7OyBZzLWiqfN2c28Vgr+STTrgcalgVYBQTBa26WSnaXOWGsaCv2JybDrYmh1CDERlgEVAg4oNQuyZqu358xCIGmeGkz3Mhp7KlNwytKOl3ihT7LROV6IoSJYw3q3gYGpI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4mC2dhz; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4mC2dhz"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso40611a12.3;
        Wed, 04 Dec 2024 10:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733335354; x=1733940154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7V53GFvkYgl3GGn7NQiYaXdsYVvKlvlq6z/L7Et1GuE=;
        b=c4mC2dhzix4yYqLOwA4Oe12TzeJiiiG9I0iAiwVRtiJGtH1zTKg5BHAVpzrW8voNOm
         cQhX0IjWdRz52doJXc+ZfJSBlMF+0zxSxHF4pB49s2nsAwCaiKVA8AEJ9CcSM7SsmwXE
         Pb+k1LqfM8rnOaLik+toPwYq+9YuRCQx+ew2YIwcI10Wwc2FAtkJPvlPaKw86FW9l2Al
         ILyftEtZ9VckbNama/D0XYNMGKTNP+FBUEtBbHj/tyxpN4deeolMt99CspaM40TQkZAU
         9VH1zc8RKbM5cxRwDr9IJqfLNGZgFgYx8pvU0BeQsXVF0vVFGK9yTwkMXsjAH8yU3Vsk
         46QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733335354; x=1733940154;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7V53GFvkYgl3GGn7NQiYaXdsYVvKlvlq6z/L7Et1GuE=;
        b=sCBPbiyKqbyQwWFHoLhXSo5n4CVoblzEq3o3G+VqWsQkbZK9Ah6u+aTDLvGUzHCmxx
         ACfc9XFCy58WjYkq07AYJpedumxzzmK9PVo/rscD9asq4SIPcOSGwzu2nRvx3/CLhVsG
         FJU0R8HUsbm/XKuCGSy3SEd19UL6U7Pqpf7QLLc4XfJb3jVzGd4wmzIhgsOYVZIxzdj8
         mCSV1XOs7T5t/IWeeVYYI0snqy/ZC8i2cEWdHuRZJF79IByv1DVBxb9oB4jrtG2D8VUL
         T95oRKooLQKEqYtd2h/WFeFHZTnOo1EDrU0+UeIpnd7j7nLJ6e+EDuOlbibHqmuTD7m6
         pOAg==
X-Forwarded-Encrypted: i=1; AJvYcCU8XY44m76YQKKHpQSap/RMnp7LJJNIEXiAcP29rkj8UH7NIvKICTE72bgFOZg2yNaCsy6fjgzPg2VA7w==@vger.kernel.org, AJvYcCX0Xfkt7lyzkqGOOP5ZcVzl3Jd15wElk4IKBIuT9YMYnS5/NYFvxjGKrl0KJL/HIxSlWpx9BLK0@vger.kernel.org, AJvYcCXjN1fqZxT9fwaRajhExXtKGMvhsRvnxDaRRQZ74z5H3cSF/wuG5UnUTCU7AZmEuSd7f9reujtUJYqpe8Qv@vger.kernel.org
X-Gm-Message-State: AOJu0YwWHMVVFyd0j82EH2txHKonmzM6VoJmOYEwltmYY9xDzbbYlCBS
	mGZSvWcSMp2Xvs2scz2bZMA10Ck3vG4rp4bS6meWtllhyopd2B+5
X-Gm-Gg: ASbGnct1FuCUerMnYOya1eq+/QffbThsXwCn/Z2Kz50ZV1VDVAfiWG73Zo+jmD+FZ00
	tUKeqI2/BMij/MlWiKmlFKtNzhTeQ8CzrXa0BoYEextSO+W63upLV7KIeySJIGYM8RmWE2UMPsq
	ebT2xfCTjTqwIkXwsUbc3Bdz2SeXI44MfzeG+lundiiICOA69Af5tbzRfqc/L1y07E4NYitgr7P
	hdkkZGUdnifjwnDD7wKEjynRntUd8/Z8zcHZHdPxrz6xfYUj61Yh/XzEqmkp6g9S2StfB8=
X-Google-Smtp-Source: AGHT+IGfGswqHPS+sVCVBRyy6YYEmMkEmFcHRdeKF8fO4AaC3KytnZpu1qaS+nFgVW1qeM0JFQPoRQ==
X-Received: by 2002:a05:6a21:330b:b0:1e0:d837:c929 with SMTP id adf61e73a8af0-1e16bdd32cemr8217439637.9.1733335353855;
        Wed, 04 Dec 2024 10:02:33 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7258947b48fsm2064736b3a.47.2024.12.04.10.02.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Dec 2024 10:02:33 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	Desheng Wu <deshengwu@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] zram: refuse to use zero sized block device as backing device
Date: Thu,  5 Dec 2024 02:02:23 +0800
Message-ID: <20241204180224.31069-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204180224.31069-1-ryncsn@gmail.com>
References: <20241204180224.31069-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Setting a zero sized block device as backing device is pointless, and
one can easily create a recursive loop by setting the uninitialized
ZRAM device itself as its own backing device by (zram0 is uninitialized):

    echo /dev/zram0 > /sys/block/zram0/backing_dev

It's definitely a wrong config, and the module will pin itself,
kernel should refuse doing so in the first place.

By refusing to use zero sized device we avoided misuse cases
including this one above.

Fixes: 013bf95a83ec ("zram: add interface to specif backing device")
Reported-by: Desheng Wu <deshengwu@tencent.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: stable@vger.kernel.org
---
 drivers/block/zram/zram_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0ca6d55c9917..dd48df5b97c8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -614,6 +614,12 @@ static ssize_t backing_dev_store(struct device *dev,
 	}
 
 	nr_pages = i_size_read(inode) >> PAGE_SHIFT;
+	/* Refuse to use zero sized device (also prevents self reference) */
+	if (!nr_pages) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	bitmap_sz = BITS_TO_LONGS(nr_pages) * sizeof(long);
 	bitmap = kvzalloc(bitmap_sz, GFP_KERNEL);
 	if (!bitmap) {
-- 
2.47.0

