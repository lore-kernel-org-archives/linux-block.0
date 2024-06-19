Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F371E7D07E
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786288; cv=none; b=gA9julnyTl3u65WjbEwBsMHLpB+xHpXtx6sBKIA5ZCpBje0evCcPUjyOVJ8YLU5pWm5SP3nfhxL2Igg5DQQMeuM8dEx6tIvPZXwti64RZC5v5laoEkAHb3wrms05oEzLozsq2Nb1wZqr9VAW3ktAR+e13pXi2nRnpuTEhgEvBU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786288; c=relaxed/simple;
	bh=8A1GSejSzZgNfH4aAX727brt37Mf/P2Xp5QorPylxo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbiLzdbZI9Us4l6W+Gr7hmxJM3QaPzgDwkdSMnTa55cqtGXmi71g1nyWMiOiO886jZ66R4ChAmB/NIyd0VHWyMcZvRWqSSVxW9Loio0GnJ/2qAKVrCs1Mw5gxhFyeT/nMgNjkdt9UhuCzNscrdAh06XenE/fi/9GqY0UMf1Zeh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EkYK93pb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkYK93pb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718786285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLIGT/uP62Mpt9qJ3fiGqtanOAACNN10aNLeckXvD54=;
	b=EkYK93pb7wk2ZXQhsHUIyafeVR9Elt5Kp4OywOsypAnRTIgFlOAQLeUoYDs0cQd9kVANza
	MRmk0TYy2pAj543UFNcrabLNmqX6QVpFJfbFEyV8GouIXni7qTjztYN8xCcBKxCXNlctxZ
	srheI0jELK+iEHDPRQgV8PuoRtt1byI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-RvS4I-4MPuCc3TRvksAepg-1; Wed,
 19 Jun 2024 04:38:02 -0400
X-MC-Unique: RvS4I-4MPuCc3TRvksAepg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D628319560BE;
	Wed, 19 Jun 2024 08:38:00 +0000 (UTC)
Received: from fedora (unknown [10.72.112.148])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76E821956087;
	Wed, 19 Jun 2024 08:37:54 +0000 (UTC)
Date: Wed, 19 Jun 2024 16:37:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
	Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] block: check bio alignment in blk_mq_submit_bio
Message-ID: <ZnKY3sVTaCGv1BKo@fedora>
References: <20240619033443.3017568-1-ming.lei@redhat.com>
 <7ed12f7e-f59a-4f6f-975b-ce7bb21652de@kernel.org>
 <ZnKPO0qUfuHPOdEi@fedora>
 <ZnKRZp6pR1xasStB@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKRZp6pR1xasStB@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Jun 19, 2024 at 01:05:58AM -0700, Christoph Hellwig wrote:
> On Wed, Jun 19, 2024 at 03:56:43PM +0800, Ming Lei wrote:
> > If we add the check for all type of IO, it requires ->bi_sector to
> > be meaningful for zero size bio. I am not sure if it is always true,
> > such as RESET_ALL.
> 
> meaningful or initialized to zero.  Given that bio_init initializes it
> to zero we should generally be fine (and are for BIO_OP_ZONE_RESET_ALL
> for all callers in tree).

Fine, let's fail this kind potential not-well-initialized bio, which is
brittle anyway.


Thanks,
Ming

