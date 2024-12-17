Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61881607AC
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734420626; cv=none; b=Bpal8hQS3EuzJPRDKWb1r5Ymbgck6qUvAHJ9eYnsFkBd13jRcXsB4yyMcPuVnnVuQ6gNK5PQQLZ2IxzPeRn9i8qKSQg4+3uIgA9vJIrHgIItV8KXQt/jmOTtRcGjgGrPozJ+QTIxnXB8iAwaPT6aocsekVza/AsPdRAD4lL/pBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734420626; c=relaxed/simple;
	bh=kwGIz6L2vJ7iFxsoYHSav+90OoQXIPO2jxpoPFLRsnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KN3f9b4ErGbk0aEFz0laf20x0NEJZmpX/PyuzfkR+ktU7kEnrLLYMkp6pIOMDhIfkueLyW5SM/McIjJ8Pa+MKGIosJQ3j+f5eG6hTho5rogOyQiJO3fk/prK9dWw3rshshwOLHxsA3t2wDI+yyjunHaY7hE7q/KHIWXtJppYzsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D7meyQN5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7meyQN5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734420622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cyCnkMw2za2BRtvTxjpso1AKI6hVmxjTcrmdwWKyib4=;
	b=D7meyQN5ADJgwlT67TFI01+1ikf591J4fhMda8iUMW6hsLSkZiRwCFyBcyvL/JLkYSZH/E
	p9nW9E5rcAItvtm29yr6BcFzwW3uR24B7SuKQIh6afBSdlUoKGCt7srfMupDsYdJoCjH6o
	VE3dOBwDwl3QYAMH9F115/FYg9hokAw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-0Bm-RbIrOie5HZHtGVoZQA-1; Tue,
 17 Dec 2024 02:30:21 -0500
X-MC-Unique: 0Bm-RbIrOie5HZHtGVoZQA-1
X-Mimecast-MFC-AGG-ID: 0Bm-RbIrOie5HZHtGVoZQA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F6F919541A9;
	Tue, 17 Dec 2024 07:30:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.165])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C70FF19560AD;
	Tue, 17 Dec 2024 07:30:16 +0000 (UTC)
Date: Tue, 17 Dec 2024 15:30:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: avoid to hold q->limits_lock across APIs for
 atomic update queue limits
Message-ID: <Z2Eog2mRqhDKjyC6@fedora>
References: <20241216080206.2850773-1-ming.lei@redhat.com>
 <20241216080206.2850773-2-ming.lei@redhat.com>
 <20241216154901.GA23786@lst.de>
 <Z2DZc1cVzonHfMIe@fedora>
 <20241217044056.GA15764@lst.de>
 <Z2EizLh58zjrGUOw@fedora>
 <20241217071928.GA19884@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217071928.GA19884@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Dec 17, 2024 at 08:19:28AM +0100, Christoph Hellwig wrote:
> On Tue, Dec 17, 2024 at 03:05:48PM +0800, Ming Lei wrote:
> > On Tue, Dec 17, 2024 at 05:40:56AM +0100, Christoph Hellwig wrote:
> > > On Tue, Dec 17, 2024 at 09:52:51AM +0800, Ming Lei wrote:
> > > > The local copy can be updated in any way with any data, so does another
> > > > concurrent update on q->limits really matter?
> > > 
> > > Yes, because that means one of the updates get lost even if it is
> > > for entirely separate fields.
> > 
> > Right, but the limits are still valid anytime.
> > 
> > Any suggestion for fixing this deadlock?
> 
> What is "this deadlock"?

The commit log provides two reports:

- lockdep warning

https://lore.kernel.org/linux-block/Z1A8fai9_fQFhs1s@hovoldconsulting.com/

- real deadlock report

https://lore.kernel.org/linux-scsi/ZxG38G9BuFdBpBHZ@fedora/

It is actually one simple ABBA lock:

1) queue_attr_store()

      blk_mq_freeze_queue(q);					//queue freeze lock
      res = entry->store(disk, page, length);
	  			queue_limits_start_update		//->limits_lock
				...
				queue_limits_commit_update
      blk_mq_unfreeze_queue(q);

2) sd_revalidate_disk()

queue_limits_start_update					//->limits_lock
	sd_read_capacity()
		scsi_execute_cmd
			scsi_alloc_request
				blk_queue_enter					//queue freeze lock


Thanks,
Ming

