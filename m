Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24847526ABD
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651606; cv=none; b=Zz+JslPgtUgBie7TQjSyqnorf1evNk630QM1BBs5/XlblzaLWUPgQ3JQiuRR0LNZ3LM9Y4o9xDx9Q7fS4aGWgLk5HSCYnAL5IWdcxV6yjhoPQB7xoke9+8if1QsVrRPocjKdioX0W0+j4F0pyCkVzadg5MXZeM/5XShj/ivhCms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651606; c=relaxed/simple;
	bh=kgacaXhkkji4P8QOQ+aFj100L+etrdW7UzgN1ijHzHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qI/E6h5/85r6ymcXKhJYWpQum0hUG0bybcJuiuOgprdIvM1gAB5FWh19t5NLfI6DMxQd9h6rUpr+9kMjMgZwqv00kKWYgTOZSBaJAEFPyuxnKCp7RkLJvFonkit3R81EgGV4XiF8kwlwMrBuU0R1OSriWf+JWBx7lj/KAQy+7LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=fpDJ4lGX; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="fpDJ4lGX"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48434392b02so687263f8f.3
        for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1789651601; x=1790256401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GhZfe7j97gcGMqNS+7HeL0ehn+NCntLK64e5hLR53vg=;
        b=fpDJ4lGXilrGasImsS96V18rgTxPnKlTfsJ8h5iuTGW9VPi6ENX2O74p7s2sxC2KUN
         CoMgUghvZqj5zv5wp4959Gq6ahTlhZnSIjqxVajt3OK8jgbTq5O5L/RTW6md1l/F27Xn
         zcyIR686SHP9IVT36NhFMPHij1o0pFm+yxoUi/pdhBFNDx/nQ6MVAd0b/QwG1JBYXZ2B
         nk72w5hTL8YOJJKkJCcbmBx62k174AOGZmTTUj6wnwIaz3eta334L6fEsSee6mHotC5N
         KXI2ElHQtn8y8Q0itswn2MfErnKrw9rysYQtfl/mTJQ33OBA76qI610ByFmvaQ0rL5qW
         SqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789651601; x=1790256401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GhZfe7j97gcGMqNS+7HeL0ehn+NCntLK64e5hLR53vg=;
        b=hXdUHYu6xYH4B02f8fOQ4QOiiCFyV0qYP3Z96kitGAYBDz/TPquNfSYSX39xJCArdj
         vTWxXihLV229h7c8C9/VQeCCsfMmXiUTdt8bawKGROAEa4yPyx97PQ+LDQ9LP6mDuWOx
         kCkuCJfe1P/eGc9q0yursx+LSGvNZcP5uCt38D9Z4dDY6W2xnOIKNnwSGadKydV+oUN0
         FQR9aJodttpooekW0EYA4uTfrfHYxFCMdECfybt6oR1hxLpd3TTm82E3tZxlF1gtDyOs
         +FslWOyp7vAGomiK8GoYwLtDrsQJF02j202ellYi6gtGc7arZ5jPi3JBPzT6PBvqEeqx
         WO3g==
X-Forwarded-Encrypted: i=1; AKwUvBwmBuW9xH5+xVqnhad30uPRVM9XN3ip6aAerMBX5DwdK15XaK9Ikt1b6tDx3WaXMCAKIzsnGawOirKrAw==@vger.kernel.org
X-Gm-Message-State: AFuF++m3yrIO0Z9zICewr541MBsii6C07TCWS5jpelDHTvp9Igle2YrF
	6Szv9w3RmLTXYf0Jv61TMV3H05x2vZo9L5jrcRzI4edkLOq7v3PTjP8ToqVp61d0Vg==
X-Gm-Gg: AYBFou21lyEwpwe9VumIg1bwe0Pyhr247EoKll8vQzfjenDpugRaQYfh79bBF0miGi7
	6kOgVUoyqYPXIR6p3jHF5yJezSjOoNkNuhW1JqliX1j0kK7sZZcqJF+azUD33S1fKbXBMHMFm9z
	HTcCeOVJu+FTC23B+3q/v05tP+EzSTmSYMQnlC7EsxJGZMVgNchXD/ozXbo1M+2gqRQQtLzwgfh
	PuXGHayVwa0jxRSsjBQZMsjzyniK+nIwzAiGH04P3EmW+joZzwRQc0Xez/cUAubbUKqMmKtWhqb
	hXzWheASBuvlI2rFp0trMiTlkeQaQGjVsLTYTbAmTUVNG7+HqrUHV6R7gOQLAmTB5KF0I9XXvHA
	Gk70zlgIBCkKb0wxXWYCJFJiUMQfnTbfzxmq9+cI4a3ia85Md9uayMzVkDB2o5QQQdfZ2+SipQu
	EkT1/9ON0/TOsS0g1zQY9FVihzLOH2IYmXvLLxGmiHbWVS40E6fMjKs1juJL9WEryE48llBgodD
	DBHuqs1YT7RFMXwbLFOi3GcsAo=
X-Received: by 2002:a05:6000:2885:b0:487:c3e:8df8 with SMTP id ffacd0b85a97d-4870ceee433mr16279360f8f.5.1789651601109;
        Thu, 17 Sep 2026 06:26:41 -0700 (PDT)
Received: from fighter ([216.128.28.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1f6cfsm15879947f8f.13.2026.09.17.06.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:26:40 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sean Rhodes <sean@starlabs.systems>,
	Evan Green <evgreen@chromium.org>,
	linux-kernel@vger.kernel.org,
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
	linux-mm@kvack.org,
	Xueqin Luo <luoxueqin@kylinos.cn>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Subject: [PATCH v3 4/4] PM: hibernate: document encrypted snapshot seed ABI
Date: Thu, 17 Sep 2026 14:26:31 +0100
Message-ID: <81c284e9246faa817050f34d46a9fbe558ddba5b.1789651581.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789651581.git.sean@starlabs.systems>
References: <cover.1789651581.git.sean@starlabs.systems>
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
 Documentation/ABI/testing/sysfs-power   | 18 +++++++++++++
 Documentation/power/userland-swsusp.rst | 35 ++++++++++++++++++-------
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index d38da077905a..c756712a9df5 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -470,3 +470,21 @@ Description:
 
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
+
+		The kernel does not authenticate the first writer. Trusted early
+		userspace must provision this file before untrusted privileged
+		code can run.
diff --git a/Documentation/power/userland-swsusp.rst b/Documentation/power/userland-swsusp.rst
index 282e01d2fe61..957be396dcf5 100644
--- a/Documentation/power/userland-swsusp.rst
+++ b/Documentation/power/userland-swsusp.rst
@@ -116,20 +116,37 @@ SNAPSHOT_S2RAM
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
+
+	The first successful seed write establishes the wrapping key for that
+	boot. The kernel does not authenticate the writer, the TPM policy used to
+	unseal the seed, or image freshness. Early userspace must provision the
+	seed before untrusted privileged code can run and must enforce any TPM
+	policy and rollback protection.
+
+	Under lockdown, direct block-device write() calls to the active swap
+	backend are restricted to the process which owns the snapshot device and
+	the extents allocated with SNAPSHOT_ALLOC_SWAP_PAGE. These writes must
+	use synchronous buffered I/O (O_DSYNC without O_DIRECT), and cannot
+	exceed the number of pages returned by that ioctl. The swap header may
+	only be written at the offset supplied with SNAPSHOT_SET_SWAP_AREA.
 
 SNAPSHOT_SET_USER_KEY
 	Mixes additional user key material into the data portion of an encrypted
 	hibernate image. The ioctl argument points to struct uswsusp_user_key.
 	key_len must be between 8 and USWSUSP_USER_KEY_SIZE bytes, and reserved
-	must be zero. The kernel writes meta_size with the encrypted metadata
-	size that userspace may transfer before providing the user key during
-	resume.
+	must be zero. During hibernation the kernel writes meta_size with the
+	encrypted metadata size. During resume, userspace passes the saved
+	meta_size back so the kernel can switch keys at the metadata boundary
+	before the snapshot header has been decrypted.
 
 The device's read() operation can be used to transfer the snapshot image from
 the kernel.  It has the following limitations:
