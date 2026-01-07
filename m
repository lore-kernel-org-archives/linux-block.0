Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697443002B3
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788105; cv=none; b=D60k1cduhh5c3xSUgXgl8C3Af2zaaaqVRwFdYjzIiIUNWB7CaEsRP7+oHAQFmgjWnYZ6N0sJDlsssvtAHs8sG9t37Qi/2+aaDBALiiUW8VmAjwqlcBdeeaxIyQIkWNnpWIYCEp75LP47FhVu3mWZDRV+iPHV+5KoV+dJfi1slQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788105; c=relaxed/simple;
	bh=wTwB/MWxgSAQTEGqC5XkldjS4z9YvtVirFzBQksS9/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJ24D6IpaWVgdjWaksbJcAkxeXO16kFAzz1zdWYi/lNEo/ZbAcwU6YYdpnuLXXMmALT3DYfL3wZkWFPLFmSOIpDLw7yzjo4nrTiuQWsgS/vTQOHaHf5xMBOvgOVM/NIl5jNfLdmh94D67ppx2Ym03EwYcKxRX2LROTqtoGd+mDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kcc+H+bv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kcc+H+bv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767788101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXtd+NTktCGMV4ePiVAp14LxBZ6CSxYMhFnJ3IAV0b0=;
	b=Kcc+H+bvOtB2b516OWDNn8frmPJtU1qYGKNjALdjhl4nyslYGTuxa0SJpFINjV1nxmHXsJ
	obNXcVNUABuwsN6YtbCb6AK6PRwDyMsPWMe6GIc7h00E0sJLb+FAOqvva0JztILYnEE/Cq
	TxpQDOspGWl8xWH6LTRd4Y8VsiF5aTw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-3chibUtYMb-45_UY8M4vmQ-1; Wed,
 07 Jan 2026 07:14:58 -0500
X-MC-Unique: 3chibUtYMb-45_UY8M4vmQ-1
X-Mimecast-MFC-AGG-ID: 3chibUtYMb-45_UY8M4vmQ_1767788097
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 934AC180034F;
	Wed,  7 Jan 2026 12:14:56 +0000 (UTC)
Received: from fedora (unknown [10.72.116.199])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E55630002D1;
	Wed,  7 Jan 2026 12:14:50 +0000 (UTC)
Date: Wed, 7 Jan 2026 20:14:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
	nilay@linux.ibm.com
Subject: Re: [PATCH v7 11/16] blk-wbt: fix incorrect lock order for
 rq_qos_mutex and freeze queue
Message-ID: <aV5ONqDDj9PBrSI5@fedora>
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-12-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231085126.205310-12-yukuai@fnnas.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Dec 31, 2025 at 04:51:21PM +0800, Yu Kuai wrote:
> wbt_init() can be called from sysfs attribute and
> wbt_init_enable_default(), however queue_wb_lat_store() can freeze queue
> first, and then wbt_init() will hold rq_qos_mutex.
> 
> Fix this problem by converting to use new helper rq_qos_add_frozen() in
> wbt_init(), and freeze queue before calling wbt_init() from
> wbt_init_enable_default().
> 
> Fixes: a13bd91be223 ("block/rq_qos: protect rq_qos apis with a new lock")
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

