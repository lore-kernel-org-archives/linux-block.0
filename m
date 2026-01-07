Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE2617DFE7
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778271; cv=none; b=Dfpja6r2JgY206oEKSZoFyfeYcj5z8bvJSD+7s1LgzMUCGTvvZYHmhCO0roFgEiryeZIugSvfYajN8VzAlKkucFI4u9TqzkQkWW2dK50HtNB7kTFNydzmUElIIPhyLGdnS8CeYdNKgpCHdfEXegPCRHcm3H7EdVyr1V/FTj6+P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778271; c=relaxed/simple;
	bh=+mLQUzL7sGnENWDC5tOM3K5UzJan9oksYK0PtdEOgcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIuTa8S3vul7QQghLxOpcGhyX0F7MbNAgYwXeZ3JToiHv/QXnbUXV24EN+PYarg4DW4Wn/fKPhm1nDhWYsGB0qicQ00Qkz36/gqq9oQd5R7wWWKdQL9hAtspRBS8BWUDCJXs5CuvTDNh0J+ATbUzt4mud1GtROul+FA/fE3TCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDC5lLdn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDC5lLdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767778269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uBIbi6AGZxxDNMrzOMMqACciEtGVGP+MyH7xlJOAJI0=;
	b=SDC5lLdnZgO5aNFGNt/ENYtiXWgwhydDgi1ApSBz7ge/3gotmoxC12VPBvwAa3Cp2LALwJ
	xIk4i78kb06Hig9THBXHP/ZFBtB7jsm61BCHB31AIcBHqtUOKEjOi9XISI8/F4+X7o+Ic0
	kthbTvCqyFmHYB+vRt0md0IEPRyYHPc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-LeGj9dtuPHClCPYQ6dvBPw-1; Wed,
 07 Jan 2026 04:31:06 -0500
X-MC-Unique: LeGj9dtuPHClCPYQ6dvBPw-1
X-Mimecast-MFC-AGG-ID: LeGj9dtuPHClCPYQ6dvBPw_1767778265
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95DB819560B2;
	Wed,  7 Jan 2026 09:31:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.199])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECE0419560A2;
	Wed,  7 Jan 2026 09:31:01 +0000 (UTC)
Date: Wed, 7 Jan 2026 17:30:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
	nilay@linux.ibm.com
Subject: Re: [PATCH v7 02/16] blk-wbt: fix possible deadlock to nest
 pcpu_alloc_mutex under q_usage_counter
Message-ID: <aV4n0ZPXnH31AcE0@fedora>
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-3-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231085126.205310-3-yukuai@fnnas.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Dec 31, 2025 at 04:51:12PM +0800, Yu Kuai wrote:
> If wbt is disabled by default and user configures wbt by sysfs, queue
> will be frozen first and then pcpu_alloc_mutex will be held in
> blk_stat_alloc_callback().
> 
> Fix this problem by allocating memory first before queue frozen.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

