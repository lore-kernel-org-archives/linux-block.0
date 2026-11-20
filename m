Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795136845;
	b=E0myNZBmhVmYxjWU7Yol79JPg4CFQur0LgwntEfnkRPdve/q5F7yMeL+WmioWl0XY+w+
	 L625Kbrys2d8dPmBmLKQ/4NoqItjDeA9doBtWOPM25Y6HCU5APxxfWHvFFCC34y5UaT7y
	 6AuywSzA/2RHof5+bFyMzFdlauFDmMe7JAuVHYtv0KXr/F/Qa2frbV9BPiZJOmMBCnKT5
	 Xh6JiQwjmCnVYE8Bb8JltscJiJSfTjs5fBI1A6USTVMS8s5w5FaEKzBAu61MirdYTquLa
	 owkr3W10ZopFfri0dwHIYj+ftewK0MeTYdkweE0wewA8mgzEiGDCsfpqV/ibuViAakA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795136845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=dRkr2BvKaK0JNp+xEr+CP1uqN9jcKW992wqEJ/xsaHY=;
	b=UcJrhDTRXtQH1Yw2pZHw0mVM9cuolcH88Hj0L60NL1QaYlW2JKivdrU4kMGHUhovMKx/
	 Wcvp01jDVaxGjGY6ffURNoQBD3vaQRISBLplvwvIUbOnthrx/HGoxsvVei0wb/2qkSxet
	 WMdslKt7CWI6J+DucHzCVFR4GgWAsmi6hdefXzDjd06vz87tTlSljyoCfeJdqSHIUgrPb
	 /HAZW4OKF6m0fjD5h9lunFBYnQHQYoLEAAaNaNabvqVwjgtqqve8vUq0SMyW8ZcJMyHZq
	 3AeySuIBb8TSErMpAGajBei9NUkKL+so3gyU63vyfauSEBKbBYueLOOtjSEm7S3S49w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ES4ennDZ;
	arc=none smtp.remote-ip=209.85.208.71
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5132060A5BC9
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 01:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5132060A5BC9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ES4ennDZ
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b879462421so1812603a12.1
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 17:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795136843; x=1795741643; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dRkr2BvKaK0JNp+xEr+CP1uqN9jcKW992wqEJ/xsaHY=;
        b=ES4ennDZTflXaeQYEQfAfoxa0BxH02PkL8QJTPLMmiyR8dGrQsgV/SPDpmfK9jWggM
         8PsX/g1+mZvKeuRNgQkM8SEyf2GEO9at10u0q9ywBXwoo9l49k6G4O/x40PqgY030zP/
         igs4cHyJTjN/xg8fABXqLn9FfqPtAL28NK9ZFbdjjzUI7ufY/4gx3bAOAuFk3MLlq7VR
         qpTGXQmaxwPLPGIKBdDahDSf6RCltzeLW6C+1MDEgwNoiZxMqqYB14/uaR1OzpKhQwlL
         S9hgbuZSqmEyW1dCCCazJwkmHAGJfc27Sv+lSoZqyUK6hrlaDOSC4YVeqtW5w+FUWT9B
         kYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795136843; x=1795741643;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dRkr2BvKaK0JNp+xEr+CP1uqN9jcKW992wqEJ/xsaHY=;
        b=fd+G/LRB88CmRYBp+Mys/3oyBhwkRqhQBKdlgTEMOh2G4SguAlgF7AT5aYkG4mcEpl
         xWccicrnmHaSQViFehd9fLCWFV4s1PiuIne6EYR/if2okvoyNrH2OV6yAko4C5tviK8/
         k/EsCv7TTgWg+JYzXLtNr2b0S39N4gCqbveEblxfa7rmoTYAUiGDKCFyL5fGcAe6Ro10
         TFJncHEf24xWKWExwLe3enVBqrnonEBNMdDk0paWJclRFjV50aJ4h1BNfMnBJ2c19pA7
         fwycShrCQ4G1vg52X89j/dPJKHfTr7lMPDlJytXjGFhy40o+kWkLmuGkWY2J8vAdUNBI
         7lXA==
X-Forwarded-Encrypted: i=1; AL+hErGyJHEcfScZrEltQIKcCblUtbz2xIymjFWZJmSo5TTL/Bp0IPS5dJJev+245rbVYHWzdOuQlfqbjJNURg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZHNQolO4DCLxerF4qNVxUs/9pUvSwI1EygNVlMZLoFfxTM5wW
	oe4b45QVoi6L5ZfulZlVQCgNazxL1YhdQarnYqLMX3IzT8i4UxzlKeEO/2SN215Lm9VYR7JUbGP
	eSAetrw==
X-Received: from ejcfw45.prod.google.com ([2002:a17:907:502d:b0:c50:519f:c790])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:370b:b0:c51:34ae:dd7
 with SMTP id a640c23a62f3a-c5134ae12d8mr166377466b.17.1795136842505; Thu, 19
 Nov 2026 17:07:22 -0800 (PST)
Date: Fri, 20 Nov 2026 01:06:50 +0000
In-Reply-To: <20261120010655.467825-1-lrizzo@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109182533.3594984-1-lrizzo@google.com> <20261120010655.467825-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261120010655.467825-21-lrizzo@google.com>
Subject: [RFC PATCH v3 20/25] arm64/mm, mm: Support decrypted PISA pages in Realms
From: Luigi Rizzo <lrizzo@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Luigi Rizzo <rizzo.unipi@gmail.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Harry Yoo <harry@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Naman Gulati <namangulati@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

An arm64 Realm (ARM CCA guest) only reports CC_ATTR_MEM_ENCRYPT, so PISA
did not treat it as a CoCo guest and refused to initialize there.

Treat a Realm as a CoCo guest: PISA pages are decrypted (shared with the
host) when they are allocated, as on SEV-SNP and TDX.

A decrypted page is mapped with PROT_NS_SHARED, the top IPA bit, set in
the address field of its PTEs. PISA maps such pages into user space with
ordinary PTEs (page cache, migrated user pages, zerocopy receive), and
for those pte_pfn() must be the PFN of the page, or vm_normal_page() and
GUP see a PFN that has no struct page.

Make __pte_to_phys() strip the bit when what is left is a decrypted PISA
page. The check is behind pisa_decrypt_key, so outside CoCo guests it
costs one static branch, and every other shared mapping (ioremap() of
emulated MMIO, swiotlb, DMA mmap) keeps the address it has today.

pisa_decrypt_key and the lookup are exported because pte_pfn() is used
by modules.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 arch/arm64/include/asm/pgtable.h | 28 ++++++++++++++++++++++++++--
 mm/pisa-meta.c                   |  9 +++++++++
 mm/pisa-node.c                   |  9 +++++++--
 3 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index a474c9fb485ad..86c60b8f43ae0 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -108,7 +108,7 @@ static inline void arch_leave_lazy_mmu_mode(void)
 			  TLBF_NOBROADCAST | TLBF_NONOTIFY | TLBF_NOWALKCACHE)
 
 #ifdef CONFIG_ARM64_PA_BITS_52
-static inline phys_addr_t __pte_to_phys(pte_t pte)
+static inline phys_addr_t __pte_to_phys_raw(pte_t pte)
 {
 	pte_val(pte) &= ~PTE_MAYBE_SHARED;
 	return (pte_val(pte) & PTE_ADDR_LOW) |
@@ -119,7 +119,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 	return (phys | (phys >> PTE_ADDR_HIGH_SHIFT)) & PHYS_TO_PTE_ADDR_MASK;
 }
 #else
-static inline phys_addr_t __pte_to_phys(pte_t pte)
+static inline phys_addr_t __pte_to_phys_raw(pte_t pte)
 {
 	return pte_val(pte) & PTE_ADDR_LOW;
 }
@@ -130,6 +130,30 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 }
 #endif
 
+#if defined(CONFIG_PISA) && !defined(__DISABLE_EXPORTS)
+DECLARE_STATIC_KEY_FALSE(pisa_decrypt_key);
+bool __pisa_phys_decrypted(phys_addr_t phys);
+#endif
+
+static inline phys_addr_t __pte_to_phys(pte_t pte)
+{
+#if defined(CONFIG_PISA) && !defined(__DISABLE_EXPORTS)
+	/*
+	 * In a Realm, PISA maps its decrypted pages into user space with ordinary
+	 * PTEs. Those have PROT_NS_SHARED, the top IPA bit, set in their address
+	 * field, but pte_pfn() must be the PFN of the page: strip the bit when
+	 * what is left is a decrypted PISA page. Other shared mappings keep it.
+	 */
+	if (static_branch_unlikely(&pisa_decrypt_key) && (pte_val(pte) & PROT_NS_SHARED)) {
+		phys_addr_t phys = __pte_to_phys_raw(__pte(pte_val(pte) & ~PROT_NS_SHARED));
+
+		if (__pisa_phys_decrypted(phys))
+			return phys;
+	}
+#endif
+	return __pte_to_phys_raw(pte);
+}
+
 #define pte_pfn(pte)		(__pte_to_phys(pte) >> PAGE_SHIFT)
 #define pfn_pte(pfn,prot)	\
 	__pte(__phys_to_pte_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
diff --git a/mm/pisa-meta.c b/mm/pisa-meta.c
index 99c5bc42eed10..b608ef71152af 100644
--- a/mm/pisa-meta.c
+++ b/mm/pisa-meta.c
@@ -189,6 +189,15 @@ bool __is_pisa_direct(phys_addr_t phys, size_t size)
 	       (phys & (PISA_SIZE - 1)) + size <= PISA_SIZE;
 }
 
+#ifdef CONFIG_ARM64
+/* For __pte_to_phys(): true if @phys is in a decrypted PISA page. */
+bool __pisa_phys_decrypted(phys_addr_t phys)
+{
+	return pisa_pfn_flags(PHYS_PFN(phys)) & PISA_DECRYPTED;
+}
+EXPORT_SYMBOL(__pisa_phys_decrypted);
+#endif
+
 /*
  * Update @meta's position on @pa's lists under @pa->lock. When all blocks
  * become available (avail == bpp), either queues @meta to @pisa_free_list (and
diff --git a/mm/pisa-node.c b/mm/pisa-node.c
index 12fbb617c342b..aa4f8759ae5e8 100644
--- a/mm/pisa-node.c
+++ b/mm/pisa-node.c
@@ -36,11 +36,16 @@ unsigned int pisa_reservoir_max __read_mostly = 16;
 
 /* Enabled in CoCo guests by pisa_node_init(): new PISA pages are decrypted for DMA. */
 DEFINE_STATIC_KEY_FALSE(pisa_decrypt_key);
+EXPORT_SYMBOL(pisa_decrypt_key);
 
-/* A confidential guest: PISA pages are decrypted for DMA. A bare-metal SME host is not one. */
+/*
+ * A confidential guest: PISA pages are decrypted for DMA. A bare-metal SME host
+ * is not one. An arm64 Realm only reports CC_ATTR_MEM_ENCRYPT.
+ */
 static bool pisa_coco_guest(void)
 {
-	return cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
+	return cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) ||
+	       (IS_ENABLED(CONFIG_ARM64) && cc_platform_has(CC_ATTR_MEM_ENCRYPT));
 }
 
 /* Memory encryption that PISA cannot handle: neither an SME host nor a guest it decrypts for. */
-- 
2.56.1.809.ga0b61035b5-goog

