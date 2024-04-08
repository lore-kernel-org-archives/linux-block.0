Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AB52C698
	for <linux-block@vger.kernel.org>; Mon,  8 Apr 2024 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561846; cv=none; b=mNFoy/Lt77W/ErFK15kwdO+vatyojXqefghSyfdS0FgHYEglqeJoQpR9AB7Akwl3EoW9hW50+zEMK0nUlsdzQyqh2Q1rZKtlLgBOhj7BF2tqM0UHFEKBnB4cQY3PD+nd9Axcs3c9BYK7qAZkRD9c3TwtuT32IhJ3bwSGtZsdyuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561846; c=relaxed/simple;
	bh=ecyeBXGK82/eFN9LslE+mSPLS31lizAFpzbcT4NKcw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftR0FsSw0fHAyF4BfYwHdVLFVMcIdDx8sxqZjIoZb06tpoC073VY6Gx2B1AWTAIw/DTOwBlgMExqiBTqAMh2+EhHxXYJH/HToDj8UC7i6T/ExTL5GxZq1dCboSUD3DP8fWlnVK+wnzf5GyhfA0Hconvgye14/Wzr7m8NZ6K5Qh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PSQzIBGj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSQzIBGj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712561844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zok5UA7oux0fNoVZjmVOaCMEVoiNpsfOVeWw9Y7sbQA=;
	b=PSQzIBGjeRFYGyevC9L7rFC/wZrk9rVdzdsypXuw2KRYO4MgNe+HPjdJ8UTvpvkERJOYOa
	1Fvj9QmePNbkzVEyj9sZ5lBS1/NrVOj7+e9Nq9+KS7ccc/cLmaC21Wj4gyg5RrW3dERvoL
	kq2A3yUBTurvMUUUysgcANbpMoy/uFE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-ov6hsXmzPh6vXoJsDFph-A-1; Mon, 08 Apr 2024 03:37:19 -0400
X-MC-Unique: ov6hsXmzPh6vXoJsDFph-A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5795F800219;
	Mon,  8 Apr 2024 07:37:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4508A47E;
	Mon,  8 Apr 2024 07:37:13 +0000 (UTC)
Date: Mon, 8 Apr 2024 15:36:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	janpieter.sollie@edpnet.be, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@lists.linux.dev, Song Liu <song@kernel.org>,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH] block: allow device to have both virt_boundary_mask and
 max segment size
Message-ID: <ZhOekuZdwlwNSiZV@fedora>
References: <20240407131931.4055231-1-ming.lei@redhat.com>
 <20240408055542.GA15653@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408055542.GA15653@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Mon, Apr 08, 2024 at 07:55:42AM +0200, Christoph Hellwig wrote:
> On Sun, Apr 07, 2024 at 09:19:31PM +0800, Ming Lei wrote:
> > When one stacking device is over one device with virt_boundary_mask and
> > another one with max segment size, the stacking device have both limits
> > set. This way is allowed before d690cb8ae14b ("block: add an API to
> > atomically update queue limits").
> > 
> > Relax the limit so that we won't break such kind of stacking setting.
> 
> No, this is broken as discussed before.  With a virt_boundary_mask
> we create a segment for every page (that is device page, which usually
> but not always is the same as the Linux page size).  If we now also
> limit the segment size, we fail to produce valid I/O.

It isn't now we put the limit, and this way has been done for stacking device
since beginning, it is actually added by commit d690cb8ae14b in v6.9-rc1.

If max segment size isn't aligned with virt_boundary_mask, bio_split_rw()
will split the bio with max segment size, this way still works, just not
efficiently. And in reality, the two are often aligned.

> 
> The problem is that that neither the segment_size nor the
> virtual_boundary should be inherited by a stackable device and we
> need to fix that.

It is one big change with regression risk, which may not be good after -rc3.



Thanks,
Ming

