Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794570843;
	b=e5mAm9VEE08S1ojzUE80qo6R2t+p5dPjK8NJDQzqAuvoHX7xgO+FzMmvkoN6Gqjh9HUz
	 eIiQ1r5pwt6gg8KgjcWCvoeNAJuHDd+93ppJhYTWuOijmy+Q5rVc5Q8wWCSLgQGdr48DO
	 YCxUwO9+g7nXIYYtgkRuUg50EXZy32HTE0InQD/DuXEWwzcRvPhgi/ftdGuXIujXZFNDd
	 sowO80oTo8kIA/bHAKQVkrFWz/iCp1SqkLvdeg3J3dgNknD+GJFe5VD2UNi58rrGp69ZH
	 RM2i29iAUQqNJnFAi2my9SCLYT9N+8tl2UPFgK3+TiWW85dNrm4VMkj+F4oyDBg+VnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570843;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=6VIbklSNHpaHPe7owsh2v83BxTALTQC2OqvtNAbZbXI=;
	b=3S6TIGV50IlAQvG0haZaxeVdvoKHTKYCmt8ax5523L+D7LAgcw3wxgkZ9GAtBTIe+nBL
	 0rH7jkrcQn/lC2KO3PnR75UrmEIUmjSjUxTdK2zet4cwJT1s4jTlLxXyhz36vuhnZ4UIU
	 DwNNICQP/TfEMzFP1Hj/T8uO80C5g2w5w+qpm4QIvCO34k2iMuoJ32fcX/kDw4e57cmJQ
	 UFx/PuvjbAwzXZmQYvKp579Lz4trfBbccwLBWu2JqhMr1KjiXXO4qr4wMb64E5Lkhuwfh
	 fa9YbTqe+yLhfvSQge/qm7ybPpaMNHhRAlTNHtTES/lQbLoCgxdoe26CNs/i61kqmtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=IzI4iTo0;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B594606A327;
	Fri, 13 Nov 2026 11:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B594606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=IzI4iTo0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=6VIbklSNHpaHPe7owsh2v83BxTALTQC2OqvtNAbZbXI=; b=IzI4iTo0ZVEwy1OH8iwa+c73xY
	0KUoKKcJRmreZEJ2CxMJziUAVJa5eQ92NiD1TtZmzBP0lug0FD2AYVlrYU8P+yBNSBUm/dt/TF5Z9
	PqWpr9+6+0qqK7AjyRg91xOhOxNTqi9JPlTgPABLFNP0I244jluLiaMzI7oI6ybbIZ2THP1y0YCUr
	ynAAwdcEy++jHUTivojn3C0HA3c4x/EM9TVh/qe1VzwnLj+cIdfZlESeGFGHYHWy8cL09dZpzLYis
	GtpWNol5sPANH1YOa1H2RMvBTsvyX2i1eW4IAgPqvKHoYFXuJsyH/dXS6k5AmZrZceOEt/n8MPJQl
	GpH9Z1eQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRpqy-00EjRf-18;
	Fri, 13 Nov 2026 11:54:00 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 13 Nov 2026 03:51:44 -0800
Subject: [PATCH RFC 1/3] x86/uaccess: Split the STAC/CLAC out of
 copy_user_generic()
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
Message-Id: <20261113-pipe-pool-regression-smap-v1-1-b0dc69558ab3@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2421; i=leitao@debian.org;
 h=from:subject:message-id; bh=q+SZD0RppzaqbM7PSuQLymGR+DDCy5YJ0lZdm4LMUQ8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9vpO+0WC5Jq8WOr3cMvtJzAD2pMPuQC/mi6lv
 aXNzyucEa+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavb6TgAKCRA1o5Of/Hh3
 bbpKD/wMyMhvRxYBWqizEDe9KIQkp5+yBCqnDdFOHXa2dvdFBzE+oiQiI6HHolWqJ6Yq33HBwQo
 u5/UxJKW6QbWHn4/+sORO3BCCzsdgL5eJzK7MHfYtkpjDYl70khrOVUcV92w0qw/8VG1VUuc78p
 zh8VIyBPTccxekCjEwrvVjBtsDGETmDPCB0xwANxwsxK+9xu+DC76bn0zoBJWLHiwWo3w/eBM5G
 4F0i0r/vda59wEUjAqU25QDqg/D47aJoHSKg/PniFQlvPQO3L/0FXuJDNtSQlaqruy/v5mCMuUa
 V100X6m41a2yuqA/AOFPvltX+otjqdrExF52poxSM3Tz5YVFz3YDTKmRFdDj+BxQKRulAN77tnP
 O4BNW5Fu89ewXpuZz6Zw3a0aXGjdmvy4952s3dHgPQX2E9p6DJTcOTdRdMBeVKgQGiXwxfpqRN3
 6GwSBEBKXaA3emAhgZbvXE33QW9mD1j8AFMkR7RXWHK2upYWfbrnEsZ6vibeAUm6v9JlpnB+K1q
 65co7KGR9aoqe2+nxQItz73g5QbKslYskfIG7/5kG2ho0C+F0XuFtCFufNRhTkS9P+g5F8bKuwn
 h+p+WXP1I59GKut/Cb6rkJVg6S8HxCI+xD00pwDTwioSlMEK8ss800HbSDaz5RsAAsmeABvdx12
 ocAMXR111DxVS+Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

copy_user_generic() brackets every copy with STAC/CLAC. A caller that
copies several kernel buffers to or from one user range pays for a pair
per buffer, even when one user access section could cover them all.

The x86 unsafe_copy_to_user() works inside such a section, but it moves
8 bytes per store, which is the wrong tool for page sized copies. x86
has no unsafe_copy_from_user() yet, and the one posted with the sframe
unwinder [1] is the same loop for reads.

Move the body of copy_user_generic() into unsafe_copy_user_generic(),
which leaves STAC/CLAC to the caller's user access section, and turn
copy_user_generic() into a STAC/CLAC wrapper around it. The existing
callers get the same code.

Link: https://lore.kernel.org/all/20260821195259.2688377-19-jremus@linux.ibm.com/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/include/asm/uaccess_64.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 20de34cc9aa6e7..b2bd40d3768d4c 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -115,10 +115,13 @@ static inline bool __access_ok(const void __user *ptr, unsigned long size)
 __must_check unsigned long
 rep_movs_alternative(void *to, const void *from, unsigned len);
 
+/*
+ * copy_user_generic() without the STAC/CLAC, for several copies inside one
+ * user access section. Returns the number of bytes not copied.
+ */
 static __always_inline __must_check unsigned long
-copy_user_generic(void *to, const void *from, unsigned long len)
+unsafe_copy_user_generic(void *to, const void *from, unsigned long len)
 {
-	stac();
 	/*
 	 * If CPU has FSRM feature, use 'rep movs'.
 	 * Otherwise, use rep_movs_alternative.
@@ -131,6 +134,19 @@ copy_user_generic(void *to, const void *from, unsigned long len)
 		_ASM_EXTABLE_UA(1b, 2b)
 		:"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
 		: : "memory", "rax");
+	return len;
+}
+
+/*
+ * Hack: lets generic code test for this helper.
+ */
+#define unsafe_copy_user_generic unsafe_copy_user_generic
+
+static __always_inline __must_check unsigned long
+copy_user_generic(void *to, const void *from, unsigned long len)
+{
+	stac();
+	len = unsafe_copy_user_generic(to, from, len);
 	clac();
 	return len;
 }

-- 
2.53.1-Meta

