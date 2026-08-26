Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624B13AFCE9
	for <linux-block@vger.kernel.org>; Wed, 26 Aug 2026 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773766; cv=none; b=nOoR8mWCN+B2JXHqkZTC84+nMSmdeP2Jui+vWlHkqyCvmtosBGzMadBlmEnBZehpj656BOQVZ+DbhJEV55PHIdacmYDRPBewz8F/HrdKZyt2YoYhST65UFU41eP1msrbQzidW9l5vpPd+mz2ARgTMP6FMfmtx+FelbVD75ETrsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773766; c=relaxed/simple;
	bh=y9g2ualI/bK6M+PISVPgksBz/q7GbK0yHm3ggAbxYGc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=DrkVoWJ3mPhATVy/WHZuPVH+BWOT7Pa4nnmHqwYfN4dAiEgWbeifGyrCUL0LJ/uJbyzEwvHnmvtl/jRBF5rSzyZj2/MpGE4+kiE75GolDIaVmEfuxMmYI3DyRsxmPIxiMITTHOWBAUA85ETp2NJgM2KmBfu2HXVwl2o5mQEk/tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8cwaFE5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8cwaFE5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tuNSEaT3GKGdOWYWz+Vtzv8wtmbE7GwqDneMzbaR/Ys=;
	b=Z8cwaFE5FJVgP+AnpINTszMPUahSXIsyYCkQ8rwuSMoOoeiBVzG1LrTWwttAcnZqJuqICd
	t+L6xbSIBYBFQvu3zHWYtz5nHTz5sLs7m0JsN9dJVuWIozBKJMu5Pv1aJnzOsC12HaK1Wc
	qE2d1rUKT+JCNJD3CSzMtYoINoBoegY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-NVaS2IIWMbGp8zxC6NffEg-1; Wed,
 26 Aug 2026 15:49:08 -0400
X-MC-Unique: NVaS2IIWMbGp8zxC6NffEg-1
X-Mimecast-MFC-AGG-ID: NVaS2IIWMbGp8zxC6NffEg_1787773745
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1840B1954B13;
	Wed, 26 Aug 2026 19:49:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.88.47])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E75D11955F43;
	Wed, 26 Aug 2026 19:49:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ao8xqMXoCfj4AWUw@kbusch-mbp>
References: <ao8xqMXoCfj4AWUw@kbusch-mbp> <1819786.1787768317@warthog.procyon.org.uk>
To: Keith Busch <kbusch@kernel.org>
Cc: dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
    Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Fix start and length check added to iov_iter_extract_bvecs()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1864927.1787773740.1@warthog.procyon.org.uk>
Date: Wed, 26 Aug 2026 20:49:00 +0100
Message-ID: <1864928.1787773740@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Keith Busch <kbusch@kernel.org> wrote:

> iov_iter_alignment loops over all the vectors when we only need to
> examine the current one here.

Actually, I don't think that's true.  iov_iter_extract_pages() is allowed to
pull from multiple bio_vecs in an ITER_BVEC, for example - and if, say, the
page in the second bio_vec is contiguous with the first, then
iov_iter_extract_bvecs() will use it - so you still need to check bv_len on
it.

David

