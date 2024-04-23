Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883E947772
	for <linux-block@vger.kernel.org>; Tue, 23 Apr 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713857548; cv=none; b=dCzfPIe+Fbnla8Pf4guCJjmUBsJsm5u5FYFma0ISA/rq8Fo8rNIlJpMOH/qCSQRx2s2AxCePNi83v8ZzWFNZGULbhQYkcClNGFSEWyfiKqX2zfNyhMdYltTmA6N1vO8VUu1DGaItzknUDX5Jrrh2r/zQkwraw1eUWlRJcdAF0cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713857548; c=relaxed/simple;
	bh=fCtgTqqPIGgKR7CtOKrHPlxAEAm3QiX1Kyq3VvKxjHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMpFGo1lvKxcux/UdJiVjAf78tnMTAYXjTbS5U+300dsjrpnQ3h5miXXKE+4h6shqpge3024jHysRoP8qJRxhD96uDLsbWr1b8p+IkNzr8b4m2r3JxmtKT58QM1YJkSxIss6BXj6/s5fRsju/oGPlpMSV+sge1MWKFc+12nr5/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NYieVH1i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYieVH1i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713857544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+l4LrlxVKztyl389Cf9Ye2PtVJ+Dx3CAmwyRxf4t95E=;
	b=NYieVH1iCOJCLYqhIJPSTNfBIdqUvpdxReVRGJgDDYPO+qLSvkGwQcjOwzP4R1ZO8hS1T3
	i+gHNV7LdUNa607VAOFmSfqc658HOYcBgp4tHIiIqop7bXpErm3qFEAXbwfg/rxcknSbj9
	zKXsD5wN1sF3rOKTlScLNc7afswDSRw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-XPyiARAZPVCA_2h0Qmy82g-1; Tue,
 23 Apr 2024 03:32:20 -0400
X-MC-Unique: XPyiARAZPVCA_2h0Qmy82g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58B5E1C05122;
	Tue, 23 Apr 2024 07:32:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.86])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AB0320128F3;
	Tue, 23 Apr 2024 07:32:15 +0000 (UTC)
Date: Tue, 23 Apr 2024 15:32:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: hch@lst.de, axboe@kernel.dk, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, mpatocka@redhat.com,
	Brandon Smith <freedom@reardencode.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH for-6.10 1/2] dm-crypt: stop constraining
 max_segment_size to PAGE_SIZE
Message-ID: <Zidj46jf/9USES3L@fedora>
References: <ZfDeMn6V8WzRUws3@infradead.org>
 <20240411201529.44846-2-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411201529.44846-2-snitzer@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Thu, Apr 11, 2024 at 04:15:28PM -0400, Mike Snitzer wrote:
> This change effectively reverts commit 586b286b110e ("dm crypt:
> constrain crypt device's max_segment_size to PAGE_SIZE") and relies on
> block core's late bio-splitting to ensure that dm-crypt's encryption
> bios are split accordingly if they exceed the underlying device's
> limits (e.g. max_segment_size).
> 
> Commit 586b286b110e was applied as a 4.3 fix for the benefit of
> stable@ kernels 4.0+ just after block core's late bio-splitting was
> introduced in 4.3 with commit 54efd50bfd873 ("block: make
> generic_make_request handle arbitrarily sized bios"). Given block
> core's late bio-splitting it is past time that dm-crypt make use of
> it.
> 
> Also, given the recent need to revert meaningful progress that was
> attempted during the 6.9 merge window (see commit bff4b74625fe Revert
> "dm: use queue_limits_set") this change allows DM core to safely make
> use of queue_limits_set() without risk of breaking dm-crypt on NVMe.
> Though it should be noted this commit isn't a prereq for reinstating
> DM core's use of queue_limits_set() because blk_validate_limits() was
> made less strict with commit b561ea56a264 ("block: allow device to
> have both virt_boundary_mask and max segment size").
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

