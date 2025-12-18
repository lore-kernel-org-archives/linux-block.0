Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD013009F2
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766056295; cv=none; b=CbcoPH4rMmHQ+Rha6mCHjutTqYmsLN3LJSKVnwKVYG4tU5zdNOzmBAkJbeDqLkjEY+hPRE2Spc/8ETT4b4JzS37TAy087eAH8+UvCZZbNemXQLP3sIxGgUhQrS+I95ismOoFBqbhYT+V1acFr01Ic71jogAUNJaHY/leqt5vXXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766056295; c=relaxed/simple;
	bh=Ofdmbm4lI4SYYyLIph2U45z+D3FelM0SA7cgMZ2ZUo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ausza1XGBSiH1/nwuSELiUDUf0JHtWE1c0PrUor6hJQR/pVeOwek7Hrxw7oaQXqknvIsdpCNJEDExZ1poyqnPmKKdlclnS7T0unuFZJ1lAl8xMBGZjJKtNlHN2DCACvIHrVDUd+hZtr4JG9NqXZaK6IoMKq11JE5zgjMY1eTfCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W3BYRAE4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3BYRAE4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766056291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh4x6vcqiy2glFKG/9cWvHnQJQfKfzHzZjFLoqsSTIc=;
	b=W3BYRAE4/osKzlTbzgQH2Kqv1ZCcRru0LFtDdBzF4QlP93n05rxCSitv9nrdL7XgAX2pH6
	gA2NpLoZWUj+Bbb/muZYfw/rHDpAR0xYe1cdMif/VUKCHy7YLzr3nSvL5iDGsdI9P3IEN0
	Z2C7furICqVBobF2IFAYQgDKwXLeTHc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-bWhHRLwvMPmKlJtyPmR_8w-1; Thu,
 18 Dec 2025 06:11:27 -0500
X-MC-Unique: bWhHRLwvMPmKlJtyPmR_8w-1
X-Mimecast-MFC-AGG-ID: bWhHRLwvMPmKlJtyPmR_8w_1766056286
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8404A195605B;
	Thu, 18 Dec 2025 11:11:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.190])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 030B4180044F;
	Thu, 18 Dec 2025 11:11:20 +0000 (UTC)
Date: Thu, 18 Dec 2025 19:11:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
	nilay@linux.ibm.com
Subject: Re: [PATCH v5 04/13] blk-rq-qos: fix possible debugfs_mutex deadlock
Message-ID: <aUPhUj3VgUvGRVxU@fedora>
References: <20251214101409.1723751-1-yukuai@fnnas.com>
 <20251214101409.1723751-5-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214101409.1723751-5-yukuai@fnnas.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sun, Dec 14, 2025 at 06:13:59PM +0800, Yu Kuai wrote:
> Currently rq-qos debugfs entries are created from rq_qos_add(), while
> rq_qos_add() can be called while queue is still frozen. This can
> deadlock because creating new entries can trigger fs reclaim.
> 
> Fix this problem by delaying creating rq-qos debugfs entries after queue
> is unfrozen.
> 
> - For wbt, 1) it can be initialized by default, fix it by calling new
>   helper after wbt_init() from wbt_enable_default; 2) it can be
>   initialized by sysfs, fix it by calling new helper after queue is
>   unfrozen from queue_wb_lat_store().
> - For iocost and iolatency, they can only be initialized by blkcg
>   configuration, however, they don't have debugfs entries for now, hence
>   they are not handled yet.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

This patch need to rebase on the following -rc2.


Thanks,
Ming

