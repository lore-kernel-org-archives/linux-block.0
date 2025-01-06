Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA2718651
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 03:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736134842; cv=none; b=f3y/m04TZnt/uJpMRx0rnnqS6nq+AJ/oDDfAnzepboDd4mpgNKebA0HRfz2AFVvdYZGgYRU8Kkt5gZF5ZKXglDluS63UEPvP0G5YL5KdrNLkvffaKnBNDlnNe3wWmEb79PEeWdqRkojxK96vNa1UTpUsFmm10c85l/Z+DVm1Kzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736134842; c=relaxed/simple;
	bh=fsy8vuer/mJeg/gWSTuhFbQAdHRzr2fZa7uKrL6OZBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2ZbXg7Ia9WWF5mhPLxBXhblbwWMWgRDUw5B8Hu/BFV3p6fxWNqhYS5Fl8NgtVvOWy2HoB0L29MlZShtEL02gR+YkZgvmD16CaFDBgR0VGI4ImxyYmLml5AXAY5Peet2E7YrxOgHoAbsvsz6V4XSUhpj9breNRSS1sr5S372P6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mw0FY8dU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mw0FY8dU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736134839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3tOJAnIBDB+fr4CPUuhNDC5lL3nuKPSuWa2qdR59qUo=;
	b=Mw0FY8dUDXeS/J2ScEUgbh7nIdUajEM8NBk2jCHrytj3YJQecjgQddMt5kGhiU2EcYn3Fq
	6yWVupxWl69L6otmjt10qkHG4MQR1L879Cnkk8UDB9r/lvZqIeW9fvOmllUvV0Ikco96O3
	UPW1I21t/tHLgLxuAfjP+GvpkORcmvQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-gfSZ1YnTNVmQ_oYUjhCj_Q-1; Sun,
 05 Jan 2025 22:40:36 -0500
X-MC-Unique: gfSZ1YnTNVmQ_oYUjhCj_Q-1
X-Mimecast-MFC-AGG-ID: gfSZ1YnTNVmQ_oYUjhCj_Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F28DA1956088;
	Mon,  6 Jan 2025 03:40:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.65])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BBB71956088;
	Mon,  6 Jan 2025 03:40:27 +0000 (UTC)
Date: Mon, 6 Jan 2025 11:40:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 1/3] block: Fix sysfs queue freeze and limits lock order
Message-ID: <Z3tQpt7n-NdSDN13@fedora>
References: <20250104132522.247376-1-dlemoal@kernel.org>
 <20250104132522.247376-2-dlemoal@kernel.org>
 <Z3tOn4C5i096owJc@fedora>
 <ae75194f-334f-4337-b1e6-e68b8d63bc93@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae75194f-334f-4337-b1e6-e68b8d63bc93@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, Jan 06, 2025 at 12:35:36PM +0900, Damien Le Moal wrote:
> On 1/6/25 12:31 PM, Ming Lei wrote:
> > On Sat, Jan 04, 2025 at 10:25:20PM +0900, Damien Le Moal wrote:
> >> queue_attr_store() always freezes a device queue before calling the
> >> attribute store operation. For attributes that control queue limits, the
> >> store operation will also lock the queue limits with a call to
> >> queue_limits_start_update(). However, some drivers (e.g. SCSI sd) may
> >> need to issue commands to a device to obtain limit values from the
> >> hardware with the queue limits locked. This creates a potential ABBA
> >> deadlock situation if a user attempts to modify a limit (thus freezing
> >> the device queue) while the device driver starts a revalidation of the
> >> device queue limits.
> >>
> >> Avoid such deadlock by introducing the ->store_limit() operation in
> >> struct queue_sysfs_entry and use this operation for all attributes that
> >> modify the device queue limits through the QUEUE_RW_LIMIT_ENTRY() macro
> >> definition. queue_attr_store() is modified to call the ->store_limit()
> >> operation (if it is defined) without the device queue frozen. The device
> >> queue freeze for attributes defining the ->stor_limit() operation is
> >> moved to after the operation completes and is done only around the call
> >> to queue_limits_commit_update().
> >>
> >> Cc: stable@vger.kernel.org # v6.9+
> >> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> >> ---
> >>  block/blk-sysfs.c | 123 ++++++++++++++++++++++++----------------------
> >>  1 file changed, 64 insertions(+), 59 deletions(-)
> >>
> >> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> >> index 767598e719ab..4fc0020c73a5 100644
> >> --- a/block/blk-sysfs.c
> >> +++ b/block/blk-sysfs.c
> >> @@ -24,6 +24,8 @@ struct queue_sysfs_entry {
> >>  	struct attribute attr;
> >>  	ssize_t (*show)(struct gendisk *disk, char *page);
> >>  	ssize_t (*store)(struct gendisk *disk, const char *page, size_t count);
> >> +	ssize_t (*store_limit)(struct gendisk *disk, struct queue_limits *lim,
> >> +			       const char *page, size_t count);
> > 
> > As I mentioned in another thread, freezing queue may not be needed in
> > ->store(), so let's discuss and confirm if it is needed here first.
> > 
> > https://lore.kernel.org/linux-block/Z3tHozKiUqWr7gjO@fedora/
> > 
> > Also even though freeze is needed, I'd suggest to move freeze in each
> > .store() callback for simplifying & avoiding regression.
> 
> The patch would be simpler, sure. But the code would not be simpler in my
> opinion as we will repeat the freeze+limits commit+unfreeze pattern in several
> callbacks. That is why I made the change to introduce the new store_limit()
> callback to have that pattern in a single place.
> 
> And thinking about it, queue_attr_store() should be better commented to clearly
> describes the locking rules.

The pattern can be enhanced by one new helper or API.

But let's discuss if we really need the pattern first.

IMO, freeze isn't needed in ->store().

Thanks,
Ming

