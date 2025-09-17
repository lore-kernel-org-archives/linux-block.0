Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BA22FA0F5
	for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 03:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758080691; cv=none; b=VCHawDuNT5Z2gcJRJfp2FlZOTydqgLGxH16SiAJVZcNR4feKnXjv9B+To50IJQ63yduj9rGvgWusGgZ36+NJfBPIBFJ7ZydM2dXUG4afKQ1jgYwuNI9gtiykDSjGIly2zJLPKhpCYvnL8l0XyU12aasuKrYjtCu3BoOMfYhn3no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758080691; c=relaxed/simple;
	bh=brs4ynh2EX1zKJbEsmqAWlwx+gwWTI2hrhr0+Q8A/nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UP3BqGMXw5uWIr9Rb1KlT2ksHxRabsnFl4jvAlRaipPQhCeQUtwOlyktGm49GbiIkp1MjMqoYVwaCEgsJSUfmXGomn0O6Czd3teBvkxAC2h02ZFcbMOHQHfeoJn08W5PWomnbj+Y2ilJuLXAG5jAfaUdLSn7+VbEh/DE5R+lxgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GpLqY2H1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpLqY2H1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758080687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TeScVp6EM/w+oXwDgks3VBbqhhAtTEMi8rcdR7CeoBY=;
	b=GpLqY2H1wX4NmynlGZDlI1m1TVb5vT8uXSg5KD2qGIZ7xIrVxt9/N3S7Y/kzN978ZoJ7jo
	47MDam8Gr3pSvoPK3GQYFhOmJoQBjV9UG2XowTzVhjdYAU3xMPzA/rCqw5lVNN1wNgSJLZ
	2qrZ/oRiIzWYB8ZTi10WgjrctBzxRw4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-UB6GcXWcMheu3Wcm_8q9Rw-1; Tue,
 16 Sep 2025 23:44:41 -0400
X-MC-Unique: UB6GcXWcMheu3Wcm_8q9Rw-1
X-Mimecast-MFC-AGG-ID: UB6GcXWcMheu3Wcm_8q9Rw_1758080679
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33DD71800451;
	Wed, 17 Sep 2025 03:44:39 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB0A119560B8;
	Wed, 17 Sep 2025 03:44:33 +0000 (UTC)
Date: Wed, 17 Sep 2025 11:44:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH] blk-mq: Fix the blk_mq_tagset_busy_iter() documentation
Message-ID: <aMoumx_xoGyRXuMu@fedora>
References: <20250916204044.4095532-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916204044.4095532-1-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Sep 16, 2025 at 01:40:43PM -0700, Bart Van Assche wrote:
> Commit 2dd6532e9591 ("blk-mq: Drop 'reserved' arg of busy_tag_iter_fn")
> removed the 'reserved' argument from tag iteration callback functions.
> Bring the blk_mq_tagset_busy_iter() documentation in sync with that
> change.
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>
 

Thanks,
Ming

