Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696CF38FB9
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754486959; cv=none; b=Za5bzcA5RWgeeVMPfOoqwVQ6YGDEjG39Mzy0sI68+4JocwQtJfv9zCQmOMHRrlAiUrco9P+xAij0QA9p1KGihh1xI2gkGmh78kGxJp0+64V4sPKHu+BJ70xqi+odTDFfSOoi2ka+VHdYQSZOPhUGHBOZ+K5oHtx9aq7rE3vYXDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754486959; c=relaxed/simple;
	bh=izgjM9nVwRqZoAfp3GuLDtbbPs/P0xvLQWzM+uPiSuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBucSesioCF/s5ZyYAqhsxGZtIWOAgFdNEaYJ4MxYlSJWEBX5xMoZbkly3As2HC99OQjJ9FQdfLz3CX+JYW1pF8D6f0bjNMztXw/CHC+kH1GYCJDAdMRO5MQxYWun3RMS06UcB2ysHmqbvI/HF/bqWFW60IxHytI0VkKAaB4+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JjjPkIwX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjjPkIwX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754486956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gR+qI/Ob38VIe7wgkbk8/TXE1kJroPqMw/pbEOZbtVU=;
	b=JjjPkIwXbjKr2A+hDmELbsqCgXedfD6u/N9PrasAJihftYdbq8VqI17QWwojL9a5pqCtAJ
	9VeK1E57Darf7hIc2M3a7piRmBgEV3oiN2fVaRquV+82Pwf40xXRKI4+NaB9WtMuSjue67
	xhZxVxjR2lIvDD4CcJ1MNfH0asQbjxk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-Gj6Oyni_MDGmmQBNWum8WA-1; Wed,
 06 Aug 2025 09:29:13 -0400
X-MC-Unique: Gj6Oyni_MDGmmQBNWum8WA-1
X-Mimecast-MFC-AGG-ID: Gj6Oyni_MDGmmQBNWum8WA_1754486951
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F15F319560A6;
	Wed,  6 Aug 2025 13:29:10 +0000 (UTC)
Received: from fedora (unknown [10.72.116.35])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4112E180035C;
	Wed,  6 Aug 2025 13:29:05 +0000 (UTC)
Date: Wed, 6 Aug 2025 21:28:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	John Garry <john.garry@huawei.com>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 5/5] blk-mq: Replace tags->lock with SRCU for tag
 iterators
Message-ID: <aJNYmjoJsarvObBy@fedora>
References: <20250801114440.722286-1-ming.lei@redhat.com>
 <20250801114440.722286-6-ming.lei@redhat.com>
 <c86b6974-fcd6-0a96-a69a-1831f6c6d8d8@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c86b6974-fcd6-0a96-a69a-1831f6c6d8d8@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Aug 06, 2025 at 05:21:32PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/01 19:44, Ming Lei 写道:
> > Replace the spinlock in blk_mq_find_and_get_req() with an SRCU read lock
> > around the tag iterators.
> > 
> > This is done by:
> > 
> > - Holding the SRCU read lock in blk_mq_queue_tag_busy_iter(),
> > blk_mq_tagset_busy_iter(), and blk_mq_hctx_has_requests().
> > 
> > - Removing the now-redundant tags->lock from blk_mq_find_and_get_req().
> > 
> > This change improves performance by replacing a spinlock with a more
> > scalable SRCU lock, and fixes lockup issue in scsi_host_busy() in case of
> > shost->host_blocked.
> > 
> > Meantime it becomes possible to use blk_mq_in_driver_rw() for io
> > accounting.
> > 
> > Signed-off-by: Ming Lei<ming.lei@redhat.com>
> > ---
> >   block/blk-mq-tag.c | 12 ++++++++----
> >   block/blk-mq.c     | 24 ++++--------------------
> >   2 files changed, 12 insertions(+), 24 deletions(-)
> 
> I think it's not good to use blk_mq_in_driver_rw() for io accounting, we
> start io accounting from blk_account_io_start(), where such io is not in
> driver yet.

In blk_account_io_start(), the current IO is _not_ taken into account in
update_io_ticks() yet.

Also please look at 'man iostat':

    %util  Percentage  of  elapsed time during which I/O requests were issued to the device (bandwidth utilization for the device). Device
           saturation occurs when this value is close to 100% for devices serving requests serially.  But for devices serving requests  in
           parallel, such as RAID arrays and modern SSDs, this number does not reflect their performance limits.

which shows %util in device level, not from queuing IO to complete io from device.

That said the current approach for counting inflight IO via percpu counter
from blk_account_io_start() is not correct from %util viewpoint from
request based driver.


Thanks, 
Ming

