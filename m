Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388982;
	b=VUVSSR+RQanJWYAmR0SZHphYCDrmram5OOFsYTCw7Ju/IrRPgRUTZOSnARbqMwTWtdRU
	 MIahhZaRKq0PKO4RfUm0dvx/TOOQ+0LJELazD9oPWz9HMtuxFUQCzCRud45ww/2T+TtIK
	 AAwibdULye3RbB71dMgVBaW9yYDlLoucqOhXsHxNbVKsrOp4eCOEaZLASV/Twsee2dcku
	 yUGYUB6oRyhlx312L3YBPSsSOqgXruushPqU/OqeBQCZ9Y9NtaENNzvK0MPXQo9rm4vIY
	 MlNhy/KOp5KwTATTbek7kM4oIknmWot5JX3wXuIERC3O757a3D+HV7LpH1NP0Ype09A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388982;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Scanned-By;
	bh=QmMJdpeOrbBF2O8Rw/Eya6dBXKB/QLzdOLPIp3j0r8U=;
	b=NVCbJjb14/lv/DTVOS4mJhU789gadildP0/e/YYtF4A2EHweyW3koXAI+dQr4m+uCUnx
	 cnFeS/+jCr0oG6Symh0SGqMyuDdao4SCNrjqDpV3N4G40zGhmkVxZysG6eaH72wlq4pZ2
	 8kJ+h3J1M4xYzdZb27G1mFPCo3jZOc04F6u7TYAC1DhJ7hOy9bX6HtMIADpwWG9f5Olnt
	 MPELKdH6GDra1Y09q30jUF6FhSgJpHixRGJrd+oIT+4s3oSjipZmIbw5D12DXHDT9XHPy
	 0Sq//kx7c/gxEVZxpI7yKv9Tg8mbsHbgRqqlpwW4UN9nDUdj5Bc1NnjzOO9jYCEp4mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CVPAX+Yu;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81921606A31A
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 19:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81921606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CVPAX+Yu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793388980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmMJdpeOrbBF2O8Rw/Eya6dBXKB/QLzdOLPIp3j0r8U=;
	b=CVPAX+Yuc4QZ+dMn93gGo+0X9dp27j4STyqFAnA2HPkRG7VEg85FtkFN9O3lc8X/PK6Wrz
	69kQdJGc8ihlZxpQ4x/v1KsEo9MkieZK9HwiVpofv+lWmcQzeox09Xq2XYuW5RziG3njK8
	iC9wfGnLevpFQbkDw8e9kiPf71+vqws=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-b-BZeOgUOHiMET9nfAtkiQ-1; Fri,
 30 Oct 2026 15:36:19 -0400
X-MC-Unique: b-BZeOgUOHiMET9nfAtkiQ-1
X-Mimecast-MFC-AGG-ID: b-BZeOgUOHiMET9nfAtkiQ_1793388978
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DBA018011DC
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 19:36:18 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF0D87DA;
	Fri, 30 Oct 2026 19:36:17 +0000 (UTC)
Date: Thu, 29 Oct 2026 16:09:40 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alberto Faria <afaria@redhat.com>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] vdpa_sim_blk: add support for FUA writes
Message-ID: <20261029200940.GA1589831@shajnocz.csb>
References: <20261021055235.648957-1-afaria@redhat.com>
 <20261021055235.648957-3-afaria@redhat.com>
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
In-Reply-To: <20261021055235.648957-3-afaria@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On Wed, Oct 21, 2026 at 06:52:34AM +0100, Alberto Faria wrote:
> Expose VIRTIO_BLK_F_REQ_FLAGS and VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA to
> drivers. The simulator is a ramdisk, so it handles FUA and non-FUA
> writes in the same way.
> 
> Signed-off-by: Alberto Faria <afaria@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> index 76dd5b0828d7a..bfdb2de4d6807 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -31,7 +31,9 @@
>  				 (1ULL << VIRTIO_BLK_F_TOPOLOGY) | \
>  				 (1ULL << VIRTIO_BLK_F_MQ)       | \
>  				 (1ULL << VIRTIO_BLK_F_DISCARD)  | \
> -				 (1ULL << VIRTIO_BLK_F_WRITE_ZEROES))
> +				 (1ULL << VIRTIO_BLK_F_WRITE_ZEROES)  | \
> +				 (1ULL << VIRTIO_BLK_F_REQ_FLAGS)  | \
> +				 (1ULL << VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA))
>  
>  #define VDPASIM_BLK_CAPACITY	0x40000
>  #define VDPASIM_BLK_SIZE_MAX	0x1000

This allows VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA to be negotiated without
VIRTIO_BLK_F_REQ_FLAGS. Please check if there is a way to prevent this
since the spec requires it.

Thanks,
Stefan

