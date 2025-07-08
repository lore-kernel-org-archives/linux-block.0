Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D3D191F9C
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 02:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751942788; cv=none; b=lNN9Ae8ww5TzyseiHnlctC4Gy6CdFpJ+/AghZIhLLQaTwLNmdR0V0GOAaOJ/0vI/jvGnTSXaypko8dOorBeB1E4Yggy2j8k8qqVNEDce04xL8//MQuJAxKTJcgBpZv66QdckFXOqFZDSG66NvoujUX6HGFckX4pQuNz3BHcIv68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751942788; c=relaxed/simple;
	bh=bV63f8XEUoCWMlOBvVeuR9Ptfvqbwxd9+vTo40J5oX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMxTD9+rAw6ivswUGA6fI1QzmDLZk+eswVUgp60wWbPy4OcaL4nup0HIu2HV31H26qEhzDXxGAmzMp2fbFajAkEeJ+mL01kLLF/qTBhh0B+631HUTO6P9fVi702w+j71/J2J/m2CMwellhXoPN4OICZ2PhSI10HV1QBtcgg6dk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GDfmHkZM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDfmHkZM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751942784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DrYPhW9upjzk5P78SdEwMjAG/WbTXiFI741894VXTTw=;
	b=GDfmHkZMpk4ONA04gAqUypOwsmPHpRafkes/9iy94+2Tkrcdr21biLzCYvg6IUf16pOwl+
	8C10+n/AYn3jCYhjDchtvxrp5AHQ2skeAF5FX/m2R2t2l4K2YitHRMOIeQwF1x2anokuYK
	+zs7hwOw1zTGaoBsYvZZWazkFxs/jjk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-VY45ijIiPXSbmUrwZsAOpw-1; Mon,
 07 Jul 2025 22:46:18 -0400
X-MC-Unique: VY45ijIiPXSbmUrwZsAOpw-1
X-Mimecast-MFC-AGG-ID: VY45ijIiPXSbmUrwZsAOpw_1751942777
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5481180029E;
	Tue,  8 Jul 2025 02:46:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.39])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 851B030002C0;
	Tue,  8 Jul 2025 02:46:11 +0000 (UTC)
Date: Tue, 8 Jul 2025 10:46:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <aGyGboLwcn2cXoRo@fedora>
References: <20250707141834.GA30198@lst.de>
 <aGxz6s9oUp2FkbyX@fedora>
 <aGyCH8TOQgVY3AP9@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGyCH8TOQgVY3AP9@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Jul 07, 2025 at 08:27:43PM -0600, Keith Busch wrote:
> On Tue, Jul 08, 2025 at 09:27:06AM +0800, Ming Lei wrote:
> > On Mon, Jul 07, 2025 at 04:18:34PM +0200, Christoph Hellwig wrote:
> > > Hi all,
> > > 
> > > I'm a bit lost on what to do about the sad state of NVMe atomic writes.
> > > 
> > > As a short reminder the main issues are:
> > > 
> > >  1) there is no flag on a command to request atomic (aka non-torn)
> > >     behavior, instead writes adhering to the atomicy requirements will
> > >     never be torn, and writes not adhering them can be torn any time.
> > >     This differs from SCSI where atomic writes have to be be explicitly
> > >     requested and fail when they can't be satisfied
> > >  2) the original way to indicate the main atomicy limit is the AWUPF
> > >     field, which is in Identify Controller, but specified in logical
> > >     blocks which only exist at a namespace layer.  This a) lead to
> > 
> > If controller-wide AWUPF is a must property, the length has to be aligned
> > with block size.
> 
> What block size? The controller doesn't have one. Block sizes are

It should be any NS format's block size.

> properties of namespaces, not controllers or subsystems. If you have 10
> namespaces with 10 different block formats, what does AUWPF mean? If the
> controller must report something, the only rational thing it could
> declare is reduced to the greatest common denominator, which is out of
> sync with the true value reported in the appropriately scoped NAUWPF
> value.

Yes, please see the words I quoted from NVMe spec, also `6.4 Atomic Operations`
mentioned: `NAWUPF >= AWUPF`.



Thanks,
Ming

