Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6861519B5
	for <linux-block@vger.kernel.org>; Fri, 14 Feb 2025 02:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498861; cv=none; b=I7+CC0ZW8bQGAj2/4E3JlhEQg+nr1mBjStdsETkez4547AZQKtkKylyFXXffjYbBcZBx35gRXAd6HcuTByQpoT702Hqibeib7R7fnjc4xxZPJX0jk3bbiOlVdo0a8106kWg+yPwhmxtOssj8OktH8QlfuqJDCG5PNasrgB/j3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498861; c=relaxed/simple;
	bh=mLClLGvXbO0CMLhZGrz2U35H9vqdBu4vR6zXvcE7d9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCfoyfhWWjvpnt6fb/1anMvXAJCG/qKvTDVH3CjjAMSF1wiQjNou5Zk9sQPGqV9l7ayEhxdbkTAtI8yS3VvnR1q2e+bIVRNqipS6NdEkGBlZJTuru9NMEMUWj+9F1OVxPUasoU4bJjRiV7el1HtdJ3UoCt1oRn6CsXfJOy3rMAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W3FdFS0P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3FdFS0P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739498857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FiHFuZJ7szxMHdc5YtOAwGdGEHzTXFjOhmKzGzVvsXs=;
	b=W3FdFS0P71b3wbFpSEl5yRdOwAm+bedqb8tv/YaZYddZa70SydWUv/HvH67C/p77sJVYmW
	f+uMmndSO4kJ8w4CSFf8BXU8eXM50J6dkNPaHJY4Hgw9+kJPmKs3Bkn3RHSbFUwd+RQKq6
	qbKUdfvUCM0EHn5XDMOE5lztydc4c38=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-nHAxxu_-NceTUsYQ4z30Rg-1; Thu,
 13 Feb 2025 21:07:36 -0500
X-MC-Unique: nHAxxu_-NceTUsYQ4z30Rg-1
X-Mimecast-MFC-AGG-ID: nHAxxu_-NceTUsYQ4z30Rg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A410C19373D9;
	Fri, 14 Feb 2025 02:07:34 +0000 (UTC)
Received: from fedora (unknown [10.72.120.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAA911800360;
	Fri, 14 Feb 2025 02:07:29 +0000 (UTC)
Date: Fri, 14 Feb 2025 10:07:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 1/7] block: remove hctx->debugfs_dir
Message-ID: <Z66lWy5Yf4T_4mlg@fedora>
References: <20250209122035.1327325-1-ming.lei@redhat.com>
 <20250209122035.1327325-2-ming.lei@redhat.com>
 <20250213064146.GA20494@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213064146.GA20494@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Feb 13, 2025 at 07:41:46AM +0100, Christoph Hellwig wrote:
> On Sun, Feb 09, 2025 at 08:20:25PM +0800, Ming Lei wrote:
> > For each hctx, its debugfs path is fixed, which can be queried from
> > its parent dentry and hctx queue num, so it isn't necessary to cache
> > it in hctx structure because it isn't used in fast path.
> 
> It's not needed, but it's also kinda convenient.  What is the argument
> that speaks for recalculating the path?

q->debugfs_lock will be not necessary if these cached entries are removed,
please see the last patch.


Thanks,
Ming

