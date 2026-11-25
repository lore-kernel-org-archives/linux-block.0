Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625051;
	b=miqzFAjl7eXY6tz/vYXgw/4Hwf5SaHbX0fO3rSapCMfTXKaVKGN3vgIX0xj2kxto0NUx
	 pxj2UBVdDogjBzejU5nBCAGehEpOe+ioXjWv0VGd1d9h2uqM3srIMi7F7IqvtLp0lXVJj
	 V8owVh89X5qqMFuU8eXFylDJeVBwOyVtfwhp5Iq8AFCdMAel0/Huf8YmxvY1hlmQ/Edpo
	 Te3shPdHihONQ4J/Sg68WjybtCqbLLQ8TfDxODpxlpe1Q9wZ4R4s5eMNFLQ43k4fYeLWt
	 eOZAlNBIYCl/Xh2fpZgNUYcq5AZb1gKvpa0KqeiItQzpYQMuww4zcXUdrDzeC4Y8hXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625051;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Scanned-By;
	bh=j9wc/WBD4TeIiWhN9HbMNb3tvnxBQeG77ywCTfXJ2nc=;
	b=WbNmYRNULAHnNzvPOjFxqF5eQgUIPqgHkXNQ4afQDABabkLlO5c0VzY5d6AO2xpVE+Zh
	 ZYBUABGFie9OGI8dCnGy+a5rD0ftpEixhMTprCPdQ7tAYViOZ7cMFDVqArN3ZgFCQfGh8
	 NYjXTACo0KgVYwKVnXPqWqxFFECAPP+8LdxBiM1f7lUiZ8I6cW29eMut68k3DH/rpHeyZ
	 rS9Z6050xp/lyHFRUTLCo93QvCe0kOhPvjce7djqynq5P8Yh6k9TZnp/+WE9imok1E9vQ
	 W9qP9tjIc5IeglNtXGVN1KWq/SuK+ZcsnQHVdqQUJCthn5Zkhgwe2Gk7/OBpm+6iP+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W57zIl43;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18444606A32C
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 16:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18444606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W57zIl43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795625050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j9wc/WBD4TeIiWhN9HbMNb3tvnxBQeG77ywCTfXJ2nc=;
	b=W57zIl43sOJmcRg+AzgoUwa0Wmvc7FUiWn+u4UuSmZ3wGeo4XAozErg9VmYgiFkxGbGQBb
	h8eOZX8RkT220wQj92Fp4bakdw0qnyd76OtxUnAcXtSwEPO/yyOYoGk8ypIh9dtvnpKb57
	LFswNIMTAqiICccu4snr7jfHHh/1eKI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-h4s-kNO0PVOF3gg4dt63NQ-1; Wed,
 25 Nov 2026 16:44:04 +0000
X-MC-Unique: h4s-kNO0PVOF3gg4dt63NQ-1
X-Mimecast-MFC-AGG-ID: h4s-kNO0PVOF3gg4dt63NQ_1795625043
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BF801955E96;
	Wed, 25 Nov 2026 16:44:03 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 96F791800550;
	Wed, 25 Nov 2026 16:44:02 +0000 (UTC)
Date: Wed, 25 Nov 2026 11:44:01 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alberto Faria <afaria@redhat.com>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH v3 2/2] vdpa_sim_blk: add support for FUA writes
Message-ID: <20261125164401.GD10456@shajnocz.csb>
References: <20261125083947.263216-1-afaria@redhat.com>
 <20261125083947.263216-3-afaria@redhat.com>
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
In-Reply-To: <20261125083947.263216-3-afaria@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Nov 25, 2026 at 08:39:47AM +0000, Alberto Faria wrote:
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> index bb137e4797633..70890974b6e56 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> @@ -45,6 +45,7 @@ struct vdpasim_dev_attr {
>  	u32 nas;
>  
>  	void (*work_fn)(struct vdpasim *vdpasim);
> +	int (*validate_features)(u64 features);

This is okay for now. Possible future changes:
- It may be necessary to split validate_features() into
  validate_device_features() and validate_driver_features(). This is
  because the device can advertise all possible features even though
  drivers may not be allowed to enable all of them simultaneously.
- A struct vdpasim *vdpasim argument will probably be needed for checks
  that depend on the device itself.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

