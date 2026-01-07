Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AED309DCB
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767787504; cv=none; b=Slomq1K8dG8rmwkczsajo7eNxHqR8+Tnmz+jPXImQlux0i4wstqJSozb1e//8no4sXo084K0hdh/ALrJFsAxb3PkB0lm281Fp3aoQtrOu//uxlEigs3N36ri0jTqsD9dsfaOw4pAFlmhYmGvBoMl5xfVHedrszvwO3dd5iThb/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767787504; c=relaxed/simple;
	bh=cPgjr0c3tnXSioGQ2Pv3K/ip8s3yZgvsmdFIOWNrCAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tb019HBl6o24Fp/Xuk1YFR6vhrBd/Eh9XHqWFR9lB6d+cRc6Jq3fBAr3i6lun/n19b8KJ2AMlK1zXYXrBLYn7nxihaoEIL9WUUU1YLmqz9W5cYnsMHXTZMtMQ75Ns6EenenPV3dTHTmELAofCJovXoNujuYMzrnMXYCDT8RGvcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G90Qed1p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G90Qed1p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767787498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YCh8v5X4plTO2AJyzJWnSf2omIF5Jqns6VnxxjVYSrw=;
	b=G90Qed1p9p3zYc/9NmtsQyXtbXJ7y/KHexii1Wi7GL5pQw5hDRsbhj8saoJ1orv6MrWWhB
	2MgYNsC4IW/ZAS5Uu3W6Y25/tZGI7c6xIuMXLz9UnnFukjC1GXyoC3pWksPdwE9dsL3gvP
	SRSg7OkNOIR+1e3fHqkdcl1vuJfRLDA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-vJJHoaRAN4yC5UqFT8v2ew-1; Wed,
 07 Jan 2026 07:04:55 -0500
X-MC-Unique: vJJHoaRAN4yC5UqFT8v2ew-1
X-Mimecast-MFC-AGG-ID: vJJHoaRAN4yC5UqFT8v2ew_1767787494
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E8B5180047F;
	Wed,  7 Jan 2026 12:04:54 +0000 (UTC)
Received: from fedora (unknown [10.72.116.199])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EB5C1800109;
	Wed,  7 Jan 2026 12:04:48 +0000 (UTC)
Date: Wed, 7 Jan 2026 20:04:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
	nilay@linux.ibm.com
Subject: Re: [PATCH v7 09/16] blk-throttle: fix possible deadlock for fs
 reclaim under rq_qos_mutex
Message-ID: <aV5L25KZkM4dvzLD@fedora>
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-10-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231085126.205310-10-yukuai@fnnas.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Dec 31, 2025 at 04:51:19PM +0800, Yu Kuai wrote:
> blk_throtl_init() can be called with rq_qos_mutex held from blkcg
> configuration, and fs reclaim can be triggered because GFP_KERNEL is used
> to allocate memory. This can deadlock because rq_qos_mutex can be held
> with queue frozen.
> 
> Fix the problem by using blkg_conf_open_bdev_frozen(), also remove
> useless queue frozen from blk_throtl_init().
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---

I think this patch goes toward wrong direction by enlarging queue freeze
scope, and blkg_conf_prep() may run into percpu allocation, then new
lockdep warning could be triggered.

IMO, we should try to reduce blkg_conf_open_bdev_frozen() uses, instead of
adding more.

Thanks,
Ming

