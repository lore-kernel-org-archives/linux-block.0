Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E508A331A53
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766051304; cv=none; b=rgDSuYpJHF3z4lH/Kn3AxO1E+kcdFHUZKFQxN7eewrhiCQ4MZDCujD83zCSn9VtvcYZAmqmH7J1SsbW0JnES+Aezh0NQtIjQdU+BiJfPexsmPXF4Zwdl2pCJ87Q3RPK8i9l2cHTNyB7NwpD8a3k5GP6cIl5MPogJb7x6iyG1sao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766051304; c=relaxed/simple;
	bh=rP/Ofn1sN0BmK5KiKRvC3orLKLHaV0DW0GjCZtua9O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqmNwJK7YZYLkb5/qRKgLa80uZdD8BMHNtQMNOE68UgWbtV9omoY3D7O8WqRAtQLnirVGPOm/v6V80VvFo1hRtqYHx6bvP/DhAIytlCxDlFiso725lSpZ8Zi7ro9MsnWqOmjd9XwGdsHJb2biYDTVtKY+u/MeJD0ldaqZmsTv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RHWeJ9ac; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHWeJ9ac"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766051301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tgn5lR7FDYBypxhGgnmczlkEtfdsuZV3CEtWkEFDsnc=;
	b=RHWeJ9acADqm2/tMVZl0C6ayMqHnKc7s6P66b8LAAbBb71089r6B/PH1unYeE6rR0XXReN
	ch5muajrl+2xiWWLMxc++RQphx7zPUSuM9AFUlYolcuo+aYMPoZP9LYb4K5aYvQ15hvRin
	0aaDVVQ2+fpCu1jx2Ny+t7ufS6CW5gM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-89Zs1v1tNFKGla9eqU8yIQ-1; Thu,
 18 Dec 2025 04:48:18 -0500
X-MC-Unique: 89Zs1v1tNFKGla9eqU8yIQ-1
X-Mimecast-MFC-AGG-ID: 89Zs1v1tNFKGla9eqU8yIQ_1766051297
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1E361956094;
	Thu, 18 Dec 2025 09:48:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.190])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F82B1955F2D;
	Thu, 18 Dec 2025 09:48:09 +0000 (UTC)
Date: Thu, 18 Dec 2025 17:48:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	huang-jl <huang-jl@deepseek.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 2/3] block: don't initialize bi_vcnt for cloned bio in
 bio_iov_bvec_set()
Message-ID: <aUPN1W9PmN6Xo2sL@fedora>
References: <20251218093146.1218279-1-ming.lei@redhat.com>
 <20251218093146.1218279-3-ming.lei@redhat.com>
 <aUPLr_cUd9nmvoI0@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUPLr_cUd9nmvoI0@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Dec 18, 2025 at 01:38:55AM -0800, Christoph Hellwig wrote:
> On Thu, Dec 18, 2025 at 05:31:43PM +0800, Ming Lei wrote:
> > For a cloned bio, bi_vcnt should not be initialized since the bio_vec
> > array is shared and owned by the original bio.
> 
> Maybe, maybe not.  What is the rational for that "should" ?
 
->bi_vcnt is never set for bio allocated from bio_alloc_clone().

Thanks, 
Ming

