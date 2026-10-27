Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128686;
	b=BXYojftbEh1mNFwFxOc+o/gnjGIyuZ9DNdpXkwMw9Zi2r2sbGDA/KadPuiecAaPwmHNc
	 wjuNwM7o0CladkFrVUD+C9qxRgXX9Qq07AUwI0R6olJ7OQEr+H47PiTmgyZwX2MinwuRm
	 ET5DO+n6SVJQ09PFhTnjO3XERQBJY6TPfAbsuEWIEyLJ2d+XF5Zy7o9UQi31DPT8HevOi
	 Ghs3l9NVaJNR43ysY6NCf+W51koQ/DNEOW/3wMIUTl2+dUjYhVF79g/dFYfQNsEg3Gikb
	 zxbkyMvJ3ytqbUqTuiuTmSVqSMRwWFbRSZo8vA12zQk3+PvrWNlsGRgHhdZlXSF15hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128686;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Scanned-By;
	bh=7/No7ycCs2MnT2orES72SqWWMGh3qVK3ShQRxwctkpA=;
	b=J6p0Dmq9e7bVEx/vllXl3wl6JmX+O7RMLp8pbuWp9viaV6rdkE8ndV5yMMezvGOT7jP5
	 XRuk7ELat4kGlK5mzTwbVfYGEz49H/Ge/a3bCGlZuvPpGHEe7FtyJIfSRWOA7/LmkIoNS
	 7PE8OrWBPewDSYRNDL65lYCvhzqhhEAcduB0WKYYYHsWwWkNwh4HBnyaglCswF+q7Ou09
	 eNUcZlkYXgLItxq9UraUMfNBul5tsyXy/PaJAdw3GKcIsKpmtht0ebYhUN5h4fDNwA3qd
	 GQrJC5r1S/1BbTRW0dpy6P9yC+WKo+huS1z1LVPMJUw0Vywc+Ft+36ChI8itVZrBDHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DWM561VY;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B39606A323
	for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 19:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27B39606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DWM561VY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793128684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7/No7ycCs2MnT2orES72SqWWMGh3qVK3ShQRxwctkpA=;
	b=DWM561VYqLK7crBcdnASQzv+R+LBGeD5H6YXyYfXNzAU0wmdilMHcukQOP9Evru6IeWtjv
	VARF0am7RDPopiI3wQ46GSS0stw0t39xbuhtEIefli+5FPjz9uvRqrFAdZmHd0v0l3yfSs
	dddceiDtEVm/4EgpN1Fsr+vJXPXSr4k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-uA8oikN1OKqB5a_uqW4b4A-1; Tue,
 27 Oct 2026 15:18:00 -0400
X-MC-Unique: uA8oikN1OKqB5a_uqW4b4A-1
X-Mimecast-MFC-AGG-ID: uA8oikN1OKqB5a_uqW4b4A_1793128679
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 910C51800619;
	Tue, 27 Oct 2026 19:17:58 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 253971803A48;
	Tue, 27 Oct 2026 19:17:57 +0000 (UTC)
Date: Tue, 27 Oct 2026 15:17:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: shao.mingyin@zte.com.cn
Cc: mst@redhat.com, jasowangio@gmail.com, virtualization@lists.linux.dev,
	pbonzini@redhat.com, eperezma@redhat.com, hch@lst.de,
	dlemoal@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: Fix zone append sector reporting in batched
 completion
Message-ID: <20261027191756.GB933537@shajnocz.csb>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
> 
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

