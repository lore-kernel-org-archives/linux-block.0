Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5071F6A349
	for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="zKBAK2OE"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TBQjS18ptz9spj;
	Fri, 12 Jan 2024 16:40:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1705074044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DjVPjjjOC9+VfIQIJ1ZCZOkIJE5V+3KCLHNSv8iSUzM=;
	b=zKBAK2OEqLzWPvOw5JB/dhK2JTaVuc25nJgUcgCQYSRZZ/biXbLqIpI+ECzQKHy0aF8yP+
	p1my3UGhK29FORk4ewodR9ldGGBjZFZAb8b3mRJopsKsfI7R6DlDr1AMPBcMfgvlSK8mk6
	rJpWCsO2VWw+wKpGUw3qdE9XN6J3wiaOaMYtLNicjYW4IS7ev4lTnWJKQCp2Zw4H4driOy
	qlYweryOcYIvRu0iVRVR3hkNuKY5A/2/LzWCm+2HDK7EHTQBNCrQ8MABxC5OMZZhbjQ8Ux
	7ZjxeJxfYC11GaFO46EH2EM5l2/+8AhisWxOc4SSiIuAH69f9BX4C7poS2AuxQ==
Date: Fri, 12 Jan 2024 16:40:40 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, 
	Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>, 
	John Meneghini <jmeneghi@redhat.com>, linux-nvme@lists.infradead.org, hch@lst.de, 
	Keith Busch <kbusch@kernel.org>, p.raghav@samsung.com, javier.gonz@samsung.com
Subject: Re: [Report] blk-zoned/ZNS: non_power_of_2 of zone->len]
Message-ID: <pvojitlhpwnxoc3zws5ufwsg2wnygirzobuuktbrcfv3b2zcyo@oevh6e2x3adx>
References: <ZaCSOH7L+Nm6PvcN@fedora>
 <20503cd0-3a99-45bb-8374-40296a3cb92a@kernel.org>
 <ZaCyC5RIAcbkBYeL@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaCyC5RIAcbkBYeL@fedora>

Hi Ming,

> > 
> > It is the latter. There was a session at LSF/MM last year about this. I recall
> > that the conclusion was that unless there is a strong user demand for non power
> > of 2 zone size, we are not going to do anything about it. Because allowing
> > non-power of 2 zone size has some serious consequences all over the place,
> > including in FSes that natively support zoned devices. So relaxing that
> > requirement is not trivial.
> 
> Just saw Bart's work on supporting non-power_of_2 zone len:
> 
> https://lore.kernel.org/linux-block/dc89c70e-4931-baaf-c450-6801c200c1d7@acm.org/

As Bart said, I did most of the work in 2022.

> 
> IMO FS support might be another topic, cause FS isn't the only user,
> also without block layer support, the device isn't usable, not mention FS.
> 

I also added a small dm target in the series that converts a non-po2
device to a po2 device to support existing FS without modifications
until native support is added in them.

One of the main arguments against the support was the fragmentation it
may cause in the FS world for zoned devices. Given that F2FS already
supports non-po2 devices, it is only btrfs that will need some work to
have native non-po2 support.

> Since non-power2 zoned device does exists, I'd suggest Bart to restart the
> work and let linux cover more zoned devices(include non-power 2 zone).
> 

I would be more than happy to provide my reviews if someone wants to do
a respin on that series. IIRC, the changes to the block layer were not
very intrusive.

--
Pankaj
