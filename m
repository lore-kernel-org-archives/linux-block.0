Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916073103C4
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 02:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746499213; cv=none; b=kjQzuoFofSgVgWqZs1ugfCucPx/v4g5e2dZ+lsxy4olPMI+l1CHXBuIgK9VFPoJsoJZ+KLB5Fa+HDuv+hZfnRKCMM/hjcEPizHGHZdzTfToCxW6GnbUnnr8SwmwFvuwn2HUDaY4s19UKm3yUuGCMC+jQNQFeAqu7I+MYIQby23w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746499213; c=relaxed/simple;
	bh=CTbLsyl58iltfZZfRBi+FNlAbbyFqCv8E4mvbDWbueA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUrdE3eZ8mCcNtrCCs74kO0YaS2ZBVa7obc4MY+YeLEcojkeEj9a9pVWSR7AD7JtHNbG2TE5eF4Y48Du10drsd3lecW1WQuIomPJzLMlYbXGWLJZ3sHlFmo3XEM02Jzqopl8d8tORawyGfir7b1kspx30+4TFggNSRqACdnwFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TMBHzKjv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMBHzKjv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746499210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cEYYbJsPFV36ejeonpvfPVQlMdzMST330wtCWmXF40w=;
	b=TMBHzKjv3IVnCbKBItD3ggbgvhOdm8zMM7eo8hmCI1nusd0hUUMyj1hUPti8FzUZXJ2OTI
	AliadBq7CB2vw6Qg+a6CxfHhUNfb/eQYydZI1r+IQ+sJCNP9YZdJFy8EwhGq2gqjiBIbfo
	1+J37ji5KSsid1HvZibax9CHOUfUFxw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-dzS3dgcLMEuTTv1vBNJieQ-1; Mon,
 05 May 2025 22:40:07 -0400
X-MC-Unique: dzS3dgcLMEuTTv1vBNJieQ-1
X-Mimecast-MFC-AGG-ID: dzS3dgcLMEuTTv1vBNJieQ_1746499206
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02EBA1956088;
	Tue,  6 May 2025 02:40:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7F0830001AB;
	Tue,  6 May 2025 02:40:02 +0000 (UTC)
Date: Tue, 6 May 2025 10:39:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ublk: consolidate UBLK_IO_FLAG_OWNED_BY_SRV checks
Message-ID: <aBl2fkjRwh3SJqWE@fedora>
References: <20250505172624.1121839-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505172624.1121839-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, May 05, 2025 at 11:26:23AM -0600, Caleb Sander Mateos wrote:
> Every ublk I/O command except UBLK_IO_FETCH_REQ checks that the ublk_io
> has UBLK_IO_FLAG_OWNED_BY_SRV set. Consolidate the separate checks into
> a single one in __ublk_ch_uring_cmd(), analogous to those for
> UBLK_IO_FLAG_ACTIVE and UBLK_IO_FLAG_NEED_GET_DATA.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
> v2: rebase

Reviewed-by: Ming Lei <ming.lei@redhat.com>



Thanks,
Ming

