Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E632123BB
	for <linux-block@vger.kernel.org>; Fri, 11 Oct 2024 02:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728613855; cv=none; b=qxH7FNMz1eCk3cu1/nJZfQ03YS2G2hqluGkNHkr77n6MVdolVuA2TSJ7aW6+NL800O2cqqEWKcmOeTIXcgzO+NN1nuquQI76CwpZTomR06SpkkzjDLIOr+kqI7a3/oozttlG1LKiFpsu9kR0rW5zin9Uzq4HZj2zRXgrQ+yTaAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728613855; c=relaxed/simple;
	bh=XTor+vWsJcNTslL3wHRA9CpfyzV3VEEvaLTpotKbCYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlAGwzLHuSgld9HztHeMDcpjjeQSyHv17a8/9qdXQfuVF9+x6BbhY1/AO32G/GpOox9knJf9QYxgyKzu7Bjo7BZzMOfRLUGzlCtSnF81lVMAU3dRladyfa78zyyJEfjPN1MLkgRJXili1jFfu9WrqHW0FTnZsh2U0VWw2wIAoGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eXZ0K5X4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXZ0K5X4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728613851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j2RwKah2dclBo6wIv+Ov0iX6SiF/+MMToA3jHFFUR4M=;
	b=eXZ0K5X4Wqv+53OVglCYZ9OT9g64LGQH6zNMET1vxUSo/CvcLd4Pb4QjtDpxjvzFhG8ulu
	LR2E6jd54z23t/xa+eDFJ5+IP+zUH6SejlLDsCTK1gOiNruYWiFqplvwK6KJWccBHgEc9j
	cx4HirOuaasNY7ImEm+TsYAgSlNH9q0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-0QXbca8iMSeKOnPKPWah5w-1; Thu,
 10 Oct 2024 22:30:50 -0400
X-MC-Unique: 0QXbca8iMSeKOnPKPWah5w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 751581955EA7;
	Fri, 11 Oct 2024 02:30:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.103])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D657119560A2;
	Fri, 11 Oct 2024 02:30:45 +0000 (UTC)
Date: Fri, 11 Oct 2024 10:30:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH V6 7/8] io_uring/uring_cmd: support provide group kernel
 buffer
Message-ID: <ZwiN0Ioy2Y7cfnTI@fedora>
References: <20240912104933.1875409-1-ming.lei@redhat.com>
 <20240912104933.1875409-8-ming.lei@redhat.com>
 <b232fa58-1255-44b2-92c9-f8eb4f70e2c9@gmail.com>
 <ZwJObC6mzetw4goe@fedora>
 <38ad4c05-6ee3-4839-8d61-f8e1b5219556@gmail.com>
 <ZwdJ7sDuHhWT61FR@fedora>
 <4b40eff1-a848-4742-9cb3-541bf8ed606e@gmail.com>
 <655b3348-27a1-4bc7-ade7-4d958a692d0b@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <655b3348-27a1-4bc7-ade7-4d958a692d0b@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Jens,

On Thu, Oct 10, 2024 at 01:31:21PM -0600, Jens Axboe wrote:
> Hi,
> 
> Discussed this with Pavel, and on his suggestion, I tried prototyping a
> "buffer update" opcode. Basically it works like
> IORING_REGISTER_BUFFERS_UPDATE in that it can update an existing buffer
> registration. But it works as an sqe rather than being a sync opcode.
> 
> The idea here is that you could do that upfront, or as part of a chain,
> and have it be generically available, just like any other buffer that
> was registered upfront. You do need an empty table registered first,
> which can just be sparse. And since you can pick the slot it goes into,
> you can rely on that slot afterwards (either as a link, or just the
> following sqe).
> 
> Quick'n dirty obviously, but I did write a quick test case too to verify
> that:
> 
> 1) It actually works (it seems to)

It doesn't work for ublk zc since ublk needs to provide one kernel buffer
for fs rw & net send/recv to consume, and the kernel buffer is invisible
to userspace. But  __io_register_rsrc_update() only can register userspace
buffer.

Also multiple OPs may consume the buffer concurrently, which can't be
supported by buffer select.


thanks, 
Ming

