Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67F23A7F66;
	Mon, 17 Aug 2026 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952831; cv=none; b=MG1oShr7oIW2MnxHcuTEys2X6Mt14Ks9WpVnVJkyr+UOglzp1a/9fF4h6gn0klYz0L6HAuVo1ig8yrKdB9+h6KlLi9o4ReeswIkqwuCdblsPo7ByXibu2VCwqWbGZCVnTtoBQA8OlQh5dALjlQ5qG8GXaLBHjZNn2soNEkGhiuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952831; c=relaxed/simple;
	bh=bTSZpnf8wyCZlBDlvISxtWkgL9AjIa7Q3HKX7HHOM7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZM7uchdR7HQBVylhJg7tMVYQHiBBCTE5zOJVogJrTuDXMc3TE5hme0Dmu1fCTiZwtyqKVJsPoe9vaXsWisAJOV6lX8Kq3Iru2nEClSbOsFGLTqhVpbuicpy77BOCjQ2K4f9T3tY+DBkKKzvjCZUFQ0aVf5Z3awKORTVkvqbfyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jCxrBi5c; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jCxrBi5c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DFDN/PdTY0WN+0gVaVVZDI54u9+PaCelSEQkbZrja5w=; b=jCxrBi5cgrH1qC0Cu/gjn2OuYm
	b8wkqzVmOdXwWJq497vOoyyRPnNtlVpxMDS2R+zqnvPjQymV7suJqBmc1b8TefC9W0Tm8yOk3TgV7
	2wo+S/UPid5UNQcclirsBYs5ynyIPflkt8aFNMvQyuFUbypCdm/zg2NEf0KE6siELuP4MuTcAlz8z
	fiZLeKNn2f+xG8a2irGOMzkCcXXEYDbNv8h3ZPjf/CXaRdgdw/v8Fp2p5nkKyGe/9YOM5oQWjykGi
	uWiyNsX0NeIuGN9z2Af38+LgDaI9fM3PTfDFzDYlKFnmWazzo0THhUY3Vg1TOZjGgOVGPFhr7UF0H
	XQYhQk9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvs3o-00000005ay8-3NTo;
	Mon, 17 Aug 2026 07:47:08 +0000
Date: Mon, 17 Aug 2026 00:47:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergii Ushakov <sergiiushakov@google.com>
Cc: virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio-blk: clamp max_segments when indirect descriptors
 are disabled
Message-ID: <aoK8fF27_nu1ux9s@infradead.org>
References: <20260814105954.4060627-1-sergiiushakov@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814105954.4060627-1-sergiiushakov@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Aug 14, 2026 at 12:59:54PM +0200, Sergii Ushakov wrote:
> When VIRTIO_RING_F_INDIRECT_DESC is not negotiated by the host, every
> scatter-gather segment in a request must consume a physical slot in
> the virtqueue ring.
> 
> If the host does not advertise VIRTIO_BLK_F_SEG_MAX and provides a small
> virtqueue (e.g. 128 descriptors on QNX Hypervisor), the block layer
> defaults max_segments to BLK_MAX_SEGMENTS (1024). When a multi-page
> compound bio arrives from the page cache, virtqueue_add_split() rejects
> the request with -ENOSPC and triggers:
> 
>   WARNING: at drivers/virtio/virtio_ring.c:1493 virtqueue_add+...
>   WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
> 
> This permanently wedges the blk-mq queue and blocks all subsequent disk
> I/O in uninterruptible sleep (D state).
> 
> Add a virtio_blk.max_segments module parameter to allow runtime cmdline
> overrides, and automatically clamp sg_elems to
> (virtqueue_get_vring_size - 2) when indirect descriptors are disabled.

What is the reason for the override?

