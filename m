Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067C02063DA
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739436740; cv=none; b=SEMSpLqjzo8H0HHnZKmPTgGOpnrVw6VEzxzfYuzWDV65btYqGD3maQ51Ktrbd1+MNJscCHyCurJKTMi4KF4draSQrkR/+QeBFo+H9KKGN+I52TS4aiT+tTGTIdHQCxlQgRXFN8dCR8aoJF9qzJrNh4YZN9jRvv6Ju+EP4vIc+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739436740; c=relaxed/simple;
	bh=Pzgdlneehcv85ynAe3hKbDSr0sY+4+wL8Ed819/AqQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TksrA6q6t5dHD+pmSSlNx0L/7GgGqpMgtWhfYrLTJCES+GUoeYkJtIC2Q7fUVSWfueTQQkFLiHDb1cCNweh+3CC5sUZPQoexE1/7tWDyD/FfL0wdJY/bjIw1EAsJ7Q3GTV0wSCYqF92ZNDnE5ooi/Lhzq+jJ1g9y84SVbOfFNAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBeAmDxn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBeAmDxn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739436737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=diBjIy7ocUtfKAVzzG/kxu1XlwNc4n1RSemvg9LZe9Q=;
	b=NBeAmDxn2KIblR70efyf0SOvrVTTsH2MKwLxPgnYF7T9+a+QLs8T3jr7rjkUt3q1L9sLwS
	dWOcFRXW/MC2yVNMyGfEapmEIeoJumxv6Dv6v508tQxROgQ53rmMMsQN6FJx2oh0hJkbck
	a0ksdF04B/5c3H1cLuALBtNhOuL9jW8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-geIt4luEOH63rTKRLQGIPw-1; Thu,
 13 Feb 2025 03:52:11 -0500
X-MC-Unique: geIt4luEOH63rTKRLQGIPw-1
X-Mimecast-MFC-AGG-ID: geIt4luEOH63rTKRLQGIPw_1739436730
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C249C18EB2CB;
	Thu, 13 Feb 2025 08:52:09 +0000 (UTC)
Received: from fedora (unknown [10.72.120.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE1011800360;
	Thu, 13 Feb 2025 08:52:01 +0000 (UTC)
Date: Thu, 13 Feb 2025 16:51:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Daniel Gomez <da.gomez@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <Z62yq9bbxWwPvJot@fedora>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
 <Z6peww6d3EP5-B8n@bombadil.infradead.org>
 <Z6qxnAEMeTVW-wK-@fedora>
 <t2o3dadb744eyzy7v6jta3gdjgscpttf4s3abqm2mndk5mvwjl@hbvl7vzv6foj>
 <Z62nJqXu_et99D02@fedora>
 <Z62tpanLQgFK8j0i@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z62tpanLQgFK8j0i@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Feb 13, 2025 at 12:30:29AM -0800, Christoph Hellwig wrote:
> On Thu, Feb 13, 2025 at 04:02:46PM +0800, Ming Lei wrote:
> > The problem[1] is that this kind of mmc card fails to be recognized as
> > block disk. Block layer io split code can handle this case actually.
> 
> When we still had bio_add_pc_page it would break the assumption that
> you could always add a full page.  With that gone and everything going
> through the split machinery we might be fine now, but backporting it
> to 6.13 and earlier will cause breakage.
 
Yes, I will mention the following two are depended for backporting in
commit log:

02ee5d69e3ba block: remove blk_rq_bio_prep
6aeb4f836480 block: remove bio_add_pc_page

Thanks, 
Ming

