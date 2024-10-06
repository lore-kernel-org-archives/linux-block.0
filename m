Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693C618E2A
	for <linux-block@vger.kernel.org>; Sun,  6 Oct 2024 02:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728183331; cv=none; b=koA5mQXNiw83HVZpLtTByNj9tWTysIj/fpWguRQyil+CPGg4WItGNEyFxrWwGBpuweZ+5mDyhwhgPV565jIKJcFerDZsSmmL3OCf5Ub3Ip4699H49gWpDcWTFkfsiyXQ38FCio3H2fg7B2yrIERKXgpQYD6n+E3SyDfxtC7Zcp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728183331; c=relaxed/simple;
	bh=XoqFHZoD8LRyFFEFoy2YX3wiPCjH12B5geCY53ZUBwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKSgMybHzDM9VHWhvo90Czobmtb3vMr1YCD8aVrbwDy90eWv33GzMsVwCcmYG/6pgwrP04q9lanrWoY0H6oeA2B97k47ZeNAHNpf7v4h7ai8LZJrMd4iyn/moND6V380zHHYpXH/UZehXPIkxZOKJ6s2425ZGQneWXVY2N0M5iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtYvgcHd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtYvgcHd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728183327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G6iRkIjBzgaoc8hnTNYoN69g64sbyelNUkm4jm5FOYc=;
	b=TtYvgcHdPT2ws9jd1fhL+dCUH98LLnNccu8IhukHufHaq8TgwUAn0gX+EJlS0VJzsHTmcI
	DwbmQzNjTZH38oN8dRMQbHFFJ1j/0hbAkS14lF0sAxlT0T/Db7/YqotU0xfl4kgYp5Gp2F
	/TX7cxPdJeCaZiFclPZYrWb6hhFxnQc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-CJH37iC7M3igG37hagfVkw-1; Sat,
 05 Oct 2024 22:55:24 -0400
X-MC-Unique: CJH37iC7M3igG37hagfVkw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00DF51956096;
	Sun,  6 Oct 2024 02:55:22 +0000 (UTC)
Received: from fedora (unknown [10.72.116.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0546519560A2;
	Sun,  6 Oct 2024 02:55:16 +0000 (UTC)
Date: Sun, 6 Oct 2024 10:55:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH] lib/iov_iter.c: extract virt-contiguous pages in
 iov_iter_extract_bvec_pages
Message-ID: <ZwH8D-Hx4G7XvOUC@fedora>
References: <20241004153025.1867858-1-ming.lei@redhat.com>
 <3855842.1728061012@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3855842.1728061012@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Oct 04, 2024 at 05:56:52PM +0100, David Howells wrote:
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > All iov_iter_bvec() users only want to extract virt-contiguous pages from
> > iov_iter_extract_pages() instead physical-contiguous pages.
> 
> What do you mean by "virt-contiguous"?  Virtual according to what mapping?

The term is from comment iov_iter_extract_kvec_pages(), seems it is
invented by you, :-)

Actually iov_iter_extract_pages() requires that there isn't gap in the
extracted pages, so 'offset' only exists in the 1st page, then these
pages can be mapped to one virtual(contiguous) address.

> 
> The reason for physical contiguity is that you can pass a set of physical
> contiguous pages as a single DMA descriptor.  Therefore, at some point, you
> might end up screwing up skb_splice_from_iter().  Currently, that's limited to
> a PAGE_SIZE per fragment, but hopefully that will be fixed at some point.

If any user wants to extract physical pages, new interface can be added for
returning single page instead of page array, cause it is physically contiguous.

Other kind of iterators(UBUF, KVEC, ...) do return non physically-contiguous
pages.

The point is that one bvec often point to one page except for huge page
case, so iov_iter_extract_pages() just returns single page each time
no matter how big maxpages & maxsize is passed in.

It is actually one regression:

Fixes: a7e689dd1c06 ("block: Convert bio_iov_iter_get_pages to use iov_iter_extract_pages")


Thanks,
Ming

