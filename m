Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95291DCB24
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162147; cv=none; b=eqZeK+Xy0Sr+M6GduuBjoY4o72a0F1XCz0tEZ9/XL7F2VMES9M2A7Yi9Bcz6xIbiSUJxFrvnJipDxLJboA6O51dWsIJr6ZJZ2ul5DC2nON8h9lW5V55CGBRhyblLBmOWmbaq77uJ63Nu9hwvYRLlE1yAJx4rHeF9YciG99B8RIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162147; c=relaxed/simple;
	bh=DfkaNj1QKL6aDuZlMAfZaQ54C6BtUuR9FHoah5Vg2Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bi0ZpOsfXBJ578ZQ6fIRC0Xtfsa3oiGOZ7zwfix5dkU5gs0QRuAiy0cnCV+XjtcE2TSPU7qfo2nv+UtKx9l+uFQC1Ks+SkXrBjFbwR9pLqIJRyL4HMY6GqkhQOnVsLW4b1h8bguxRbkAi2++Pade4vuiea+RIUFDHXIySWCerAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hmCfTfM2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmCfTfM2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736162142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lEgqGUmmdHlI+KexeqkKfc5uGqdJkewykFHtwS7IbqQ=;
	b=hmCfTfM2mhKhyKHJ8Wpqj1W1CRs+Iy23HwopJ4JiDScehB/hilmi2qQ9/HThtyYEybchsG
	Ym1HmAzUrl63+hUScK/2ToLJX7D6vH3d7Uzr5csihPKV+AAjHept09NLTGWVdWAIzWLfWz
	3e1esbW5452Y47Avla49nB7VLP8rE74=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-ramjuIovO8u7SQJZqBradQ-1; Mon,
 06 Jan 2025 06:15:39 -0500
X-MC-Unique: ramjuIovO8u7SQJZqBradQ-1
X-Mimecast-MFC-AGG-ID: ramjuIovO8u7SQJZqBradQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D39319560A2;
	Mon,  6 Jan 2025 11:15:38 +0000 (UTC)
Received: from fedora (unknown [10.72.116.180])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B979D195608A;
	Mon,  6 Jan 2025 11:15:32 +0000 (UTC)
Date: Mon, 6 Jan 2025 19:15:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 1/3] block: Fix sysfs queue freeze and limits lock order
Message-ID: <Z3u7Twc4UPWvlfJJ@fedora>
References: <20250104132522.247376-1-dlemoal@kernel.org>
 <20250104132522.247376-2-dlemoal@kernel.org>
 <Z3tOn4C5i096owJc@fedora>
 <20250106082902.GC18408@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106082902.GC18408@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, Jan 06, 2025 at 09:29:02AM +0100, Christoph Hellwig wrote:
> On Mon, Jan 06, 2025 at 11:31:43AM +0800, Ming Lei wrote:
> > As I mentioned in another thread, freezing queue may not be needed in
> > ->store(), so let's discuss and confirm if it is needed here first.
> > 
> > https://lore.kernel.org/linux-block/Z3tHozKiUqWr7gjO@fedora/
> 
> We do need the freezing.  What you're proposing is playing fast and loose
> which is going to get us in trouble.

It is just soft update from sysfs interface, and both the old and new limits
are correct from device viewpoint.

What is the trouble? We have run the .store() code without freezing for
more than 10 years, no one report issue in the area.


> While most (all?) limits are simple
> scalars, you often can't update just one without the others without
> having coherent state.  Having coherent state was the entire point of
> the atomic queue limit updates.

We am talking all the update in block queue sysfs store(), in each
interface just one scalar number is updated in atomic way.

The atomic update API is still applied, I meant queue freeze can be
removed.


Thank,s
Ming

