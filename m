Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B3C334C1D
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536503; cv=none; b=OYkTE0l5duUG/3rdOgQMPZWFgtGidGVRdzXbaaLN0yIDJq2EWufaPw/S1fKJbc4dqMeLXgpxlHMe+K0mxfC5gC0L4er7LrKMy8f59/Ad2kYQxBARU980M/7hEINDEvD0D7bXdMAEYVfsxZ/VYvYEfnLTeHTqkXU47tatvMqG46U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536503; c=relaxed/simple;
	bh=lZTd1lV0NR42pa7D0BuGtOTV1Q0P8I0AMHgpPvn1128=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1xIo8JlzvqBS3RvULBiXC96Brtz8iUF2AsSjJEVKua/4BBepUbh4+j6DDFBpmaU2DdZS2pIS7rUzFRVSfZ0y+AO2I38tj0A91jPSmWZAmOkdnFsS5qjwIQ1W8fj/lonlzEUjRuUdhCsFPXMEhqmQ1FvFU9S8T9qk6JbbyA/zlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hqx6/4Mb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hqx6/4Mb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774536499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=evL0/OmosrUhnFvxU7W1kQQCuTZic4jAqtDDtfuE3+A=;
	b=Hqx6/4MbM9PlBQOUl9bmWvTLUGOHmCDV9FT/SgDc+uYusxlAe/iVq2Cz+IYhp4EA2H52Jh
	pAhh1hFqhGgzl7ABlOPKurJdYPk0j1euHERaq9LsKRVX575/zx7B9LCLp/v8ucmHOsl2CR
	iW0Ifnocm9PLaA4dMjpYzVAMqjxZxIk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-rncOT4gBM2uhb97k_EwmLg-1; Thu,
 26 Mar 2026 10:48:15 -0400
X-MC-Unique: rncOT4gBM2uhb97k_EwmLg-1
X-Mimecast-MFC-AGG-ID: rncOT4gBM2uhb97k_EwmLg_1774536494
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCED4180034F;
	Thu, 26 Mar 2026 14:48:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.100])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D49A3000223;
	Thu, 26 Mar 2026 14:48:08 +0000 (UTC)
Date: Thu, 26 Mar 2026 22:48:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2 1/5] block: Fix a source code comment
Message-ID: <acVHJMOHRRdsO1OJ@fedora>
References: <20260325213719.2850619-1-bvanassche@acm.org>
 <20260325213719.2850619-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325213719.2850619-2-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Mar 25, 2026 at 02:37:11PM -0700, Bart Van Assche wrote:
> Fix a source code comment that is no longer correct since commit
> 889c57066cee ("block: make segment size limit workable for > 4K
> PAGE_SIZE").
> 
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

