Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407FB2AE8D
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 01:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741053408; cv=none; b=BBXiaA96xaX25Z37ceTMct6l12iuzQFCF5SWrCtKeD5M4WiLMgoGr25A2GvQieRiJueh9f4abXVB+kBlt6VHVVC4ZgfXk5JZAa6Sb4llmMxhFM4/dT5LofWQ13ftPQ4U5EGepqmWP+jiO5VCNP81dZZAh8JcQFTFO8OKffdFq2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741053408; c=relaxed/simple;
	bh=ckwES0wRXBhpCdcj4WA8NtfzZH/0wnwIVg6NCZ4v9Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aw2Bgn1h4celzIyBQixRC5V9pNj5pwir/l6aJQoOdwhiFxb5Pwb/hhH2MHy9VKURp67Ykd6rW4JF/qtJGucXC2XplcCao26BpuiyhApB/jXSWmtpEDpxYf5A9G7Md4xO2b9xgyFvlXiWfmADeuN+0CGp4D8KT9YiMzZv04EL2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cQHCGTjW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQHCGTjW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741053405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VSm2mAYGj6WACUOO5bbq2aEV25O4CvctarLFrMmLDPo=;
	b=cQHCGTjWXhW3n/uECOKnRH9LTC2FxvESOjiW8SJMCrLxJ+OTpbT1rQF0KAKwEjv6w9q4G9
	OQb9q4iJIWdpbeXxM0SqxitfNJFa8dvAytiHblpvCTmQYuKT9aXXfIiFmXzg12l3xLrspY
	myy9liuink0pJ2M0gsQlKoBXFfGptUc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-5NMN1ISPN6Sds1r6Q59hqg-1; Mon,
 03 Mar 2025 20:56:41 -0500
X-MC-Unique: 5NMN1ISPN6Sds1r6Q59hqg-1
X-Mimecast-MFC-AGG-ID: 5NMN1ISPN6Sds1r6Q59hqg_1741053400
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C691819560BC;
	Tue,  4 Mar 2025 01:56:40 +0000 (UTC)
Received: from fedora (unknown [10.72.120.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F4563000197;
	Tue,  4 Mar 2025 01:56:36 +0000 (UTC)
Date: Tue, 4 Mar 2025 09:56:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: don't cast registered buffer index to int
Message-ID: <Z8Zdz9cKSAadx7-F@fedora>
References: <20250301190317.950208-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301190317.950208-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Mar 01, 2025 at 12:03:16PM -0700, Caleb Sander Mateos wrote:
> io_buffer_register_bvec() takes index as an unsigned int argument, but
> ublk_register_io_buf() casts ub_cmd->addr (a u64) to int. Remove the
> misleading cast and instead pass index as an unsigned value to
> ublk_register_io_buf() and ublk_unregister_io_buf().
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

