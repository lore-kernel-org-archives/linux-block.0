Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794570848;
	b=A6XjidinAGt46vlxgOlnk0JeYlhCwcOZ8vnKq9N1lMK7OxVAi6bCYLEdBNPNkX1v483n
	 b8lXCDsKvFTINdmTzWS+481PFmnTl8SfM8ULHPyzNtsZ/EAZ9xtcpvq/G/c8Fwy5F+pRn
	 MWufqp359gjM/lb8QQOzFNme11VrIWA1MiJX5rcP0ykmIdw+BLXKNFkkIMBPRGIejjPr0
	 Co1zxNiOlUiBWN0CT1Kt3sub1Ft+5FspkE/zNo6xofdoj6Vj0CAhUnQ+9tiMwh6+ek1OI
	 IvSkoera5B139Scmzj1t8TgQXym/jK52YTpyhq1fs9hu7Yo/3tYU+iK+5HmceXK4cHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570848;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=G+lYotQNwdxfkBFSIeUojHCFQQyxXxiBjs1TYiuhj1w=;
	b=nJyk4GvAlBUIvBCFLUWAmtVX6LK0oElQY+itzutIjhZ7kbYzTu1qzGI8NXMcyhS4HWtM
	 XnDyycckevg31a+OaYCcq6QrTTecBGSEK1KCYFBQARVSB3968Ck0X8h5Xc4mZJ25Znnti
	 BdFGWRhRAUlpc0I4yeEhi1i9HhyML+O09mKCqtdnRWNMed0CsnPX6neDosZ/CrCK+ns+G
	 DyEPhRm5/zNxV4pL+WgVPlQN9cwcICHs9sRGu6e1hWMsC2PZ0HpuhUKPmGMbU7bgRNPJy
	 nxOJB85HVypxCuxITjjVTRUX50w0+PAhN7IiLwlnPzqazMtotNP5bhFh0oV9qHXPgyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=BOU2kMQy;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B856606A330;
	Fri, 13 Nov 2026 11:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B856606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=BOU2kMQy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=G+lYotQNwdxfkBFSIeUojHCFQQyxXxiBjs1TYiuhj1w=; b=BOU2kMQy5uNVc/B49Xl7Ih/dQr
	wRtqRuT5bNpnGZoYrW5A95vqYGrHRnLKqynmUpZmMvPldD82eSQ1vqxJbpgAB2hWESPyP/TzFQlgb
	Uuy6l7kWLUao0PFhVwZ2xQ6Z38yVLUZgryDHp1uzmm2e3zHaQv+LZHNyDo8JK89H2C3vAFfHw0s2P
	zgUkmUuuqrDfeoT0IBSVBIaDnJlFpBtOUAUmLnDPArS0FrZ+ShumwR46XSmOeJSz3RljZLwvGWLx5
	kNfEnyfKBXjklfsuTRVnMC3HTqErbxm/GetFK0zylSUQVaWABcb9Igb3oT5vaTeQa3QApr9fcMZzM
	M2KlqBYw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRpr3-00EjRl-0S;
	Fri, 13 Nov 2026 11:54:05 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 13 Nov 2026 03:51:45 -0800
Subject: [PATCH RFC 2/3] iov_iter: add copy_bvecs_to_iter_full()
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
Message-Id: <20261113-pipe-pool-regression-smap-v1-2-b0dc69558ab3@debian.org>
References: <20261113-pipe-pool-regression-smap-v1-0-b0dc69558ab3@debian.org>
In-Reply-To: <20261113-pipe-pool-regression-smap-v1-0-b0dc69558ab3@debian.org>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3728; i=leitao@debian.org;
 h=from:subject:message-id; bh=U/NRLZWrctGe+2fy7wNHdm+hsE9iuqTyfUNWsdpX00I=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9vpOiU+J8qKVmXoilto/l5+P6XKCUpQR9lV9o
 dq7l17WpMqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavb6TgAKCRA1o5Of/Hh3
 bfh4D/9f1DwpbTVDgHLVwxRELZ22BsB9GDWgT1det7iGn1FvNAZpBbH8Y944lUL6NxrsB6LSRdp
 VlP8VI1W/ovYZRcad9cZFUmWcE14Beo4b70qXIED6x12WkJuk3zY55MHTK7Mffs+sTEh49WVbQd
 GWd5wblRaAwMNcxzsyGnGsbRxD+Ue3RVnRVSEKJkbK+sSz6cgMHuww5tKO+EAeUY+ASfgoXgdl9
 f1ITY+Mceqt8Hzeenn0Nviz1f9QApEYoJitvqG3sJm/rBJL0HN2CcYiGI8qtflW4BFVKFZ0K67f
 WZS51LFglPdl7K+zQ5W6LK8/uGBK26eiRX75m8pqs+R3GxwadY+Csic1BBSf2v7tIu5uUS8LJDP
 LgPJ7mI9C8HVnrMCiq1QHyhflpwWJmP1wy9QtHzkFe6BzHZYkWSX6ROYamOAChKLN7Czjr5GUCI
 98wn852rCduoN6Xd4/rVk7c95jwmhUL5iMNGp6Xw0WMCmyHUTqHynqUs5aL4eUP3ur94eaaW49G
 7vaXelZQD49mkA6Tpxj4GpjlzyleuFCOYjet+ItfSuOVcgw+g1rWfs4Pvcx/surQNS2wtngz2SI
 n43xHf2lgqGRkanLmWhe03ll3Xa79RTiYjblhO/hLJ1PxJUb8ZWxk/hSInvS933NtUXj/CuuiKh
 dE/XlTXuZv2ZLiQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

copy_page_to_iter() opens and closes a user access section for every
page it copies to a user buffer. On x86 that is a STAC/CLAC pair per
page, even when the caller holds a batch of pages, as anon_pipe_read()
does, that one section could cover.

Add copy_bvecs_to_iter_full(), which copies an array of pages to an
iov_iter like a copy_page_to_iter() loop, but all or nothing: after a
short copy the iterator is reverted, as copy_from_iter_full() does.

For a plain user buffer (ITER_UBUF) on architectures that provide
unsafe_copy_user_generic(), all the copies run inside one scoped user
write access. It keeps the usercopy fault injection and the
instrumentation that copy_to_user_iter() does for every copy. Every
other destination gets the copy_page_to_iter() loop.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/uio.h |  2 ++
 lib/iov_iter.c      | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 76e4103b9ec423..7ab25080b0edea 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -197,6 +197,8 @@ size_t fault_in_iov_iter_writeable(const struct iov_iter *i, size_t bytes);
 size_t iov_iter_single_seg_count(const struct iov_iter *i);
 size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
+bool copy_bvecs_to_iter_full(const struct bio_vec *bv, unsigned int nr,
+			     struct iov_iter *i);
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
 size_t copy_folio_from_iter_atomic(struct folio *folio, size_t offset,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index de7a48205e0117..2df0539228be84 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -387,6 +387,67 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 }
 EXPORT_SYMBOL(copy_page_to_iter);
 
+#ifdef unsafe_copy_user_generic
+static bool copy_bvecs_to_ubuf_full(const struct bio_vec *bv, unsigned int nr,
+				    struct iov_iter *i)
+{
+	char __user *dst = i->ubuf + i->iov_offset;
+	size_t len = 0, off = 0;
+	unsigned int k;
+
+	for (k = 0; k < nr; k++)
+		len += bv[k].bv_len;
+	if (len > iov_iter_count(i) || should_fail_usercopy())
+		return false;
+
+	might_fault();
+	scoped_user_write_access_size(dst, len, efault) {
+		for (k = 0; k < nr; off += bv[k].bv_len, k++) {
+			void *src = page_address(bv[k].bv_page) +
+				    bv[k].bv_offset;
+
+			instrument_copy_to_user(dst + off, src, bv[k].bv_len);
+			if (unsafe_copy_user_generic((__force void *)dst + off,
+						     src, bv[k].bv_len))
+				goto efault;
+		}
+	}
+	iov_iter_advance(i, len);
+	return true;
+
+efault:
+	return false;
+}
+#endif
+
+/*
+ * Copy the pages in @bv to @i one after the other, like copy_page_to_iter(),
+ * but all or nothing: after a short copy @i is reverted. For a plain user
+ * buffer the copies share one user access section where the architecture
+ * allows it.
+ */
+bool copy_bvecs_to_iter_full(const struct bio_vec *bv, unsigned int nr,
+			     struct iov_iter *i)
+{
+	size_t copied = 0, n;
+	unsigned int k;
+
+#ifdef unsafe_copy_user_generic
+	if (iter_is_ubuf(i))
+		return copy_bvecs_to_ubuf_full(bv, nr, i);
+#endif
+	for (k = 0; k < nr; k++) {
+		n = copy_page_to_iter(bv[k].bv_page, bv[k].bv_offset,
+				      bv[k].bv_len, i);
+		copied += n;
+		if (n != bv[k].bv_len) {
+			iov_iter_revert(i, copied);
+			return false;
+		}
+	}
+	return true;
+}
+
 size_t copy_page_to_iter_nofault(struct page *page, unsigned offset, size_t bytes,
 				 struct iov_iter *i)
 {

-- 
2.53.1-Meta

