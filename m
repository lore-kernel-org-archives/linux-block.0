Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CEF500951
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972688; cv=none; b=rZkPLVj04YBf0Ev7fIH+uVok6FN+1HnZWw2reSmVVN8TDYYzfcb7BDFCzPu+4eHiYbGQ1ttweYFkLJTfQ5H6nkXoVLV2fI6aEW19JFdFIVuwyTKhkBjhDFD2/Tm0kXQC+dmJxMLHP+93DVn67TldlFgfF/JyZFMl2MgGY76m90k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972688; c=relaxed/simple;
	bh=bvhJVIQWtwfjUfz/RmFvnSSQyRV043RTXmbYHx7VeHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riCgLcqMd/e0tbPtOukYWuLwxaVGhlIOuekfMfOaVBefo4uOfjvtKSmU04cjK478aYvwA2FNLevKHqTbWsSDaYnBAo3XICN49x6/AMjfAF8YkCw7gK3P1PLa3RxY2rnLauZXaUr5wY6gWbuF+zTKXtzUIccj633PYnKNDsC1bf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bgh7kNdm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgh7kNdm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767972686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ViBkhJq5sQu37jN/l696lTJGeFUJOwEfwM+VWEO3FD0=;
	b=bgh7kNdmMwX/Lcq6pqqhHfpfjIYNPJrRkemEd/uPl+/9Vd0O9uV9Kx0IukyHlrfydE02u4
	Ep2eZJfkcG2FUZjNmeOVEqTH+wmakb7VlK0mDVDciW4H3Rbf0wrsFBvcCElknlOGo5DPQ2
	8zsZzISMYMjzHINa2PmWqKkp2a1wOOA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-On0ZK2r3NLOvhbvuMZC0Dw-1; Fri,
 09 Jan 2026 10:31:25 -0500
X-MC-Unique: On0ZK2r3NLOvhbvuMZC0Dw-1
X-Mimecast-MFC-AGG-ID: On0ZK2r3NLOvhbvuMZC0Dw_1767972684
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 417F818002C7;
	Fri,  9 Jan 2026 15:31:24 +0000 (UTC)
Received: from fedora (unknown [10.72.116.172])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66F7B1800285;
	Fri,  9 Jan 2026 15:31:19 +0000 (UTC)
Date: Fri, 9 Jan 2026 23:31:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ruikai Peng <ruikai@pwno.io>
Subject: Re: [PATCH] ublk: fix use-after-free in ublk_partition_scan_work
Message-ID: <aWEfQ148Qu0axKfp@fedora>
References: <20260109121454.278336-1-ming.lei@redhat.com>
 <aWEaOFuhRPvtnkRO@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWEaOFuhRPvtnkRO@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Jan 09, 2026 at 07:09:44AM -0800, Christoph Hellwig wrote:
> Why does ublk have it's own partition scan code anyway?

It is for improving error handling and avoiding deadlock.

ub->mutex is held when calling add_disk(), when IO error or timeout is
triggered, error handling code path requires ub->mutex.

So it takes nvme mpath's approach to scan partition from wq context.

Thanks, 
Ming

