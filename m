Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A031F4716
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744037660; cv=none; b=pASgqWWYY8fxEJ176/VnferZgvPQAaJ3In2OxW97kfXm7YG2pYYe/iAeQtXjnO0m2qf6XD6Vp45fU5cx+KBp3FOT0FHKPkSDMsIi9LocfWiadrO8BlfuDfS8BLLrbxE/c+zo/Fh4g/iTzIct9NJqxKMb+v5wx+x6KXRSvwIUI6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744037660; c=relaxed/simple;
	bh=Jjt7ZbxI34FOLZVVA70IOrRA6DrynfYhRSt0SxZw0UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLKCVVJYO0aGe0d3hCDmFpaGj38mC4heW0Rj1zF776RJJQiOK+8/YmXAusIklIsTVU0wMUJCxR50K7+Ou+efkNQ+K9vyK/eeAr8/pOXT2WIAEYsu8DV9zwBUBrbT7w6nUQjGh2g8Rqo1mUcL21gMG0I4+E+ayfJhLLtZaEF+5Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fKZcriyw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKZcriyw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744037657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hC74ZWpJwv2xPVhirkcEsv8uJ88JkcJRmVIbBjZ0OYM=;
	b=fKZcriywkIFppcVNkTrlKxPsLLFfmQltU/nPcJnkpDFflR8cjpOhFx2p1J3KfwgHnhylZ6
	I/7tJchUsM9zXHZ0PwsR7tr3FC7ypZlUe6LoJ305Ma0YfIQg5kIgdZMDxXxs/ZE8JI3gXr
	4ZChpwyqT6y9kvnX92AzmThHUwQMjZw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-b4idOAm7PPq9cpXZQ06EMg-1; Mon,
 07 Apr 2025 10:54:13 -0400
X-MC-Unique: b4idOAm7PPq9cpXZQ06EMg-1
X-Mimecast-MFC-AGG-ID: b4idOAm7PPq9cpXZQ06EMg_1744037651
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF6F5180882E;
	Mon,  7 Apr 2025 14:54:11 +0000 (UTC)
Received: from fedora (unknown [10.72.120.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8814F3001D14;
	Mon,  7 Apr 2025 14:54:07 +0000 (UTC)
Date: Mon, 7 Apr 2025 22:54:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	syzbot+9dd7dbb1a4b915dee638@syzkaller.appspotmail.com
Subject: Re: [PATCH] loop: replace freezing queue with quiesce when changing
 loop specific setting
Message-ID: <Z_PnCUw0eeVdwxxy@fedora>
References: <20250403105414.1334254-1-ming.lei@redhat.com>
 <20250404091149.GC12163@lst.de>
 <Z-_LLTtusK8g0rlM@fedora>
 <20250407064806.GA18766@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407064806.GA18766@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Apr 07, 2025 at 08:48:06AM +0200, Christoph Hellwig wrote:
> On Fri, Apr 04, 2025 at 08:06:05PM +0800, Ming Lei wrote:
> > On Fri, Apr 04, 2025 at 11:11:49AM +0200, Christoph Hellwig wrote:
> > > On Thu, Apr 03, 2025 at 06:54:14PM +0800, Ming Lei wrote:
> > > > freeze queue should be used for changing block layer generic setting, such
> > > > as logical block size, PI, ..., and it is enough to quiesce queue for
> > > > changing loop specific setting.
> > > 
> > > Why?  A queue should generally be frozen for any setting affecting the
> > > I/O path.  Nothing about generic or internal.
> > 
> > For any driver specific setting, quiesce is enough, because these settings
> > are only visible in driver IO code path, quiesce does provide the
> > required protection exactly.
> 
> What are "internal settings" please?  If you change the loop backing
> file outstanding I/O is relevant.  If you change NVMe ANA or retry
> policies are relevant as they are checked in the I/O completion handler.

internal setting means the driver internal setting, which is only visible
for driver.

Here this setting(lo_offset, backing file, dio, ...) won't be used in completion
handler, so it is fine to use quiesce here for updating these loop specific
setting.

> 
> > > This also misses an explanation of what setting this protects and why
> > > you think this is safe and the sound fix.
> > 
> > 1) it is typical queue quiesce use case
> 
> What is the typical queue quiesce use case?  Why is it "typical" and
> why is it safe.

typical quiesce provides sync with driver's ->queue_rq(), and it is typical
that these driver settings are only used in driver submission code path.

> 
> > 
> > 2) loop specific setting is only visible in loop queue_rq() & workfn, and
> > quiesce does provide the sync for queue_rq()
> 
> _What_ loop specific setting.

Any setting is only visible in loop driver, such lo_offset, backing file,
dio, ...

> 
> > 3) for driver, quiesce is always preferred over freeze, and freeze is
> > easily mis-used by driver, you know we have bad driver uses for freeze.
> 
> I am actually much more worried about quiesce.  It is much less well
> defined.

It is widely used, and please see document of blk_mq_quiesce_queue().


Thanks,
Ming

