Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB811EB36
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 02:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736303414; cv=none; b=GhEyOcHjjwCfkeytDaVJ4MQlJ2wW90UxfSOa0eDlYWj6gMYeFwOG3O9oznDcMQiPRjcV4SyVSJ50jE5b/DMGTqSmFSc9rO0IpgsGVMrKwIriLT4udspB0DUr2mf/WZ0hV/Hc59GOtvp7QjFaEHHq7RayMu26/Gs7GQcogaCSkgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736303414; c=relaxed/simple;
	bh=944tru6ZH9IGetLXHpAR8IAWuFyd2W7/LjMsG34sGwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saq4ujfeUmFSphNWJCEPb/P5PJDTMAMtzVKhpdbVv4WLge3ahuemFsFi1Lav15JZ9TVZK2HfdAq/OUOrAXlQfChhcGCJpQZ11FlaRJWY9OyGKi05dnUhjOBpP+evBnOH30M0VwP/81pLptMmyOou9PoCR7Vi8cjudA+/551lEog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlY7AGyO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlY7AGyO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736303411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yaRVqEtdPDGAiRG/e/XfdPtClHHgMTf/dxGRZC0HFvQ=;
	b=DlY7AGyOyJn4rNNzZEjhcP7oWl8dyO5eG+uar8PfQcfGrNFumevU+5wEbHTLgW/KwMfgQe
	7iT969E3h+u1J6ukqFIrFjYUGpoki3TCPEu6j9YMNV+AM3C6csoBqj8pxCkCODyCms/GyH
	pg/m/WvLnlljd3v0vjIwfgxJDqRx0S8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-bWx0olfQMmS0YPvVqhIMMw-1; Tue,
 07 Jan 2025 21:30:08 -0500
X-MC-Unique: bWx0olfQMmS0YPvVqhIMMw-1
X-Mimecast-MFC-AGG-ID: bWx0olfQMmS0YPvVqhIMMw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA63C19560B3;
	Wed,  8 Jan 2025 02:30:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.126])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5DDD1956088;
	Wed,  8 Jan 2025 02:30:02 +0000 (UTC)
Date: Wed, 8 Jan 2025 10:29:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] New zoned loop block device driver
Message-ID: <Z33jJV6x1RnOLXvm@fedora>
References: <20250106142439.216598-1-dlemoal@kernel.org>
 <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
 <20250106152118.GB27324@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106152118.GB27324@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, Jan 06, 2025 at 04:21:18PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 06, 2025 at 07:54:05AM -0700, Jens Axboe wrote:
> > On 1/6/25 7:24 AM, Damien Le Moal wrote:
> > > The first patch implements the new "zloop" zoned block device driver
> > > which allows creating zoned block devices using one regular file per
> > > zone as backing storage.
> > 
> > Couldn't we do this with ublk and keep most of this stuff in userspace
> > rather than need a whole new loop driver?
> 
> I'm pretty sure we could do that.  But dealing with ublk is complete
> pain especially when setting up and tearing it down all the time for
> test, and would require a lot more code, so why?  As-is I can directly

You can link with libublk or add it to rublk, which supports ramdisk zone
already, then install rublk from crates.io directly for setup the
test.

Forking one new loop could add much more pain since you may have to address
everything we have fixed for loop, please look at 'git log loop'


Thanks,
Ming

