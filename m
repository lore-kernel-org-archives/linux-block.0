Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DEE2580D7
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160054; cv=none; b=jsiHZ4FhjZqWVzKe+24QtsWDbQ8T6B487turCkBgx5Lrap5m/YR2oWEbfOTHOiPTZlvxaNGrkRFv2+P2VFJa2P9erI+8pqznUU0h9JR4YcziqWVyfKVezdH/EzLeDUwj2rjEFP/4mA8OJCtNAQcy5lqv6ArVO7lQviDgOr7cpc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160054; c=relaxed/simple;
	bh=wMcnPdUCFx40hqyageRaHybYN+Tt7ybSqt6EnoIQKLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtkzO2E/2+6z811QqZsrJNuZXvf7hvnpzIYiMe7f2hR+0RszRd0h1Xo58uGwNz2yV2D20+tM1kDktCvNsDg3QORdmBAT0onClFURLJIi4aYCdaPfo3uGbFCfsN7uYU0Zgk0kfrF+iQk+U3uBfbXkDDGkgSOa75eXR0zVz/b8RcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VdzzmLTl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdzzmLTl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755160051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VCtxsI2k9h9lYGDNgah1NdymPgILTjH6myt1fejzWfc=;
	b=VdzzmLTlhNFLIUIJCDI2W+tTOKtEYe4EmdKp8smUUxjQC1E+c1q3ZFzTjDaE/UUJRJ+I02
	bZj3Wf/RH2v1y5GtjIx0PBe0nXTfzzptErwGekU37K5SXCMfs7J5lEx34LARQ410CBvGQf
	J3tQtiUVhKebpfGFpXoZnwY9dD7ta7E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-n5-3eCyoNMWweKpsJ1vVJw-1; Thu,
 14 Aug 2025 04:27:30 -0400
X-MC-Unique: n5-3eCyoNMWweKpsJ1vVJw-1
X-Mimecast-MFC-AGG-ID: n5-3eCyoNMWweKpsJ1vVJw_1755160048
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B9E218004D4;
	Thu, 14 Aug 2025 08:27:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.148])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06B4A1955E89;
	Thu, 14 Aug 2025 08:27:16 +0000 (UTC)
Date: Thu, 14 Aug 2025 16:27:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, bvanassche@acm.org, nilay@linux.ibm.com, hare@suse.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 00/16] blk-mq: introduce new queue attribute asyc_dpeth
Message-ID: <aJ2d3gtfi0aEaeEc@fedora>
References: <20250814033522.770575-1-yukuai1@huaweicloud.com>
 <aJ2WH_RAMPQ9sd6r@fedora>
 <b6587204-9798-fcb0-c4b7-f00d5979d243@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6587204-9798-fcb0-c4b7-f00d5979d243@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Aug 14, 2025 at 04:22:27PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/14 15:54, Ming Lei 写道:
> > On Thu, Aug 14, 2025 at 11:35:06AM +0800, Yu Kuai wrote:
> > > From: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > Backgroud and motivation:
> > > 
> > > At first, we test a performance regression from 5.10 to 6.6 in
> > > downstream kernel(described in patch 13), the regression is related to
> > > async_depth in mq-dealine.
> > > 
> > > While trying to fix this regression, Bart suggests add a new attribute
> > > to request_queue, and I think this is a good idea because all elevators
> > > have similar logical, however only mq-deadline allow user to configure
> > > async_depth. And this is patch 9-16, where the performance problem is
> > > fixed in patch 13;
> > > 
> > > Because async_depth is related to nr_requests, while reviewing related
> > > code, patch 2-7 are cleanups and fixes to nr_reqeusts.
> > > 
> > > I was planning to send this set for the next merge window, however,
> > > during test I found the last block pr(6.17-rc1) introduce a regression
> > > if nr_reqeusts grows, exit elevator will panic, and I fix this by
> > > patch 1,8.
> > 
> > Please split the patchset into two:
> > 
> > - one is for fixing recent regression on updating 'nr_requests', so this
> >    can be merged to v6.17, and be backport easily for stable & downstream
> 
> There are actually two regressions, as fixed by patch 5 and patch 8, how
> about the first patchset for patch 1-8? Are you good with those minor
> prep cleanup patches?

Then probably you need to make it into three by adding one extra bug fix for
`fix elevator depth_updated method`, which follows the philosophy of
"do one thing, do it better", also helps people to review.

Thanks, 
Ming

