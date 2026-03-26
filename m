Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D55E3F99E0
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536397; cv=none; b=kkxvTxPxc4su6NOqkObCCPqenp1gb2BSMbTxE7DO4Giu1FHNhbyCDNqBhWYW7qD9khj7Nw74kaiaXs9T29pzynyniStTXzmqj/mAJLTX15wDGHwAQ9eSWmpDWRBOWiW5Qop2XGAYPGtVfkPTmYFoFN14PVOb4EuQXVj+ItKCMsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536397; c=relaxed/simple;
	bh=ro1DOQTNSXAHpBuspJglbrVyUDkH0tL2th2+GWEhwA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwkNECPl7OlfQ+0RfSclFU5595huVTzp1qgFiw+9p/IufEm9WA1VuR7O0vPcggc4kZkpcO0wehnrmYJFz4eIR7OF7lQngmNmknDGsK1Q5w3DnVMpYFZ28+F6pmgJ7xdAY8NLyU3Z2Bpa6ddpE3OayhL8S06DnN2wBmA0fqhUOf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRJ+bZ6C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRJ+bZ6C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774536395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vUV63l6vK+SYEZFA1WZcxF2SMBPFTg0fKP2ZBOGJKPY=;
	b=DRJ+bZ6C8VS02mlBkx3+DL+xuhiHnjrppAMOE0KKyM67hTz2fNBhVwcLlFFTnP3H+A1UZJ
	obeho8VERaga6kdCNbPxhT3QSxc0tRme9nfhD8HCz1k4h3U84hq9hkk/Q4Ro5NUSHD4sVj
	xdeXBuv0gC9H7ZjWbGo17MljDVx9CgI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-07P1xW05NSqIxQaUBbn_UQ-1; Thu,
 26 Mar 2026 10:46:33 -0400
X-MC-Unique: 07P1xW05NSqIxQaUBbn_UQ-1
X-Mimecast-MFC-AGG-ID: 07P1xW05NSqIxQaUBbn_UQ_1774536392
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ED3019560A6;
	Thu, 26 Mar 2026 14:46:32 +0000 (UTC)
Received: from fedora (unknown [10.72.116.100])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D002419560B1;
	Thu, 26 Mar 2026 14:46:26 +0000 (UTC)
Date: Thu, 26 Mar 2026 22:46:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2 2/5] block: Fix the max_user_sectors lower bound
Message-ID: <acVGvcqQxPdTRFCi@fedora>
References: <20260325213719.2850619-1-bvanassche@acm.org>
 <20260325213719.2850619-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325213719.2850619-3-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Mar 25, 2026 at 02:37:12PM -0700, Bart Van Assche wrote:
> The lowest value that can be supported for lim->max_user_sectors is the
> logical block size. This patch prepares for reducing BLK_MIN_SEGMENT_SIZE
> to a value that may be less than the logical block size.
> 
> Cc: Ming Lei <ming.lei@redhat.com>
> Fixes: 889c57066cee ("block: make segment size limit workable for > 4K PAGE_SIZE")

Before commit 889c57066cee, PAGE_SIZE is applied for the limit, so you don't
fix commit 889c57066cee.

The 1st bad commit is actually commit d690cb8ae14b ("block: add an API to atomically
update queue limits').

Please fix the fix tag, otherwise feel free to add:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

