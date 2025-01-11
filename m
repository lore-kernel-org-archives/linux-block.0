Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676DDDDD2
	for <linux-block@vger.kernel.org>; Sat, 11 Jan 2025 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736564764; cv=none; b=FA9je8C4NMfMdzSe/DEfNg40kR621uugu5DPmJUDFSMcAjGZtciZuJ1Klff7jw4JJUUviLkz0nOxm8qBEgPC0tY/WGEXbhjaIv57rOfpJ3Kkwgi83cHJiO6TEIn/W9GTtAhA2qV6OyTIVpfWRhRpIk0FNa9y0xdQA3efLenGIuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736564764; c=relaxed/simple;
	bh=kHSd4Ajr7fnGjFQhT39R8DUQ5dFnbiry6F7Z/L4UUVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6l6EdwXTMMNdKtdpXrfs/CiKhSfZTkNN1OOaaRWkfmowUTxvxjYqtQ08OvzbxnHf7LOIGlNr6517q9sDc8GOvjWOi6yj6I5UlXAaJn2aS3atkAsh2+a3DKHH8orS2ideI+iwn9znh88SwO1RAUrrrYx09695v9DB/lf5Cstahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNuJwevI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNuJwevI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736564761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0l+nqmXaO1JoCLOWX/PUDFsSptgKKafyRo6Rpbd5qmA=;
	b=NNuJwevI6RphUdqlIVG2m9vKW/LNKf1YBnZdRmODZCRkKN0E1WhiPfBrjLIEqpSDCjDd/+
	AcMadT8MzruaFlGqJA3EbjXkR1g8QohLqMduD74cG+8N9JeSZKLTdEcvlfANy04U4im7R3
	e9zCl9oNrU+ijTqJhdcsR1PYCWhdyHA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-zM9D_0_XODOPLh1-nh5mNg-1; Fri,
 10 Jan 2025 22:05:59 -0500
X-MC-Unique: zM9D_0_XODOPLh1-nh5mNg-1
X-Mimecast-MFC-AGG-ID: zM9D_0_XODOPLh1-nh5mNg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03BCD19560A3;
	Sat, 11 Jan 2025 03:05:58 +0000 (UTC)
Received: from fedora (unknown [10.72.116.10])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED63E19560AD;
	Sat, 11 Jan 2025 03:05:53 +0000 (UTC)
Date: Sat, 11 Jan 2025 11:05:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org
Subject: Re: Blockdev 6.13-rc lockdep splat regressions
Message-ID: <Z4HgDJjMRv4s5phx@fedora>
References: <65a8ef7321bf905ab27c383395016fe299f6dfd9.camel@linux.intel.com>
 <Z4EO6YMM__e6nLNr@fedora>
 <7017f6bf8df5bbd8824f9f69e627c3f33b9aa7cd.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7017f6bf8df5bbd8824f9f69e627c3f33b9aa7cd.camel@linux.intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Jan 10, 2025 at 03:36:44PM +0100, Thomas Hellström wrote:
> On Fri, 2025-01-10 at 20:13 +0800, Ming Lei wrote:
> > On Fri, Jan 10, 2025 at 11:12:58AM +0100, Thomas Hellström wrote:
> > > Ming, Others
> > > 
> > > On 6.13-rc6 I'm seeing a couple of lockdep splats which appear
> > > introduced by the commit
> > > 
> > > f1be1788a32e ("block: model freeze & enter queue as lock for
> > > supporting
> > > lockdep")
> > 
> > The freeze lock connects all kinds of sub-system locks, that is why
> > we see lots of warnings after the commit is merged.
> > 
> > ...
> > 
> > > #1
> > > [  399.006581]
> > > ======================================================
> > > [  399.006756] WARNING: possible circular locking dependency
> > > detected
> > > [  399.006767] 6.12.0-rc4+ #1 Tainted: G     U           N
> > > [  399.006776] ----------------------------------------------------
> > > --
> > > [  399.006801] kswapd0/116 is trying to acquire lock:
> > > [  399.006810] ffff9a67a1284a28 (&q->q_usage_counter(io)){++++}-
> > > {0:0},
> > > at: __submit_bio+0xf0/0x1c0
> > > [  399.006845] 
> > >                but task is already holding lock:
> > > [  399.006856] ffffffff8a65bf00 (fs_reclaim){+.+.}-{0:0}, at:
> > > balance_pgdat+0xe2/0xa20
> > > [  399.006874] 
> > 
> > The above one is solved in for-6.14/block of block tree:
> > 
> > 	block: track queue dying state automatically for modeling
> > queue freeze lockdep
> 
> Hmm. I applied this series:
> 
> https://patchwork.kernel.org/project/linux-block/list/?series=912824&archive=both
> 
> on top of -rc6, but it didn't resolve that splat. Am I using the
> correct patches?
> 
> Perhaps it might be a good idea to reclaim-prime those lockdep maps
> taken during reclaim to have the splats happen earlier.

for-6.14/block does kill the dependency between fs_reclaim and
q->q_usage_counter(io) in scsi_add_lun() when scsi disk isn't
added yet.

Maybe it is another warning, care to post the warning log here?


Thanks, 
Ming

