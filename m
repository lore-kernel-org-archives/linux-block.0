Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795280995;
	b=qVosRjOkcuahIJja4SfkpB+olU3YqbWaS1ORVCNX7r8Blm2N742DFuuaE7UvnZBTU7XE
	 C20jJQYJVbOlvozCAvdZ4eUePtimOkPlrUU0VjzRalolxjNkkKhUg9woz+Q77hpFM/o6Z
	 0kEnCz4/cdv2YfO7ahb/KMvaBFzVXyoCGV/W1DAKjiPSlZwzPVuj8JTo4FFiY/M19qZEz
	 G1C5nWSwOiPC2k3mWgcTrhJ2q1t0713R+qwqMgqvEKtf9ffJMdlyBjpq86Gnsj7/xEDCE
	 lr2pqiofD1J3SmWWFP53UPwFWWQObPnzp+1Z9qrbw/UO5ahcvIjgJW5TOuKdJfe6hpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795280995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=zDORON3xMDp8H5oOXThyfh+pRFIhkBuXyf3+LFM8vcQ=;
	b=PaZ33NAuFoBGL5Oo2O8k/GVyXDBuWEsozJUMoX6bpSfJnTWsP+qSvPVyhXZJ8JZR4md+
	 rJ+skkvlp6oWN1avQr0zwM7lA1tq/YDhRrX1YxnSFBBtSZVGgHf/jYj/71u9zwzCcOdaa
	 QLReAZFcUSph/NaiV76tehXlCrOCjMvrdX5N5juUKYWxUypPPu2nbtrGSx2H3FfcdhDl+
	 Ao9hbz+iAtWbUA9Zj/Ta+8+X6xv/LpvuiNRz9iZ8aF42PJfw6x235EknLs+abmd5l9ztZ
	 MwWck0iBo2IaZ9v1BWr6txdIglmXtvEr/4fFcHLumgqiVHbIdQf0/TsgM+GN0eB2QNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ATrcJoCL;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9450606A338
	for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 17:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9450606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ATrcJoCL
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b50dc340d9so39535c88.1
        for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 09:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795280994; x=1795885794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zDORON3xMDp8H5oOXThyfh+pRFIhkBuXyf3+LFM8vcQ=;
        b=ATrcJoCLmDvsJt7us0vYVNcN8Ff7k3YMHTyWBSqVGKwqTmVCVwd/FIrLSgusZrGSB+
         kZFsKIMcR4xrcT5iBZ6jLMj4rA2JuvJ5mWgH2pz2bNmYxr4swNRW7haMSu04JzSNGRgZ
         8RpMainQQYIsAObH/oC7HvIdZy3pPctVCBLozGJvX4wkxx2jvpTxEVmH6bIvxkTvvkFM
         2YUZ0VUY8O9zJYEdV+11iAGyFjl2A+/YaRP3gFHkXLSs6iwR7LP6DjjApLze0eOZMwQv
         asMQSdnzy9C39/XiM83Ipwo8UBodt7TLnJLf/4vzwo/5OI7K3x0pNK5TPO03YUKXWA2Y
         8Npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795280994; x=1795885794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zDORON3xMDp8H5oOXThyfh+pRFIhkBuXyf3+LFM8vcQ=;
        b=wLxvB0KThm4/+hH+SKA9eoe4QZSsjfIfijFcbRyKS4JPorxdIJXsAFQ4EWeLL0Npd1
         CXXeunb3cGl+JhpFbphMseWLqJ6Yvt/Yp6BA9MAuoJ4XsI5XG0xGNT1nYx/hrSiJSn5n
         oKWOLicMKXnNvaM0T7FDz6CQw4mgBfVpq7jkRptNELqDVI5tUgPPNyUXCAAPFJaDWojb
         cPMTcBuIo4w4P9ZVzsKbALGs929/1aP5ZJFL1FDwg9s2PnvSbXSqktF5insMKwn378SJ
         uKnzuEjooomgCuclbmud2PVH/G2oN7RAHnI9qhfkgdtTjEQwuQeBW1DhJ9GflrOlMqYC
         EW2Q==
X-Forwarded-Encrypted: i=1; AL+hErFttvfznq3A0rLPNBy5BH5TPC4h5ZveRCJ+JD9vIufcJLx91x95nMwFJqF86gDZUwyiKqtF0Lhy+rQGig==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Vxw0Ncfo8IF8vpALUKoAFb4V+8nz21R8qzf/HKfjlQ7MRDq4y
	0i87IHngWUXkDtj8OJtOHj1Y4TEJ62PlbuCESpRaNqkDGQWsFyMjWlRM
X-Gm-Gg: AZFdTZfysILjYLGv6RP8vWgs4uPTo/DM/6IwQ4Qiyc+Jg5+weo1B+doTEEZ+tx17gra
	f7xGrUBCzAmgt5GR8YoVuwQdhVNZ5vfjiJBgY4rLrvIixuWQb5oSRXDDR7iv3Y2vhmX2VctTefX
	f12/LRNWB8lOYUNl4dG8Hx3Ss8B56ojFIwfQiqO0YJEsNoNSF6AAAEFGADqCs6iBV4iqJ9easlc
	M9HxnFSONeMQkb1hy6SUl04yZYK+J+OdxCnsCDQw2bUiSBCYy9nAoqeN91OROMi9eX90QSNTWNr
	OE4Xl+mUhxAQMzFQV7by2ikuXVyOWdawqwSv/KMoZ0E4WtjPVUIp9i9pKNHe1HJeb2BDWM0SkGJ
	QezAjRDS9VhCObkQN+tf3btnuEzEKLtFgdCKVKccBiaGwQWeXOgrU1/x74uDCMjDqnmMzVbRF1P
	tESdq5z6QTYpZvp8iDT4Ufqq435+Zu0afWMa3IXU6oYzpC+U9eVGyLkEurWYkaV4q+JJ+tyI/aY
	qdpCTi+or8OZygsOHQbuxps9bG6K/y3xKkBjaF5lnqC7skxczWnTP4rPxFgptXkZhMKzv6xDjny
	bI1+NF4iuLv041Lme2WR/FY4cUfP4dHiRjXisRcL31+oNc0Q72aC8Lxist5o5Q3ryiE=
X-Received: by 2002:a05:701b:450b:20b0:1b5:5a76:dfea with SMTP id a92af1059eb24-1b55a76e18emr7712339c88.0.1795280993507;
        Sat, 21 Nov 2026 09:09:53 -0800 (PST)
Received: from o6.lan ([2602:fce1:44f:115e::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm22813152c88.14.2026.11.21.09.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 09:09:53 -0800 (PST)
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
Date: Sun, 22 Nov 2026 01:09:25 +0800
Subject: [PATCH RFC 2/3] lib/lz4: add safe decompression from two input
 buffers
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-zram-split-decomp-mm-rfc-v1-2-4e69b08c0fed@gmail.com>
References: <20261122-zram-split-decomp-mm-rfc-v1-0-4e69b08c0fed@gmail.com>
In-Reply-To: <20261122-zram-split-decomp-mm-rfc-v1-0-4e69b08c0fed@gmail.com>
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Xueyuan Chen <xueyuan.chen21@gmail.com>
X-Mailer: b4 0.16.0

LZ4_decompress_generic() assumes contiguous input. Its wide literal
loads can cross the boundary between independently mapped fragments.

Add a dictionary-free block decoder that reads from two buffers and
handles literals, lengths and offsets that cross the split.

Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
---
 include/linux/lz4.h      |  18 ++++++
 lib/lz4/lz4_decompress.c | 163 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 181 insertions(+)

diff --git a/include/linux/lz4.h b/include/linux/lz4.h
index ad6042a718b5..3b6217bd9a9b 100644
--- a/include/linux/lz4.h
+++ b/include/linux/lz4.h
@@ -292,6 +292,24 @@ int LZ4_decompress_fast(const char *source, char *dest, int originalSize);
 int LZ4_decompress_safe(const char *source, char *dest, int compressedSize,
 	int maxDecompressedSize);
 
+/**
+ * LZ4_decompress_safe_split() - Decode a single block from two buffers
+ * @first: address of the first input fragment
+ * @first_len: bytes in the first input fragment
+ * @second: address of the second input fragment
+ * @second_len: bytes in the second input fragment
+ * @dst: output buffer, disjoint from the input buffers
+ * @capacity: bytes available in the output buffer
+ *
+ * The fragments, in order, contain one dictionary-free LZ4 block.
+ * Their addresses need not be adjacent. An empty fragment may be NULL.
+ *
+ * Return: the decoded size, or -EINVAL on error.
+ */
+int LZ4_decompress_safe_split(const u8 *first, size_t first_len,
+			      const u8 *second, size_t second_len,
+			      u8 *dst, int capacity);
+
 /**
  * LZ4_decompress_safe_partial() - Decompress a block of size 'compressedSize'
  *	at position 'source' into buffer 'dest'
diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
index 3a2cd9acada4..548197faa3e3 100644
--- a/lib/lz4/lz4_decompress.c
+++ b/lib/lz4/lz4_decompress.c
@@ -39,6 +39,11 @@
 #include <linux/kernel.h>
 #include <linux/unaligned.h>
 
+#ifndef STATIC
+#include <linux/errno.h>
+#include <linux/limits.h>
+#endif
+
 /*-*****************************
  *	Decompression functions
  *******************************/
@@ -705,6 +710,164 @@ int LZ4_decompress_fast_usingDict(const char *source, char *dest,
 }
 
 #ifndef STATIC
+struct lz4_split_input {
+	const u8 *first;
+	const u8 *second;
+	size_t split;
+	size_t size;
+	size_t pos;
+};
+
+static __always_inline size_t
+lz4_split_input_left(const struct lz4_split_input *in)
+{
+	return in->size - in->pos;
+}
+
+static __always_inline int lz4_split_get_byte(struct lz4_split_input *in)
+{
+	size_t pos = in->pos;
+
+	if (unlikely(pos == in->size))
+		return -1;
+	in->pos++;
+	if (pos < in->split)
+		return in->first[pos];
+	return in->second[pos - in->split];
+}
+
+/* The caller has checked that two bytes remain in the block. */
+static __always_inline int lz4_split_get_offset(struct lz4_split_input *in)
+{
+	size_t pos = in->pos;
+
+	in->pos += 2;
+	if (pos >= in->split)
+		return get_unaligned_le16(in->second + (pos - in->split));
+	if (in->split - pos >= 2)
+		return get_unaligned_le16(in->first + pos);
+	return in->first[pos] | (in->second[0] << 8);
+}
+
+static __always_inline bool
+lz4_split_copy_literals(struct lz4_split_input *in, u8 *dst, size_t len)
+{
+	size_t pos = in->pos;
+
+	if (unlikely(len > lz4_split_input_left(in)))
+		return false;
+	if (!len)
+		return true;
+	if (pos < in->split) {
+		size_t n = min(len, in->split - pos);
+
+		memcpy(dst, in->first + pos, n);
+		pos += n;
+		dst += n;
+		len -= n;
+	}
+	if (len)
+		memcpy(dst, in->second + (pos - in->split), len);
+	in->pos = pos + len;
+	return true;
+}
+
+/* The decoder has checked the lookbehind distance and output capacity. */
+static __always_inline void
+lz4_split_copy_match(u8 *dst, size_t distance, size_t len)
+{
+	size_t copied = min(distance, len);
+
+	if (distance == 1) {
+		memset(dst, dst[-1], len);
+		return;
+	}
+
+	memcpy(dst, dst - distance, copied);
+	/* Reuse the period already written, keeping each copy disjoint. */
+	while (len - copied > copied) {
+		memcpy(dst + copied, dst, copied);
+		copied *= 2;
+	}
+	if (copied < len)
+		memcpy(dst + copied, dst, len - copied);
+}
+
+static __always_inline int
+lz4_split_read_length(struct lz4_split_input *in, int length, int limit)
+{
+	int byte;
+
+	if (length > limit)
+		return -EINVAL;
+	if (length < RUN_MASK)
+		return length;
+
+	do {
+		byte = lz4_split_get_byte(in);
+		if (byte < 0 || byte > limit - length)
+			return -EINVAL;
+		length += byte;
+	} while (byte == 255);
+	return length;
+}
+
+int LZ4_decompress_safe_split(const u8 *first, size_t first_len,
+			      const u8 *second, size_t second_len,
+			      u8 *dst, int capacity)
+{
+	struct lz4_split_input in = {
+		.first = first,
+		.second = second,
+		.split = first_len,
+	};
+	int written = 0, min_last_literals = 0;
+
+	if (capacity < 0 || !dst || (!first && first_len) ||
+	    (!second && second_len) || first_len > SIZE_MAX - second_len)
+		return -EINVAL;
+	in.size = first_len + second_len;
+
+	for (;;) {
+		int token, literal, distance, match;
+
+		token = lz4_split_get_byte(&in);
+		if (token < 0)
+			return -EINVAL;
+		literal = lz4_split_read_length(&in, token >> ML_BITS,
+						capacity - written);
+		if (literal < 0 ||
+		    !lz4_split_copy_literals(&in, dst + written, literal))
+			return -EINVAL;
+		written += literal;
+		if (!lz4_split_input_left(&in))
+			return literal >= min_last_literals ? written : -EINVAL;
+
+		/* A match must leave room for the final literal sequence. */
+		if (lz4_split_input_left(&in) < 2 + 1 + LASTLITERALS ||
+		    capacity - written < MFLIMIT)
+			return -EINVAL;
+
+		distance = lz4_split_get_offset(&in);
+		if (!distance || distance > written)
+			return -EINVAL;
+		match = lz4_split_read_length(&in, token & ML_MASK,
+					      capacity - written - MINMATCH -
+					      LASTLITERALS);
+		if (match < 0)
+			return -EINVAL;
+		match += MINMATCH;
+		lz4_split_copy_match(dst + written, distance, match);
+		written += match;
+		/*
+		 * Leave at least LASTLITERALS bytes and end at least MFLIMIT
+		 * bytes past the start of the last match.
+		 */
+		min_last_literals = max(LASTLITERALS, MFLIMIT - match);
+	}
+}
+EXPORT_SYMBOL_GPL(LZ4_decompress_safe_split);
+
 EXPORT_SYMBOL(LZ4_decompress_safe);
 EXPORT_SYMBOL(LZ4_decompress_safe_partial);
 EXPORT_SYMBOL(LZ4_decompress_fast);

-- 
2.47.3

