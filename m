Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065574B1E69
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628126; cv=none; b=Nu/tZk2MiHou0tulLQxsUbRr9MeOP0yYHD9iqhnGMCvh44SIzhXNhhJMErIx5U+NdCOIorunOQufDDkhKVunMVDSu8xCpeZtklf2O4LjAbCQWgaT2xK4JD45Bs+64Y+s4CRtJ9bHalJoxY43R+wYf7crhDDUJ912tOvc8iMYHmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628126; c=relaxed/simple;
	bh=5IkEOn52PWH+k/pZj2mDofzl1o2qhwB8jftjC5MiFSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDpM2ga9Ws+iNHI/aiZXmk13cI40L0DZTUrbG+Uirpd4SSDDW40GSh4QBn5Za1yRBePomNg0z2sttfcsfGqtpobPoSi2SZeWAqMZnb5Uis1VrTvnmZnpQyZ+DaAjoStDvcw4I/aHHnvF4DZ282VcxiYK/ctRE/6qn9BIU3TYXI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFs41/oE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFs41/oE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746628123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jbLD6nmUyw0BIv1Ef4L+/kYJFDKueDDNDbNo5EPJIE=;
	b=KFs41/oEA8rw0PgcFm0GHKkndte8ztQjEhS8p9QsfmbsRjB9nkTEXDtGiyDaqqv3RUC7qm
	eHzP4MEyBKkhT8ZQOVr7WpvrU3M0Gu5yFx/c+LkIVCEJ0qXxymjI0YsPwSD9+mCJtSmyoC
	6Oao9OMAxMbs5ABosm3TjkRQyi1GhrM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-ZELZ97pTPpi40OqZvgllsA-1; Wed,
 07 May 2025 10:28:38 -0400
X-MC-Unique: ZELZ97pTPpi40OqZvgllsA-1
X-Mimecast-MFC-AGG-ID: ZELZ97pTPpi40OqZvgllsA_1746628117
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54D651800ECB;
	Wed,  7 May 2025 14:28:37 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A49C81956058;
	Wed,  7 May 2025 14:28:32 +0000 (UTC)
Date: Wed, 7 May 2025 22:28:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 1/2] block: move queue quiesce into elevator_change()
Message-ID: <aBtuCDKTQK1PReDg@fedora>
References: <20250507120406.3028670-1-ming.lei@redhat.com>
 <20250507120406.3028670-2-ming.lei@redhat.com>
 <20250507135349.GA1019@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507135349.GA1019@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, May 07, 2025 at 03:53:49PM +0200, Christoph Hellwig wrote:
> On Wed, May 07, 2025 at 08:04:02PM +0800, Ming Lei wrote:
> > blk_mq_freeze_queue() can't be called on quiesced queue, otherwise it may
> > never return if there is any queued requests.
> > 
> > Fix it by moving queue quiesce int elevator_change() by adding one flag to
> > 'struct elv_change_ctx' for controlling this behavior.
> 
> Why do we even need to quiesce the queue here, and not anywhere else?

Quiesce is for draining the in-progress critical area, which can't be
covered by queue freeze. Typically, all requests are freed, the run queue
activity isn't finished yet, so schedule data can be touched by the un-finished
code path.

We did fix this kind of bugs by queue quiesce several times.

Thanks, 
Ming

