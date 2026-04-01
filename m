Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF0836922D
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775057803; cv=none; b=n1FLGHf4fqn3syX5LQCEcu5+YkFcZKgI0pumZBYjrpY901pYSXDM/NXoUVIRJ3s72mAz4jq7p9rghrDEGeM839Mw3KbwVV5IZk7oiRAH09ZxnEZPpXX4vGEyhZ6yGLIKhPJ+EzoGrnj+FFPnjRFzMRM9vEoChDg1sxWUhK5G/eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775057803; c=relaxed/simple;
	bh=PTpIDiuMPckb/qTjHtZuhCCl/yBCkYRz5MJcU6WOEPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNUrYgaTIStNN8rBljQ6CVj8LojEgRH3OyvzF1QK58SMNOIo/W1JDcgqTr/C3e1ejD3eRMDgQz8sQkmTK81xQDR6ktNENgAVpfvjOQCbN4bpfrqc+8QBx9A1AwG4MHQ/O9uVTq+2AfmNph96eY/doNJ8S5Fubq/86NJNlVqxXog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FC/1uoUC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FC/1uoUC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775057801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4OfMia3xaTgNoxE8+1FTJOxUdQ0kWfmgzmuNXkkoCk4=;
	b=FC/1uoUCIiTTSPJ8L7JwrOFkFHKYlasII+0kWJWzKkvBeCPgpZ/D6WyKIYkgNqLOpXXNUw
	ZZRodL17iGL6HfSO+tsetMu1K3OqCZfjmTFQrYFF5gZ9ikZxDLfKZZb61m8uRCH4KdK9qD
	ctHmMwuZnACWoYwTHnXcnfSjqSbEeGc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-hw19WzZBPiSkvnHeDzgxzA-1; Wed,
 01 Apr 2026 11:36:38 -0400
X-MC-Unique: hw19WzZBPiSkvnHeDzgxzA-1
X-Mimecast-MFC-AGG-ID: hw19WzZBPiSkvnHeDzgxzA_1775057797
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E4BE195609E;
	Wed,  1 Apr 2026 15:36:36 +0000 (UTC)
Received: from fedora (unknown [10.72.116.89])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD1B81954102;
	Wed,  1 Apr 2026 15:36:33 +0000 (UTC)
Date: Wed, 1 Apr 2026 23:36:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH V2] ublk: use unchecked copy helpers for bio page data
Message-ID: <ac07fNyWOrX5PcUa@fedora>
References: <20260401012401.3653194-1-ming.lei@redhat.com>
 <f10b5a3d-33f9-486c-b8e9-6d9286448f69@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f10b5a3d-33f9-486c-b8e9-6d9286448f69@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Apr 01, 2026 at 09:19:23AM -0600, Jens Axboe wrote:
> On 3/31/26 7:24 PM, Ming Lei wrote:
> > Bio pages may originate from slab caches that lack a usercopy region
> > (e.g. jbd2 frozen metadata buffers allocated via jbd2_alloc()).
> > When CONFIG_HARDENED_USERCOPY is enabled, copy_to_iter() calls
> > check_copy_size() which rejects these slab pages, triggering a
> > kernel BUG in usercopy_abort().
> > 
> > This is a false positive: the data is ordinary block I/O content ?
> > the same data the loop/nbd driver writes to its backing file via
> > vfs_iter_write().  The bvec length is always trusted, so the size
> > check in check_copy_size() is not needed either.
> > 
> > Switch to _copy_to_iter()/_copy_from_iter() which skip the
> > check_copy_size() wrapper while the underlying copy_to_user()
> > remains unchanged.
> > 
> > Fixes: 2299ceec364e ("ublk: use copy_{to,from}_iter() for user copy")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> > V2:
> > 	- update commit log (Caleb Sander Mateos)
> > 
> >  drivers/block/ublk_drv.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 2e475bdc54dd..3e329906ae19 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1322,10 +1322,18 @@ static bool ublk_copy_user_bvec(const struct bio_vec *bv, unsigned *offset,
> >  
> >  	len = bv->bv_len - *offset;
> >  	bv_buf = kmap_local_page(bv->bv_page) + bv->bv_offset + *offset;
> > +	/*
> > +	 * Bio pages may originate from slab caches without a usercopy region
> > +	 * (e.g. jbd2 frozen metadata buffers).  This is the same data that
> > +	 * the loop driver writes to its backing file ? no exposure risk.
> > +	 * The bvec length is always trusted, so the size check in
> > +	 * check_copy_size() is not needed either.  Use the unchecked
> > +	 * helpers to avoid false positives on slab pages.
> > +	 */
> >  	if (dir == ITER_DEST)
> > -		copied = copy_to_iter(bv_buf, len, uiter);
> > +		copied = _copy_to_iter(bv_buf, len, uiter);
> >  	else
> > -		copied = copy_from_iter(bv_buf, len, uiter);
> > +		copied = _copy_from_iter(bv_buf, len, uiter);
> >  
> >  	kunmap_local(bv_buf);
> 
> Is this just a jbd2 issue? Because we can just get the slab marked
> appropriately to not trigger these warnings.

If the ublk block device is permitted to mount FS, it is inevitable to expose
the meta to ublk userspace daemon, same with loop, or other block device.

Any bio pages backed by slab without a usercopy need to bypass the size check,
which isn't necessary too.


thanks,
Ming

