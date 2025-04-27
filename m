Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633A34C80
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745760341; cv=none; b=dMoGZuGsyDyAjq23pHPqrDktxY2Raki1H7OmNh512FELgUsVPalHcWmqaPJHjqsDQ44tHn7SorsjWr+wjgr4VGyel1RWZScRo8VCIHHUeyLtuDpbfZk5UuF6oUzMDFy0YRZM4R18Bhzl0Ey4E9AaQb5fdZT9qd1PoxJBFHBc2Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745760341; c=relaxed/simple;
	bh=J+J0vXBfY/cllhNJdTtShzOR/VTTy52hyTb2JnZDjiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUzQYFlZ8sqDAyiciHlVtfIH1TE7KGXHcJAcf6wEohCc+HCo23P6GWwt0YFrtrxIwCO/LeOkkKGq9Q/8GFLJ+yQQ/fsr4sqibdfJCpYUfgQBZYrDqsZrFJVFrE1FfVN/3QnsJiIQKKh9sqFsNZmcsFjxbd95E39c7P/pPdxpRes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2Si4dTs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2Si4dTs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745760338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SWMzpH+bq3UgzWC600ztVu0Xn2KB/G03jIH5HOI+B14=;
	b=G2Si4dTsByG3ER7dKwzAqNzPrH4S++XEpT8RAL4p4/tUmPNPjRR8N/KJUjLgQD5B+0ggnk
	hi+uzfD1Uf+YtVMBafa1ERbqhZUdQILiYTQYYdRMh5+3exq9zHHaHT9qLegHVqa5eF1LX6
	OGsfiow3Nc3J3wB7UOgiAqXfMpAIdYs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-FbIS4VPCOlq5OL3llgNd1w-1; Sun,
 27 Apr 2025 09:25:36 -0400
X-MC-Unique: FbIS4VPCOlq5OL3llgNd1w-1
X-Mimecast-MFC-AGG-ID: FbIS4VPCOlq5OL3llgNd1w_1745760335
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 830591956096;
	Sun, 27 Apr 2025 13:25:35 +0000 (UTC)
Received: from fedora (unknown [10.72.116.119])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 006C2180045B;
	Sun, 27 Apr 2025 13:25:31 +0000 (UTC)
Date: Sun, 27 Apr 2025 21:25:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] ublk: store request pointer in ublk_io
Message-ID: <aA4wROulY-gMJFqS@fedora>
References: <20250427045803.772972-1-csander@purestorage.com>
 <20250427045803.772972-9-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427045803.772972-9-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sat, Apr 26, 2025 at 10:58:03PM -0600, Caleb Sander Mateos wrote:
> A ublk_io is converted to a request in several places in the I/O path by
> looking up the (qid, tag) on the ublk device's tagset. This involves a
> bunch of pointer dereferences and a bounds check of the tag.
> 
> To make this conversion cheaper, store the request pointer in ublk_io.
> Overlap this storage with the io_uring_cmd pointer. This is safe because
> the io_uring_cmd pointer is only valid if UBLK_IO_FLAG_ACTIVE is set on
> the ublk_io, the request pointer is valid if UBLK_IO_FLAG_OWNED_BY_SRV,
> and these flags are mutually exclusive.

Yeah, it becomes exclusive after UBLK_IO_NEED_GET_DATA is cleaned as one
sync command.

> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming

