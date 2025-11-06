Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE11245006
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 04:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762402989; cv=none; b=OV67FfTb4PjpGSwAewbOZCKOOCg2zvlvgRrC8XYXj0wF8irfb87TGQXceEA0IbqpvtQMM68lPKczhIyqeEfG16RK9x5mmw0NFdiSvBx38jaL2OYhZcwt7dnc/UkJ/Xmltgb632RTWojuizLgMSJgkz2avg1t7HAG+N8zX8PFrZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762402989; c=relaxed/simple;
	bh=MDu/x5MjuWQmqdTJsivVkQennR0uk9XQkzjnFg+MG6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NctqRKKL2JXVeNNgfarlGz62yBLVgN8XyXKZo21EA90KWfUtDW2E7cwPMfwGWCqS3iK0BSUGvuPYyTMVOdoHlUYx01/qhJG/jYBkNVs3CO/B0wMED5RPVqb3BT4ozS7c2dgV74E6GWi42aZXRcnSl6XB9CJ64YY2A4jlMRLwQQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQ9Xfi82; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQ9Xfi82"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762402986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=McWH5uoiv0Qcs12llAIn0we0DdmJGhAn3KTRWhafxfs=;
	b=TQ9Xfi823D8isnaoIPn67Pv3oH4wFF9NrGHp94UjHYRLyVDiZtgNjEomxCK9JUFVnWrFLs
	hgou6Ewe1My29U533uz+scje1cp6n5+gk3QbsWHXEe+QB/tcXR8s/mZBx9WNBO2pHVBR3i
	B+mXN4qpK9A7fNWIRA6PJ+dnOqmTRvw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-_eNqBynKOEKO6sRZQ5qoTQ-1; Wed,
 05 Nov 2025 23:23:03 -0500
X-MC-Unique: _eNqBynKOEKO6sRZQ5qoTQ-1
X-Mimecast-MFC-AGG-ID: _eNqBynKOEKO6sRZQ5qoTQ_1762402982
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 998B81800350;
	Thu,  6 Nov 2025 04:23:01 +0000 (UTC)
Received: from fedora (unknown [10.72.120.24])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9BC3300018D;
	Thu,  6 Nov 2025 04:22:57 +0000 (UTC)
Date: Thu, 6 Nov 2025 12:22:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ublk: use copy_{to,from}_iter() for user copy
Message-ID: <aQwinGy55Bk0r-LU@fedora>
References: <20251105202823.2198194-1-csander@purestorage.com>
 <20251105202823.2198194-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105202823.2198194-2-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Nov 05, 2025 at 01:28:22PM -0700, Caleb Sander Mateos wrote:
> ublk_copy_user_pages()/ublk_copy_io_pages() currently uses
> iov_iter_get_pages2() to extract the pages from the iov_iter and
> memcpy()s between the bvec_iter and the iov_iter's pages one at a time.
> Switch to using copy_to_iter()/copy_from_iter() instead. This avoids the
> user page reference count increments and decrements and needing to split
> the memcpy() at user page boundaries. It also simplifies the code
> considerably.
> Ming reports a 40% throughput improvement when issuing I/O to the
> selftests null ublk server with zero-copy disabled.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

