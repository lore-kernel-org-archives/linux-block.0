Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF0AC7EE29
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 21:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbjEWVqk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 17:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238648AbjEWVqj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 17:46:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67324CD
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684878350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/W7OJHL92lUHH48ytLmCoCkEDFoG/94300gJczLQVak=;
        b=M+4DG1rLTLzzPaELdEYecjnhJjYt+0fcuKrAbUmKfwulWf8gOFQ91opwE4z+xvkSVl85WH
        35w9WjrCdW58s7odbEaXWo6WpwBmWJN/mg3Cu1nE8paN2enOlZFVx1aRDf6+8baRi/hG7v
        AkGJlylnNYml7dYdckijv9HzrOFQEck=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-B7Bjk2NWPxmNn_w2pScseA-1; Tue, 23 May 2023 17:45:49 -0400
X-MC-Unique: B7Bjk2NWPxmNn_w2pScseA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75b185c9736so34305585a.2
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878348; x=1687470348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/W7OJHL92lUHH48ytLmCoCkEDFoG/94300gJczLQVak=;
        b=UgrKTt89Z2ncCGxdVt8G3ZeC3KTwAaQtNJADnEV5lNNNgBUilK2W3F5pre+RcH16BB
         wpRxXYQ9o0qqvhZwapS5peS4XBtUSGHEIVoN7IOqU2czXIh1IRkobkmoDzMdJ9CDkWPd
         bwbpWbv0wMyJmMCf4X/PHyYfLFl52vnR2gw9CNWVDvqCQGlXSIPBohd7dTKjLzYVc1or
         OEnOnUZqmAlUZAhzTnGk8/nyFENEhzC+qappsF3JddKCXnhvIWgnW5LWmFgnssCIERL2
         A3hEuaf4mnJuOh0jlx3/ttsSKXyPmOyRGK1cE1rotoWMJUFv4TVaG38ZmDV2KXUxH7qI
         gvHQ==
X-Gm-Message-State: AC+VfDzQ3SIaMQyKlRAPQmrUWn8xvYMDpStGGyyD++E/GaLkFurEWnNs
        c0RaiUyOBxgZHtFdvKqBhwOosx07Ncn8YTLh8AVbt3aD/7KA62zVFTY+e6SGlLChnVCrqQlHsZO
        9y/pP6TOqaW33zNYEcc3XKwTdFh3ihmw=
X-Received: by 2002:a05:620a:19a9:b0:75b:399a:2224 with SMTP id bm41-20020a05620a19a900b0075b399a2224mr382098qkb.28.1684878348499;
        Tue, 23 May 2023 14:45:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7tSLnpI38iij/VIHdRocpFfh0uKyRu4A+7fXW3Uf50SJh0f0oYgkpWEO1cvW4Nn5vLUnCR+w==
X-Received: by 2002:a05:620a:19a9:b0:75b:399a:2224 with SMTP id bm41-20020a05620a19a900b0075b399a2224mr382083qkb.28.1684878348218;
        Tue, 23 May 2023 14:45:48 -0700 (PDT)
Received: from bf36-1.. (173-166-2-198-newengland.hfc.comcastbusiness.net. [173.166.2.198])
        by smtp.gmail.com with ESMTPSA id s24-20020ae9f718000000b0074fafbea974sm2821592qkg.2.2023.05.23.14.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:45:47 -0700 (PDT)
From:   "J. corwin Coburn" <corwin@redhat.com>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org
Cc:     vdo-devel@redhat.com, "J. corwin Coburn" <corwin@redhat.com>
Subject: [PATCH v2 02/39] Add the MurmurHash3 fast hashing algorithm.
Date:   Tue, 23 May 2023 17:45:02 -0400
Message-Id: <20230523214539.226387-3-corwin@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523214539.226387-1-corwin@redhat.com>
References: <20230523214539.226387-1-corwin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

MurmurHash3 is a fast, non-cryptographic, 128-bit hash. It was originally
written by Austin Appleby and placed in the public domain. This version has
been modified to produce the same result on both big endian and little
endian processors, making it suitable for use in portable persistent data.

Signed-off-by: J. corwin Coburn <corwin@redhat.com>
---
 drivers/md/dm-vdo/murmurhash3.c | 175 ++++++++++++++++++++++++++++++++
 drivers/md/dm-vdo/murmurhash3.h |  15 +++
 2 files changed, 190 insertions(+)
 create mode 100644 drivers/md/dm-vdo/murmurhash3.c
 create mode 100644 drivers/md/dm-vdo/murmurhash3.h

diff --git a/drivers/md/dm-vdo/murmurhash3.c b/drivers/md/dm-vdo/murmurhash3.c
new file mode 100644
index 00000000000..c68d0d15390
--- /dev/null
+++ b/drivers/md/dm-vdo/murmurhash3.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: LGPL-2.1+
+/*
+ * MurmurHash3 was written by Austin Appleby, and is placed in the public
+ * domain. The author hereby disclaims copyright to this source code.
+ *
+ * Adapted by John Wiele (jwiele@redhat.com).
+ */
+
+#include "murmurhash3.h"
+
+static inline u64 rotl64(u64 x, s8 r)
+{
+	return (x << r) | (x >> (64 - r));
+}
+
+#define ROTL64(x, y) rotl64(x, y)
+static __always_inline u64 getblock64(const u64 *p, int i)
+{
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	return p[i];
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+	return __builtin_bswap64(p[i]);
+#else
+#error "can't figure out byte order"
+#endif
+}
+
+static __always_inline void putblock64(u64 *p, int i, u64 value)
+{
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	p[i] = value;
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+	p[i] = __builtin_bswap64(value);
+#else
+#error "can't figure out byte order"
+#endif
+}
+
+/* Finalization mix - force all bits of a hash block to avalanche */
+
+static __always_inline u64 fmix64(u64 k)
+{
+	k ^= k >> 33;
+	k *= 0xff51afd7ed558ccdLLU;
+	k ^= k >> 33;
+	k *= 0xc4ceb9fe1a85ec53LLU;
+	k ^= k >> 33;
+
+	return k;
+}
+
+void murmurhash3_128(const void *key, const int len, const u32 seed, void *out)
+{
+	const u8 *data = (const u8 *)key;
+	const int nblocks = len / 16;
+
+	u64 h1 = seed;
+	u64 h2 = seed;
+
+	const u64 c1 = 0x87c37b91114253d5LLU;
+	const u64 c2 = 0x4cf5ad432745937fLLU;
+
+	/* body */
+
+	const u64 *blocks = (const u64 *)(data);
+
+	int i;
+
+	for (i = 0; i < nblocks; i++) {
+		u64 k1 = getblock64(blocks, i * 2 + 0);
+		u64 k2 = getblock64(blocks, i * 2 + 1);
+
+		k1 *= c1;
+		k1 = ROTL64(k1, 31);
+		k1 *= c2;
+		h1 ^= k1;
+
+		h1 = ROTL64(h1, 27);
+		h1 += h2;
+		h1 = h1 * 5 + 0x52dce729;
+
+		k2 *= c2;
+		k2 = ROTL64(k2, 33);
+		k2 *= c1;
+		h2 ^= k2;
+
+		h2 = ROTL64(h2, 31);
+		h2 += h1;
+		h2 = h2 * 5 + 0x38495ab5;
+	}
+
+	/* tail */
+
+	{
+		const u8 *tail = (const u8 *)(data + nblocks * 16);
+
+		u64 k1 = 0;
+		u64 k2 = 0;
+
+		switch (len & 15) {
+		case 15:
+			k2 ^= ((u64)tail[14]) << 48;
+			fallthrough;
+		case 14:
+			k2 ^= ((u64)tail[13]) << 40;
+			fallthrough;
+		case 13:
+			k2 ^= ((u64)tail[12]) << 32;
+			fallthrough;
+		case 12:
+			k2 ^= ((u64)tail[11]) << 24;
+			fallthrough;
+		case 11:
+			k2 ^= ((u64)tail[10]) << 16;
+			fallthrough;
+		case 10:
+			k2 ^= ((u64)tail[9]) << 8;
+			fallthrough;
+		case 9:
+			k2 ^= ((u64)tail[8]) << 0;
+			k2 *= c2;
+			k2 = ROTL64(k2, 33);
+			k2 *= c1;
+			h2 ^= k2;
+			fallthrough;
+
+		case 8:
+			k1 ^= ((u64)tail[7]) << 56;
+			fallthrough;
+		case 7:
+			k1 ^= ((u64)tail[6]) << 48;
+			fallthrough;
+		case 6:
+			k1 ^= ((u64)tail[5]) << 40;
+			fallthrough;
+		case 5:
+			k1 ^= ((u64)tail[4]) << 32;
+			fallthrough;
+		case 4:
+			k1 ^= ((u64)tail[3]) << 24;
+			fallthrough;
+		case 3:
+			k1 ^= ((u64)tail[2]) << 16;
+			fallthrough;
+		case 2:
+			k1 ^= ((u64)tail[1]) << 8;
+			fallthrough;
+		case 1:
+			k1 ^= ((u64)tail[0]) << 0;
+			k1 *= c1;
+			k1 = ROTL64(k1, 31);
+			k1 *= c2;
+			h1 ^= k1;
+			break;
+		default:
+			break;
+		};
+	}
+	/* finalization */
+
+	h1 ^= len;
+	h2 ^= len;
+
+	h1 += h2;
+	h2 += h1;
+
+	h1 = fmix64(h1);
+	h2 = fmix64(h2);
+
+	h1 += h2;
+	h2 += h1;
+
+	putblock64((u64 *)out, 0, h1);
+	putblock64((u64 *)out, 1, h2);
+}
diff --git a/drivers/md/dm-vdo/murmurhash3.h b/drivers/md/dm-vdo/murmurhash3.h
new file mode 100644
index 00000000000..d84711ddb65
--- /dev/null
+++ b/drivers/md/dm-vdo/murmurhash3.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/*
+ * MurmurHash3 was written by Austin Appleby, and is placed in the public
+ * domain. The author hereby disclaims copyright to this source code.
+ */
+
+#ifndef _MURMURHASH3_H_
+#define _MURMURHASH3_H_
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+void murmurhash3_128(const void *key, int len, u32 seed, void *out);
+
+#endif /* _MURMURHASH3_H_ */
-- 
2.40.1

