Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC24DDDAD
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715439890; cv=none; b=HXCffNvDf9tjblhyZdtO7xItE3MQOr7FQ9tNMV8G4uR1nzhYJxm60qOEnBK/AF2B43AoKbyWmnsvCeVK6VBqRHl3ScDd4GoqbC81jJwHZ8bdo6BuK/WmtSnzjJhkkNV0/JPc17JCeD0bWhAxhqu91o8S/WhmpicDe3iju5cEDko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715439890; c=relaxed/simple;
	bh=xUbWc7fj517LFIdf3gDv32EBpQhBBvxt79pLIr82Kcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufkD8+jcXtpXI8CdXXaLbig+PPa4qJ/PpKOXIRLp4IKpKDw6myJ+uoDbbGQyJamw9Gkgn88TYwxErm1GQtfmHzgXZRiGDA7gBIH48lgLpjn7UzTvI/tF0bMTmCG20oePjYlwhm8kvC7WWZy8IJgXtCK5YIvWQVukE3WQ+F0UdRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SVohtMGb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVohtMGb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715439887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0PLXdiUI8m4MEUDeWkRWZDRtsZo779QPF8tHxv4ocyw=;
	b=SVohtMGb3hT4j6R2Wads8EF+lxuVaBL5p0wb6MeVt7ZVjBAYseAthLjItoHKF1vUUclb05
	dUe7v7MjixKnmjzMBWtClSS0VYf5CbvcDbW7RKy7zlYSCjGnI77CGBrZF0AGyDnPfZVbSD
	W6Zp2ukZM6gZ59+K2+RCC3VJ8yoCD7o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-48F_gGkpMmC5YSS9O40joA-1; Sat, 11 May 2024 11:04:44 -0400
X-MC-Unique: 48F_gGkpMmC5YSS9O40joA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF195812296;
	Sat, 11 May 2024 15:04:43 +0000 (UTC)
Received: from fedora (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CA5AC20CC4A0;
	Sat, 11 May 2024 15:04:41 +0000 (UTC)
Date: Sat, 11 May 2024 23:04:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] ublk_drv: set DMA alignment mask to 3
Message-ID: <Zj+JBbODPDh/v3vK@fedora>
References: <379b841f-210f-41dc-a44c-f1dc3197e10f@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <379b841f-210f-41dc-a44c-f1dc3197e10f@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Sat, May 11, 2024 at 08:40:57AM -0600, Jens Axboe wrote:
> By default, this will be 511, as that's the block layer default. But
> drivers these days can support memory alignments that aren't tied to
> the sector sizes, instead just being limited by what the DMA engine
> supports. An example is NVMe, where it's generally set to a 32-bit or
> 64-bit boundary. As ublk itself doesn't really care, just set it low
> enough that we don't run into issues with NVMe where the required
> O_DIRECT memory alignment is now more restrictive on ublk than it is
> on the underlying device.
> 
> This was triggered by spurious -EINVAL returns on O_DIRECT IO on a
> setup with ublk managing NVMe devices, which previously worked just
> fine on the NVMe device itself. With the alignment relaxed, the test
> works fine.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

It should be triggered since DIO DMA alignment is relaxed:

Reviewed-by: Ming Lei <ming.lei@redhat.com>



Thanks, 
Ming

