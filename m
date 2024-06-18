Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F257848D
	for <linux-block@vger.kernel.org>; Tue, 18 Jun 2024 02:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718676727; cv=none; b=XHJm6YVzttBqKU2XS3e8z9+HTjgG0Me6VClfNT2mInaCpnWvyw387gUXbYg1+iauf8LNrxJs6716jSeLQgow5MnEUDcz5K5yv0tqrte1RPx/zCR8Kgh9f49YvaHzO2lHlOtnWOYRlTX30SWwAIHX15f1iwwhABawoS55CeN9aSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718676727; c=relaxed/simple;
	bh=zFrpeu6AbICHbaSPlg/hRH9auVFy/sdbDDujClEkYHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFyQ5q7gdi4BTh8VqJybvBVMdglTvlz/9RPy8pDDiuk24u3aM6u91VwqrPs+qvvY/BRVAI//7B0gbaM8vvSBbWrJ2ZcLNsSvqrm/Qv9aBqL0N38vg8YXr4TQAp4mDDVPpSDkKtiCoVymcEeQGhvqTyDueqL+G2PCbzFXeWsjEz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5LIGyQe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5LIGyQe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718676724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/lTYCoRKMMo1EeW95bAsXwqnYlCChDryMr6+xmdd00=;
	b=b5LIGyQeIcXj2irQNq2ymdNpDn3/sKbRbtS/p0h8ntxIQJF5omkU6xYXTgKCN6vX+1UXS3
	1Tzu0PPrM70sZMsfN9G32ZfNSnkm7zv6hqwlpmn5BxGUK1kFjbo8DGenQUGd40xso9zIc9
	TiR2xVKnUkjleKsx2HrpkSycByGNQW4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-8NwKDRDGMPe8k05diRso6A-1; Mon,
 17 Jun 2024 22:12:01 -0400
X-MC-Unique: 8NwKDRDGMPe8k05diRso6A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F891195609F;
	Tue, 18 Jun 2024 02:12:00 +0000 (UTC)
Received: from fedora (unknown [10.72.112.49])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC18A1956087;
	Tue, 18 Jun 2024 02:11:56 +0000 (UTC)
Date: Tue, 18 Jun 2024 10:11:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] ublk: refactor recovery configuration flag helpers
Message-ID: <ZnDs5zLc5oA1jPVA@fedora>
References: <20240617194451.435445-1-ushankar@purestorage.com>
 <20240617194451.435445-3-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617194451.435445-3-ushankar@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Jun 17, 2024 at 01:44:49PM -0600, Uday Shankar wrote:
> ublk currently supports the following behaviors on ublk server exit:
> 
> A: outstanding I/Os get errors, subsequently issued I/Os get errors
> B: outstanding I/Os get errors, subsequently issued I/Os queue
> C: outstanding I/Os get reissued, subsequently issued I/Os queue
> 
> and the following behaviors for recovery of preexisting block devices by
> a future incarnation of the ublk server:
> 
> 1: ublk devices stopped on ublk server exit (no recovery possible)
> 2: ublk devices are recoverable using start/end_recovery commands
> 
> The userspace interface allows selection of combinations of these
> behaviors using flags specified at device creation time, namely:
> 
> default behavior: A + 1
> UBLK_F_USER_RECOVERY: B + 2
> UBLK_F_USER_RECOVERY|UBLK_F_USER_RECOVERY_REISSUE: C + 2

ublk is supposed to support A, B & C for both 1 and both 2, but it may
depend on how ublk server is implemented.

In cover letter, it is mentioned that "A + 2 is a currently unsupported
behavior", can you explain it a bit? Such as, how does ublk server
handle the I/O error? And when/how to recover? why doesn't this way
work?

For example, one rough way is to kill the daemon in case of A, then recovery
can be started and new daemon is created for handling IO.

But we are open to improve this area to support more flexible ublk
server implementation.

Thanks,
Ming

