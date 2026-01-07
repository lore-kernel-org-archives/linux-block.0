Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01073161B7
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778989; cv=none; b=lR2NxCawVaNWEffp6KaWgLtu8rdH8iY0KmMKd91u12eOfETJ/6j8VHJEgZwsRC7glEvKAhRcbdvgaJXtB6hszKhpUt2SXoq+LJFVUBc0rvXvCvGSAwtBbgnX6+X7QeL45CK/BiotWV3HH86eKiJY2J3oJp0t9By6/5ZSyY7fJVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778989; c=relaxed/simple;
	bh=oz22MDHhnEMQankL27fuXQ4AWkbdLB83rvLBqeXCCYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7vFIAJ6P2C2afJ4n299BdL41YonI8xOXAz+689aY+zVScQK0GzKZXGRGn1mMJZH7L8IVIgxT7fH/94QZtILB8O/lfZlsAjJTUGx7RQ92rGwHCXtdgy3bJiDhCZfYVRx8u8p/yeL4fO8D3Iwe1gucyeFzezqjY9d8nzgm5iQiP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WHa+845W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHa+845W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767778986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HP+JI1WuwX2Mw/86uzQnPlxOsn43UtRxUgQF7K3C7EU=;
	b=WHa+845WIsZhuJCYDUKUGoGHXQdPaLAhUS1/1mh49R9yjBCqceFFw211HulLmEvGtl2fRR
	DEPXYByrKR+1VBSDrk6hdM9MNI3X8qjngfavp7YCS8IIknuFA5zLeyxObsUYeKtsNP4/wr
	jIKYWJbBfisZHWK9aOnNbUDUD6F61F4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-IAp-Lik-N3qPSfHPWA_PTg-1; Wed,
 07 Jan 2026 04:43:05 -0500
X-MC-Unique: IAp-Lik-N3qPSfHPWA_PTg-1
X-Mimecast-MFC-AGG-ID: IAp-Lik-N3qPSfHPWA_PTg_1767778984
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D2701956094;
	Wed,  7 Jan 2026 09:43:04 +0000 (UTC)
Received: from fedora (unknown [10.72.116.199])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 613FC19560AB;
	Wed,  7 Jan 2026 09:42:59 +0000 (UTC)
Date: Wed, 7 Jan 2026 17:42:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
	nilay@linux.ibm.com
Subject: Re: [PATCH v7 05/16] blk-mq-debugfs: make
 blk_mq_debugfs_register_rqos() static
Message-ID: <aV4qnwPTG6FEnMfP@fedora>
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-6-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231085126.205310-6-yukuai@fnnas.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Dec 31, 2025 at 04:51:15PM +0800, Yu Kuai wrote:
> Because it's only used inside blk-mq-debugfs.c now.
> 
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

