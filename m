Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017AA27816C
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 01:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775005974; cv=none; b=sG+q3DdNWWDlhkRMnKwGoRj0QUajYHYnDKz7aiDvKfzJjLH0phFL+aCaLul8FBiNU/pK83ir/9hDwn31xZxMuYekoFv8f6yT0GdFs2JAkujUqC99uPmrgvBufUEioVZtCRXedbQSehPWlrrZSoFwnc7lp+fHd8cSx+XX7IM7ujI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775005974; c=relaxed/simple;
	bh=476bPJH1yiHIKo35sskVy9NYL76Mta57CGMe4J6vEwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyGVQbz3GeApyk0Qi+djD7hwum5wzyBy0GgZg4LqvqdVXp49/YP8qeHH81OsrgIOw1wP/7soBIkX9JU7eCusDDWdaIhD8cjoxGMQz44YvHI3Bp5efU4skIjrEWV3zc8hrGlyv1aFDW1fSX9u4c83TY2xqQs2XKOTrrSq5YIWxoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOQqRH/f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOQqRH/f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775005972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X5u0Mvf0aIh7sPUU6rhICf017MOlqHpAj5kv9TV0zHM=;
	b=SOQqRH/fvQWGFbdhkgA3ZRMEPhoaPRWBmSSgCg16MCR0QgtAKIWuyQZhO5H83mgWf7xrNY
	IdsTJuyj56KWhuRZKEXTvfkfLWRNfrtuJBw0DZHqKQt2R4p+07GKRgpWiirP5LkVKB7yN1
	p1Y6y5O+37l8y2vO0mTCJOUsrBgAPEY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-FHqy26LoMYmKoZ1mlFpj7w-1; Tue,
 31 Mar 2026 21:12:48 -0400
X-MC-Unique: FHqy26LoMYmKoZ1mlFpj7w-1
X-Mimecast-MFC-AGG-ID: FHqy26LoMYmKoZ1mlFpj7w_1775005967
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31DE21800344;
	Wed,  1 Apr 2026 01:12:47 +0000 (UTC)
Received: from fedora (unknown [10.72.116.96])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B700130001A2;
	Wed,  1 Apr 2026 01:12:43 +0000 (UTC)
Date: Wed, 1 Apr 2026 09:12:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 4/6] block: Reduce the minimum value for the maximum
 DMA segment size
Message-ID: <acxxBsnoMhZo2iCk@fedora>
References: <20260327211349.2239633-1-bvanassche@acm.org>
 <20260327211349.2239633-5-bvanassche@acm.org>
 <ack5VqUS_gRuxodF@fedora>
 <7fe454fa-d39b-4d2f-a238-297df2261cdd@acm.org>
 <acsb_mLxDz8RpXF1@fedora>
 <70b6d783-fdd3-4dce-807a-80b0967906a3@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70b6d783-fdd3-4dce-807a-80b0967906a3@acm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Mar 31, 2026 at 09:12:54AM -0700, Bart Van Assche wrote:
> On 3/30/26 5:57 PM, Ming Lei wrote:
> > What is the exactly code path you are trying to cover by changing
> > BLK_MIN_SEGMENT_SIZE?
> 
> In the solution I came up with and that we are no longer using in Android
> (we switched to the upstream approach) there were code paths
> that are only triggered if max_segment_size < PAGE_SIZE (see also
> https://lore.kernel.org/linux-block/20230522222554.525229-1-bvanassche@acm.org/).
> I'm not sure there are any such code paths left?

Then please setup one aarch64 VM with 16/64K PAGE_SIZE for covering the
code path.

It is insane to reduce BLK_MIN_SEGMENT_SIZE just for faking max_segment_size < PAGE_SIZE
in 4K page size kernel for test purpose only, IMO.


Thanks,
Ming

