Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A22DC791
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779789; cv=none; b=V/Nf/P1c3GCNj6SmOvRCZs9CgtU/SIGyQd888qCFiWXU7HCwo/sCvDTOBlHPiziu1VCqzrXbhFaNjC7edH1SCx7sGvwfh+GTbZYjIDSgH3b8GAJuhqswtAtvxRHI34AYy+4oAa6E6mCrW7Shcntj4YhXE3JJ7+T0laDynsA3ifY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779789; c=relaxed/simple;
	bh=ocPchDHCpM0fEcO1m4uMIU73bSBCGaFF02MvFfrskp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/iPkBbUGGndCyYZ43TK2V4w/hTCg5JLfgq8CW6H8CnA75YGq/bdrlBqQMZnlwPoUvC213/fSxhxHLyFL36armrdECy41FztFto059LdglDM6pI/jFB0a3TNPdqWT6Oj1ZuN/DFJtf3S97aKCeiioPd8WWU+TPlL7jUcaLy5Plw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iv3bMIFx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iv3bMIFx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767779786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=510+ECMXwKSqA8eBlVMpMsZ1/r3QZo+C+DoikHrTyRM=;
	b=Iv3bMIFxNQ0FYBX1CaDRD9cFCgPMveZhC4OhrqEP9VaOsx0zoPz88DRfKxTxKkp+t8oExe
	XKv2I5nNzKqMJ0w6duPHxD2TXnLF2HsGdigUgbrYEsRfZ+usx1YsPemD/Aaf2to5un5xu7
	m83GNF/3N++DugmMW29pU1BWjqNk7NU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-Pp7vbYWmOnGj4mC6NhWjRw-1; Wed,
 07 Jan 2026 04:56:23 -0500
X-MC-Unique: Pp7vbYWmOnGj4mC6NhWjRw-1
X-Mimecast-MFC-AGG-ID: Pp7vbYWmOnGj4mC6NhWjRw_1767779782
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34D8F195608D;
	Wed,  7 Jan 2026 09:56:22 +0000 (UTC)
Received: from fedora (unknown [10.72.116.199])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0AC018004D8;
	Wed,  7 Jan 2026 09:56:18 +0000 (UTC)
Date: Wed, 7 Jan 2026 17:56:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
	nilay@linux.ibm.com
Subject: Re: [PATCH v7 08/16] blk-mq-debugfs: warn about possible deadlock
Message-ID: <aV4tvN3RwzkRx0is@fedora>
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-9-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231085126.205310-9-yukuai@fnnas.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Dec 31, 2025 at 04:51:18PM +0800, Yu Kuai wrote:
> Creating new debugfs entries can trigger fs reclaim, hence we can't do
> this with queue frozen, meanwhile, other locks that can be held while
> queue is frozen should not be held as well.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

