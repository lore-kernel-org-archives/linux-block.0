Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D095464E
	for <linux-block@vger.kernel.org>; Fri, 14 Feb 2025 01:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739497054; cv=none; b=X6Jyn+G+DbOrzLC8YtjG/SPwESD7uoR+jhMYYCHzX4NN4gOFFV+6wep1gYxnVjf7WGWHbUQZ0frYWKMcUB0i05xIr+c1rNraO/VTliURV3V7est20pjj3V5C+Rn1KdtyO1QsOx9CWMu/fucI11zNESNJIpzbBD4hITKFOA1Nr6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739497054; c=relaxed/simple;
	bh=th2a3/NR4yque+I+XMypzM08WC3VfGK3QaeeVf4/ZJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ak+9Hi7rHFdCpujbaRSo8MudnerALXz7dg+jjn9bZuYUhn7k+5dBuyjrU4Dcx23nAFo631bJEDNhgdYprwZ3aFfeHKhIvVfAiMxZAgQSj5Iif6lK/ueL0akNwn0Y9/O1lN4MZKmTo1YRBvfGarTtt41VBJCX7MFX76hbvhrhHs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDWyiB43; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDWyiB43"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739497052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PLsi2bsHcAnbAizdWk411TmzIEVW5qW0GKyRVefphv0=;
	b=TDWyiB43KFivN75nSHyWZAyfxtQVc1Dcsb+74r2NKlHPF34XNP/x43uzqmGPeH9rHZJVOi
	UG6Vx2fd4ligFgM63t1YzRjwJrG18X3/6oIJmNyylK3vPKUTP3UTi1sZ+zBg5NI0/0sm3o
	Z8WeqeYyPNSWVHCj9TTYF2M1/+2HcGU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-Jw6paGdyO2-qKfB2yhYcSw-1; Thu,
 13 Feb 2025 20:37:27 -0500
X-MC-Unique: Jw6paGdyO2-qKfB2yhYcSw-1
X-Mimecast-MFC-AGG-ID: Jw6paGdyO2-qKfB2yhYcSw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96AEC180034A;
	Fri, 14 Feb 2025 01:37:25 +0000 (UTC)
Received: from fedora (unknown [10.72.120.24])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1025300018D;
	Fri, 14 Feb 2025 01:37:16 +0000 (UTC)
Date: Fri, 14 Feb 2025 09:37:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <Z66eRnK7V_lHFe5I@fedora>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
 <Z6peww6d3EP5-B8n@bombadil.infradead.org>
 <Z6qxnAEMeTVW-wK-@fedora>
 <t2o3dadb744eyzy7v6jta3gdjgscpttf4s3abqm2mndk5mvwjl@hbvl7vzv6foj>
 <Z62nJqXu_et99D02@fedora>
 <Z62tpanLQgFK8j0i@infradead.org>
 <Z62yq9bbxWwPvJot@fedora>
 <csvt2osvntbtvqveufnsiv2dhinz46z744fx4mgjarbd3twg45@k7zm3jv4k2xb>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <csvt2osvntbtvqveufnsiv2dhinz46z744fx4mgjarbd3twg45@k7zm3jv4k2xb>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Feb 13, 2025 at 03:18:43PM +0100, Daniel Gomez wrote:
> On Thu, Feb 13, 2025 at 04:51:55PM +0100, Ming Lei wrote:
> > On Thu, Feb 13, 2025 at 12:30:29AM -0800, Christoph Hellwig wrote:
> > > On Thu, Feb 13, 2025 at 04:02:46PM +0800, Ming Lei wrote:
> > > > The problem[1] is that this kind of mmc card fails to be recognized as
> > > > block disk. Block layer io split code can handle this case actually.
> > > 
> > > When we still had bio_add_pc_page it would break the assumption that
> > > you could always add a full page.  With that gone and everything going
> > > through the split machinery we might be fine now, but backporting it
> > > to 6.13 and earlier will cause breakage.
> >  
> > Yes, I will mention the following two are depended for backporting in
> > commit log:
> > 
> > 02ee5d69e3ba block: remove blk_rq_bio_prep
> > 6aeb4f836480 block: remove bio_add_pc_page
> 
> Ming, is that sufficient for your use case? Or do you still need to remove the
> assumption that the "minimum" segment size is not PAGE_SIZE?

If you want to make any block device with < 64K max_segment_size working
on 64K page_size kernel, you need this patch and the following three
dependencies:

commit 6aeb4f836480 ("block: remove bio_add_pc_page")
commit 02ee5d69e3ba ("block: remove blk_rq_bio_prep")
commit b7175e24d6ac ("block: add a dma mapping iterator")


Thanks,
Ming

