Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1642330FF33
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788075; cv=none; b=bEg6iO6+/ZeZQGKODtyooVCHyLTzqOmpcfbI2Cgvh6CycEUPfF//4OkxsPhfoiREHZqOF2wbclyuIJe2Ba6zk2tKZvVjzGWu3WrNA7VvAZ4ybJK5tBNLTi4AkAIrqzKWmcIpgEEITmDWMHiBGdzB5gHRR0XclKv7lig/jSLtlGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788075; c=relaxed/simple;
	bh=3fYepAqNba65IcWWTsBu8FgBOsIj4YLKzwP0X7fVVvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ljvbj3mJbxnFkW3NIc1Nf6Y76CSZmPK16p6sQrKjkA91aPq/mkifIB0kStF74VfgsMNV9blxLXhWbEu1kj336V5oXmdX6ohOu/ML235VkltT4nePpEFF6ceilK2uvURoZGgWf0jxian/tuR7elkmDebY6SQ2pPNS532k7YPgcQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DENe1zY6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DENe1zY6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767788071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kr1ScmwddpJZQALKRlBdjbVX3TySDiSCfOK0X8dpTN4=;
	b=DENe1zY67S4YuaDSswTF+LsBpCZwHdZTPLXEFY3vEZB4CRQ6g9KcLWSAs6W87ltxbNz33W
	Q80g955cvSK1ZzVLIeHw2RYwjsVhJgalIKmwrviiY4iaVZfzpVaOaLKfWFI7D6lrd5L1dG
	G/RcFDjLX4DV4K2+DNSBzX3F3Q49io8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-NP_ASy0qNd2xUDWCBOpX3A-1; Wed,
 07 Jan 2026 07:14:28 -0500
X-MC-Unique: NP_ASy0qNd2xUDWCBOpX3A-1
X-Mimecast-MFC-AGG-ID: NP_ASy0qNd2xUDWCBOpX3A_1767788067
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EE43180061D;
	Wed,  7 Jan 2026 12:14:27 +0000 (UTC)
Received: from fedora (unknown [10.72.116.199])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB28E18001D5;
	Wed,  7 Jan 2026 12:14:23 +0000 (UTC)
Date: Wed, 7 Jan 2026 20:14:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
	nilay@linux.ibm.com
Subject: Re: [PATCH v7 10/16] block/blk-rq-qos: add a new helper
 rq_qos_add_frozen()
Message-ID: <aV5OGq9hDB918C4w@fedora>
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-11-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231085126.205310-11-yukuai@fnnas.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Dec 31, 2025 at 04:51:20PM +0800, Yu Kuai wrote:
> queue should not be frozen under rq_qos_mutex, see example from
> commit 9730763f4756 ("block: correct locking order for protecting blk-wbt
> parameters"), which means current implementation of rq_qos_add() is
> problematic. Add a new helper and prepare to fix this problem in
> following patches.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---
>  block/blk-rq-qos.c | 21 +++++++++++++++++++++
>  block/blk-rq-qos.h |  2 ++
>  2 files changed, 23 insertions(+)

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks, 
Ming

