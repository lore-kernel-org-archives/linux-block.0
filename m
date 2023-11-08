Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE467D505
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mj/oboZF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAEA170A
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 23:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699430338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VTPOAHI4VrFDKyek3fkCUZ/+KVhb9MAjFPumhsrLqU4=;
	b=Mj/oboZFUoCQNraTvnygCyRZXwQdkwJm7ScAYSMN9S3jg23+aB/+fpR1WLojWBTGk3A1M2
	EffsCHl16miu4qtUhnKpqS4XMUwVFHutFu9uitQ8DmO20hUwDXW+hpj/H63d+qi4vN56mt
	u3QbBR2GWx+NA6mErGHX0XSgUgfnGKQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-whr2-yMHNP-cWCckD2CCAw-1; Wed, 08 Nov 2023 02:58:55 -0500
X-MC-Unique: whr2-yMHNP-cWCckD2CCAw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF608101A529;
	Wed,  8 Nov 2023 07:58:54 +0000 (UTC)
Received: from fedora (unknown [10.72.120.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 26DD11121306;
	Wed,  8 Nov 2023 07:58:50 +0000 (UTC)
Date: Wed, 8 Nov 2023 15:58:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Ed Tsai <ed.tsai@mediatek.com>, ming.lei@redhat.com
Subject: Re: [PATCH] block: try to make aligned bio in case of big chunk IO
Message-ID: <ZUs/tsrNEZiHcCco@fedora>
References: <20231107100140.2084870-1-ming.lei@redhat.com>
 <ZUs4njXE7xpg04Yi@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUs4njXE7xpg04Yi@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Tue, Nov 07, 2023 at 11:28:30PM -0800, Christoph Hellwig wrote:
> On Tue, Nov 07, 2023 at 06:01:40PM +0800, Ming Lei wrote:
> > In case of big chunk sequential IO, bio's size is often not aligned with
> > this queue's max request size because of multipage bvec, then small sized
> > bio can be made by bio split, so try to align bio with max io size if
> > it isn't the last one.
> 
> I have a hard time parsing this long sentence.

It covers the reasons(multipage bvec, bio split, big sequential IO) and solution(
align bio), or any suggestion to simplify it further?

> 
> > +	/*
> > +	 * If we still have data and bio is full, this bio size may not be
> > +	 * aligned with max io size, small bio can be caused by split, try
> > +	 * to avoid this situation by aligning bio with max io size.
> > +	 *
> > +	 * Big chunk of sequential IO workload can benefit from this way.
> > +	 */
> > +	if (!ret && iov_iter_count(iter) && bio->bi_bdev &&
> > +			bio_op(bio) != REQ_OP_ZONE_APPEND) {
> > +		unsigned trim = bio_align_with_io_size(bio);
> 
> Besides the fact that bi_bdev should always be set, this really does
> thing backwards.

Looks it is true after your patch passes bdev to bio_alloc*(), but
bio_add_page() is just fine without bio->bi_bdev.

Also this way follows the check for aligning with block size.

But seems safe to remove the check.

> Instead of rewding things which is really
> expensive don't add it in the first place.

The rewind may not be avoided because iov_iter_extract_pages() can often
return less pages than requested. Also rewind is only done after the bio
becomes full(at least 1MB bytes are added) and there is still data left,
so it shouldn't be too expensive.

I will provide 'size' hint to iov_iter_extract_pages() to try to make
it aligned from the beginning in next version, but rewind may not be
avoided.


Thanks,
Ming

