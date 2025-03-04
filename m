Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5333611CAF
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 02:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741055113; cv=none; b=sJvi9NdzSAbh5uFABZcxicNgPUL8csYOtXdTSfv14yhWixnulw0++O2Sso5phfQCCKDk681M9grs9pQCpUUp8Eft0W79LyOGqe5LwxeWJMQ+tHJUVi5MJgV0VJBvZa5YuVAfRiROcCALcIOgxHgHMFicoBBGnANgRYqzxeVddOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741055113; c=relaxed/simple;
	bh=qv/zts2MThIop8JFZxG9TKaeVtbC6bDZU5bovI04XLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7Qama1gGrZBNBU/xhlox7pgfK8Q1whv/PsawfDO9srO59HnBaFaklZiQwmMJaVzz4QsYHjsNUo5piu10fEAaIUNj8+89i2OLThZAoFpDy5yGW431ebkiOqGzBpYtGUjmB3i5Duuvolkyt5CcUht8GxXrX/2pEVlxjBz5Y5DNws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iLD16YBx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLD16YBx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741055111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BgUwcgr4jn/DlMOOTnBVfMkvwq98PJLSyPiDU7PQuew=;
	b=iLD16YBxFYuO/EbUQaDnqqWBYGx0hpBaccq2eMLSkc5PUWxhsMVZKFJOpRnLPrahjgIvoJ
	XB3SaHzIAmeYTwL8wh+uyWx/PvagLH9f4ZO51XrS3pcyK/X8iDoIV3UHfsop/SKZcC1h6O
	PwJOezruPrgTaYrPfZ1A5XF+Dcxpqmk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-FLszKppNNAmIX4iCE9_l3w-1; Mon,
 03 Mar 2025 21:25:07 -0500
X-MC-Unique: FLszKppNNAmIX4iCE9_l3w-1
X-Mimecast-MFC-AGG-ID: FLszKppNNAmIX4iCE9_l3w_1741055106
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1136119137A2;
	Tue,  4 Mar 2025 02:25:06 +0000 (UTC)
Received: from fedora (unknown [10.72.120.26])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95C8B1956048;
	Tue,  4 Mar 2025 02:25:00 +0000 (UTC)
Date: Tue, 4 Mar 2025 10:24:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, dlemoal@kernel.org,
	hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv5 5/7] block: protect nr_requests update using
 q->elevator_lock
Message-ID: <Z8ZkdnERBlgIe2UF@fedora>
References: <20250226124006.1593985-1-nilay@linux.ibm.com>
 <20250226124006.1593985-6-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226124006.1593985-6-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Feb 26, 2025 at 06:09:58PM +0530, Nilay Shroff wrote:
> The sysfs attribute nr_requests could be simultaneously updated from
> elevator switch/update or nr_hw_queue update code path. The update to
> nr_requests for each of those code paths runs holding q->elevator_lock.
> So we should protect access to sysfs attribute nr_requests using q->
> elevator_lock instead of q->sysfs_lock.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

