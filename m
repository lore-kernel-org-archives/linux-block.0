Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB3425A2CF
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473068; cv=none; b=Rx4UyD72JbL4tteVIT8aYg3sPVBaK0/McEtIZxx6rLsF9fyhPUQljl0EjPadeMfnqu2sb+YW+aDsV9KDdpP24d0m8LwDuiYpvXppmWQET+Dwg3hOViyuUXnJAER3jsS8GNLcFvnSl/enIR+LcYQBRuWbn775fppEdtHsuT9HsFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473068; c=relaxed/simple;
	bh=uuv8ZgmpOlmJQpAdciLRDo0G8IC0mjavFEn1bxYGn4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNZB0qhHpiIlOETEbNlMRFYQuk4PBCHGX1h5/DSvpQIa4Mndjj+s3vEyo4gQgvVBbkHlutu/0cd400mC1W0nNq0km5PNCA4fRIruMkj/GXrDF9quu5t9/KkwU1F7Mivis/6eKt6maSzRYJ9ZqGQSoOthY01ZGTxjmhRoSdbyWDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XRZXPtlL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRZXPtlL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740473065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bVVrby4aLD7jcZhFshhdC7T4zMS/FfecuM4BztbogwU=;
	b=XRZXPtlLMnY2FR1LXxVHr2vLWrnZhAzs75D+6AuVEYEG263SDQAE9XS60pdPf/EUMD7nvh
	cEJbLVGD3zzLGB1LNJS8bsDD7jCIn4kSvzjJ4fTsimIFLhfo3B+eRWQ1t2IabY9KjuXdOW
	IcA+KvWckgOQkEplAtpkTrQzaUsRWpM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-ARuI5unZPv62rmLjRDnCyw-1; Tue,
 25 Feb 2025 03:44:19 -0500
X-MC-Unique: ARuI5unZPv62rmLjRDnCyw-1
X-Mimecast-MFC-AGG-ID: ARuI5unZPv62rmLjRDnCyw_1740473057
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8702F1801A16;
	Tue, 25 Feb 2025 08:44:17 +0000 (UTC)
Received: from fedora (unknown [10.72.120.31])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D385F1800965;
	Tue, 25 Feb 2025 08:44:11 +0000 (UTC)
Date: Tue, 25 Feb 2025 16:44:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: asml.silence@gmail.com, axboe@kernel.dk, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, bernd@bsbernd.com,
	csander@purestorage.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 03/11] io_uring/net: reuse req->buf_index for sendzc
Message-ID: <Z72C1uhv4uDKnIZE@fedora>
References: <20250224213116.3509093-1-kbusch@meta.com>
 <20250224213116.3509093-4-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224213116.3509093-4-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Feb 24, 2025 at 01:31:08PM -0800, Keith Busch wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> There is already a field in io_kiocb that can store a registered buffer
> index, use that instead of stashing the value into struct io_sr_msg.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

