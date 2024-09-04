Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FDC170A11
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436914; cv=none; b=OiAWJXk9U2e/Vq0kQkTbrGXtz+t17c0EBfonIppoZosk/rvJ112NsL2nlVP0goK9/xoDCNxD5sBiaQSQGzRkmeaZ/BLmjFddtCCm8KxbRfY+yIkiUpRuCqgRvCuVcYboO86oyrXTFaCSrCr4N7ghQxIP3rAdgE8YpInqZyBs6vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436914; c=relaxed/simple;
	bh=uqOMba/The6pJSKp+CbA/Iwap7Vm6sY76UDDUe8L3Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiDcbB2h7JFB/6WJko+XjmOo4zEi6OleBYT4gOcIg2Mdk7evpfPnjktNqe4M4yTL321ZJ3Jn2llR/N/h8HqTrpZAu4CJsDdhULsxIC5uiBXaP1uvx8f6HMxj8LK5VNu/e2fjxK/XqJmiNNELpsEY7IYhF03d+FhYjzHL/HvK5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cxiFJTqV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxiFJTqV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725436911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b1hrffS5UHJg7kzezTrDoIdBib7K1M8RXAnPgDpUGMI=;
	b=cxiFJTqV0d62ckD2WmIzTgjOzbJfTjuGXpvZjhdS6jlcsjPjPWa3Gxky6SpUo6X9WInDZV
	VRI0Pa3NPDB4fpI6w9Ez+FaurIIAaLBoRXDQnJMX5Ppyp12c5dWxz4BGgph9WYNmTWytQo
	Ii8C8qRzQU6ew5h5qnPOyyMWtdyViD8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-Omr3cNLRMdagnJLOcCK1Dw-1; Wed,
 04 Sep 2024 04:01:48 -0400
X-MC-Unique: Omr3cNLRMdagnJLOcCK1Dw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD8F01956089;
	Wed,  4 Sep 2024 08:01:46 +0000 (UTC)
Received: from fedora (unknown [10.72.116.141])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2A283000239;
	Wed,  4 Sep 2024 08:01:42 +0000 (UTC)
Date: Wed, 4 Sep 2024 16:01:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: ZhangHui <zhanghui31@xiaomi.com>
Cc: axboe@kernel.dk, bvanassche@acm.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH v3] block: move non sync requests complete flow to softirq
Message-ID: <ZtgT4HhEsyRJMoQH@fedora>
References: <20240903115437.42307-1-zhanghui31@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903115437.42307-1-zhanghui31@xiaomi.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Sep 03, 2024 at 07:54:37PM +0800, ZhangHui wrote:
> From: zhanghui <zhanghui31@xiaomi.com>
> 
> Currently, for a controller that supports multiple queues, like UFS4.0,
> the mq_ops->complete is executed in the interrupt top-half. Therefore, 
> the file system's end io is executed during the request completion process,
> such as f2fs_write_end_io on smartphone.
> 
> However, we found that the execution time of the file system end io
> is strongly related to the size of the bio and the processing speed
> of the CPU. Because the file system's end io will traverse every page
> in bio, this is a very time-consuming operation.
> 
> We measured that the 80M bio write operation on the little CPU will

What is 80M bio?

It is one known issue that soft lockup may be triggered in case of N:M
blk-mq mapping, but not sure if that is the case.

What is nr_hw_queues(blk_mq) and nr_cpus in your system?

> cause the execution time of the top-half to be greater than 100ms.
> The CPU tick on a smartphone is only 4ms, which will undoubtedly affect
> scheduling efficiency.

schedule is off too in softirq(bottom-half).

> 
> Let's fixed this issue by moved non sync request completion flow to
> softirq, and keep the sync request completion in the top-half.

If you do care interrupt-off or schedule-off latency, you may have to move
the IO handling into thread context in the driver.

BTW, threaded irq can't help you too.


Thanks, 
Ming

