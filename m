Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2B523237C
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736756590; cv=none; b=jYszRAcwdCXTfyz/EDzoymN772PnyAeRPzVMAIs3bP9PXXJYF/FNvAS1/0FMJ/e2mx1NLJoSvWg/MjMRA3bPbYPXb2dNCeTf1BFPGfmOwuLH78+03ug5ph9GKzd3eGGN3PhOiTu1nByOWP9/Jm2fmqWCBp07vdhVE8AB0PcmEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736756590; c=relaxed/simple;
	bh=/HC/w7F2ShPZMkZNrCCCYt5w9g9LTuFPunCm31V9P+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJXYMuSmUtta4oLMT8ywty/YdGmJDTDAwbY5PMnxDEiCAPVFA49UJI87cTjcUurbIoHZSLvooshgqgqZqNs2zbPh+0Lrt3aM6p4z+5W3hUSPGhVqEwelOBTVqdszEGYYrMoQeJXLlcTZCtYs5QUYaCfrObyIG8HZeWWUPeK/oCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8aqmA0o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8aqmA0o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736756587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gTlivx8Egr6tYdQampClg14FCqdSDAST3SdF+HthHss=;
	b=L8aqmA0onmlsMjfFId+8AOW18hXSZawL89MfDdfOTRy/PSPXNqBUaHRwkD1LPY4t/WHdg0
	GkdCYmHf+RZfIMIFQMQtGLdEUetaWD08VTsldKiWxPL0nEFhFnaStuqplqdQUu1og8LMWX
	uwqc4hTc1TuyvkZdQkyOSB8CCxQ0v3M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-LdkO5Xz6MwKdx_r93yqguQ-1; Mon,
 13 Jan 2025 03:23:04 -0500
X-MC-Unique: LdkO5Xz6MwKdx_r93yqguQ-1
X-Mimecast-MFC-AGG-ID: LdkO5Xz6MwKdx_r93yqguQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CE5619560AA;
	Mon, 13 Jan 2025 08:23:01 +0000 (UTC)
Received: from fedora (unknown [10.72.116.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8F6619560AD;
	Mon, 13 Jan 2025 08:22:56 +0000 (UTC)
Date: Mon, 13 Jan 2025 16:22:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>
Subject: Re: [PATCH] loop: don't call vfs_flush() with queue frozen
Message-ID: <Z4TNW2PYyPUqwLaD@fedora>
References: <20250113022426.703537-1-ming.lei@redhat.com>
 <Z4Spc75EiBXowzMu@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4Spc75EiBXowzMu@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Sun, Jan 12, 2025 at 09:49:39PM -0800, Christoph Hellwig wrote:
> On Mon, Jan 13, 2025 at 10:24:26AM +0800, Ming Lei wrote:
> > If vfs_flush() is called with queue frozen, the queue freeze lock may be
> > connected with FS internal lock
> 
> What "FS internal lock" ?

Please see the report:

https://lore.kernel.org/linux-block/359BC288-B0B1-4815-9F01-3A349B12E816@m.fudan.edu.cn/T/#u

> 
> > , and potential deadlock could be
> > triggered.
> > 
> > Fix it by moving vfs_flush() out of queue freezing.
> 
> That doesn't work.  The pagecache will be dirties by any command
> processed using buffered I/O, so we need to freeze first to ensure
> that there are no outstanding commands.

vfs_flush() is called in case of previous buffered IO for flushing dirty
pages.

The call from loop_change_fd() has been broken, because ->lo_backing_file
is updated to new one when calling loop_update_dio(), and I will cover
this case in V2.

For others in which backing file isn't changed, the patch is just fine
in case of new buffered IO mode, isn't it?


Thanks,
Ming

