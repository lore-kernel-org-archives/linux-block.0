Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7018D15539A
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765936041; cv=none; b=MEVqrjexeUMXgAkfZyGsXk//jURoQqMVhCSPNXPrSpgeK5lhYOMlU6cUqgztiseBq8emUk6A0j0HwagySIrJcRlpzrGIdw4gexlqpf2Du9uzyRsQ5PPBd0Dxn7nEOApopIIcg4liGXdIRArUdnQ0h88G9GvUkZTBoiqY6WWkvHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765936041; c=relaxed/simple;
	bh=6jf/zGubgVOPjbBX+52J37PY6UVXRYaHLLG9ODYssxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKDcrGfYbh14dVoDdeA83niVgkALuCscRHjWQlaitTGUfBwDlQ8gBYooujuuNfZESnEabDM1sKMWTQPymI23ZnuTrCnjmTyf6idMflaT8E/+KqddfjLnWrvLp8xL2pSVCAIqZjkcpRFsWv++N1jinwObvKbmZxPjS+l+Vpaip4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyxkSEZR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyxkSEZR"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0a33d0585so33751635ad.1
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 17:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765936040; x=1766540840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IX62QACWHnPBRf5oS1mJvqi2yLF9xLlELjcpU1yBfU0=;
        b=VyxkSEZRpLPXhqjk6oNFTLJPLvOCv885VrcPI5KAFWtZOBoZ9aizjnGSiBExz6R6+C
         cLNaMdAVo3hK8/pn4mS4TppHtMI5USiQ1s98d+kvPy1Qapjgrwz7ww3UtvQarYf/U2Lr
         MbFv6sDT+hcbhNG65w5XFii9onUp2I/sIN0ObqfkMovUx02sjhyhH6uPnXdIVHSzLDby
         nGk9MvkLot2o+ueCQ1zx9KESf0rCiq7vFBOPB3P4YLVsWrHmSsZpT4cU6mAWPvxxGoog
         3Z/WAGYtQaTUFA6/yMkhsRK5UASpKAQQCxmbF06+b7Yw2JY6pFa+QUnY9zXtOG5Vl5P8
         nhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765936040; x=1766540840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IX62QACWHnPBRf5oS1mJvqi2yLF9xLlELjcpU1yBfU0=;
        b=Wgspy4Rguhdm+4KhNgmkOIDKq3En4HR5obrG1B8MFHnsFpvdA0Xc7XWc9rX188RV2a
         sCRpfrgCPDLJcGJbmUZ7s2vYpoHixR4CknJoOivj02JDFl+OEXGQWHV5ccB0vGy0Rirl
         pwDh3g01j9ygK4qY848FUNWG6Qspw/WWul0cV20olZtvSpI6iEbhi/uwCZkIe9ba2NVz
         G4EKdMkz03eqXkrghM0E/xhe+ck54MhXUzYedOdYMzmisGZv8AdU5fgMEHNopay2fUZ6
         WAta5JWKOIsmtQK2BM0vcpRn9xieksRJ4B0aTKGq2J3/WKpp9cVZehlg1zbxzFMS98Xs
         T1tg==
X-Forwarded-Encrypted: i=1; AJvYcCV9+vtehpYC1iTtcUEssZon80w1blcIJ2k/BLihGzTRR9+E/ihbSaGJ2hOd8RMAsQEd3kaNeMdhOGGa0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiFBl3kofkBfcFLVzIkpZCRjkIv3hyUd2lSDfk51SlGjanN58S
	N3aWhZ6pMAqsqaA6LkaYO2EWneR5myytuJyQEuJJWiqYdR94zG8R4cVl
X-Gm-Gg: AY/fxX4LSvr+Am0zL5sIdkhkzJ8AOq4Cef/2LnNRVdsN5V1u1TMQ8hSi2WflNODHDUL
	dBv/AmXHgYboT2nKF4q6s5i78gvmkxh+mp/hNVt0QxG+i4LP7W5E/RdqhgzG3lZBEh3BcZRpFSo
	M0hqkQIQh57fBsDDAC0nLL21TQc1Flv7rECq9W7rIIIXkmauDnJxMbwdoHrygpbHPsZLenhgxul
	Ek0t6Ijgj6VqyVs4mscv+NYg2T+zzKdv88ahX043UKFLjvRRDTaSd0+Dsbv6X4TwuM2yhuY111x
	flHXvylAO86Cdy7nsBbGQWze5LXNYuNmT5mTZcksVZ10NGcrB4fE8K0mPActqQzgAK4mbyHuovv
	oYokuQjUsQwros0ZP1LuGYSZdrLUs2OKOTiXclwtg0Ysw/ngT6VACb8fjOt1Boje42FX9vKKBaY
	zzcaRc+pEVQK0gQp7sTMehusJkaSZJntxoKDDKirZuwo6pbHQ7mV5Pnz18H+CQb6XaAY8=
X-Google-Smtp-Source: AGHT+IEu90ZOwnSFrLaZzTvyYxg2VfIEgcCDuK0V8/kosm5Q28k8NN8vuywHnAi2NKtzsH+ePiT6fA==
X-Received: by 2002:a17:903:244e:b0:2a0:a09a:c31f with SMTP id d9443c01a7336-2a0a09ac828mr102502835ad.8.1765936039677;
        Tue, 16 Dec 2025 17:47:19 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:d818:afcd:6227:33b5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea0594e8sm175629965ad.87.2025.12.16.17.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 17:47:19 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: axboe@kernel.dk,
	martin.petersen@oracle.com,
	stefanha@redhat.com
Cc: hare@suse.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+660d079d90f8a1baf54d@syzkaller.appspotmail.com
Subject: [PATCH v3] block: add allocation size check in blkdev_pr_read_keys()
Date: Wed, 17 Dec 2025 07:17:12 +0530
Message-ID: <20251217014712.35771-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blkdev_pr_read_keys() takes num_keys from userspace and uses it to
calculate the allocation size for keys_info via struct_size(). While
there is a check for SIZE_MAX (integer overflow), there is no upper
bound validation on the allocation size itself.

A malicious or buggy userspace can pass a large num_keys value that
doesn't trigger overflow but still results in an excessive allocation
attempt, causing a warning in the page allocator when the order exceeds
MAX_PAGE_ORDER.

Fix this by introducing PR_KEYS_MAX to limit the number of keys to
a sane value. This makes the SIZE_MAX check redundant, so remove it.
Also switch to kvzalloc/kvfree to handle larger allocations gracefully.

Fixes: 22a1ffea5f80 ("block: add IOC_PR_READ_KEYS ioctl")
Tested-by: syzbot+660d079d90f8a1baf54d@syzkaller.appspotmail.com
Reported-by: syzbot+660d079d90f8a1baf54d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=660d079d90f8a1baf54d
Link: https://lore.kernel.org/all/20251212013510.3576091-1-kartikey406@gmail.com/T/ [v1]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v3:
  - Renamed PR_KEYS_MAX_NUM to PR_KEYS_MAX
  - Moved define to include/uapi/linux/pr.h
v2:
  - Added PR_KEYS_MAX_NUM (64K) limit instead of checking KMALLOC_MAX_SIZE
  - Removed redundant SIZE_MAX check
  - Switched to kvzalloc/kvfree
---
 block/ioctl.c           | 9 +++++----
 include/uapi/linux/pr.h | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 61feed686418..344478348a54 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -442,11 +442,12 @@ static int blkdev_pr_read_keys(struct block_device *bdev, blk_mode_t mode,
 	if (copy_from_user(&read_keys, arg, sizeof(read_keys)))
 		return -EFAULT;
 
-	keys_info_len = struct_size(keys_info, keys, read_keys.num_keys);
-	if (keys_info_len == SIZE_MAX)
+	if (read_keys.num_keys > PR_KEYS_MAX)
 		return -EINVAL;
 
-	keys_info = kzalloc(keys_info_len, GFP_KERNEL);
+	keys_info_len = struct_size(keys_info, keys, read_keys.num_keys);
+
+	keys_info = kvzalloc(keys_info_len, GFP_KERNEL);
 	if (!keys_info)
 		return -ENOMEM;
 
@@ -473,7 +474,7 @@ static int blkdev_pr_read_keys(struct block_device *bdev, blk_mode_t mode,
 	if (copy_to_user(arg, &read_keys, sizeof(read_keys)))
 		ret = -EFAULT;
 out:
-	kfree(keys_info);
+	kvfree(keys_info);
 	return ret;
 }
 
diff --git a/include/uapi/linux/pr.h b/include/uapi/linux/pr.h
index 847f3051057a..f0ecb1677317 100644
--- a/include/uapi/linux/pr.h
+++ b/include/uapi/linux/pr.h
@@ -79,4 +79,6 @@ struct pr_read_reservation {
 #define IOC_PR_READ_KEYS	_IOWR('p', 206, struct pr_read_keys)
 #define IOC_PR_READ_RESERVATION	_IOR('p', 207, struct pr_read_reservation)
 
+#define PR_KEYS_MAX		(1u << 16)
+
 #endif /* _UAPI_PR_H */
-- 
2.43.0

