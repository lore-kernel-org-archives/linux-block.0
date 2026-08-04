Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E5846AA97
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838489; cv=none; b=NdyiLVN+QNO7UnPar5UbY6BGv6bYY+dYY7Ezh9ld6HA2umnGDJjGzTafVT3lgk4bpLobf8E1IDRmVuhXMMMNJU9Lnr2io1f8Poz0rpMnWUz8RjzjSTjUNFNWsA8Dqoknvs7cshNniRiEFg44pxgBwYd4rH4sBcfXpNTyMA+48gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838489; c=relaxed/simple;
	bh=YAY85gc1J7l4pem+Ynb5YEtvC9qyhSgj+8jFccC3U1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJ7KIsH+ezLN3UtPXmkOnIZpOzStoBq8pLr07pu0mPL0ZQsLV/gFS57a+6CMZXtaA1F/tko9ufUGpRpHPTUmRaS607op9BX1/fThTkrs0jBSQEpwltBfyw6j5sDEThTjqJSG4haOw4yzZeM0C20DL/T2ZOII9Kx+AqWxMTWxFIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=TmhBfOkw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="TmhBfOkw"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-495590dde14so30515945e9.0
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 03:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1785838485; x=1786443285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xjThVuiPrln2+ib/P2lXqoKMuHizlqJXK8kVkecnjrE=;
        b=TmhBfOkw/s7grKESu166inWttGlniDjxJf2EATHZbsEEuh7pF0oUxim8gP5tMPWA0n
         UfMhy3NGtqvyRtZXFFOqruvKjzPB0Me3pC/rjrebzO4vwPGCEtdATlQv7hrzIEAdsWG5
         Y5n498+moByVZLtxQi+mJ6TF3j+DpA4fdlGiXnE/Ws/TEHVxVqtp4FkJKnWkJhMtWvgN
         NZ+Yj3LD4RAI6cMEVvWkn5vjZvzP+hNLAD9AVbPESWHBFr2UNNEt2KHZzdJ6GZ5XH33e
         zjXPnJvriJS8I5xc26cRZyHOzBlVpxIZQEMwxi0KbYO7Fqrw0tgnTI5MNExAX0QfeVsj
         3glA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785838485; x=1786443285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xjThVuiPrln2+ib/P2lXqoKMuHizlqJXK8kVkecnjrE=;
        b=BR7T8eSd4PT6k4658XswfqeNoz9KZ4arRWLewDkJyY0N4irVAIp9W9uo3nAGQdjADC
         s8uKklPPnNEtCfb3Mx4KV7RR46s1h968cHKtgzf9G9mkfqNwsP4OV9znHXsMEO373Egl
         LMXlxGOFlpe4tRGNv8oMBRl83d0fR5qMv4Ey8+GEiw40kNXSEP5B0Ium5UjltZPunaZd
         m66HSoSrFbxlRVvQPFxlOvQAp8G20sdTJ6VbYLLGWtmk9a23cQIPVTQlDuS3JOzLX3cf
         zWP8GJREf41lDGQ9ZrLdY88PdF98hsCPL/eqPf94Q7ISxkzjmZDq7SLUpCxUpfzARxFb
         g/TA==
X-Forwarded-Encrypted: i=1; AHgh+RrznfXP7il6UvohQgQlw/vD/gnu7oN1s//tFflUhjGKssbCJZ6XOlUuIRK/Tytye/eFOCp8hP/ZgLssWg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl91xkrhpGb1Gp+wtKJwDfL0eAMv5Y8wfRoWoxZxnpucMuZ5JK
	j758Afb7rayc3e949TimPwSn/lBoXdRfUu6QJrwoP5YuOgh/Fip+nsE1v83QtGu1Gw==
X-Gm-Gg: AR+sD12ftwD+wTHHa2QfvghycA+ml+DUCq7yKbkfjop2zpYu8avL8ofJy5wZIZtvYNx
	fKU4AN/zlWr+9joU65MF7Uyu4EW6xmqvKNeVlGVgkjGTwfPoNGJCKTbB1zsj/stsHi75/4GmrdP
	rGvtPQSkQ3RCBjo/YPEWYx5dhWORgI5droiiPTdZpMebbVgtyexS9bIsnjZLu9XSwVKK5y4lLyp
	Z0A/hIifijvxGincCFTEQQxKxHvKxs68p8lR6dG9Vc1brB+cvMeQ6dO1cDHVvkyAApJeIJhGzzg
	cxDv0WCqi6hc96yhOZm6a2Lq12hP3RiIyyzqy1zbHd5EieaA0UF+OfBxyhi5Ff+xAcFYspdOJ2s
	CTyKmrI6GP8N67bOphJxKstgbbqVEg6rQ/ReMWA+GnzgxKLTSi5SFpUdM3QgQMlMgctto45R4wb
	sHUb52XKV6RYPrbCQT3dE1F65xKxtR5gk2UH0UyvQ7y6+lh77jShOYC3LBn5b6YCnUhnr0NA9/7
	pzPCnIkVjBPEDmqRvhg7MkaFrBhPk34
X-Received: by 2002:a05:600c:564b:b0:495:52dc:73a9 with SMTP id 5b1f17b1804b1-4980c675370mr239950485e9.11.1785838485451;
        Tue, 04 Aug 2026 03:14:45 -0700 (PDT)
Received: from horizon.localdomain ([216.128.28.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7bf4sm73248805e9.11.2026.08.04.03.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:14:45 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sean Rhodes <sean@starlabs.systems>,
	Evan Green <evgreen@chromium.org>,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 3/4] PM: hibernate: document encrypted snapshot seed ABI
Date: Tue,  4 Aug 2026 11:14:36 +0100
Message-ID: <1f5b50e20b857dfa66f9c5d7c3df41738706140b.1785838445.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785838445.git.sean@starlabs.systems>
References: <cover.1785838445.git.sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the write-only snapshot_seed sysfs file and update the userspace
snapshot interface text to describe the opaque wrapped-key flow used by
encrypted hibernation.

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 Documentation/ABI/testing/sysfs-power   | 14 ++++++++++++++
 Documentation/power/userland-swsusp.rst | 15 +++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index d38da077905a..57f6063ef88c 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -470,3 +470,17 @@ Description:
 
                 Minimum value: 1
                 Default value: 3
+
+What:		/sys/power/snapshot_seed
+Date:		July 2026
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Write-only file present when CONFIG_ENCRYPTED_HIBERNATION=y.
+
+		Trusted early userspace writes a 32-byte seed, encoded as
+		64 hexadecimal characters plus an optional newline, before
+		enabling encrypted userspace hibernation snapshots.
+
+		The first successful write locks the seed until the next boot.
+		Writing the same seed again succeeds. Writing a different seed
+		fails with EPERM.
diff --git a/Documentation/power/userland-swsusp.rst b/Documentation/power/userland-swsusp.rst
index 282e01d2fe61..777518ac591d 100644
--- a/Documentation/power/userland-swsusp.rst
+++ b/Documentation/power/userland-swsusp.rst
@@ -116,12 +116,15 @@ SNAPSHOT_S2RAM
 	its state on the basis of the saved suspend image otherwise)
 
 SNAPSHOT_ENABLE_ENCRYPTION
-	Enables encryption of the hibernate image within the kernel. Upon suspend
-	(ie when the snapshot device was opened for reading), returns a blob
-	representing the random encryption key the kernel created to encrypt the
-	hibernate image with. Upon resume (ie when the snapshot device was opened
-	for writing), receives a blob from usermode containing the key material
-	previously returned during hibernate.
+	Enables encryption of the hibernate image within the kernel. Trusted
+	early userspace must write the 32-byte snapshot encryption seed to
+	/sys/power/snapshot_seed before calling this ioctl. Upon suspend
+	(ie when the snapshot device was opened for reading), this ioctl returns
+	an opaque wrapped key blob and the starting nonce. Upon resume (ie when
+	the snapshot device was opened for writing), this ioctl receives the
+	same blob and nonce from usermode after the same seed has been written
+	to /sys/power/snapshot_seed. The plaintext image key is generated and
+	unwrapped inside the kernel.
 
 SNAPSHOT_SET_USER_KEY
 	Mixes additional user key material into the data portion of an encrypted
