Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0EF184
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 04:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745294466; cv=none; b=kd33bef0qWv9eAMuvBZhNKBBccdWoCkr5fu2U1HeNF2mtew8M1CRzHo31wG+SBM8F7N60e6y4x6B+mByfylN42/sw4UL69oTy/HUQ4b8isvABsBGop5yecmsLe8LrVFhM+qoQrruk26Vf9goyKUils+vUjNIMFrhM1swUOVpDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745294466; c=relaxed/simple;
	bh=ZkM7JYyguEpw7xe+F0jM1C4lvJTZzqcTcU6c7dDvWnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6ZvsaSCTrXJ370/zH2y9w6Hg3oJrDoFfFcWtKZOuRqpZY/RsRur7n2141iUzmxUggNSn3bM5MHh7cgrXFREhEGjF4/fGK26gMflzC8K0OGB8uf1R7ca9E4rHteP6b1ZY9yavX4sKcjCCDsrmKox8vBinKqdjKKUk+hTqMaH0z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QhJviZ6G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhJviZ6G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745294460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EJ1QnSCTk6HYUjkLoRgNBKcnk2YBAMYB1iPneN53MlU=;
	b=QhJviZ6GrwL0ICDQGYDGz1RZaalWE7kraov9GWgfF+8yNO6jRbeOCb7NdWka1KKxRPiuFl
	oizpEtTKgN80om16l6eLaeB7wfF/nNOg7gU51ckHPc9g+vpjjxdRaWyRrgRNwIkovIs7F7
	+aYB/18OmU+7gjUwL6qkcxq6hwRI1Dg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-RR_FrDJXNfa8IZmveUgi-A-1; Tue,
 22 Apr 2025 00:00:56 -0400
X-MC-Unique: RR_FrDJXNfa8IZmveUgi-A-1
X-Mimecast-MFC-AGG-ID: RR_FrDJXNfa8IZmveUgi-A_1745294454
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F272180056F;
	Tue, 22 Apr 2025 04:00:54 +0000 (UTC)
Received: from fedora (unknown [10.72.116.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69BBF195608F;
	Tue, 22 Apr 2025 04:00:48 +0000 (UTC)
Date: Tue, 22 Apr 2025 12:00:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH V2 03/20] block: don't call freeze queue in
 elevator_switch() and elevator_disable()
Message-ID: <aAcUbMjt7QdBx3eS@fedora>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-4-ming.lei@redhat.com>
 <20250421123456.GC24038@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421123456.GC24038@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Apr 21, 2025 at 02:34:56PM +0200, Christoph Hellwig wrote:
> On Sat, Apr 19, 2025 at 12:36:44AM +0800, Ming Lei wrote:
> > Both elevator_switch() and elevator_disable() are called from sysfs
> > store and updating nr_hw_queue code paths only.
> 
> I don't understand this sentence.  What does
> "and updating nr_hw_queue code paths only" mean?

Both two are only called from the two code paths, in which queue is
guaranteed to be frozen.


Thanks,
Ming

