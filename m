Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286931B27C
	for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 03:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgDuPUgT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705030168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KlQJtx+Ix6clj47MDD9g3zO0R/DI/A3ugdWOrgzoTc=;
	b=QgDuPUgTFKvwr6IJ4YAXWrWEMzT63DUQwKpa37E7WntgPHOzz7snR933XxVKXl9KFcunD9
	uY4Y73V8UALhaOAP6yYIlnI//Lq0eZ7eg0u+htmSUynrFKVLJryO0Shyd+xnflntaWQ/65
	xflz8p4Rfkl6MGRw/JUyA8UonnFctAk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-EeSG8WwIOsWGGWrv1FtX4A-1; Thu,
 11 Jan 2024 22:29:23 -0500
X-MC-Unique: EeSG8WwIOsWGGWrv1FtX4A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CFD91C172A6;
	Fri, 12 Jan 2024 03:29:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.36])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 48067492BC6;
	Fri, 12 Jan 2024 03:29:18 +0000 (UTC)
Date: Fri, 12 Jan 2024 11:29:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
	John Meneghini <jmeneghi@redhat.com>,
	linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [Report] blk-zoned/ZNS: non_power_of_2 of zone->len]
Message-ID: <ZaCyC5RIAcbkBYeL@fedora>
References: <ZaCSOH7L+Nm6PvcN@fedora>
 <20503cd0-3a99-45bb-8374-40296a3cb92a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20503cd0-3a99-45bb-8374-40296a3cb92a@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Fri, Jan 12, 2024 at 12:05:45PM +0900, Damien Le Moal wrote:
> On 1/12/24 10:13, Ming Lei wrote:
> > Hello Damien and Guys,
> > 
> > Yi reported that the following failure:
> > 
> > Oct 18 15:24:15 localhost kernel: nvme nvme4: invalid zone size:196608 for namespace:1
> > Oct 18 15:24:33 localhost smartd[2303]: Device: /dev/nvme4, opened
> > Oct 18 15:24:33 localhost smartd[2303]: Device: /dev/nvme4, NETAPPX4022S173A4T0NTZ, S/N:S66NNE0T800169, FW:MVP40B7B, 4.09 TB
> > 
> > Looks current blk-zoned requires zone->len to be power_of_2() since
> > commit:
> > 
> > 6c6b35491422 ("block: set the zone size in blk_revalidate_disk_zones atomically")
> > 
> > And the original power_of_2() requirement is from the following commit
> > for ZBC and ZAC.
> > 
> > d9dd73087a8b ("block: Enhance blk_revalidate_disk_zones()")
> > 
> > Meantime block layer does support non-power_of_2 chunk sectors limit.
> 
> That is not true. It does. See blk_stack_limits which ahs:
> 
> 	/* Set non-power-of-2 compatible chunk_sectors boundary */
>         if (b->chunk_sectors)
>                 t->chunk_sectors = gcd(t->chunk_sectors, b->chunk_sectors);
> 
> and the absence of any check on the value of chunk_sectors in
> blk_queue_chunk_sectors().

I meant non-power_of_2 chunk sectors limit is supported, see

07d098e6bbad ("block: allow 'chunk_sectors' to be non-power-of-2")

And device mapper uses that.

> 
> > The question is if there is such hard requirement for ZNS, and I can't see
> > any such words in NVMe Zoned Namespace Command Set Specification.
> 
> No, there are no requirements in ZNS for the zone size to be a power of 2 number
> of sectors/LBAs. The same is also true for ZBC and ZAC (SCSI and ATA) SMR HDDs.
> The requirement for the zone size to be a power of 2 number of sectors is
> entirely in the kernel. The reason being that zoned block device support started
> with SMR HDDs which all had a zone size of 256 MB (and still do) and no user
> ever wanted anything else than that. So everything was coded with this
> requirement, as that allowed many nice things like bit-shift/mask arithmetic for
> conversions between zone number and sectors etc (and that of course is very
> efficient).

Thanks for the clarification.

> 
> > So is it one NVMe firmware issue? or blk-zoned problem with too strict(power_of_2)
> > requirement on zone->len?
> 
> It is the latter. There was a session at LSF/MM last year about this. I recall
> that the conclusion was that unless there is a strong user demand for non power
> of 2 zone size, we are not going to do anything about it. Because allowing
> non-power of 2 zone size has some serious consequences all over the place,
> including in FSes that natively support zoned devices. So relaxing that
> requirement is not trivial.

Just saw Bart's work on supporting non-power_of_2 zone len:

https://lore.kernel.org/linux-block/dc89c70e-4931-baaf-c450-6801c200c1d7@acm.org/

IMO FS support might be another topic, cause FS isn't the only user,
also without block layer support, the device isn't usable, not mention FS.

Since non-power2 zoned device does exists, I'd suggest Bart to restart the
work and let linux cover more zoned devices(include non-power 2 zone).


Thanks,
Ming

