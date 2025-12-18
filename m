Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B71A314D0E
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055995; cv=none; b=G/Zyou/ICg7TaCX66jPSS3xD8QuBahdOoKXkQz7TrWOEzXFyq2GxujRv17QfAPgr/asqcEn2CE5H2wsp9G20dqTkGUsC0nzIqVqXQRuGHpxfIpEZpl83tohRC7uj7iAFjp76S/J+Z7yZVIVN7W00Fo8O5QZBO6PFKWTUbEqnYqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055995; c=relaxed/simple;
	bh=kE//TKFQATgJXZfyew5hvY5cLu0D5YBPc1MkXJ9SXhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMRSMLO9qy41tUUbjxnE/mRwMZWCIq1fpb36mZao64qcxKj5V/cBrU5XDsc7WG48Bvtjk5yq0HVmFYq55QIUK7hKHwylJY4dodaGQVAW95ckYaCfkokXdWd5SCrpNADBEqkEDXh6nBTzPjorDWwGi6C9AP1xYMLs+Yd40SPVVDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7VAnRgg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7VAnRgg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766055992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QKjHidN3GLE94JIukjlBdgqQ2/0xceYtSf9/q53jqb0=;
	b=S7VAnRggTRmvB4wNBtuftElwSUywyqGV+9c37p9cJKjo8C3Hs5k9Zs5Wq9V7Ks832STrfG
	vesgNjJX3vihpn8XospFJjlWsa7xPER1ApIgSqfgtVe8YmK/kYQ8aPprw89dGMMiW5IPsY
	yw49aNARku5xzeeyu+25knTpxeAMXQE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-840ikdROO_etkAHVSNcycA-1; Thu,
 18 Dec 2025 06:06:31 -0500
X-MC-Unique: 840ikdROO_etkAHVSNcycA-1
X-Mimecast-MFC-AGG-ID: 840ikdROO_etkAHVSNcycA_1766055989
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 557271800620;
	Thu, 18 Dec 2025 11:06:29 +0000 (UTC)
Received: from fedora (unknown [10.72.116.190])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39BE130001A2;
	Thu, 18 Dec 2025 11:06:24 +0000 (UTC)
Date: Thu, 18 Dec 2025 19:06:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
	nilay@linux.ibm.com
Subject: Re: [PATCH v5 03/13] blk-mq-debugfs: factor out a helper to register
 debugfs for all rq_qos
Message-ID: <aUPgKnROy8SYT0RE@fedora>
References: <20251214101409.1723751-1-yukuai@fnnas.com>
 <20251214101409.1723751-4-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214101409.1723751-4-yukuai@fnnas.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sun, Dec 14, 2025 at 06:13:58PM +0800, Yu Kuai wrote:
> There is already a helper blk_mq_debugfs_register_rqos() to register
> one rqos, however this helper is called synchronously when the rqos is
> created with queue frozen.
> 
> Prepare to fix possible deadlock to create blk-mq debugfs entries while
> queue is still frozen.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

