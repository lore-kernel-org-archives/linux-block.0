Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7E1205513
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 04:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745554258; cv=none; b=GN3ixxMdMsedB5GPMqA+E653YME9OHfRJ6cGQRNAV9XWFNm69d8XjTAQb3xOctTK9TC4PlpQs0XVGOXob5JR3D6Bfh2QEllY1J1rEuaxkUirqwqMxv32TW9zcXSgM+/pzfzZyao2H6EHSCUnkIdF0a1lH48wzyGr5lxRsHlVhXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745554258; c=relaxed/simple;
	bh=D/hcbHnyMSqeD0W8JyJTl0jgD2JVlNuy3egJ++7Jmuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbcFFryQgqHo+evTng63U16JHv0DyW2RzHa+iUqKmVFBO9KZ5fx9m4/fAPYQfea+cYT2uP1MNr++HyQ2FK31OTHneW7nPBshzYAsm3wzzkTRU1q2zEENTRXFNmAPnczjjLCu5qDIzYxNgxRt//FA1xCsyCchpddonoay1kWbiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYcUegXY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYcUegXY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745554255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Saep6Q8BHgH5BzZhrQAUfvhl3egE4nte6wKx6JG6V1A=;
	b=aYcUegXYnQ1c8QViAUgsPCFHLmNuhBgesb2oI0mPviGNX435A1St+djEVJcwY4xu49yugq
	k605h+Wvd0PPzm5HaNdOnUk1L65ph5P66+6q7YSdFKtE85+ztbtxhpqLTvVAEPnNm9r9Sf
	qF1Sa7BeXUO71ukmTf4LxS58vF8uuWs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-SvhvGMGkNJm0cIzX-Mje1Q-1; Fri,
 25 Apr 2025 00:10:51 -0400
X-MC-Unique: SvhvGMGkNJm0cIzX-Mje1Q-1
X-Mimecast-MFC-AGG-ID: SvhvGMGkNJm0cIzX-Mje1Q_1745554249
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60153195609F;
	Fri, 25 Apr 2025 04:10:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 249061800378;
	Fri, 25 Apr 2025 04:10:43 +0000 (UTC)
Date: Fri, 25 Apr 2025 12:10:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Ofer Oshri <ofer@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	Jared Holzman <jholzman@nvidia.com>, Yoav Cohen <yoav@nvidia.com>,
	Guy Eisenberg <geisenberg@nvidia.com>, Omri Levi <omril@nvidia.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: ublk: RFC fetch_req_multishot
Message-ID: <aAsLPk6x0a2HUG4m@fedora>
References: <IA1PR12MB606744884B96E0103570A1E9B6852@IA1PR12MB6067.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA1PR12MB606744884B96E0103570A1E9B6852@IA1PR12MB6067.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Apr 24, 2025 at 06:19:29PM +0000, Ofer Oshri wrote:
> Hi,
> 
> Our code uses a single io_uring per core, which is shared among all block devices - meaning each block device on a core uses the same io_uring.
> 

Can I understand you are using single io_uring for serving one hw queue of
multiple ublk device?

> Let’s say the size of the io_uring is N. Each block device submits M UBLK_U_IO_FETCH_REQ requests. As a result, with the current implementation, we can only support up to P block devices, where P = N / M. This means that when we attempt to support block device P+1, it will fail due to io_uring exhaustion.
> 

Suppose N is the SQ size, the supported count of ublk device can be much bigger
than N/M, because any SQE is freed & available after it is issued to kernel, here
the SQE should be free for reuse after one UBLK_U_IO_FETCH_REQ uring_cmd is
issued to ublk driver.

That is said you can queue arbitrary number of uring_cmd with fixed SQ
size since N is just the submission batch size.

But it needs the ublk server implementation to flush queued SQE if
io_uring_get_sqe() returns NULL.

> To address this, we’d like to propose an enhancement to the ublk driver. The idea is inspired by the multi-shot concept, where a single request allows multiple replies.
> 
> We propose adding:
> 
> 1. A method to register a pool of ublk_io commands.
> 
> 2. Introduce a new UBLK_U_IO_FETCH_REQ_MULTISHOT operation, where a pool of ublk_io commands is bound to a block device. Then, upon receiving a new BIO, the ublk driver can select a reply from the pre-registered pool and push it to the io_uring.
> 
> 3. Introduce a new UBLK_U_IO_COMMIT_REQ command to explicitly mark the completion of a request. In this case, the ublk driver returns the request to the pool.  We can retain the existing UBLK_U_IO_COMMIT_AND_FETCH_REQ command, but for multi-shot scenarios, the “FETCH” operation would simply mean returning the request to the pool.
> 
> What are your thoughts on this approach?

I think we need to understand the real problem you want to address
before digging into the uring_cmd pool concept.

1) for save memory for lots of ublk device ?

- so far, the main preallocation should be from blk-mq request, and
as Caleb mentioned, the state memory from both ublk and io_uring isn't
very big

2) need to support as many as ublk device in single io_uring context with
limited SQ/CQ size ?

- it may not be one big problem because fixed SQ size allows to issue
arbitrary number of uring_cmd

- but CQ size may limit number of completed uring_cmd for notifying
incoming ublk request, is this your problem? Jens has added ring resize
via IORING_REGISTER_RESIZE_RINGS:

https://lore.kernel.org/io-uring/20241022021159.820925-1-axboe@kernel.dk/


3) or other requirement?



Thanks,
Ming

