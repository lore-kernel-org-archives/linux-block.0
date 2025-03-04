Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45692B9AA
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054403; cv=none; b=a2FN1p2AUViVefwJP3iFUblUaUSxFe1x45obSWDrZSkysGJ8+QDX4jYEeFvnOplJe0xkjIYrCiDKrUAqIkFXue/K9XbW3UFIqoZram4HF5CEq08H72AQA7Dn90Xn1A9fYzEWwNp5YwUHn6gkoyrGjgXsdgzNVlgzgZX2++cEvlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054403; c=relaxed/simple;
	bh=C+CqhtUS+B5yiZWPISVHmW/0r20K1H3sqRXym4yFy08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGJdC3QeB0GYna84H2rL6R91cS5spDsYgOqOvtR+6nwPbaHFqNHvTXUbBkAMoG/lK6aYSgbpmMEhhQ3gMGdsVYctMsaIsInZzZJtqnY/ZBqM709ISWsf9QlkbBn7/5JGeyrz3L6rXVN1M8SUceURmVsuFX1qNEG2qWSnjQjwpqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GhgcHEtn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhgcHEtn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741054400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8xZAaxnYWyzg+Lcmr4Py1YO5ZB7+KkexHVbalmtrQnI=;
	b=GhgcHEtn+C3p6PMiAfacB6RLn9+YaHxvTNVW0WQs3QckA+kE2/6npcpf4NPxuh2UGVd1Gc
	AnNwVi06OKgm2B1t9mUFPMiDux5ZrFX31GkMO2wO8FvUZCk40RN7IPuT5E9tazkI6+Jako
	7MiAR129rW70ccEovfIGmLXglQW3znA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-ySjgLfD0MISn1hOxVqfDIQ-1; Mon,
 03 Mar 2025 21:13:17 -0500
X-MC-Unique: ySjgLfD0MISn1hOxVqfDIQ-1
X-Mimecast-MFC-AGG-ID: ySjgLfD0MISn1hOxVqfDIQ_1741054395
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 712621800986;
	Tue,  4 Mar 2025 02:13:15 +0000 (UTC)
Received: from fedora (unknown [10.72.120.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F67F180035F;
	Tue,  4 Mar 2025 02:13:09 +0000 (UTC)
Date: Tue, 4 Mar 2025 10:13:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, dlemoal@kernel.org,
	hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv5 3/7] block: remove q->sysfs_lock for attributes which
 don't need it
Message-ID: <Z8Zhr2oE6FPe3ycS@fedora>
References: <20250226124006.1593985-1-nilay@linux.ibm.com>
 <20250226124006.1593985-4-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226124006.1593985-4-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Feb 26, 2025 at 06:09:56PM +0530, Nilay Shroff wrote:
> There're few sysfs attributes in block layer which don't really need
> acquiring q->sysfs_lock while accessing it. The reason being, reading/
> writing a value from/to such attributes are either atomic or could be
> easily protected using READ_ONCE()/WRITE_ONCE(). Moreover, sysfs
> attributes are inherently protected with sysfs/kernfs internal locking.
> 
> So this change help segregate all existing sysfs attributes for which
> we could avoid acquiring q->sysfs_lock. For all read-only attributes
> we removed the q->sysfs_lock from show method of such attributes. In
> case attribute is read/write then we removed the q->sysfs_lock from
> both show and store methods of these attributes.
> 
> We audited all block sysfs attributes and found following list of
> attributes which shouldn't require q->sysfs_lock protection:
> 
> 1. io_poll:
>    Write to this attribute is ignored. So, we don't need q->sysfs_lock.
> 
> 2. io_poll_delay:
>    Write to this attribute is NOP, so we don't need q->sysfs_lock.
> 
> 3. io_timeout:
>    Write to this attribute updates q->rq_timeout and read of this
>    attribute returns the value stored in q->rq_timeout Moreover, the
>    q->rq_timeout is set only once when we init the queue (under blk_mq_
>    init_allocated_queue()) even before disk is added. So that means
>    that we don't need to protect it with q->sysfs_lock. As this
>    attribute is not directly correlated with anything else simply using
>    READ_ONCE/WRITE_ONCE should be enough.
> 
> 4. nomerges:
>    Write to this attribute file updates two q->flags : QUEUE_FLAG_
>    NOMERGES and QUEUE_FLAG_NOXMERGES. These flags are accessed during
>    bio-merge which anyways doesn't run with q->sysfs_lock held.
>    Moreover, the q->flags are updated/accessed with bitops which are
>    atomic. So, protecting it with q->sysfs_lock is not necessary.
> 
> 5. rq_affinity:
>    Write to this attribute file makes atomic updates to q->flags:
>    QUEUE_FLAG_SAME_COMP and QUEUE_FLAG_SAME_FORCE. These flags are
>    also accessed from blk_mq_complete_need_ipi() using test_bit macro.
>    As read/write to q->flags uses bitops which are atomic, protecting
>    it with q->stsys_lock is not necessary.
> 
> 6. nr_zones:
>    Write to this attribute happens in the driver probe method (except
>    nvme) before disk is added and outside of q->sysfs_lock or any other
>    lock. Moreover nr_zones is defined as "unsigned int" and so reading
>    this attribute, even when it's simultaneously being updated on other
>    cpu, should not return torn value on any architecture supported by
>    linux. So we can avoid using q->sysfs_lock or any other lock/
>    protection while reading this attribute.
> 
> 7. discard_zeroes_data:
>    Reading of this attribute always returns 0, so we don't require
>    holding q->sysfs_lock.
> 
> 8. write_same_max_bytes
>    Reading of this attribute always returns 0, so we don't require
>    holding q->sysfs_lock.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

