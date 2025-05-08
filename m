Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742E121CFFD
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692202; cv=none; b=WF1uaYAqeNyPvd5Yl1MUEg8Y+BBf+wvlazkmUW5KLg5tSpmXc3IHGyr664/T+wZAOnA0zNU3UTENQHv39wfMjNl2iEyws1+/6SUgJrRFMQAhHggNt4oOkRNmmc4bd44eerKoljTG2zspVSczR0T1ub1gFUAIibZytAJ5Gr9+6+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692202; c=relaxed/simple;
	bh=5oWG0q7RqnvnrtO1DK3f3+pSXhArVMSWHky53yyZZ+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHxQu5ThwBt8BcCZy+/XlMPRtR04faJuIIirJnrjGsIk/o57Z2K3Ul4tM67H0qXKKvKaDzEWi3tK3fn2kTvCxxifkqQfP16Zhlw/PPviLj6F+x39Uxq1XWXYipIyd7a9CVqXjmWtvGfaGCPYUO/4ya+k0w3XKozIhMlv5BiOYwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSy/frT+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSy/frT+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746692199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EqSUzM3RTqytvNWXRqBaFZxzqwt9uk/pjnXeGJg051o=;
	b=QSy/frT+cXzyeXRQtnsYcynAOsoMdoZi8e5KDDpcofZYNGocZJsWR9PNRyHJtT9g3mdGeR
	2JNvl+mtGMg6y7Bc9NNY7G9tPIi6sZ7FZSRyYLhaiNEY7se90zjpd5LvQlnhJK2QHN613m
	lFJuGxAlmfU9J45Ef8Z59SdAck6r5ZM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-VH1FO2ZHOV2EIJ70uC7LiQ-1; Thu,
 08 May 2025 04:16:36 -0400
X-MC-Unique: VH1FO2ZHOV2EIJ70uC7LiQ-1
X-Mimecast-MFC-AGG-ID: VH1FO2ZHOV2EIJ70uC7LiQ_1746692195
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6D261955D4D;
	Thu,  8 May 2025 08:16:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.149])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F41FA19560A7;
	Thu,  8 May 2025 08:16:30 +0000 (UTC)
Date: Thu, 8 May 2025 16:16:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 2/2] block: avoid unnecessary queue freeze in
 elevator_set_none()
Message-ID: <aBxoWUETFToLLzCN@fedora>
References: <20250507120406.3028670-1-ming.lei@redhat.com>
 <20250507120406.3028670-3-ming.lei@redhat.com>
 <20250507135450.GB1019@lst.de>
 <aBwrlQuvlBVPGb5Y@fedora>
 <20250508050448.GB27049@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508050448.GB27049@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, May 08, 2025 at 07:04:48AM +0200, Christoph Hellwig wrote:
> On Thu, May 08, 2025 at 11:57:09AM +0800, Ming Lei wrote:
> > Not sure if I get your point, do you want to avoid freeze queue for the case
> > of disk owning the queue? I think it can't be done, because someone may
> > still open the bdev and submit IO to it even though del_gendisk() is
> > in-progress.
> 
> Isn't the disk marked dead at this point and there should be no
> pending I/O submissions?

Yeah, just inflight IOs aren't drained.

This patch isn't necessary, the only effect is that blk_mq_freeze_queue_wait
is done a bit earlier.


Thanks, 
Ming

