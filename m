Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9D210E0
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744848252; cv=none; b=PgzJbMErFQeyTDNi6JjZG5a1kUH9tHIUT4hM1pw5LenggGWdiLkaNIL1ILPcuwmAc4uFzxQ6Uk4B77d4UBJmxEm7CbfTTusnuwmWZpCDTTwXjBPwPHlEDWD6RKmtURwCezUDVnxz1oJ1/E0tESQ9UkN3w6V9E8n6S0E6qUHnASU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744848252; c=relaxed/simple;
	bh=uIn/7th2wUcitwfmOg3RJzeFwuykIUsAhKN36nS47o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmoDUYFZB+bHJnaKCntDZZLcEEQgf2QA9Ltl458HzyN9wWZtfr1qyg8a1OAtmiq7kM7CK7t60fv0HHGszKBUPyFFfeviQThBmyldi6yikabmzM4WNL1Lh9ggMvu1Nwj+gQQw2rpEjJCkBvKoDQMtnQdM8zm+7uuV2EyCrIh4I9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dmMt3As9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmMt3As9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744848249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gBMBkAZr+FQ2q4SCLnikyll76U7vKb/WiicaJuxJd+M=;
	b=dmMt3As9dCcRO7nIOgSeq/wpq6j8j9CWgtB3xgDXCleZkKl4W4rMKtAT3DjS2nx/KOnJts
	I16nFZe8okyQTuBcgDXy3nwW1p9V2OGiZ22ccCXMWBLLTFH+Jcd9A3wEaPUxDf54O8OJDp
	+33DOa8SVf2O1fwdYz7RW2p3Gk0rjg4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-DCSeCLOdMhyOqkVOSkZHpQ-1; Wed,
 16 Apr 2025 20:04:05 -0400
X-MC-Unique: DCSeCLOdMhyOqkVOSkZHpQ-1
X-Mimecast-MFC-AGG-ID: DCSeCLOdMhyOqkVOSkZHpQ_1744848244
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AD8119560AF;
	Thu, 17 Apr 2025 00:04:04 +0000 (UTC)
Received: from fedora (unknown [10.72.116.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D27161800352;
	Thu, 17 Apr 2025 00:04:00 +0000 (UTC)
Date: Thu, 17 Apr 2025 08:03:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V2 0/8] ublk: simplify & improve IO canceling
Message-ID: <aABFa1Eqzy-FAwoD@fedora>
References: <20250416035444.99569-1-ming.lei@redhat.com>
 <4c922dc0-b76a-456d-9760-5cec6f12629d@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c922dc0-b76a-456d-9760-5cec6f12629d@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Apr 16, 2025 at 12:45:39PM -0600, Jens Axboe wrote:
> On 4/15/25 9:54 PM, Ming Lei wrote:
> > Hello,
> > 
> > Patch 1st ~ 7th simplifies & improves IO canceling when ublk server daemon
> > is exiting by taking two stage canceling:
> > 
> > - canceling active uring_cmd from its cancel function
> > 
> > - move inflight requests aborting into ublk char device release handler
> > 
> > With this way, implementation is simplified a lot, meantime ub->mutex is
> > not required before queue becomes quiesced, so forward progress is
> > guaranteed.
> > 
> > This approach & main implementation is from Uday's patch of
> > "improve detection and handling of ublk server exit".
> > 
> > The last patch is selftest code for showing the improvement ublk server
> > exit, 30sec timeout is avoided, which depends on patchset of
> > "[PATCH V2 00/13] selftests: ublk: test cleanup & add more tests"[1].
> > 
> > [1] https://lore.kernel.org/linux-block/20250412023035.2649275-1-ming.lei@redhat.com/T/#medbf7024e57beaf1c53e4cef6e076421463839d0
> > 
> > Pass both ublk kernel selftests and ublksrv 'make test T=generic'.
> 
> Looks good to me - what are we targeting with this patchset? I think
> an argument could be made for 6.15, curious what you're thinking?

I am fine with either 6.15 or 6.16.


Thanks,
Ming

