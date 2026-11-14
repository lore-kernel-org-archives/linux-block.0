Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794690103;
	b=Ajba9YlUgzX9UpzhyLWjfU4G9sd+cgVWC2yCXyPDlv2qlL6dFxJzwMrTUp1dkYXLkDwP
	 aS7vd1FkhNDWSGs2sLck9ym7ZCLgNThIrE1ZfvJLSeszEY5WPnijPz6q56dXzQHCsgpTf
	 2vkkcw1BqJV3fKUsDu0damvPnz9dAMmwI7DFHb2FpsxU6NyCiYIksGoFqu1M4JmFj6CK0
	 z+iXs4QPQ52Ehxtt72549V4UiSMa14M0VkzMUY+VUWDzO/4CkulCPJQssvql3shL1UfWy
	 uN7jxy7UkxOXBmI1q+xzSk6oTp5e0n8CgnfMEBWcaHGgR5QVjNP96GYJ0l1tQwEz7FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794690103;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:cc:Subject:
	 In-Reply-To:Message-ID:References:MIME-Version:Content-Type:
	 X-Scanned-By;
	bh=W36WF/9m32YwszJFJtP4N6eElBtazo+wbR9k9iqRXpE=;
	b=LF/189okxIzlzFXyJ2PhvH2+V2wwyg6c8o4n6HovOLJyIH6SitYaOGyQbF4nqT4Uj1ba
	 DS0tvSkoGel+sU8BLyi51YdnykMjIvQEi/IgzTriVtJopEP/oEHt/8FdVbRPrJocrSNHH
	 XkbijYCm/zXUJ+0QjypXVEV/fKUrMKXvCoNVBWEwpNw7StkwFs26C9ndldGiCM2tIp2N9
	 ksCk6KJHULIEGshdhwLi6I0pxVS3rP45KIq79OhFo7pQ+e5lenaPFLLVd9/l0J7dQGUoo
	 IVfT6D0uwUyz+xP2hRhz42Jgj4vm8AjTFGwE5FjLP38GkmFOgV1Jw0/05XQwRD6Xd0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DoAvnG9n;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7741606A32D
	for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 21:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7741606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DoAvnG9n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794690102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W36WF/9m32YwszJFJtP4N6eElBtazo+wbR9k9iqRXpE=;
	b=DoAvnG9nJCL/pO0B3XnA6sttUoBobIbv7LeBfBUGPc1dyFd3S0xmeEs14PrMWz+aPk3w3/
	/nxdpbvTn2hTl6iaFNfsZ6IKiWIZZpbkg+JuoW5zJsyxHGeUYE8AGY2qDitBR+ddObu2aH
	fNdsQ/+XMeAdQ5t7wN3DTVLwRFUJ5PI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-bk35ufeUMt6PX4spgoE_Fw-1; Sat,
 14 Nov 2026 16:01:36 -0500
X-MC-Unique: bk35ufeUMt6PX4spgoE_Fw-1
X-Mimecast-MFC-AGG-ID: bk35ufeUMt6PX4spgoE_Fw_1794690095
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74810180049F;
	Sat, 14 Nov 2026 21:01:34 +0000 (UTC)
Received: from mpatocka-thinkpadx1carbongen12.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D37A530000E5;
	Sat, 14 Nov 2026 21:01:31 +0000 (UTC)
Date: Sat, 14 Nov 2026 22:01:29 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Mike Snitzer <snitzer@kernel.org>
cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
    Keith Busch <kbusch@meta.com>, axboe@kernel.dk, dm-devel@lists.linux.dev, 
    bmarzins@redhat.com, linux-block@vger.kernel.org
Subject: Re: block: let a stacking device inherit its members' DMA
 alignment
In-Reply-To: <avdNg7ckyt6-M8si@kernel.org>
Message-ID: <f1831833-335b-5b63-95b9-9eac893accb4@redhat.com>
References: <20260709161519.1559723-1-kbusch@meta.com> <20260709161519.1559723-2-kbusch@meta.com> <atpBVtPqGDWZ2AFo@kernel.org> <aumxcHVjVonjs6OV@infradead.org> <auoab2ewQZGDpRi3@kbusch-mbp> <avdNg7ckyt6-M8si@kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On Fri, 13 Nov 2026, Mike Snitzer wrote:

> On Tue, Nov 03, 2026 at 10:31:27AM -0700, Keith Busch wrote:
> > On Tue, Nov 03, 2026 at 02:03:28AM -0800, Christoph Hellwig wrote:
> > > On Thu, Oct 22, 2026 at 01:01:10PM -0400, Mike Snitzer wrote:
> > > > On Thu, Jul 09, 2026 at 09:15:17AM -0700, Keith Busch wrote:
> > > > > From: Keith Busch <kbusch@kernel.org>
> > > > > 
> > > > > All device mappers that want to override the dma_alignment do so.
> > > 
> > > Don't start a patch description by quoting another mail.
> > > 
> > > > Direct I/O from memory every member accepts is therefore rejected at
> > > > the stacking device, and callers that check the advertised alignment
> > > > (for instance through STATX_DIOALIGN) fall back to buffered I/O.
> > > > 
> > > > Leave dma_alignment at zero in blk_set_stacking_limits() so that the
> > > > stacked value is the strictest of the members'.  blk_validate_limits()
> > > > still applies the SECTOR_SIZE - 1 default when nothing was stacked,
> > > > such as for a table with no devices.  Targets that process the data
> > > > themselves and need logical-block-aligned memory already set
> > > > dma_alignment in their io_hints (dm-crypt, dm-integrity, dm-verity,
> > > > dm-log-writes), and NVMe multipath sets its own.
> > > 
> > > Chances are very high that this will introduce bugs somewhere,
> > > as a lot of drivers are historically not ready to deal with lower
> > > alignments, and will creeat nasty exploitable bugs.
> > > 
> > > So you'll need to audit each driver that wants to relax this
> > > individually, and then override the value for them.  Alternatively
> > > we could start with 0 in the block layer, but then you need to
> > > lift the current setting into each caller first, and only remove
> > > them one-by-one with a commit per driver explaining why that is safe
> > > (and sensible).
> > 
> > I suppose it would be safer to have each stacking driver that can
> > tolerate lower alignment granularity explicitly override the limit to 0
> > to inherit whatever the stacking members require. For md-raid,
> > that's not too bad as it can set lim.dma_alignment = 0 in
> > raid0_set_limits() after md_init_stacking_limits(). But other device
> > mappers don't have a way to override it so I guess something has to
> > happen in dm_calculate_queue_limits() to allow this option.
> 
> DM devices have the ability to change limits really well, both in DM
> core and the individual DM targets using .io_hints hook in their
> target_type struct.  Mikulas knows what is needed for DM.
> 
> Mike

The problem is that the limits may change. I.e. for example, you can have 
a linear device on the top of a disk that allows unaligned bio vectors, 
you take a snapshot of the device, and suddenly, the dm device stops 
supporting unaligned bio vectors.

There would be a race condition:
1. you check queue limits, see that it supports unaligned vectors
2. you construct a bio with unaligned vectors
3. you reload the dm table with a target that doesn't support unaligned 
vectors
4. you submit the bio
5. the bio with unaligned vectors is delivered to a target that doesn't 
support them and misbehaves on them (for example, dm-raid1 used to 
livelock if it received unaligned vectors, and other targets may misbehave 
as well because they were written in the era when all vectors were 
aligned)

So, if we want to support unaligned vectors in dm, we must make sure that 
device mapper never misbehaves on unaligned bio vector, regardless of 
which dm target is used.

Auditing and rewriting all the targets to support unaligned vectors 
doesn't seem practical.

One possibility how to support it would be to make per-target flag whether 
the target accepts unaligned vectors. Then, we would have a per-table flag 
that is true if all the targets in the table support unaligned vectors.

Then, if dm receives a bio and the table doesn't have the flag set, we 
would check the alignment of bio vectors in the dm core and terminate the 
bio with BLK_STS_INVAL without giving it to the target.

I just don't know how much this extra walk through the bio vector would 
degrade performance for the common case (i.e. no unaligned vectors).

Mikulas

