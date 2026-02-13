Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C2627456
	for <linux-block@vger.kernel.org>; Fri, 13 Feb 2026 04:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770957864; cv=none; b=OHs5QumYDmiUzJq2unjzd447zyM6HxfHz0GKs7bnUdGbg3F82m+G79if+jaw0WQ9BK2c795SCQLJRgdvGuOX6zHu1bJ3qB9yyERSx9vgQO61qL79uIoifkiV14b6M2yLsxkPjedcc5EnHOtRW6sJ4FbFBxfjRcmbDRyuI35F0eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770957864; c=relaxed/simple;
	bh=XRtF0h5DT1NCBrYb1bkU5MRmyDnjb63fIpwUrC6Pf0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmJX21Ch14itM2Yz542GIGwBS7XufJgz695yEuSaoBxQkjREogVWkM1DceOWn06kJdSnrkc3cb6nhVCYRZTiNylpg5ur7+lEiSTY8so4PVtCpmzy3EVteWJV5PzGEUD1dJVeQxoJZS0gEnwr98RMnbxef2125aFkdBoQJ5RgBE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kxym6T0A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kxym6T0A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770957862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=guGtY1JCXFXTjV1h91oQJKpMb6fkAzkGxE/Lmcv0SFQ=;
	b=Kxym6T0AQb/yxZbU1BeXf2p74MhZnsaY+wCOLqTe1y24eUenjcuBeInJD7widcutk/JeJ5
	fXraAmq4c5mr4JQ8UgAkmBMDZVrMU796rY7EJf9H2AznX7b/25+9CE6d7lDggVBxJOH7hF
	RnS5w9xkInl7dMsEKhmfW8x/0MlW+TA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-RPHmPoipPfONhgWznoVn8A-1; Thu,
 12 Feb 2026 23:44:16 -0500
X-MC-Unique: RPHmPoipPfONhgWznoVn8A-1
X-Mimecast-MFC-AGG-ID: RPHmPoipPfONhgWznoVn8A_1770957854
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 344A61955D4D;
	Fri, 13 Feb 2026 04:44:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.140])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E333E18003F5;
	Fri, 13 Feb 2026 04:44:03 +0000 (UTC)
Date: Fri, 13 Feb 2026 12:43:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: Jens Axboe <axboe@kernel.dk>, nilay@linux.ibm.com, hch@lst.de,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: use NOIO context to prevent deadlock during
 debugfs creation
Message-ID: <aY6sDstii_R_zOfs@fedora>
References: <20260212080135.1673063-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212080135.1673063-1-yukuai@fnnas.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Feb 12, 2026 at 04:01:35PM +0800, Yu Kuai wrote:
> Creating debugfs entries can trigger fs reclaim, which can enter back
> into the block layer request_queue. This can cause deadlock if the
> queue is frozen.
> 
> Previously, a WARN_ON_ONCE check was used in debugfs_create_files()
> to detect this condition, but it was racy since the queue can be frozen
> from another context at any time.

debugfs lock doesn't depend on queue freeze, so the implied deadlock isn't
obvious.

Can you explain a bit why freeze from another context may cause dead lock?


Thanks, 
Ming

