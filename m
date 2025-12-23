Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D248F30E0F0
	for <linux-block@vger.kernel.org>; Tue, 23 Dec 2025 01:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452967; cv=none; b=i35ObTaB1shdTppNYK5JHZ9aM2vEFYjy2NKM15ysJmAp8GhiAVIcWc3uN5liKOSxjBeHWNPRnh/GRknEUeA0Zpn9LN5/gJ4yzcsbXsPJVxMz62fa3QRTTNZQ0+Q+FZk4N2wbyyuB2Q09/ry40EpG6ccPNVE/tpk5TWPpAMsnu54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452967; c=relaxed/simple;
	bh=5eBPm0TA6nyP2udOPIJcJDkQtXVGsSrcTmdOy8w0faM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lli03EHP/wQVZ2zr8pCamAghNak6/PmP4e+DIT3kpJHgrtfGofazU7yNRDTxRCpxS5CDuaDGnYmU5TAl2+PsQmQjbDPFa73IUNL3voc4nsq7JqcSqcNvis6y7R3p1u8IrfliXo2tA8PWZLtahsqMrv5jdfHInjDR2S7+VMLJ3g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FYlBigxW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYlBigxW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766452964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0QIv+rEiDfd08F+MOw32Rp4Ucek9Daa5OsoIob9logs=;
	b=FYlBigxWMlCrrsApt1FgfUzvK09T3jRyJjsKa03YD/gKc82tkMDJkVXm3gwmvMfmxue9wI
	tlExEIIYP9hKYn4/bU4lnkbG9SZmLcC92Um4Iz4ro9jJfaPLkB4+00S1djpUNkDm2S6KcE
	pSCvJwVBAT6VBZTKT2cn17ihfgG4a08=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-97rey7fJM5KKeSLw_q3uTA-1; Mon,
 22 Dec 2025 20:22:41 -0500
X-MC-Unique: 97rey7fJM5KKeSLw_q3uTA-1
X-Mimecast-MFC-AGG-ID: 97rey7fJM5KKeSLw_q3uTA_1766452959
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D2B019560B2;
	Tue, 23 Dec 2025 01:22:39 +0000 (UTC)
Received: from fedora (unknown [10.72.116.97])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29BC9180045B;
	Tue, 23 Dec 2025 01:22:33 +0000 (UTC)
Date: Tue, 23 Dec 2025 09:22:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Ionut Nechita (WindRiver)" <djiony2011@gmail.com>
Cc: axboe@kernel.dk, gregkh@linuxfoundation.org,
	ionut.nechita@windriver.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, muchun.song@linux.dev,
	sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] block: Fix WARN_ON in blk_mq_run_hw_queue when
 called from interrupt context
Message-ID: <aUnu1HdMqQbksLeY@fedora>
References: <20251222201541.11961-1-ionut.nechita@windriver.com>
 <20251222201541.11961-3-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222201541.11961-3-ionut.nechita@windriver.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Dec 22, 2025 at 10:15:41PM +0200, Ionut Nechita (WindRiver) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> Fix warning "WARN_ON_ONCE(!async && in_interrupt())" that occurs during
> SCSI device scanning when blk_freeze_queue_start() calls blk_mq_run_hw_queues()
> synchronously from interrupt context.

Can you show the whole stack trace in the warning? The in-code doesn't
indicate that freeze queue can be called from scsi's interrupt context.


Thanks, 
Ming

