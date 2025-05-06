Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9934D221297
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 02:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746497629; cv=none; b=sq05y2p775KjYm0H7NAcNyhKZqoDP+D+/4vuq6TXeuss1ywHAEu/UJ1Jt+kNC2lgxSrZ7vJ9YEEV3h1PAwwD9z068vXZwwJ7fu9swlp7uV5/MIWtBWH9ovTZ/J7SAs7pgDnQ62FMvCj15wLA9sxLGhfWZFjXrS5siuoRSSwGw/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746497629; c=relaxed/simple;
	bh=pGHuY53mTIBAsi0F04ITJ3ONgN0kSqoNs7XhlwNe12A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peIP49Rio4MKO/k+S+obV+e/YDmPvVlszjrDi1e5f+xkEHQ6TLN8BA8spJdfriWGhxMMcmkjsej+J+54gCzC46qYSpCLNhjZuuyudxbcjcRt2WgI5QGMTFOPBuEo0FdMMz9p2t9vBF6COiMCiwI/y7UdEZ9ms5ZWRaod3zBjHn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WldYqO2x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WldYqO2x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746497626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eVL8gs3Yhq/srlGDSTgjUKW/IXRRnfqHKmU0Evzgiyo=;
	b=WldYqO2xwGEjvmnRQU1FMD4f/3kSGTEFHeN9S8owg0kv+VjmX0WXiZrzMWXUUh5iXeyRVV
	UMHOrzP8MP7DWQNjErdmXQ261wFUDXu22Fg+imcDpKdJcRtsrBtMwBIq5Em7YbE6Cg9Z/G
	q7pra/MDbZ++OBIs944g42StGvl66zE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-JiHRFEOyMwWsqglsWnNmGQ-1; Mon,
 05 May 2025 22:13:43 -0400
X-MC-Unique: JiHRFEOyMwWsqglsWnNmGQ-1
X-Mimecast-MFC-AGG-ID: JiHRFEOyMwWsqglsWnNmGQ_1746497622
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D78B1800983;
	Tue,  6 May 2025 02:13:42 +0000 (UTC)
Received: from fedora (unknown [10.72.116.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9038C30001AB;
	Tue,  6 May 2025 02:13:39 +0000 (UTC)
Date: Tue, 6 May 2025 10:13:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jared Holzman <jholzman@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: Port to 6.14-stable - ublk: fix race between
 io_uring_cmd_complete_in_task and ublk_cancel_cmd
Message-ID: <aBlwTtmeZErD4gnH@fedora>
References: <9a10100c-9d76-4522-9f6c-d0a6ad32ca81@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a10100c-9d76-4522-9f6c-d0a6ad32ca81@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, May 05, 2025 at 07:06:37PM +0300, Jared Holzman wrote:
> Hi Ming,
> 
> I'm attempting to back port the fix for this issue to the 6.14-stable branch.
> 
> Greg Kroah-Hartman has already applied d6aa0c178bf8 - "ublk: call ublk_dispatch_req() for handling UBLK_U_IO_NEED_GET_DATA",
> but was unable to apply f40139fde527 cleanly.
> 
> I created the patch below. It applies and compiles, but when I rerun the scenario I get several hung tasks waiting on the ub->mutex
> which is being held by the following task:

Hi Jared,

You need to pull in the following patchset too:

https://lore.kernel.org/linux-block/20250416035444.99569-1-ming.lei@redhat.com/

which avoids ub->mutex in error handling code path.

I just picked them in the following tree:

https://github.com/ming1/linux/commits/linux-6.14.y/

Please test and see if they work for you.


Thanks,
Ming

