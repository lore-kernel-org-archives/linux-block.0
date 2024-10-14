Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDCD15AF6
	for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 01:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728869259; cv=none; b=N5xjRmeXPwQYtMay9owO37nXm8H5Xex6ZSwNknWndpUTNvgQpM2pJu0SVi+tTdcjIXDEiEd+fllaOREG+oiJRLPF+1KImh5EIKD/i04GDZEJXfxb19Pec/jQvaMkZWnx7N6WGX/UBnm3yPi4gNP5jr+ta+Up8MXUPIBhKXC56mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728869259; c=relaxed/simple;
	bh=4ZUXS+fpXMj0rqGVsOfAWazL9hWyK+uoeVHAyuMdy7c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tYg2BDRtthtOU1WZyqy7HryYpnckVzINZoJNG7ppFiy8U6zYq2E1X0JtVWeo+LzlwWVFg4Tflnp9VdmXQQkeQvka3SHDiDP3ntCTFlY8f7Ca3eFIfC3dE6xqqPJN8WR/YpIpYoNroW4YGVC+FuIVbpdNHstuEk0E2Tb070mtIk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4lORWFQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4lORWFQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728869256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=4ZUXS+fpXMj0rqGVsOfAWazL9hWyK+uoeVHAyuMdy7c=;
	b=c4lORWFQ59uo07lNiK0FI5oMWxWXToaWhzrPL983WH8BDkCtFI6ncRZNAWPBSMrmaaHsiu
	XJN2+NJGEQN4ZmIWMguMOAod1f60poRHGahU7Ea4wu4KllSJsJbiKCWUBGiblZq4fMVL5D
	C8YiBCqIBC/hICnP7xmti4VmYCqEO5g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-xMTe649hPVCV0sK32Rfkpw-1; Sun,
 13 Oct 2024 21:27:31 -0400
X-MC-Unique: xMTe649hPVCV0sK32Rfkpw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A80619560B1;
	Mon, 14 Oct 2024 01:27:29 +0000 (UTC)
Received: from fedora (unknown [10.72.116.46])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3794819560AA;
	Mon, 14 Oct 2024 01:27:22 +0000 (UTC)
Date: Mon, 14 Oct 2024 09:27:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hamza Mahfooz <someguy@effective-light.com>,
	Christoph Hellwig <hch@lst.de>,
	Dan Williams <dan.j.williams@intel.com>
Cc: ming.lei@redhat.com, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-raid@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [Report] annoyed dma debug warning "cacheline tracking EEXIST,
 overlapping mappings aren't supported"
Message-ID: <ZwxzdWmYcBK27mUs@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hello Guys,

I got more and more reports on DMA debug warning "cacheline tracking EEXIST,
overlapping mappings aren't supported" in storage related tests:

1) liburing
- test/iopoll-overflow.t
- test/sq-poll-dup.t

Same buffer is used in more than 1 IO.

2) raid1 driver

- same buffer is used in more than 1 bio

3) some storage utilities
- dm thin provisioning utility of thin_check
- `dt`(https://github.com/RobinTMiller/dt)

I looks like same user buffer is used in more than 1 dio.

4) some self cooked test code which does same thing with 1)

In storage stack, the buffer provider is far away from the actual DMA
controller operating code, which doesn't have the knowledge if
DMA_ATTR_SKIP_CPU_SYNC should be set.

And suggestions for avoiding this noise?

Thanks,
Ming

