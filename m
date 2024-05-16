Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43436CDA8
	for <linux-block@vger.kernel.org>; Thu, 16 May 2024 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847312; cv=none; b=pDPEYXpZgs0Dx0LRjYTjx3sUQQUF3xY1aGqOhNsL0TpqgCbmt5N2e57/OWq5TPYXbpwv8UCtz/jG0DZaz8wOyt2Kb6DqJAyziHs1c7St8WgX9Ea8nK3oaqimjNAPfIHmTOuQQzM5ho/MxEL/6+GdDxJg8B0GgQwylgyPxmm59jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847312; c=relaxed/simple;
	bh=T/uwawyFZV/tmZPc2PPlj+6W7w2/FYrQnUW2b4TES/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPD3XYDCiF/wajoQFQ2iWZUa+FGwYdJ9yNLdrhyXsoHieyXOLr9tIPJ6BWNhjRbC16YYsKk4YZSXf0MRkrmDCzyhd2b6WlLpDl7DnOc6O1UaU3QPYgDZhDlmJq0LHGOR3/yHG/1Y60/RxF+iIeTYGH4fVrwUKPpXbxxxwInP03s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPe4V9qH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPe4V9qH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715847308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CNafrKnk4FIq2+HqmIqGhvURcy9ujy5KvmOkvU/Cn1I=;
	b=UPe4V9qH8Cre2aMj3aMRJ5qf52eTThKrR60fADybStzhZXGSLAioZGNS2sT4khWET1qnfV
	kWNCsVVTg2XsFoHB1GgiXfvvGpMYdoJelN1vo3cuNeV8bROioGj0GFVWb6QdZmM0y5srQn
	Dsvfcu0Zz/vz2DIGMRv5VAKKdkv/vp4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-nExiO4DSOf2sOTvOJ2-zwA-1; Thu,
 16 May 2024 04:15:04 -0400
X-MC-Unique: nExiO4DSOf2sOTvOJ2-zwA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B264329AA396;
	Thu, 16 May 2024 08:15:03 +0000 (UTC)
Received: from fedora (unknown [10.72.116.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 70814561A;
	Thu, 16 May 2024 08:14:58 +0000 (UTC)
Date: Thu, 16 May 2024 16:14:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [RFC PATCH 1/2] block: change rq_integrity_vec to respect the
 iterator
Message-ID: <ZkXAfmbtXzKGaouC@fedora>
References: <f85e3824-5545-f541-c96d-4352585288a@redhat.com>
 <c366231-e146-5a2b-1d8a-5936fb2047ca@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c366231-e146-5a2b-1d8a-5936fb2047ca@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Wed, May 15, 2024 at 03:28:11PM +0200, Mikulas Patocka wrote:
> If we allocate a bio that is larger than NVMe maximum request size, attach
> integrity metadata to it and send it to the NVMe subsystem, the integrity
> metadata will be corrupted.
> 
> Splitting the bio works correctly. The function bio_split will clone the
> bio, trim the iterator of the first bio and advance the iterator of the
> second bio.
> 
> However, the function rq_integrity_vec has a bug - it returns the first
> vector of the bio's metadata and completely disregards the metadata
> iterator that was advanced when the bio was split. Thus, the second bio
> uses the same metadata as the first bio and this leads to metadata
> corruption.

Wrt. NVMe, inside blk_mq_submit_bio(), bio_integrity_prep() is called after
bio is split, ->bi_integrity is actually allocated for every split bio, so I
am not sure if the issue is related with bio splitting. Or is it related
with DM over NVMe?

However, rq_integrity_vec() may not work correctly in case of bio merge.


Thanks, 
Ming

