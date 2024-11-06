Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA1818DF81
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 03:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730862699; cv=none; b=KT514m+Ndzeag1aMqes//+479/YpJsvkxFysb8Bf/SBzgytj+0E3zGcgmtX4EThCVbQqa9I0Qn+gSLhOfKsIJrye9esHUZI1OGalUha99Z0ccmRxo5g4SQcy4c53cvTm7jNjZrGSeF+ENEVF1JEPVBEZ+NM6ij6x8hDNtN4VYaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730862699; c=relaxed/simple;
	bh=3fEoyIGYwrvpkvL3MwyMS96ylSKFk+L791VUrhdtKtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtSWEewoRED8AV18oP62Wb7uZIW0VECTRAenfyhiRDMrYia5bFlhEzVTLr8pwtGL47Wf0agnrrhOJqYpvtwdfDvBctrvM15LPDOi27fHs8y9f51QMjfiJpyAIvbLbS3iX7m+GHUKuC7+fLApTDtEFGyi4oc5dmrhw7O4viqGAUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WIGFPCjT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIGFPCjT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730862696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ATNSNbRxtKD0jEclTRwjW2lWzrhsUGqyg1WtrFfV64s=;
	b=WIGFPCjT80rVsuZRVKnVthAy35TrOSQJRc6WLzJCD75shaFjjwL3cyA7s5vvOCr7UuEJox
	2SMhekFQoXfXN8HVFZWWHrupCyGybFg03G2+NbV5ifd1rjpPKS8GR1CmX1smPRe+cp4Rk6
	oq+kNKeg/8DnAKNf7wqykOxHEkKjG0U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-5vl56TXAPhq21gP4rwdtww-1; Tue,
 05 Nov 2024 22:11:31 -0500
X-MC-Unique: 5vl56TXAPhq21gP4rwdtww-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F26D1955EAA;
	Wed,  6 Nov 2024 03:11:29 +0000 (UTC)
Received: from fedora (unknown [10.72.116.96])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D37219541A5;
	Wed,  6 Nov 2024 03:11:22 +0000 (UTC)
Date: Wed, 6 Nov 2024 11:11:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next] block: fix uaf for flush rq while iterating tags
Message-ID: <ZyreVTWn2no-WCC3@fedora>
References: <20241104110005.1412161-1-yukuai1@huaweicloud.com>
 <Zyn_RGV2i9COvNQl@infradead.org>
 <217f242b-b4e2-89f7-3b0f-3337c251a603@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <217f242b-b4e2-89f7-3b0f-3337c251a603@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Nov 06, 2024 at 10:58:40AM +0800, Yu Kuai wrote:
> Hi,Ming and Christoph
> 
> 在 2024/11/05 19:19, Christoph Hellwig 写道:
> > On Mon, Nov 04, 2024 at 07:00:05PM +0800, Yu Kuai wrote:
> > > From: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > blk_mq_clear_flush_rq_mapping() is not called during scsi probe, by
> > > checking blk_queue_init_done(). However, QUEUE_FLAG_INIT_DONE is cleared
> > > in del_gendisk by commit aec89dc5d421 ("block: keep q_usage_counter in
> > > atomic mode after del_gendisk"), hence for disk like scsi, following
> > > blk_mq_destroy_queue() will not clear flush rq from tags->rqs[] as well,
> > > cause following uaf that is found by our syzkaller for v6.6:
> > 
> > Which means we leave the flush request lingering after del_gendisk,
> > which sounds like the real bug.  I suspect we just need to move the
> > call to blk_mq_clear_flush_rq_mapping so that it is called from
> > del_gendisk and doesn't leave the flush tag lingering around.
> > 
> 
> This remind me that del_gendisk is still too late to do that. Noted that
> flush_rq can acquire different tags, so if the multiple flush_rq is done
> and those tags are not reused, the flush_rq can exist in multiple
> entries in tags->rqs[]. The consequence I can think of is that iterating
> tags can found the same flush_rq multiple times, and the flush_rq can be
> inflight.

How can that be one problem?

Please look at

commit 364b61818f65 ("blk-mq: clearing flush request reference in tags->rqs[]")
commit bd63141d585b ("blk-mq: clear stale request in tags->rq[] before freeing one request pool")

and understand the motivation.

That also means it is just fine to delay blk_mq_clear_flush_rq_mapping()
after disk is deleted.

Thanks,
Ming

