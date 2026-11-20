Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186848;
	b=Mzlb5Po94LhU+SX8hDnMvkUITn5mM7ko1/dSQeki8NFzsOmgUyQpBIZWPVXR9n808RPU
	 j7549uvmliejt+X6xDfu74t2wJPBXL9wybgDl4pJwsCJ9Ov2cTaoT8he+sHVMsTpcF/46
	 lzM80r0grqZwXIh829ibGoB4SaYdH56et31JpLfdqsy/9pLrh2Q1GQIpuTg9od9DM1JXx
	 3XGXjbfYsAI2xcaSsciUdXa6nJJatXoBXX9p8R8Xlt77Z+QqR82GeyyXqRk/kwWkVJJpU
	 y5DUmJojjyqcse9krV5s9kSlS3dAjedI4nKP+CkgVInfzk/w5mtuZVhcZnQS0Iqw5DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186848;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=5JBlPJli6OfYtaXbnsCRcDvuo+f9RBF/Z1J4z/dtryI=;
	b=3jMidK0q/aecRkupL1wKEC5ghcxxeN2SpX8msueJHhfhr2XvbYdKLgso90S8LhDwLSMC
	 KKbPfliD6+b38d6gtaDytkPY6YSkGCroklL4FxcD6M3eeIwM6rtZNPICSeey79KG80xXP
	 GqR04HvtT0ko1nLNbJoWv5Xqj9r0Krp04YRF3vKLoI0rcjIG0DyWz9sToYteZ/CYC7+Ze
	 K9+r6IGxloSAC+MiMk8iXnUXL8iFRI7Nx4zczSVJUCmXlSJcIjjozzo/c2rzFttfjoTNf
	 G25cDGkwNMbUw7ogl4aAc1Oa1ggA+WRMe9BhBCcrc+SMsgktiDNm9yppEt5sw1cv3ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Qm2X8Dra;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1890D6074D3D;
	Fri, 20 Nov 2026 15:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1890D6074D3D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Qm2X8Dra
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5JBlPJli6OfYtaXbnsCRcDvuo+f9RBF/Z1J4z/dtryI=; b=Qm2X8Dralnvmkui8wBcy3AnGza
	vl1q3g28aHQOBYTda6mEogDwRpsDSdw8fLBz+wcx+0lQh/78BfX+VHFOqpk9eB4wmnz8Ii5P65Hxv
	nbiNFH98h8/7LdtDGqe2o1CMVVLDVe2aWc96hu/Rr3Ej1YAScqn10ClTeEbUTC/TuVM79inFMMT3G
	URudZ4CPQaS9N5X0DabQmCB9ARkKIKKuPxJEy4rgqIq/z5O/ATBzKhbsxUaCyjz+JZYGocQjCRFzd
	DAQRKT0sYE+4ZLx8FfJ69+usqHd+rhbUCyZkFpYxnm+3ADWpZbgZiUqmzLw688PixPLe+g0dzqYRZ
	RayTdX/g==;
Received: from willy by casper.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUQ6A-00000006Tl3-228s;
	Fri, 20 Nov 2026 15:00:22 +0000
Date: Fri, 20 Nov 2026 15:00:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luigi Rizzo <lrizzo@google.com>
Cc: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Lorenzo Stoakes <ljs@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, driver-core@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/25] PISA: Pre-mapped IOVA Superpage Allocator
 for DMA and CoCo
Message-ID: <awBghmT0tiAh7OqK@casper.infradead.org>
References: <20261003212241.3432303-1-lrizzo@google.com>
 <20261109182533.3594984-1-lrizzo@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109182533.3594984-1-lrizzo@google.com>

On Mon, Nov 09, 2026 at 06:25:08PM +0000, Luigi Rizzo wrote:
> PISA stands for "Pre-mapped IOVA Superpage Allocator" and as the name
> says, it is a specialized memory allocator. Invoked via __GFP_PISA* flag

No.
