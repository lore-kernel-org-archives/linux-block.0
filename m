Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260CA15DBC1
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171223; cv=none; b=swipCvdp86+oPcugsgF8kj9MVhHSBkVNzh0Ep6fOcSSixASXiOjbMAl/iaSfhQyQp6goY/KMsqlX+BTn9lCDiJguuR6sx6+pJsT5hVweP0ZECaSLywCZMqQjYgHcT/MRSPoVsU9CESTTxpmrnBUWTj3Bvgp/SOvrmU8RqQPxsVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171223; c=relaxed/simple;
	bh=4K3FNYLtfeLbi8JMODhuhAWPR27ybOQj1Dx3KRxraGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xiv4CXSpKhOmJTss/FpI36zAFh6oOUZCQ8MbPmSdu6s0YZ7KDv5L9cMvddpgr7zXgItI0fOz3yMud/84jK1dgxbDRyaZDD/3H/scwFBenWVKQVqK91cmpufobHWtnIu7Qr4i00aHOPFFX0ZcLCC6MwFjedxR/yg54jiUMrXMXTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NgZuFwJZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NgZuFwJZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755171220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NibyQwq38EV7vpBLk3lcghaC92HWoT6w05RtscB8wKU=;
	b=NgZuFwJZMQiEgpUEArUNxY0Qh2XTcEOP3oRlH5Mv4aNdEjeFFKwDd6EZa3PPy24by8nIMJ
	0KHPf0AOR9PTXisiEksUKDHaQfEjNG+s7va80pL9ikANcQuGc3PgMXdr4MM+9Qzr5H3BJj
	F1oOwBgcU6B9ExvmfCXwhKCrV7rLPU4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-wlfnI0NkMiu8Xf7fyE6FBg-1; Thu,
 14 Aug 2025 07:33:35 -0400
X-MC-Unique: wlfnI0NkMiu8Xf7fyE6FBg-1
X-Mimecast-MFC-AGG-ID: wlfnI0NkMiu8Xf7fyE6FBg_1755171214
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C021B195608D;
	Thu, 14 Aug 2025 11:33:33 +0000 (UTC)
Received: from fedora (unknown [10.72.116.148])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 977DB300019F;
	Thu, 14 Aug 2025 11:33:27 +0000 (UTC)
Date: Thu, 14 Aug 2025 19:33:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, yukuai1@huaweicloud.com,
	hch@lst.de, shinichiro.kawasaki@wdc.com, kch@nvidia.com,
	gjoyce@ibm.com
Subject: Re: [PATCHv3 2/3] block: decrement block_rq_qos static key in
 rq_qos_del()
Message-ID: <aJ3JfYZgihDTvWXq@fedora>
References: <20250814082612.500845-1-nilay@linux.ibm.com>
 <20250814082612.500845-3-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814082612.500845-3-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Aug 14, 2025 at 01:54:58PM +0530, Nilay Shroff wrote:
> rq_qos_add() increments the block_rq_qos static key when a QoS
> policy is attached. When a QoS policy is removed via rq_qos_del(),
> we must symmetrically decrement the static key. If this removal drops
> the last QoS policy from the queue (q->rq_qos becomes NULL), the
> static branch can be disabled and the jump label patched to a NOP,
> avoiding overhead on the hot path.
> 
> This change ensures rq_qos_add()/rq_qos_del() keep the
> block_rq_qos static key balanced and prevents leaving the branch
> permanently enabled after the last policy is removed.
> 
> Fixes: 033b667a823e ("block: blk-rq-qos: guard rq-qos helpers by static key")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

