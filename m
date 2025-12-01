Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F4521348
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 00:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764548964; cv=none; b=FunWjVtgLrezUTZaCaMQCU8UattvtymVpJO9jx9SnwWSqeMQkqRlVyv1hDtsX0W6kepThGXZVaGXclQD0Um1mwQZnhxcWNA2JeW9HT04V9S/utoDovcBSdJLopPy/rwPMObXnrsQaHbfSQLAPuGPyv3LEGeadMmMxmE92AyJ1YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764548964; c=relaxed/simple;
	bh=08Ejvx+Rw3/CweA7xeeVMIlPiCYSxpHa3b1QCzDT+vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARxiXD2xIYwCqhNRvwxdHgGuueqsxoBEQ8mPhlQeYS2o8GAaTzl8r+m0m2Roi5ShxW5uVBZhUVg+PdcHLc8nsMsC+6KkmdB/Yd6/yb7SvQtYVtAsETX17UwS3wnbbgZEFwebVB4uyPk9cvgNxZxCR+Xg+pioZMm/iqz6bMk88MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pnhf4v2t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pnhf4v2t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764548961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vArVcgE+uLpoeVsUtVD5dLGMd1SvMdk+s+byUM9jYJo=;
	b=Pnhf4v2tXvDSSFylZmfNjFuNLReNHg22IAsk4nyHqUZQfN2g4AlPJz9HZMuuq8dmuv2gMU
	+6u9dPttQarhSatoQryTbCZshm0RIMtLYRIYl9FQuHt1HT8DbvPfHdFazZW8+6CusilhO8
	rWIRdG6IVJ618W3YHyhgytzqWcoiN1Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-oiDvd2fKNZ-hvN3aKUXbFg-1; Sun,
 30 Nov 2025 19:29:17 -0500
X-MC-Unique: oiDvd2fKNZ-hvN3aKUXbFg-1
X-Mimecast-MFC-AGG-ID: oiDvd2fKNZ-hvN3aKUXbFg_1764548956
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF0DA195609F;
	Mon,  1 Dec 2025 00:29:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0528730001A4;
	Mon,  1 Dec 2025 00:29:11 +0000 (UTC)
Date: Mon, 1 Dec 2025 08:29:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
	nilay@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v3 06/10] blk-wbt: fix incorrect lock order for
 rq_qos_mutex and freeze queue
Message-ID: <aSzhUuotVA2a5h2h@fedora>
References: <20251130024349.2302128-1-yukuai@fnnas.com>
 <20251130024349.2302128-7-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130024349.2302128-7-yukuai@fnnas.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sun, Nov 30, 2025 at 10:43:45AM +0800, Yu Kuai wrote:
> wbt_init() can be called from sysfs attribute and wbt_enable_default(),
> however the lock order are inversely.
> 
> - queue_wb_lat_store() freeze queue first, and then wbt_init() hold
>   rq_qos_mutex. In this case queue will be frozen again inside
>   rq_qos_add(), however, in this case freeze queue recursively is
>   inoperative;
> - wbt_enable_default() from elevator switch will hold rq_qos_mutex
>   first, and then rq_qos_add() will freeze queue;
> 
> Fix this problem by converting to use new helper rq_qos_add_frozen() in
> wbt_init(), and for wbt_enable_default(), freeze queue before calling
> wbt_init().
> 
> Fixes: a13bd91be223 ("block/rq_qos: protect rq_qos apis with a new lock")
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---
>  block/blk-wbt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index b1ab0f297f24..5e7e481103a1 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -725,7 +725,11 @@ void wbt_enable_default(struct gendisk *disk)
>  		return;
>  
>  	if (queue_is_mq(q) && enable) {
> +		unsigned int memflags = blk_mq_freeze_queue(q);
> +
>  		wbt_init(disk);
> +		blk_mq_unfreeze_queue(q, memflags);
> +

This change causes new lockdep warning, see the report in:

https://lore.kernel.org/linux-block/692c17ca.a70a0220.d98e3.016c.GAE@google.com/


Thanks,
Ming

