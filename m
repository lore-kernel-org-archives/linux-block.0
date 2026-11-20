Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795143380;
	b=NdhEZWWaDCwhJ+q8SPpf1tY3+kpB6Vrnkf+9qNgnF8CFygGoSOXVh68DyhenLrGIamsp
	 T+WEFpl3jYL3yY8B5hr3YcFEl/0yTmCPHtUVlv6TVS6LLLlRwGpGSd07TxLRwU8y98Tc4
	 hicdwlb36JloPW1VxVqqw7HyoMXjke2LxhemO/b23Je5gWoa8ULYplxhjemdTPhpCshee
	 nLFUO1C7JxV02wFrvv1zkbLxOVb+grZycQVUBqXEue8Fi91bAdhVFLlUxvexEex4I9vbE
	 lBTRfGPRTGnCcZL4/f3yKvJd3YSFYZhqD0WH1LlprGdofzvAMKVkObJmRLlGqPr4Rkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795143380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m0665dM5wdxWb5+F+h/RK/x+cnUT7B3ca11RjcWX5hs=;
	b=fW9Wzn/EofobhPCD3s1w1tS1wAx7wyai8sN6OHhdrffJoU0CtrWFQkK8dge61W+ZP8w7
	 n8R8W5yTt8MpdxT+Lq8uHJy8RDIk/SNdC8VsrGINEK2j71p+BLi3o6OSgDhAp8kII6C3O
	 nVqh3GlT1ubzLeq3sDN9MtuwfB0YDVRZF7ayuqbB37yasxRGvuM3FDB34C3uhkreFl8W7
	 yFpn6t4WU3ZR55gZ+xavy3TOfHQsS2kHz8eg3vjUpKJncYIGddjzLky8UYZzo2gCrxFCq
	 OkKBOLeUCm4Oafby+YIieVod9yLF22reB3TpBX+MqRawfDEOCzTaLG5U+alkn+Uid9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mXsc1Ips;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA43606A336
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 02:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBA43606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mXsc1Ips
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so229074a91.1
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 18:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1795143379; x=1795748179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m0665dM5wdxWb5+F+h/RK/x+cnUT7B3ca11RjcWX5hs=;
        b=mXsc1Ipsc271cFgv+5H5jLsxt+xovQR8Orl9yL7q4tGbpMf8yDTxNrwFz8NTy8TSw5
         31mrr+nMNhpJoO5vCm+/duya12pFsX7rfk7F2uT+hiR1XfagyBEZkT6GlUXco7iplWtz
         CXFazb/8AbwJwWj/zmwQUPpWswMkxH1R9b3hwNvsnTd6aGwePoSYEZvkOCyA7Jaa1+3u
         ygDf7kzpv0iFxwnTHGaO37/Ha6HdZ0UDgVkiQAzsDhRl+1dTL4O1wwVh/0DdZHW686DN
         /s718p8Zxv2WCT3ojqVSk/gOjsTEVlNs79CeQn4oCqj+c9J6EMz/r7SnWmnuDszEFsc/
         TOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795143379; x=1795748179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m0665dM5wdxWb5+F+h/RK/x+cnUT7B3ca11RjcWX5hs=;
        b=jV674mgwPcgR0mbiGLXxrc/0j2lWKhA86fZzX0QgHHGPovjnKeH6NUSCvOpS3WfMTz
         qgL+5Kx24aAd9CnOeZ2n2nvXHNu7YraU8c3+zwbEaADM2bwuA3ZWDVhpqksdlZCvDBR7
         x/dGnBGQ9nShQwMyKOQT0gDjacjNhBXXhq4oh4KNt6DE/UwO4/ydxgDJ0Ddckd5zo7rG
         SGVAHm36TCg4/Wh7re7OOU9YtSodEMp7hUlcty+0bvyWUGV+XR2c0VJ2/ro0FDKAb/N0
         JhNpZDSKZYFA4tptigBVTYtTejF0UzXJm7cMxcJSv7PN2n2qRuKX3wc4In4orrfIHrEv
         Q4Sg==
X-Gm-Message-State: APuU4Z9jumQso4Hy/1+G02AiKlvlTLY/nk0X+89O+17UZd94IOqKWW2v
	IhHgGTaWpP0frSj6LmFLXKN4yO2NVZjBd3SOIsxsX4k3YQ+XF2PSEIN/C/BZenc9K4KGwTzSv3c
	PCPCB1EiCPZQKHu0uDggkT+00taMWC9K6s0tP/GoQj2D8zm1tEiYMMxAoAQ==
X-Gm-Gg: AZFdTZeJEwq8ylihtXnuHbNMT8L5dWRTgNEtbZZPQN4a94TZSt9zlTDYl0r9Y0KC5+o
	FOwAU0kh/K/N1XkchvBQJXK+OHNzmqR7XAL3OXc16DA25mwPToIpE+uwXalNbp8QXu/+6J6qWOX
	zzfgg4UI0Jgp+Bgjd2t447nVUeYdZdrkmDIz0jTIJnyYCwKQ8r8uxX8Ci07OABUEsknTdk3Rrd0
	wsjqWniyvpb4XiHdLUNyyQFo3V3KGG3xxVgJ11aSxwlDUdsIECLYAtVCqEVRDVrFijAUsLQO9hf
	krIbsK1nogSDwVlT9HC4cVSRAnGIWPysB7AfOYMuYtQRIz2NJtE8JED53fmJvTkgUSFU1n6b0Qn
	jo2UhoNKeYnBGYlgt619FlWFW8wJ+roE4qhMW93bQQBGuDvqabYV+hxb9tvpXL5rRcbwYxVglNy
	NGsjS1BdPqhiDFmPSMgUzGEcdkJUP2GPN+V3MozbiEeWNMYFNy5QOEaoqYEcvgOIB6mLOQLBIKy
	AnOIBBUgCAnIjCZznovwZ46qcuiISnxqkgPoAiVQbEJEq6D7pL5pwuxotv1GxOHwheumtCyjP7N
	65GDOhxazfqq28koYQbvECc5nlEr/puoxruBKVBrgDSajagU5iKsHtoiBpk=
X-Received: by 2002:a17:90b:4490:b0:3b0:a7b5:c044 with SMTP id 98e67ed59e1d1-3b41c7bbef0mr876896a91.1.1795143379124;
        Thu, 19 Nov 2026 18:56:19 -0800 (PST)
Received: from localhost.localdomain ([103.26.8.217])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm5546461a91.8.2026.11.19.18.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 18:56:18 -0800 (PST)
From: Lei Chen <lei.chen@smartx.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Chen <lei.chen@smartx.com>
Subject: [PATCH v2 3/5] block: add helpers to link tag set debugfs to controllers
Date: Fri, 20 Nov 2026 10:56:02 +0800
Message-ID: <d943e20493c4fd50fee90575645a1f18a81450f4.1795143228.git.lei.chen@smartx.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795143228.git.lei.chen@smartx.com>
References: <20261009030111.57784-1-lei.chen@smartx.com> <cover.1795143228.git.lei.chen@smartx.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A tag set's debugfs directory identifies its attached request queues,
but does not identify the controller that owns it. Drivers with an
existing controller debugfs directory can expose this relationship
without duplicating the controller's debug information.

Add blk_mq_tagset_debugfs_link_controller() and
blk_mq_tagset_debugfs_unlink_controller() for drivers to manage a
controller symlink in the tag set directory. Build a relative target
from the controller dentry so the link stays within debugfs and does
not depend on the mount point.

Serialize link updates with tag set debugfs registration and removal,
and use the existing NOIO scope for allocations. Callers must keep both
objects alive and remove the link before deleting the controller
directory. Provide stubs when CONFIG_BLK_DEBUG_FS is disabled.

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 block/blk-mq-debugfs.c | 54 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h | 16 +++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 72634277e088..1a1364a34c0a 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -7,6 +7,7 @@
 #include <linux/blkdev.h>
 #include <linux/build_bug.h>
 #include <linux/debugfs.h>
+#include <linux/dcache.h>
 #include <linux/idr.h>
 
 #include "blk.h"
@@ -860,6 +861,59 @@ static void blk_mq_tagset_debugfs_unlock(unsigned int memflags)
 	memalloc_noio_restore(memflags);
 }
 
+/**
+ * blk_mq_tagset_debugfs_link_controller - link a tag set to its controller
+ * @set: allocated tag set
+ * @controller: controller debugfs directory
+ *
+ * The caller must keep both objects alive during this call and remove the
+ * link before deleting the controller directory. No dentry reference is kept.
+ */
+void blk_mq_tagset_debugfs_link_controller(struct blk_mq_tag_set *set,
+						struct dentry *controller)
+{
+	unsigned int memflags;
+	char *buf, *path, *target;
+
+	if (IS_ERR(controller))
+		return;
+
+	memflags = blk_mq_tagset_debugfs_lock();
+	if (IS_ERR_OR_NULL(set->debugfs_dir))
+		goto out_unlock;
+
+	buf = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!buf)
+		goto out_unlock;
+	path = dentry_path_raw(controller, buf, PATH_MAX);
+	if (IS_ERR(path))
+		goto out_free;
+
+	/* The tag set lives two levels below the debugfs root. */
+	target = kasprintf(GFP_KERNEL, "../..%s", path);
+	if (!target)
+		goto out_free;
+	debugfs_lookup_and_remove("controller", set->debugfs_dir);
+	debugfs_create_symlink("controller", set->debugfs_dir, target);
+	kfree(target);
+out_free:
+	kfree(buf);
+out_unlock:
+	blk_mq_tagset_debugfs_unlock(memflags);
+}
+EXPORT_SYMBOL_GPL(blk_mq_tagset_debugfs_link_controller);
+
+void blk_mq_tagset_debugfs_unlink_controller(struct blk_mq_tag_set *set)
+{
+	unsigned int memflags;
+
+	memflags = blk_mq_tagset_debugfs_lock();
+	if (!IS_ERR_OR_NULL(set->debugfs_dir))
+		debugfs_lookup_and_remove("controller", set->debugfs_dir);
+	blk_mq_tagset_debugfs_unlock(memflags);
+}
+EXPORT_SYMBOL_GPL(blk_mq_tagset_debugfs_unlink_controller);
+
 #define BLK_MQ_F_NAME(name) [ilog2(BLK_MQ_F_##name)] = #name
 static const char *const tagset_flag_name[] = {
 	BLK_MQ_F_NAME(TAG_QUEUE_SHARED),
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 882ed11e7c2b..d98ec1dc1130 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -564,6 +564,22 @@ struct blk_mq_tag_set {
 #endif
 };
 
+#ifdef CONFIG_BLK_DEBUG_FS
+void blk_mq_tagset_debugfs_link_controller(struct blk_mq_tag_set *set,
+						struct dentry *controller);
+void blk_mq_tagset_debugfs_unlink_controller(struct blk_mq_tag_set *set);
+#else
+static inline void blk_mq_tagset_debugfs_link_controller(
+		struct blk_mq_tag_set *set, struct dentry *controller)
+{
+}
+
+static inline void
+blk_mq_tagset_debugfs_unlink_controller(struct blk_mq_tag_set *set)
+{
+}
+#endif
+
 /**
  * struct blk_mq_queue_data - Data about a request inserted in a queue
  *
-- 
2.43.0

