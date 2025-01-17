Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D52CA95C
	for <linux-block@vger.kernel.org>; Fri, 17 Jan 2025 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137069; cv=none; b=sjrWUmBFda+kyQWW3RXGfrDxVtcTXWzW+9A2RTUaG5aALMAQ/Vbf//E8v7KwL8jHt4JAyB3vqcyidNhinMnizkXxt9uvtfFmIt1IQS6NqnixcQ1emJ2u7zIw0ymVst4oVvTs00L2tvh4JHK3PefGHdeq4rWrA+XJJ0tB0DLuH2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137069; c=relaxed/simple;
	bh=AprcGsrsew07OhtqsUQCw5zOlQGeVquRuTMjOd7uzQ0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qgg9DciKVv8NtBbz6mc0OL9MOLvqQQDFvxJhWOtZqQ1hxMX83H4/vL3YR1Em21X8rxXdxrqD77GvXbwRtLz6l49wjqclBwz67KLEEqZ7eQ48OYK981nExII4AnljrgCc7s+tYmQ712RZt+CTobnrBoszqxTHy6FfAzJuR9sRC+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TsC/sWWe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsC/sWWe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737137066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kwD1e0n5j5vozXyseL7Lp4DzndrvqnfSuEM/pYIwaz0=;
	b=TsC/sWWeG7nFvpxA+PoegPqmMI3xcwu4bFJVbWli5ifc6moNbi9x9jNT1M8EbgL0lBUQes
	3bTmdMlZ7cTKQR8V6puU9hKpsoGTofnjkJKeBS4Bw674XGQ2zOlWmtql8ArpQT4sfKRDD8
	VMjMz6rAbr2WIAYLzHbSSRG4zSGHykg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-E-Rfro4FP5-W5zhF_Uscaw-1; Fri,
 17 Jan 2025 13:04:21 -0500
X-MC-Unique: E-Rfro4FP5-W5zhF_Uscaw-1
X-Mimecast-MFC-AGG-ID: E-Rfro4FP5-W5zhF_Uscaw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96F0D1955DC8;
	Fri, 17 Jan 2025 18:04:19 +0000 (UTC)
Received: from [10.45.224.57] (unknown [10.45.224.57])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67F3819560BF;
	Fri, 17 Jan 2025 18:04:17 +0000 (UTC)
Date: Fri, 17 Jan 2025 19:04:11 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
    Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, 
    Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v17 02/14] dm-linear: Report to the block layer that the
 write order is preserved
In-Reply-To: <20250115224649.3973718-3-bvanassche@acm.org>
Message-ID: <b0717657-8ecd-0fcf-4ca1-eb9f91ad01cf@redhat.com>
References: <20250115224649.3973718-1-bvanassche@acm.org> <20250115224649.3973718-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40



On Wed, 15 Jan 2025, Bart Van Assche wrote:

> Enable write pipelining if dm-linear is stacked on top of a driver that
> supports write pipelining.

Hi

What if you have multiple linear targets in a table? Then, the write order 
would not be preserved.

How is write pipelining supposed to work with suspend/resume? dm doesn't 
preserve the order of writes in case of suspend.

Mikulas

> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/md/dm-linear.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
> index 49fb0f684193..967fbf856abc 100644
> --- a/drivers/md/dm-linear.c
> +++ b/drivers/md/dm-linear.c
> @@ -148,6 +148,11 @@ static int linear_report_zones(struct dm_target *ti,
>  #define linear_report_zones NULL
>  #endif
>  
> +static void linear_io_hints(struct dm_target *ti, struct queue_limits *limits)
> +{
> +	limits->driver_preserves_write_order = true;
> +}
> +
>  static int linear_iterate_devices(struct dm_target *ti,
>  				  iterate_devices_callout_fn fn, void *data)
>  {
> @@ -209,6 +214,7 @@ static struct target_type linear_target = {
>  	.map    = linear_map,
>  	.status = linear_status,
>  	.prepare_ioctl = linear_prepare_ioctl,
> +	.io_hints = linear_io_hints,
>  	.iterate_devices = linear_iterate_devices,
>  	.direct_access = linear_dax_direct_access,
>  	.dax_zero_page_range = linear_dax_zero_page_range,
> 

