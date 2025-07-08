Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC321E9B08
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 03:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751944692; cv=none; b=sWhKgN/rUlJfGS1Sb6LoDSFbLtMNEzfuacFaoYobncP+aRE/r817+xBAFjah1HqKLA/YNGhGqZikxdOg3jZ+EwMEgvv9L/S6rT+jrll3r/2C/dpvNv3BuGb2mjfdJGy5Bb8mjFhmrrdjsMkOJkfnamBwvCC8MxqVadPDLjRFaUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751944692; c=relaxed/simple;
	bh=GyPlymnVgsYWet3xQn1GhqAUlwo50EZulg1NFl719EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbrCYkAprooVangvUCZW/mzWYtXp1F8EjwOGB2C4Uq28MyWF9CLQEnh2mhQ48KfMq1MWsBSWtPkeulxvvqCJg3VPH/D4slOvNgJ1Wir8P8Gg4eQc+qxd4AYTR1/w+YFlYfREoUeP6SS/LyVWxbrd5IkpRzIJBY0f2GNYL9h5R2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QpaKXAPT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpaKXAPT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751944689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dnopD1FhRzynW0zzFuLolvd4OyfdYAg2+eqiwCTe42c=;
	b=QpaKXAPTslqLzmEIiYr8jKzPgIZgAceeAwvAiNvzCrTXg6QIRr9g436puHgrAEBNlAemy1
	5faLeEJBgdMh0x4e2u/fohBs9y1ZSICpRgRfritEmDddoBtn3OGtzUWvc93XS674f/3v6O
	02wYX4yrA2y2ePAWexC5rN6a+r9jDBY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-8zwr5N74NfS8riI8N4qkxw-1; Mon,
 07 Jul 2025 23:18:06 -0400
X-MC-Unique: 8zwr5N74NfS8riI8N4qkxw-1
X-Mimecast-MFC-AGG-ID: 8zwr5N74NfS8riI8N4qkxw_1751944685
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE3A81800289;
	Tue,  8 Jul 2025 03:18:04 +0000 (UTC)
Received: from fedora (unknown [10.72.116.39])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D90171956087;
	Tue,  8 Jul 2025 03:17:59 +0000 (UTC)
Date: Tue, 8 Jul 2025 11:17:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <aGyN4pOWyclgV6-H@fedora>
References: <20250707141834.GA30198@lst.de>
 <aGxz6s9oUp2FkbyX@fedora>
 <aGyCH8TOQgVY3AP9@kbusch-mbp>
 <aGyGboLwcn2cXoRo@fedora>
 <aGyI-sl68Y0klsJn@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGyI-sl68Y0klsJn@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, Jul 07, 2025 at 08:56:58PM -0600, Keith Busch wrote:
> On Tue, Jul 08, 2025 at 10:46:06AM +0800, Ming Lei wrote:
> > On Mon, Jul 07, 2025 at 08:27:43PM -0600, Keith Busch wrote:
> > > On Tue, Jul 08, 2025 at 09:27:06AM +0800, Ming Lei wrote:
> > > > On Mon, Jul 07, 2025 at 04:18:34PM +0200, Christoph Hellwig wrote:
> > > > > Hi all,
> > > > > 
> > > > > I'm a bit lost on what to do about the sad state of NVMe atomic writes.
> > > > > 
> > > > > As a short reminder the main issues are:
> > > > > 
> > > > >  1) there is no flag on a command to request atomic (aka non-torn)
> > > > >     behavior, instead writes adhering to the atomicy requirements will
> > > > >     never be torn, and writes not adhering them can be torn any time.
> > > > >     This differs from SCSI where atomic writes have to be be explicitly
> > > > >     requested and fail when they can't be satisfied
> > > > >  2) the original way to indicate the main atomicy limit is the AWUPF
> > > > >     field, which is in Identify Controller, but specified in logical
> > > > >     blocks which only exist at a namespace layer.  This a) lead to
> > > > 
> > > > If controller-wide AWUPF is a must property, the length has to be aligned
> > > > with block size.
> > > 
> > > What block size? The controller doesn't have one. Block sizes are
> > 
> > It should be any NS format's block size.
> 
> That requires an artificial reduction to a meaningless value.

Any value has to be 'block size' aligned.

> 
> > > properties of namespaces, not controllers or subsystems. If you have 10
> > > namespaces with 10 different block formats, what does AUWPF mean? If the
> > > controller must report something, the only rational thing it could
> > > declare is reduced to the greatest common denominator, which is out of
> > > sync with the true value reported in the appropriately scoped NAUWPF
> > > value.
> > 
> > Yes, please see the words I quoted from NVMe spec, also `6.4 Atomic Operations`
> > mentioned: `NAWUPF >= AWUPF`.
> 
> The problem is when Namespace X changes its format that then alters
> Namesace Y's reported atomic size. That's unacceptable for any
> filesystem utilizing this feature.

When X changes its format, FS has to be umount.

The actual length(byte unit) of atomic write does not changed for Y,
just the unit(block size) is changed, at least from Yi's report.


Thanks, 
Ming

