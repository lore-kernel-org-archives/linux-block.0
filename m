Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7877814263
	for <linux-block@vger.kernel.org>; Mon, 21 Oct 2024 02:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729477628; cv=none; b=nGzFTFcA8SzbY2DNIeWB42+czDDssG+DmNEyat9TkBmnlBT6SjjtSyEw+c05KLOMRkqlvWiPrGdJi9vIpjT9TygWK/HAFIXmJLASCJm2Q6HkyLkHO0nhw3HzTlDe4Yr8RMQh/BXwyCTZgdnP3zvJXe9ReL4cdtHH/U7gBcDd4zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729477628; c=relaxed/simple;
	bh=wChIIOljRZMbMsClGwWazXIABPZWJ1X/9rhsdtrKznQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9pUZglKp3mYMxiUbowPl/6Sjcv1/PU0vgpZ3QWk4zLtRB5tNoW6VWj6hEVoK1wB+MVtKfOx1kJ3XeZZIoHbKdlCB35E8VLXnbEJqeBR/t0p1/Z9UjPfub2UxtIjSEsjWBWagSGKnV2v/IIcBVdrbHOscNaEpnkkGnzYlHIXEbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aHIuVJja; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHIuVJja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729477625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+sjMziFfxbGDr6d+iWUv4ZQCz7jkJM/gB/nV/7pRVlc=;
	b=aHIuVJjaGYF7cslctJ5JSQ1c4ld4npByB6nN6fUCLcOxWAWIgQlUNQLvBGB++TKNyFtlfb
	fOmyqEiNyEytF5p9oliy2J4sXQZv8IvR7ZNYtWJKzG5yeC8RgURfy45+YLbi7jXYb+crD3
	DbnM1Q4J00zNJjTtH7LHIshdGpnC4bk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-mJgu-wZ7M3C4MjtQVk-IAw-1; Sun,
 20 Oct 2024 22:27:02 -0400
X-MC-Unique: mJgu-wZ7M3C4MjtQVk-IAw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEDDE195609D;
	Mon, 21 Oct 2024 02:26:59 +0000 (UTC)
Received: from fedora (unknown [10.72.116.25])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F4C119560A3;
	Mon, 21 Oct 2024 02:26:53 +0000 (UTC)
Date: Mon, 21 Oct 2024 10:26:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
	dhowells@redhat.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iov_iter: don't require contiguous pages in
 iov_iter_extract_bvec_pages
Message-ID: <ZxW76N4hU2_4Zs3E@fedora>
References: <20241011132047.1153249-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011132047.1153249-1-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Oct 11, 2024 at 03:20:22PM +0200, Christoph Hellwig wrote:
> The iov_iter_extract_pages interface allows to return physically
> discontiguous pages, as long as all but the first and last page
> in the array are page aligned and page size.  Rewrite
> iov_iter_extract_bvec_pages to take advantage of that instead of only
> returning ranges of physically contiguous pages.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> [hch: minor cleanups, new commit log]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> v3:
>  - open code the iterator
>  - improve commit log and comments

Hello Jens,

Gentle ping...



thanks,
Ming

