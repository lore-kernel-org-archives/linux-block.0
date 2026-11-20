Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795136849;
	b=hOqILkmbRiv9H5TBXTKaXawRkp76XeGbq+cvpvyAhInvm4npMMSvnl6eWIFmBVGu5qJv
	 XVgexnTqS2SxdSaxA7wL8F+lZgpf3QUb5Sj7FUFXezi5xy7rMXPTv7ET8oIjuBXBw06+F
	 62b9709Us+bvHBNPvuNoCAxMtDGHsJnaYEB6NRlV3sCiZUnmiAM4w82TPECDtf4H9Qeb9
	 QaV0VXCMk3J9nw9wp6EDXtWhnxEOiCtvcgDFAKZzIhzF0NSbjvs6h7VWnMAezN/VF38L6
	 5NBJkufaLKt0nsdg36JA550wRqc7SB8+fzMhUY7Rf167PJLzhypwvz0652lPRjsdUNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795136849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=G58QRfdEQzG7y46akZhuXorptjXMkpo3OuC8LCJ2NV0=;
	b=AI2U0oDjuGP+0nn0qNgDkaJLdKzpVyG4hJPvreaDtkEtYn+U3uJswIbTUUQz2NN22wAM
	 kRb3AVhtyIfhUyW9y1+2OMZ9l8JBgL/F82XDbtHHeluH8T4VTGLEmSrlIQidCA7cFR27V
	 CTbk01jyDiPnDsMF+RmBU7CsNJWluk+AIwQHvAb0qldRhzZ7engA8zXOz0VEjD7S7qNzR
	 YZVLhmEcsnQ4Lq7W9kZc6VHF7Gq9LeHByA5jXs72ekgaiKGidFZ3bGee/QMp3FqMirIuW
	 lQqu/qNSVYn5N5NxAIbBgxBB3cmy1TM1ysmoXlAhaFYNoCSSPoR9I2GAqvNVGzLujWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="i/NRDXeT";
	arc=none smtp.remote-ip=209.85.208.72
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD0860A5BDD
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 01:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BD0860A5BDD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i/NRDXeT
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6ba1338b185so297223a12.0
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 17:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795136846; x=1795741646; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G58QRfdEQzG7y46akZhuXorptjXMkpo3OuC8LCJ2NV0=;
        b=i/NRDXeTSYEfEezD5V1XCNniH5DnQR9vfzm+vN5gKK7HSmUVNFLhUWOtZn4LXRiIJQ
         7lOr84/ZOjXvt7ritNVVu/osy3RhSUyU3FCk+Pw9T0yIlE0tS9M7K5m0c5cvKVY4vcRh
         vDQGrnMk78tO+qeqC8ad8KBdcWSowlXT2FagYVCCZtB/EJiLRo+yck6vYxjyaPewi4vR
         UL0d9YPpJ3xayrffRlaaHIljkm3oTX4gKw2dicVuQ8h3dJIW5pRCbKERyujSv1BcD6ie
         J2zwyS0rwBonSC+WfgiN2c/3IOZmtmGZKJHfgc25vf4U4QDfGhET0Dxyxo5sdg5s1aQI
         Jd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795136846; x=1795741646;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G58QRfdEQzG7y46akZhuXorptjXMkpo3OuC8LCJ2NV0=;
        b=d+V3ug5OnOt3Asn19382gSBYblOmfP6omT0U5BBNP0XqraPzXUTxabuQ61danzrlpg
         vj3zoFG6qsYfSpWXXyX0ClpxTNRqzBtXNgPd3LQEJjaRQcxABlEo7AkzWjSVVSNJMrmP
         0JTOIMKxV60fmLT9piE1rwHJKUAx8KbUte4JzWUSCXtHC2hCTC4l6TMXyqoqbsj7nH0b
         ZQEjGZ+VWSJKxd/Ct3xkqCWPTLFU1YLCNuk/E6x3g19lLF+Wn7dv6zkJTj5r87RDgtln
         ecteNmfwDoEP52Gzyh0Ts8LHgW9H0dRWz2OfhI9vVGBDB4xSC8KDzFSIbON+E7lzcTxB
         tdNw==
X-Forwarded-Encrypted: i=1; AL+hErHdjS5NpJ4CVkbVQZkEgkt6osd1XD0kH9FeVforGf6CTmgOK2Ly9VpvOumn9X3lxlK0Ybz0zRaWaA/w7Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+7MSjZeLaMW/8yDWowijQyQZ/neD+oBjjC/HZO5x7fufXPnyib
	2EGfLs5MRNbiC9MjQ9NEgLZ7JkoQrFjw47ZivQyg+Dp+3RoSKcIAEGN0M+Zc5yzrsco8NyH4Wfd
	RbQsmaw==
X-Received: from edag35.prod.google.com ([2002:a05:6402:3223:b0:6b7:7926:2af4])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:1c05:b0:6b9:c43d:892
 with SMTP id 4fb4d7f45d1cf-6ba37c7bebdmr666829a12.1.1795136845436; Thu, 19
 Nov 2026 17:07:25 -0800 (PST)
Date: Fri, 20 Nov 2026 01:06:52 +0000
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
Message-ID: <20261120010655.467825-23-lrizzo@google.com>
Subject: [RFC PATCH v3 22/25] net/libeth: Use GFP_KERNEL when pre-filling RX rings
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

libeth_rx_alloc() is called both when pre-filling RX fill queues in
process context (for indices 0 .. fq->count - 2, when buf->truesize is
still 0) and when refilling RX buffers from NAPI softirq.

Use GFP_KERNEL during the initial process-context ring fill so page_pool
and PISA page allocations (including set_memory_decrypted() under CoCo)
are not forced into GFP_ATOMIC context.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/net/libeth/rx.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 0e736846c5e8a..4361dbcf03cb1 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -106,10 +106,17 @@ void libeth_rx_fq_destroy(struct libeth_fq *fq);
 static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
 {
 	struct libeth_fqe *buf = &fq->fqes[i];
+	/* fq->fqes is zero-allocated and pre-filled in process context for
+	 * indices [0 .. fq->count - 2]; slot fq->count - 1 is first allocated
+	 * in NAPI. Use GFP_KERNEL for initial pre-fill and GFP_ATOMIC after.
+	 */
+	gfp_t gfp = (buf->truesize || i == fq->count - 1 || in_softirq()) ?
+		    GFP_ATOMIC : GFP_KERNEL;
 
 	buf->truesize = fq->truesize;
-	buf->netmem = page_pool_dev_alloc_netmem(fq->pp, &buf->offset,
-						 &buf->truesize);
+	buf->netmem = page_pool_alloc_netmem(fq->pp, &buf->offset,
+					     &buf->truesize,
+					     gfp | __GFP_NOWARN);
 	if (unlikely(!buf->netmem))
 		return DMA_MAPPING_ERROR;
 
-- 
2.56.1.809.ga0b61035b5-goog

