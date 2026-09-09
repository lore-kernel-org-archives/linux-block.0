Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D6948F00F
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944489; cv=none; b=WzAP7bjdFFUGl8+KKWeOjBL6sUObGUwhIcKCvbsK1vcjSz1pdY3D8cOa9WHbBRst7LyRu2jVmxREytTe2jVpwjJZxcQV+F+zkJhfQn6xVVbJ5ngMfdKUf+JDFSVYe9wEL9uVkWq/VdghTIE4rabgYdHe+83Aoa1DzwyG3cY2DjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944489; c=relaxed/simple;
	bh=8dP7EXppDq/wK3CzTPpxRisk/j9Ptxr4Q+k72BLzYnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=acB8hxt2GfhHWBR7aFRgs2Zb/OQWPHlLVCopMgiXLUe54PLeXBThS2c/vkwCyWeDIX+pP2jGcrlTKOZxGnLJxfvmCmwq8wksfaMJyRg6pDLZyC6k2lnkLWWvomG0dnoA29Az2DTPiZxn8fieH5KLUxfu5vt5bPHEYAhPDEhGgq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eZ+CQ2RV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eZ+CQ2RV"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc891373e0so59298995ad.2
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 02:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944480; x=1789549280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/uqYjR8CIvsGBQZ1BYCg5wZAXr0c5gOLef28qhmkr+U=;
        b=eZ+CQ2RVq+Q802GW+d7+1g69MCwaeZAybjKN0loJsRqjURkWUK+rnUbk65BcN9ejMD
         v3+5MqQ1P/JD9NDRnPnmOVAsZy2tZRqEljAFXTzgX4dsJ9gQuUDtkB6yx/3BFV65Us0z
         firhMWIUAwAAMLSHHLBAeqa5csEX94+P4ewWCycrIBlhibLljbE8D8DgUH9rP+8uMJN9
         meZv+by9OkYhDpJbG2zgyQVJxVFJ/R5orx98zEoCSxZSlDWYiYzVV+Ds/d51MY73U/AC
         0wFScTPWeMjW2cMd2eoNhjk6p6YC2sUivxLUK2R1+b8nSRwOMQNlj5dyanSi3brHikMZ
         B9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944480; x=1789549280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/uqYjR8CIvsGBQZ1BYCg5wZAXr0c5gOLef28qhmkr+U=;
        b=WDHITgTvVrjcgxyO0eSWq/mGNQ6XS45uDL43Qayd0V7W2WCGYndBKyEjRPp6zcjaNm
         HsIiIJZurzXVNskq2jAkjr9y6+W38jtg4OB3C2YXR9CdiZ4urwFskTnNAZZpP0/4zJbs
         iRKpeoolLiCrJkM1IMoWqzmz101nuszMeF7AmIJDPY0I0V91CLhKM5etj9kXtlLmKIbg
         1j6eBfRgYiAzqP15Y76B18b9vVK9r3X2BTkPDozSBwmYoAwZAEz37z2uOALZKHcCt2HP
         WpzQHFvnu+fzeHDfUc08CtvZCTwYa2076VNn/6Cn0ZNRbV/g1v2kSnCxYUobF0ipnKdC
         wANw==
X-Gm-Message-State: AFuF++lRifqWDHWdGw1SfuhvNYSnUkesS4KNIcMMk7y/q+mPBU8AZVnG
	Q9AWENrqzIzOGvRj8A1NI9XaQjVo6NE0miCcS0jKONu+MYZEXBzc1hj87p0TxNa3HoLKzMGqF2R
	llhUQRVM=
X-Gm-Gg: AYBFou3GvY18TP3OTJkAJnrWQIN4HIEFhRNEJXTAxte412+omPOWnsEWLpHoWi1iyzz
	CRRGWFacKuVUE9Ry6QLIFph94eT4mwS7vz378sGEqfaGuSQJqgEJrpcuDRq+QyLVVYbUdtQnpv9
	5uc7VIb/3ujUBQBcjPNP5OR326RSYRnjSroyy/MXivzORp6Cq5e1V1VpHygOuVISopxpz57o0ex
	s7CupqQL58ww5P6snhmH9PYXIJgDKWe/9ECuj0hfREpkRGacSEds7OeYEcp6Xu7l2jRueMW4u7c
	asXGt5yLJU/oet3ZqlMUpVlCoUbHVUe3L3V+az054X1uiHPBoYNBNeOHexYXp7aYGdtT3CIl3Ak
	6iC42HDtHVm5Tqbx73xt8EBQ+tcyoYsGSc03il4Qk9pWk5u8rt6I+aY4Yu5M/D4w9yEHMk3qg3r
	c3UJAUnOoF0/2WiEoowp12NeJjNT9W0x7nd0j50smRTgnvj+QouSiWyckR1MJrvRe12frlprSro
	K4=
X-Received: by 2002:a17:90b:2542:b0:398:9beb:5c17 with SMTP id 98e67ed59e1d1-39b2620a2bfmr47341861a91.18.1788944480190;
        Wed, 09 Sep 2026 02:01:20 -0700 (PDT)
Received: from localhost ([106.38.226.219])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b2615039asm31433140a91.15.2026.09.09.02.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:19 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-security-module@vger.kernel.org
Cc: jack@suse.cz,
	agruenba@redhat.com,
	mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	aleksa@amutable.com,
	legion@kernel.org,
	djwong@kernel.org,
	ebiggers@kernel.org,
	sandeen@redhat.com
Subject: [PATCH 1/7] fs: remove trailing whitespace from include/linux/fs.h
Date: Wed,  9 Sep 2026 17:01:06 +0800
Message-Id: <20260909090112.790006-2-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260909090112.790006-1-sunjunchao@bytedance.com>
References: <20260909090112.790006-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove trailing whitespace before introducing the inode iterator API.
This avoids unrelated whitespace changes from automatic editor cleanup
in the following patches. This also fixes formatting issues in fs.h
reported by scripts/checkpatch.pl.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 include/linux/fs.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index f9d1e05e8ae6..09c4db5e9ae0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -296,7 +296,7 @@ struct iattr {
  */
 #define FILESYSTEM_MAX_STACK_DEPTH 2
 
-/** 
+/**
  * enum positive_aop_returns - aop return codes with specific semantics
  *
  * @AOP_WRITEPAGE_ACTIVATE: Informs the caller that page writeback has
@@ -306,7 +306,7 @@ struct iattr {
  * 			    be a candidate for writeback again in the near
  * 			    future.  Other callers must be careful to unlock
  * 			    the page if they get this return.  Returned by
- * 			    writepage(); 
+ *			    writepage();
  *
  * @AOP_TRUNCATED_PAGE: The AOP method that was handed a locked page has
  *  			unlocked it and the page might have been truncated.
@@ -1315,8 +1315,10 @@ struct file *get_file_active(struct file **f);
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
 
-/* Page cache limit. The filesystems should put that into their s_maxbytes 
-   limits, otherwise bad things can happen in VM. */ 
+/*
+ * Page cache limit. The filesystems should put that into their s_maxbytes
+ * limits, otherwise bad things can happen in VM.
+ */
 #if BITS_PER_LONG==32
 #define MAX_LFS_FILESIZE	((loff_t)ULONG_MAX << PAGE_SHIFT)
 #elif BITS_PER_LONG==64
@@ -2285,7 +2287,7 @@ int sync_inode_metadata(struct inode *inode, int wait);
 struct file_system_type {
 	const char *name;
 	int fs_flags;
-#define FS_REQUIRES_DEV		1 
+#define FS_REQUIRES_DEV		1
 #define FS_BINARY_MOUNTDATA	2
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
@@ -2907,7 +2909,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos);
 extern ssize_t kernel_write(struct file *, const void *, size_t, loff_t *);
 extern ssize_t __kernel_write(struct file *, const void *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
- 
+
 /* fs/dcache.c -- generic fs support functions */
 extern bool is_subdir(struct dentry *, struct dentry *);
 extern bool path_is_under(const struct path *, const struct path *);
-- 
2.39.5

