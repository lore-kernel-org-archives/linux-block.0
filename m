Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D3319F
	for <linux-block@vger.kernel.org>; Mon,  3 Jun 2024 00:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717373132; cv=none; b=Ym1Cq0g0oD54jf6fQCE2VLce6mnCA4wtcPs6w16ChaFwYwanJYkXKiISetpvZ8uf6YSUBeZPZae5YmwxoszopRZsQD7YjS63Sh3E6NAQBXg/Ly3aOvkFwJDDt+83ioRbrcdf7i9R3OzTo4MFYRJQcYOk2IvYI3TA8kPPUOBQRU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717373132; c=relaxed/simple;
	bh=6r7z1Yttg9lTfJLTYa91j1L8sLxPnz6zalqk5ZRVS3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZizouQitkPYd/np+iVKjkQsNxFweUNj0I+DVtCR/jjlIMxjaVfhD2/IrO4iJPTwh/wX/nR7RASJQYwT9sYER//R/RQGLZIlB31BUfJ2e0VtjrtKl7Eo0KPS0axrz+W64Ye9Zfqd831FNidVjDNXOsOmKRVCa+ZCVbsTtEfcGkBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jI95X7Qq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jI95X7Qq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717373129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FQHZIgaB+fIyyxbrWLwLAjk5CP7G3CWBw1Ys6rmC1iM=;
	b=jI95X7QqflVBFICG+j5SBHKr3r8zIFiRW64p3ASmz+ThaCGFmRZm/R6hH3sRcCO9KO0SlF
	3l8WTnZZKZeJZ0hoWM3wIC1s5nNhy/wRZbc10FE+zBUhg67wIoBZ+JHUcw6yj8Z9uDKpaT
	mcDijgQlnVp93jMHpu7dLFR5cE+2oWQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-95tzrdCAMRCyHOP1qkNXsg-1; Sun, 02 Jun 2024 20:05:24 -0400
X-MC-Unique: 95tzrdCAMRCyHOP1qkNXsg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD03D85A58C;
	Mon,  3 Jun 2024 00:05:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 92D841054824;
	Mon,  3 Jun 2024 00:05:20 +0000 (UTC)
Date: Mon, 3 Jun 2024 08:05:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
	Kevin Wolf <kwolf@redhat.com>, Hollin Liu <hollinisme@gmail.com>
Subject: Re: [PATCH V3 0/9] io_uring: support sqe group and provide group kbuf
Message-ID: <Zl0IvMTuFfDOu3Gj@fedora>
References: <20240511001214.173711-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511001214.173711-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Sat, May 11, 2024 at 08:12:03AM +0800, Ming Lei wrote:
> Hello,
> 
> The 1st 4 patches are cleanup, and prepare for adding sqe group.
> 
> The 5th patch supports generic sqe group which is like link chain, but
> allows each sqe in group to be issued in parallel and the group shares
> same IO_LINK & IO_DRAIN boundary, so N:M dependency can be supported with
> sqe group & io link together. sqe group changes nothing on
> IOSQE_IO_LINK.
> 
> The 6th patch supports one variant of sqe group: allow members to depend
> on group leader, so that kernel resource lifetime can be aligned with
> group leader or group, then any kernel resource can be shared in this
> sqe group, and can be used in generic device zero copy.
> 
> The 7th & 8th patches supports providing sqe group buffer via the sqe
> group variant.
> 
> The 9th patch supports ublk zero copy based on io_uring providing sqe
> group buffer.
> 
> Tests:
> 
> 1) pass liburing test
> - make runtests
> 
> 2) write/pass two sqe group test cases:
> 
> https://github.com/axboe/liburing/compare/master...ming1:liburing:sqe_group_v2
> 
> - covers related sqe flags combination and linking groups, both nop and
> one multi-destination file copy.
> 
> - cover failure handling test: fail leader IO or member IO in both single
>   group and linked groups, which is done in each sqe flags combination
>   test
> 
> 3) ublksrv zero copy:
> 
> ublksrv userspace implements zero copy by sqe group & provide group
> kbuf:
> 
> 	git clone https://github.com/ublk-org/ublksrv.git -b group-provide-buf_v2
> 	make test T=loop/009:nbd/061:nbd/062	#ublk zc tests
> 
> When running 64KB block size test on ublk-loop('ublk add -t loop --buffered_io -f $backing'),
> it is observed that perf is doubled.
> 
> Any comments are welcome!
> 
> V3:
> 	- add IORING_FEAT_SQE_GROUP
> 	- simplify group completion, and minimize change on io_req_complete_defer()
> 	- simplify & cleanup io_queue_group_members()
> 	- fix many failure handling issues
> 	- cover failure handling code in added liburing tests
> 	- remove RFC

Hello Jens and Pavel,

V3 should address all your comments, would you mind to take a look at
this version?

Thanks,
Ming

