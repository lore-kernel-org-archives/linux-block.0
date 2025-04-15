Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6DD155382
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 02:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744684291; cv=none; b=AXMRNCmKolUf4kYkg/DCguimWTr0V/Gk7w8HqmugnpILmq+tpVOX7himYsrP5+6CYynJ+aGAeNJ6aOM8evdz7YUip194zPlFC3hTI9ymZBkTsVHYcH1HKOYk4Xj7AyWHtooPOkifLagTHhvKC+J9vEppUShdw/OvcC4Z9TtKFIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744684291; c=relaxed/simple;
	bh=CRfcOi+v09nkGpC3rkEG6mmEvwbM+hfgujH4nzglzsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Unx+e47MeA+1aLrB6IM0ppl2emJ9/J0d7fGxGZdp+XOGoELwQt36Dlb9K+X7TwdV0F+ffYxMPDheRkiIF8xQpeTXLHxzb7WrtxKhKd6iVsUAlHFyUJFd+YTdoCDEOgnq480+mEAc1WIVoxArxZwk+1FMiM4K4LYoGz7PBfZT+Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IrHNmroZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrHNmroZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744684288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9s/pTeHckl7MxMhSgsvZcBc410h/Eoul0HzXV/LGPNI=;
	b=IrHNmroZ4X/e6rofXKrRELfYfE5dBGwRLdhMo1ZVqnzIIQG9hlWNKF2UQdbAK+6x4G6p53
	aan5qXeOFnw8aOKezar9VbXe+YlxYGPVI5kdUwviI+G4U0wIAnwibnYTarXhU3rs9w96it
	k0PD7Ql8/oPSddGsCzBzzwWO/LGc9vo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-UJ_J_IIrPkKUTdWxuA_7TQ-1; Mon,
 14 Apr 2025 22:31:24 -0400
X-MC-Unique: UJ_J_IIrPkKUTdWxuA_7TQ-1
X-Mimecast-MFC-AGG-ID: UJ_J_IIrPkKUTdWxuA_7TQ_1744684283
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CE3B19560A2;
	Tue, 15 Apr 2025 02:31:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.40])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 240853001D0F;
	Tue, 15 Apr 2025 02:31:18 +0000 (UTC)
Date: Tue, 15 Apr 2025 10:31:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 10/15] block: pass elevator_queue to elv_register_queue &
 unregister_queue
Message-ID: <Z_3E8mrvV_tTHZE1@fedora>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-11-ming.lei@redhat.com>
 <20250414062209.GC6673@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414062209.GC6673@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Apr 14, 2025 at 08:22:09AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 10, 2025 at 09:30:22PM +0800, Ming Lei wrote:
> > Pass elevator_queue reference to elv_register_queue() &
> > elv_unregister_queue().
> > 
> > No functional change, and prepare for moving the two out of elevator
> > lock.
> 
> Can you explain a bit more why passing a seemlingly duplicate argument
> helps further down the series?

Please see the following patch, especially elevator_change_done() in which
the old elevator queue is retrieved from the context structure, then its
unregistering can be moved out of queue freezing & elevator lock.

Same with registering of the new added elevator queue.

I will add more words in commit log for this motivation in next version.


Thanks,
Ming

