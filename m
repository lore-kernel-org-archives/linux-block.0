Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2173218A6A9
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 02:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741055005; cv=none; b=j04LIpwg1Agc6lCXIHEW5EgH0nBjlrmWlM1+ILELO7Sn1C54d6QK7svpEHczr8bqFU2B6hBHwdXBmCc4mfqX/KWl+nF2tQlq7HUXWH7Rpis7xtK2vpVhea9Hp3jOnr+veWBuMFZqCARE/ZCew4QeqaLzUsc9RrGS8ODVo4VB+Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741055005; c=relaxed/simple;
	bh=KD3PFudT5ot0lEJOZeMQkZLIzGWsbE8WX2UX1fHlT84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7Dty5L4cN14fNlAxcmmO2Jf04kflUOg9fJoaraWNgbxYf2nWzQyMD/GW5iJizDs3AS+df7/AFEUaI7lVndyA+8YnOuJ4EVF08TkEutcxnxG2MMUGScNXUffUiFWjX598M7tRK80lTNFDme0U2PL3/4LWLoiLmKwCSDu4vr8/D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6MxmzM8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6MxmzM8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741055002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KtxLzgDSzyKBzeMILSzTwx+Ssg/ZxVNMljJXENBZuyM=;
	b=M6MxmzM8noW4r45T1t79bBXt0brpeyHD/npyv/4uxfIbk1kiXtiHLu1JdsIrkP47105NB3
	te0226LqE+2mhLZJpbOUOGSvkGTaHqnCj3nlJixRzVncak06J/hMRQmzoKF7ELllj3FxRP
	a9+WNoF+MmpgZCHo3aiadRmAVUu0LaA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-fMDhIt1dPKa2zIoNKGDLJg-1; Mon,
 03 Mar 2025 21:23:14 -0500
X-MC-Unique: fMDhIt1dPKa2zIoNKGDLJg-1
X-Mimecast-MFC-AGG-ID: fMDhIt1dPKa2zIoNKGDLJg_1741054993
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1132718004A7;
	Tue,  4 Mar 2025 02:23:13 +0000 (UTC)
Received: from fedora (unknown [10.72.120.26])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBEF3180087B;
	Tue,  4 Mar 2025 02:23:07 +0000 (UTC)
Date: Tue, 4 Mar 2025 10:23:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, dlemoal@kernel.org,
	hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv5 4/7] block: introduce a dedicated lock for protecting
 queue elevator updates
Message-ID: <Z8ZkBiL84hon16mD@fedora>
References: <20250226124006.1593985-1-nilay@linux.ibm.com>
 <20250226124006.1593985-5-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226124006.1593985-5-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Feb 26, 2025 at 06:09:57PM +0530, Nilay Shroff wrote:
> A queue's elevator can be updated either when modifying nr_hw_queues
> or through the sysfs scheduler attribute. Currently, elevator switching/
> updating is protected using q->sysfs_lock, but this has led to lockdep
> splats[1] due to inconsistent lock ordering between q->sysfs_lock and
> the freeze-lock in multiple block layer call sites.
> 
> As the scope of q->sysfs_lock is not well-defined, its (mis)use has
> resulted in numerous lockdep warnings. To address this, introduce a new
> q->elevator_lock, dedicated specifically for protecting elevator
> switches/updates. And we'd now use this new q->elevator_lock instead of
> q->sysfs_lock for protecting elevator switches/updates.
> 
> While at it, make elv_iosched_load_module() a static function, as it is
> only called from elv_iosched_store(). Also, remove redundant parameters
> from elv_iosched_load_module() function signature.
> 
> [1] https://lore.kernel.org/all/67637e70.050a0220.3157ee.000c.GAE@google.com/
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

