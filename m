Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E9F2E630
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 01:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734400386; cv=none; b=kb89XLx5N8hymXd6/7rVEstFOjh0Mq17n6FClNt8akaGHoC28d5dPz/Yd4cvpsWB/S8Dd/m4o6sbtX+nztC6eXWvuIROX68mG5T55O3RE46HRPArKaSo9IxrJGu92zJzhgRRR2Q1WjOOu9Q6x79r90BInJH5Kele8ZYYJGnluU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734400386; c=relaxed/simple;
	bh=xPmun7YTHKfv9ewruF+nYeJYBinF+YsFNDj/FBfrumQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3cehrlnp+JfY/+UOaMYIfWRg6UdOdOJn7XfxiSQ5nHgxzTJQYoNu17ou5H3P5dVtMSyswClUDSRSvjJR3M+J4LmFPRAnlW0xZmJ7fFFVhDuqQ+Mh+pzXZeEzC6g20flkORqO29ssXt0f8ht5uu/IA/Sb3EeOK8xm0v94dtbpjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cbzDg7vk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbzDg7vk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734400383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=++eaEvzxr3ipE6QxWl+JZJNd3bnUMqSdjyDxyVciy/Q=;
	b=cbzDg7vk+02t5tbLCmnyHkAvqh7IUyNo5qx7LdI5TLVkk6L4iOgKWEuBIrL1Ps6P2dK0HP
	ldZQf1iszZKjsj5TwrAK5JnTxb2pkiDpsxJWlV7J1c3AWgKdlalf5+98NYIGdrF1+xGg/e
	kXgD7zsADPHPIahZa+H5Y8WLcml4M4k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-sQ7dT6M_MqOeZLqvYoMCzA-1; Mon,
 16 Dec 2024 20:53:01 -0500
X-MC-Unique: sQ7dT6M_MqOeZLqvYoMCzA-1
X-Mimecast-MFC-AGG-ID: sQ7dT6M_MqOeZLqvYoMCzA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B3AF1956056;
	Tue, 17 Dec 2024 01:53:00 +0000 (UTC)
Received: from fedora (unknown [10.72.116.120])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0421D30044C1;
	Tue, 17 Dec 2024 01:52:56 +0000 (UTC)
Date: Tue, 17 Dec 2024 09:52:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: avoid to hold q->limits_lock across APIs for
 atomic update queue limits
Message-ID: <Z2DZc1cVzonHfMIe@fedora>
References: <20241216080206.2850773-1-ming.lei@redhat.com>
 <20241216080206.2850773-2-ming.lei@redhat.com>
 <20241216154901.GA23786@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216154901.GA23786@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Dec 16, 2024 at 04:49:01PM +0100, Christoph Hellwig wrote:
> On Mon, Dec 16, 2024 at 04:02:03PM +0800, Ming Lei wrote:
> > More importantly, queue_limits_start_update() returns one local copy of
> > q->limits, then the API user overwrites the local copy, and commit the
> > copy by queue_limits_commit_update() finally.
> > 
> > So holding q->limits_lock protects nothing for the local copy, and not see
> > any real help by preventing new update & commit from happening, cause
> > what matters is that we do validation & commit atomically.
> 
> It protects against someone else changing the copy in the queue while
> the current thread is updating the local copy, and thus incoherent
> updates.  So no, we can't just remove it.

The local copy can be updated in any way with any data, so does another
concurrent update on q->limits really matter?


thanks,
Ming

