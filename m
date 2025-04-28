Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0240786323
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839703; cv=none; b=Q/2MItZvZmOwkf+kPjWuyJxZfq3t7S6r6eaIwI1JlQ9VVG4z/4eMvnANywsh3dZzhRMTbvyj1TJEKd3WWgtxDWeYNihMXA/dV9CNzr6klVpbPlDXGZyuly6g0i0pVuuq9WSIiK2zxjUVPWSr7XZbIrmlf4gzpDeB2xcYTGciBL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839703; c=relaxed/simple;
	bh=RH6CcKWJSrBXpJMjkw7LBJpdsREjVQ+Ho2Nnt5puBQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNTP52TBUwA9cQPPEJKscfwI5VQtRdqSnax7bwvQvxUpDUoXqt452bbdbfmEYXzMVtwFKR+8RCFlZef9uoRKS8AkfMYQWckDHXILeAXIXK/PsvIikFawWNPsqOhgNAZbxX0C2go5CxnckV29z7yyHZEc5DTaNlwgIlFnGv05d7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=atUJlofR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atUJlofR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745839700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=flMEZyiQDvKXBBh/N0tOrcD5SwaQO+VoX2fmUedUcA4=;
	b=atUJlofRh4Ry2/SCzyDFBXhCTjS1nEkm783LS5bX75qFRMZlnC4dLJxoXpSww1UT7QMRC1
	tt/7mFDI8oGnRBWRFIiiIOtmeplmKZVHFObImX0Kt3X92FhoPf2/wGCcyxeXfZwpcYT0Sy
	ATN2vFg6kA4v2kO5SscaPQcXoqfux94=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-jvYWettWP3eTsNZ6WkkfBw-1; Mon,
 28 Apr 2025 07:28:16 -0400
X-MC-Unique: jvYWettWP3eTsNZ6WkkfBw-1
X-Mimecast-MFC-AGG-ID: jvYWettWP3eTsNZ6WkkfBw_1745839695
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3D251800878;
	Mon, 28 Apr 2025 11:28:14 +0000 (UTC)
Received: from fedora (unknown [10.72.116.66])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF66B30001A2;
	Mon, 28 Apr 2025 11:28:10 +0000 (UTC)
Date: Mon, 28 Apr 2025 19:28:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH V3 17/20] block: move debugfs/sysfs register out of
 freezing queue
Message-ID: <aA9mRSeP_s6fnsdz@fedora>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-18-ming.lei@redhat.com>
 <20250425183801.GC26393@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425183801.GC26393@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Apr 25, 2025 at 08:38:01PM +0200, Christoph Hellwig wrote:
> On Thu, Apr 24, 2025 at 11:21:40PM +0800, Ming Lei wrote:
> > Move debugfs/sysfs register out of freezing queue in
> > __blk_mq_update_nr_hw_queues(), so that the following lockdep dependency
> > can be killed:
> > 
> > 	#2 (&q->q_usage_counter(io)#16){++++}-{0:0}:
> > 	#1 (fs_reclaim){+.+.}-{0:0}:
> > 	#0 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}: //debugfs
> > 
> > And registering/un-registering debugfs/sysfs does not require queue to be
> > frozen.
> 
> Please explain the why it's not required.  And talking about lockdep
> dependencies is not very useful - it either is an actual lock ordering
> issue or a fale positive, but lockdep is just the messenger.

Both kobject delete and debugfs unregister drains in-progress .show/.store
and read, they do not need to freeze queue.

Thanks, 
Ming

