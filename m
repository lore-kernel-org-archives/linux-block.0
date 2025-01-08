Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3B51F8686
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736332776; cv=none; b=C0URxjIr62uhcXd56uCl9moAb6V9vEjb+kG71vmzxeYvmNDwwdtSvyQVI9yRau98UuiVUfJ0IX0UAoQR/KhA7HGlvQku9SFfB6wjXF1vf+oqSca9fjgNpiyMw7YNMPNRvbx1y3iFAR3mgBBa+axMC+HzcImyp7prJXCeZeJKxaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736332776; c=relaxed/simple;
	bh=A2IyPJwWkj30aPtAZEzNBsxxqeIDBEL196dSUFXRCqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srXfke6WRK8KSfRXvYjkkjJhcP24uAZWIdRjeG7gfcm2GAueOYk2yb/EOv2YAQ2+CRh9BHhuoJK1ACeBMLQDdXYjUVLmPxKwwTZLLmmnrE1TdFjOQXu7uUXenmsj6NQ8EbmXjnAxKDoPhbafEfrEiA9wpo8XETKnwFaFE7BCCWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tzy2g/q4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tzy2g/q4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736332773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5e7qX6c+UMsIuToE357cYeqwuSYtBePWh3qPklcP7I=;
	b=Tzy2g/q4sb5M4c8cY7C4noWnpW7Ejw6yI8B1FP/KcqmcmA2WSr8mtK2+zcxyG/cSwyHPjR
	amEkSEaI0xFv9bZ8ASJZSk2eGjx1fwYZRlKYGDZsIegR8q+0VzEpA0foE4QZsT/jqDGiV0
	3WruP2/kxaheLRsSoWBsKOV5iAx+XDo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-L_aTQMnBM0So-ZDJs6AXYw-1; Wed,
 08 Jan 2025 05:39:32 -0500
X-MC-Unique: L_aTQMnBM0So-ZDJs6AXYw-1
X-Mimecast-MFC-AGG-ID: L_aTQMnBM0So-ZDJs6AXYw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB66919153C8;
	Wed,  8 Jan 2025 10:39:30 +0000 (UTC)
Received: from fedora (unknown [10.72.116.74])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF54519560AA;
	Wed,  8 Jan 2025 10:39:24 +0000 (UTC)
Date: Wed, 8 Jan 2025 18:39:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 06/10] nvme: fix queue freeze vs limits lock order
Message-ID: <Z35V11UDYRCHgJgI@fedora>
References: <20250108092520.1325324-1-hch@lst.de>
 <20250108092520.1325324-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108092520.1325324-7-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Jan 08, 2025 at 10:25:03AM +0100, Christoph Hellwig wrote:
> Match the locking order used by the core block code by only freezing
> the queue after taking the limits lock.
> 
> Unlike most queue updates this does not use the
> queue_limits_commit_update_frozen helper as the nvme driver want the
> queue frozen for more than just the limits update.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
 
Reviewed-by: Ming Lei <ming.lei@redhat.com> 

Thanks, 
Ming

