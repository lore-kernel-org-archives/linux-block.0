Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748B6135A53
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 03:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761882333; cv=none; b=uSnswgHqP0hM6vwo46zpSOAtLZf378dP4/ta2N2MhQd2PtB+mae4nKeEwU/MfDbrsDnFk6uk4vL5+3Ph4uAK455xa83uxnbQYcNW0Gb8eHKiriGoSk9D2o9rscDQfMgERBDv8Kf/3KkGLed/I4lUiF8HiKM+3rKbKkpKLiLtqAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761882333; c=relaxed/simple;
	bh=SE2LXa2lkwxnT5rasq2vZJV1CCtoXHkNxlZ6HmwpByo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeCs+O3hhn0PPETYnluMhVaEWxnEYWZoaFbU6BlUtJssVucVif1D5tS54NDjFjD8lquwMgildf/m4CZhjnI1OQ4hfnWADoiwMY+Uqj0AkxEHAaq4OMS2EgoLG0X4gb4WEVX9dnb7TrkWWo+OlPvKN+cN8Lqd2zJBxIkKKc4w8dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fFTBSSFE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFTBSSFE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761882330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YH4wSzDPaeYqFiotjSVbG3CNJDKYovKauDGIGQdaamU=;
	b=fFTBSSFE7L0QW6GLFk3ytTrQUTUKZmPKw1AKLGfXEpxEEm93IvOTZP/fzI1NTjJlD/hjhV
	SCStKyXIAJ4xcfvyUwOyvyMfl019iz/05crW0TTOgSH5F988NAWcW2ni0x8bahYGRPmWIJ
	zFMdsFZYmAdFPdQzPWlDijIm+2HkRfU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-AM4UnVkyMlG4bDuAdoWj8w-1; Thu,
 30 Oct 2025 23:45:27 -0400
X-MC-Unique: AM4UnVkyMlG4bDuAdoWj8w-1
X-Mimecast-MFC-AGG-ID: AM4UnVkyMlG4bDuAdoWj8w_1761882326
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB1FF1955DD1;
	Fri, 31 Oct 2025 03:45:25 +0000 (UTC)
Received: from fedora (unknown [10.72.120.28])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A0AD1800589;
	Fri, 31 Oct 2025 03:45:21 +0000 (UTC)
Date: Fri, 31 Oct 2025 11:45:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: use copy_{to,from}_iter() for user copy
Message-ID: <aQQwy7l_OCzG430i@fedora>
References: <20251031010522.3509499-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031010522.3509499-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Oct 30, 2025 at 07:05:21PM -0600, Caleb Sander Mateos wrote:
> ublk_copy_user_pages()/ublk_copy_io_pages() currently uses
> iov_iter_get_pages2() to extract the pages from the iov_iter and
> memcpy()s between the bvec_iter and the iov_iter's pages one at a time.
> Switch to using copy_to_iter()/copy_from_iter() instead. This avoids the
> user page reference count increments and decrements and needing to split
> the memcpy() at user page boundaries. It also simplifies the code
> considerably.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 62 +++++++++-------------------------------
>  1 file changed, 14 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 0c74a41a6753..852350e639d6 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -912,58 +912,47 @@ static const struct block_device_operations ub_fops = {
>  	.open =		ublk_open,
>  	.free_disk =	ublk_free_disk,
>  	.report_zones =	ublk_report_zones,
>  };
>  
> -#define UBLK_MAX_PIN_PAGES	32
> -
>  struct ublk_io_iter {
> -	struct page *pages[UBLK_MAX_PIN_PAGES];
>  	struct bio *bio;
>  	struct bvec_iter iter;
>  };

->pages[] is actually for pinning user io pages in batch, so killing it may cause
perf drop.

This similar trick is used in direct io code path too.


Thanks 
Ming

