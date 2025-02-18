Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A43923ED70
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880644; cv=none; b=Yv1ll+g7OmTE9vFq065WRmpfWzrB9Q10XDedU5muXkKt+om0Wkt04TnrnGUv5zxvA+S65WFhUloTWRdNeMbq5D7/2/7buDVJUE2AxnvvjqlsvhLxy+xarjU8D2BGHP8UBSCLl7nDpYWNqMA84moqLA0a148XQ4A4Jx71uCcErFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880644; c=relaxed/simple;
	bh=1b/a6BW4aUv0mOAbZv9zI7kQHovKNsZG68lwgG/sN4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbY+bM87KL3bNz/MgoikkyN8sdHAWpaDQ9rfgMETqpIrWeZOgohmOgF3szsEc7BrcJmgRl53no30x3VMtHsl8UaG2UZLi8VFP8758I3umscX1v523B8KwaA6b8tPTPY7MQcuNqOvt+nCM3Q0w/8zIc+4M/pEBIBq2UHjlfNhksA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DKNHPQUF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKNHPQUF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739880640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mYp6Q6L+7w7tVoo4CdlHUs5PYe3qOStRgGRy3nw0hH4=;
	b=DKNHPQUFOHNMcJqy9eH03nHYvfm5EMiVOtWOL///DIM5VXxLjMxwJoAw04hUm+U377DNx0
	XfMKCSZRg5fhars5zZsf10ymD4i/BA2c/ndaKm60D+ajV6gat4LjUj9LL/iaiVkOQI9Mqh
	puddiX/bgUfYyiTXcJy6hB/of5VI4ZY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-dadCftpFP8qprSlc9rbxHQ-1; Tue,
 18 Feb 2025 07:10:37 -0500
X-MC-Unique: dadCftpFP8qprSlc9rbxHQ-1
X-Mimecast-MFC-AGG-ID: dadCftpFP8qprSlc9rbxHQ_1739880635
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A25E1800570;
	Tue, 18 Feb 2025 12:10:35 +0000 (UTC)
Received: from fedora (unknown [10.72.120.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 332921800352;
	Tue, 18 Feb 2025 12:10:29 +0000 (UTC)
Date: Tue, 18 Feb 2025 20:10:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, dlemoal@kernel.org,
	axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv2 1/6] blk-sysfs: remove q->sysfs_lock for attributes
 which don't need it
Message-ID: <Z7R4sBoVnCMIFYsu@fedora>
References: <20250218082908.265283-1-nilay@linux.ibm.com>
 <20250218082908.265283-2-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218082908.265283-2-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Feb 18, 2025 at 01:58:54PM +0530, Nilay Shroff wrote:
> There're few sysfs attributes in block layer which don't really need
> acquiring q->sysfs_lock while accessing it. The reason being, writing
> a value to such attributes are either atomic or could be easily
> protected using WRITE_ONCE()/READ_ONCE(). Moreover, sysfs attributes
> are inherently protected with sysfs/kernfs internal locking.
> 
> So this change help segregate all existing sysfs attributes for which 
> we could avoid acquiring q->sysfs_lock. We group all such attributes,
> which don't require any sorts of locking, using macro QUEUE_RO_ENTRY_
> NOLOCK() or QUEUE_RW_ENTRY_NOLOCK(). The newly introduced show/store 
> method (show_nolock/store_nolock) is assigned to attributes using these 
> new macros. The show_nolock/store_nolock run without holding q->sysfs_
> lock.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---

...

>  
> +#define QUEUE_RO_ENTRY_NOLOCK(_prefix, _name)			\
> +static struct queue_sysfs_entry _prefix##_entry = {		\
> +	.attr		= {.name = _name, .mode = 0644 },	\
> +	.show_nolock	= _prefix##_show,			\
> +}
> +
> +#define QUEUE_RW_ENTRY_NOLOCK(_prefix, _name)			\
> +static struct queue_sysfs_entry _prefix##_entry = {		\
> +	.attr		= {.name = _name, .mode = 0644 },	\
> +	.show_nolock	= _prefix##_show,			\
> +	.store_nolock	= _prefix##_store,			\
> +}
> +
>  #define QUEUE_RW_ENTRY(_prefix, _name)			\
>  static struct queue_sysfs_entry _prefix##_entry = {	\
>  	.attr	= { .name = _name, .mode = 0644 },	\
> @@ -446,7 +470,7 @@ QUEUE_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
>  QUEUE_RO_ENTRY(queue_discard_granularity, "discard_granularity");
>  QUEUE_RO_ENTRY(queue_max_hw_discard_sectors, "discard_max_hw_bytes");
>  QUEUE_LIM_RW_ENTRY(queue_max_discard_sectors, "discard_max_bytes");
> -QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
> +QUEUE_RO_ENTRY_NOLOCK(queue_discard_zeroes_data, "discard_zeroes_data");

I think all QUEUE_RO_ENTRY needn't sysfs_lock, why do you just convert
part of them?


Thanks,
Ming

