Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BE62F12D3
	for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766415186; cv=none; b=NU+ofA4khc1s/TRYjzuR/HjbKVtg+IInfDZ0cbNo7x5IP1dLIvJrvN5PMPyOvSle7KNT+0SbWqZVGLmDMW3WwILoSYf4VDh2R5cx1OQy9kAqlRe72Ek/3tGonGuFsmeJASfFjqQTE8997V5c3xSCgU8/YWiMhDWIEE7CappWqTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766415186; c=relaxed/simple;
	bh=bcdAkwIdbtG5tBRKZ1qbFT+2sJFC6AFc3k8Wr/5Juus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9SEZth5RhuOY1NJhdEjxUroJRRVPVSvyUGVJxkhdBslKBDIWOUvHfJJ72AOgP4Nk34tSuZeQGnZw576qwQxGifzOZ40m/T7h/rM8C9NFyzTqXem3T9eJalmZFPnOPoUY623QohbGRTuLn9TdGRAnQPLzGt8nsxLIh/uG4R/tOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EjkDIrus; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjkDIrus"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766415184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cne22PXGZfl46qyUBa+mbmurPwOSKuC/llq4Id6AbKQ=;
	b=EjkDIrusS84KulI0nQzq/HRtTfTBD4sTumCUUf3XlSyCf1VQMTg0eCuuqiN5KAvTxU6wzo
	23WPzbrf71JG/eBEhkgHwFU5eKP81BaZPUX+504rm5TCPG/AzxdR1Wr5qiXZp8ExRRsi4B
	4jx3HjV06q7DKFBFVuD46dy6YrN9DX8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-DtVzGnxWNvqJPEvBQZ_WWw-1; Mon,
 22 Dec 2025 09:52:59 -0500
X-MC-Unique: DtVzGnxWNvqJPEvBQZ_WWw-1
X-Mimecast-MFC-AGG-ID: DtVzGnxWNvqJPEvBQZ_WWw_1766415177
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B52E195605B;
	Mon, 22 Dec 2025 14:52:57 +0000 (UTC)
Received: from fedora (unknown [10.72.116.92])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B70D919560AB;
	Mon, 22 Dec 2025 14:52:51 +0000 (UTC)
Date: Mon, 22 Dec 2025 22:52:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 08/20] ublk: add ublk_copy_user_bvec() helper
Message-ID: <aUlbPcjuk_XlE_zq@fedora>
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-9-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217053455.281509-9-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Dec 16, 2025 at 10:34:42PM -0700, Caleb Sander Mateos wrote:
> Factor a helper function ublk_copy_user_bvec() out of
> ublk_copy_user_pages(). It will be used for copying integrity data too.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 52 +++++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index d3652ceba96d..0499add560b5 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -987,10 +987,39 @@ static const struct block_device_operations ub_fops = {
>  	.open =		ublk_open,
>  	.free_disk =	ublk_free_disk,
>  	.report_zones =	ublk_report_zones,
>  };
>  
> +static bool ublk_copy_user_bvec(struct bio_vec bv, unsigned *offset,

bv could be better to define as `const struct bio_vec *` for avoiding copy,
otherwise this patch looks fine.


Thanks, 
Ming

