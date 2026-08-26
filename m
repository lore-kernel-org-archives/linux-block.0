Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834BD484230
	for <linux-block@vger.kernel.org>; Wed, 26 Aug 2026 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775823; cv=none; b=Bfnfi6emNiz4piMMCpv9ZtqIN6DKt2QTqP7Y+egZAAL+qn6CF2WSram6sxeC8miE9tD36dzxTU+4jaLo+J4Vp6CVnr7JIPkHtfT6K8xTed5rHln9qpNuPHxjmSQ2z9LMZ3dJ1poZ4skklZt3n8Q9Bp98ziDnGALLVYbje9fl8rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775823; c=relaxed/simple;
	bh=hKNdcb4O36pMXXUw78XWvmtZ8Cm6SzYmwBSdUVVWCko=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=QOtMTUMfCipWuQdjEzhNrDKS5tPRYN+kTGq0cYqxhhQb1lgxjGdOeVeKUEUL/bEviuMClnMl6Jv19ry1+vZozTmtyaCKABqPCvFnofPh9JmxKuWyi8cLf2duOtI/KlkvNqwC9ODsUenret8yzWAFd1IhCTTEIIEdxg5P8SvEsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sm7q+nFi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sm7q+nFi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787775821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m9qT7qssYQfRq6O+ZWVrZCYJE2b1eCy9Sb45AALyhFQ=;
	b=Sm7q+nFiC9WQyfURDeEw5YPID5e0mYz+UDy6GQgGmVdIuEWSHxO+4HaW90cmdaP6xM0PkR
	u8Zlc9qHGtEOb5KEwYYl0COWazWgr17FZ83hKH3CcrnXzZj77GYt75vrIUf9QVBqckPktz
	3ucZeD94Rg04ng9QaKwcSJXS4O7Piwc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-Ez1R0MTmOw2r8ezdmlwTyA-1; Wed,
 26 Aug 2026 16:23:36 -0400
X-MC-Unique: Ez1R0MTmOw2r8ezdmlwTyA-1
X-Mimecast-MFC-AGG-ID: Ez1R0MTmOw2r8ezdmlwTyA_1787775814
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75D6C1862D53;
	Wed, 26 Aug 2026 20:23:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.88.47])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D4D8E195608A;
	Wed, 26 Aug 2026 20:23:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ao9CvZDRChrrxyCj@kbusch-mbp>
References: <ao9CvZDRChrrxyCj@kbusch-mbp> <ao8xqMXoCfj4AWUw@kbusch-mbp> <1819786.1787768317@warthog.procyon.org.uk> <1853652.1787772245@warthog.procyon.org.uk>
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
Content-ID: <1885162.1787775810.1@warthog.procyon.org.uk>
Date: Wed, 26 Aug 2026 21:23:30 +0100
Message-ID: <1885163.1787775810@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Keith Busch <kbusch@kernel.org> wrote:

> +	if (likely(iter_is_ubuf(iter) ||
> +		   iter_is_iovec(iter) ||
> +		   iov_iter_is_kvec(iter))) {

I wonder if it's worth making an exception for ITER_KVEC.  I know the structs
align, as it were, but do we use ITER_KVEC often enough?

Anyway, it seems to work, so you can add:

	Reviewed-by: David Howells <dhowells@redhat.com>

if you want to submit the patch yourself.

David

