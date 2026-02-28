Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A333D7D9C
	for <linux-block@vger.kernel.org>; Sat, 28 Feb 2026 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772273280; cv=none; b=jGOYRIV/ltUM6qsODh7i/rmmqkUoDEqSMlm37o4KngkrIUn7ovpqwkKmw68ImPO2H6mZkAN3cDYXlhbNe/UmdIGxyfTBt2lWpOjh0R3NCVvL7ijtIeFKlDoX7ea5bXuMNDmNwc4zvEnRPY8pg+yLwY5J8dVXspSpn1drAa/uY2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772273280; c=relaxed/simple;
	bh=xwXooP7PO0wvhcwlZvsXzklpYwAs6IL0zi4YFJeY+NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+sSsY9XIn6HZDDO43SDe4ng9oQtFKBJma8bgd/BNgeyHPXDjy9gjZuUkXSgO7syCk+yIyI1Fc2uiHYFgnD8qqNrEv2LMKjk+t+Lx0Ejzzl4N9XW3Zq0hbHRdz9vEZZmd3/0wf1ztPkdt1oWZGVZ9codOLomnm8XWOXluiNjTlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SegpZ7rB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SegpZ7rB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772273278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHG2K+seZXzLexgkWeh89VknsaavtXYYcyXI6WCcCJw=;
	b=SegpZ7rBZGnn2UyvInRhk5wywgxJwKjbL3B2YB1OmmQcBgsPQEY48zlZBcdr3KF/28OgN2
	dVp0LjeFGmlglZeZeBhcAz/6jjM9Sb9Gp+CIsW895oTIYMTKvZlyMnhv947A+qsnpS+wjm
	vN+FIjjgbjtz/Sk9mNSqi7EJJO8nLZ4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-Es_ua_muMP-P30jKnOvGbQ-1; Sat,
 28 Feb 2026 05:07:57 -0500
X-MC-Unique: Es_ua_muMP-P30jKnOvGbQ-1
X-Mimecast-MFC-AGG-ID: Es_ua_muMP-P30jKnOvGbQ_1772273276
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4F0118001E3;
	Sat, 28 Feb 2026 10:07:55 +0000 (UTC)
Received: from fedora (unknown [10.72.116.144])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3C2819560B8;
	Sat, 28 Feb 2026 10:07:52 +0000 (UTC)
Date: Sat, 28 Feb 2026 18:07:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests: ublk: cleanup kublk.h
Message-ID: <aaK-c4WbTlpewltn@fedora>
References: <20260227145756.3877069-1-alex@zazolabs.com>
 <20260227145756.3877069-5-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227145756.3877069-5-alex@zazolabs.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Feb 27, 2026 at 02:57:56PM +0000, Alexander Atanasov wrote:
> Arguments are handled via flags so
> remove unused no_auto_part_scan bitfield.
> 
> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
> ---
>  tools/testing/selftests/ublk/kublk.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
> index 1faeccaaecae..3379e49449b4 100644
> --- a/tools/testing/selftests/ublk/kublk.h
> +++ b/tools/testing/selftests/ublk/kublk.h
> @@ -79,7 +79,6 @@ struct dev_ctx {
>  	unsigned int	per_io_tasks:1;
>  	unsigned int	no_ublk_fixed_fd:1;
>  	unsigned int	safe_stop:1;
> -	unsigned int	no_auto_part_scan:1;
>  	__u32 integrity_flags;
>  	__u8 metadata_size;
>  	__u8 pi_offset;

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

