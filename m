Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7BA3C463
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 02:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744682627; cv=none; b=VITMXKzXegeX7t6VNZy3dyCFM4ykCzu8h5fvW+FK1NZTMOoITVeFIvZN/KVaW4H8onFVMrIs1KaGv2gkzXZah2W8TrrG3ZosAKnrYoE54Uyo7cS8sMLCHAiuj0dyNEKdsnI+juBbk4/mk4c66kichjIgqXnlLM0zgQXFzX5sByo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744682627; c=relaxed/simple;
	bh=C3/+q4BieDFlFmF24fVL0ZkztnfOytxkNuf5uPsZzVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOAUNvJM9MkgDSs2SqdYtfTrp8xmlfu9lHBkuWTUzYKRkYFtfM2UCeUkgEGHEEHt1DzXc/51ZWDZxJdH6/oNwjV1/oAyzQKLc/FuiGD/G+qAYD5RKA7BG9KNl8odLGg5ReD+6h/kra8dVWtg4IMshsWKOsc2+WaNtwA7SOiJzzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ng9k+i12; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ng9k+i12"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744682624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/HiYpzF/gFMddie6HmMvq82TtB8+xtd5ZC36RqDVGFw=;
	b=Ng9k+i12RjSc3Ae6s/h4gjM88gJP3oJhW4Jf90spCDrp2hXBcCpZjkd0xL1B7laFtbyjko
	+yJj7iu0j9x+AqblKIoRrO3YJNN126YudQVXWjpNcwrYP/AoE+36QyWQERtjM+b2L+VNZq
	otoa5JHjTO1/oSkv6S8ouBs/f//CFxY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-4mN9adyKNQOII_DtzRunWA-1; Mon,
 14 Apr 2025 22:03:42 -0400
X-MC-Unique: 4mN9adyKNQOII_DtzRunWA-1
X-Mimecast-MFC-AGG-ID: 4mN9adyKNQOII_DtzRunWA_1744682621
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07AAD1955D82;
	Tue, 15 Apr 2025 02:03:41 +0000 (UTC)
Received: from fedora (unknown [10.72.116.40])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 353D9180B488;
	Tue, 15 Apr 2025 02:03:36 +0000 (UTC)
Date: Tue, 15 Apr 2025 10:03:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 04/15] block: prevent elevator switch during updating
 nr_hw_queues
Message-ID: <Z_2-c6qhC52Kb7dg@fedora>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-5-ming.lei@redhat.com>
 <20250410143622.GC10701@lst.de>
 <Z_xczMuX5_yDKdAs@fedora>
 <20250414060754.GA6451@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414060754.GA6451@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Apr 14, 2025 at 08:07:54AM +0200, Christoph Hellwig wrote:
> On Mon, Apr 14, 2025 at 08:54:36AM +0800, Ming Lei wrote:
> > > >  	elv_iosched_load_module(name);
> > > >  
> > > > +	idx = srcu_read_lock(&set->update_nr_hwq_srcu);
> > > > +
> > > > +	if (set->flags & BLK_MQ_F_UPDATE_HW_QUEUES) {
> > > 
> > > What provides atomicity for field modifications vs reading of set->flags?
> > > i.e. does this need to switch using test/set_bit?
> > 
> > WRITE is serialized via tag set lock with synchronize_srcu().
> > 
> > READ is covered by srcu read lock.
> > 
> > It is typical RCU usage, one writer vs. multiple writer.
> 
> No, (S)RCU does not help you with atomicy of bitfields.

OK, will change it into one state variable.


Thanks,
Ming

