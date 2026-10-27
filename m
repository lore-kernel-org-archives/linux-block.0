Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113628;
	b=y5FjZJnp8PfbGZWyCLiOmNq0sY2xfMX2Abqr02O1E08fjqwdzBQmaXEwfEX3vnYnfqUL
	 Av+k/+ilWHCfrrvR5Do4F4CO6DPMLjOu+SPbmxKycQY1davV9p7r2CqEJOfB/7L7Fi+U+
	 cFuCkV865NdoWk/yX+i7nvHbRlGjCZPtE+lM8MLNdAH4hKdS4KXzFHLfErdfKBY0uV+LI
	 qMIkM9fCYHuE4+VWQRjihNEb8CPGoD0NGA7laBphrydYnpdsRGZdac04NvjYeF45bzJ6A
	 TmeYUM1DrBoaiuti5ZMG7B3nvPXUMDFAfjYm+pYzubiMq0fUCD0IfHOHwx9lvo58TVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113628;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=wWb7DbFHMWNpVZOckBqEAJofYhxXz9iaHyVeX7ywDfI=;
	b=YfrGXDQ4lO4GiLBARHgjfMlhELd6DsTw0L7haQjd980qMDra/28mYjpq8RkV/7PL0Rcj
	 OtjG9vUlhcKQuMqolei9dx0MsIg9wdfru2jd6Jx+L0/Iw60a4CllNLI3fzTKvxw0GZ9f5
	 /E9hWItIpcbOsihiNQ1KkDk2aW4QCvEQWz/8dZdCTUlFW0Kjpr1T+xgIMIibc95/XfH0o
	 ZKswkRZv3Js/1FUp65G4qrExl8PC4iP2FNamt8HvdE+ZNuqoieWyKKZiBm01gfBmrvQr8
	 QczEAENOHpJ17nFstgNJEXQBDzBWUR4hkn5eN8Yn8T+P6+sqB013X6RaHPtKlFvlH2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355CA606A324;
	Tue, 27 Oct 2026 15:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 355CA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B075568BEB; Tue, 27 Oct 2026 16:06:55 +0100 (CET)
Date: Tue, 27 Oct 2026 16:06:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: mst@redhat.com, jasowangio@gmail.com, virtualization@lists.linux.dev,
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
	hch@lst.de, dlemoal@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: Fix zone append sector reporting in
 batched completion
Message-ID: <20261027150654.GA14436@lst.de>
References: <202610261955196384aSLGuy3_0MiTvlYXVdiC@zte.com.cn>
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
In-Reply-To: <202610261955196384aSLGuy3_0MiTvlYXVdiC@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 26, 2026 at 07:55:19PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> For zone append, the block layer copies req->__sector back into the
> bio in blk_zone_append_update_request_bio(), so the driver must update
> req->__sector with the sector reported by the device.
> virtblk_request_done() does that, but the batched completion path used
> by virtblk_poll() only unmaps and cleans up the requests before calling
> blk_mq_end_request_batch().
> 
> A zone append completed through polling therefore keeps the sector that
> was assigned at submission time, and the file system or application sees
> the wrong LBA for the written data.
> 
> Move the sector update into a helper and call it from both completion
> paths.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Can you add something to blktests to exercises this?

