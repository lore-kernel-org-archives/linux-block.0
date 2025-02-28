Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20838192B6D
	for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730519; cv=none; b=C9H1iCFVxANFBsHSz3JkH/kuH8RX/ARUhZUoBYsiwMPC7TiRZUu3GmwW1edaDaCNWMARyM1o4aAwFBw2ZvN/fDJS1kW9J6KkE1+YTCGcMaRcVXQy/UZXToTOb/eAH1ypUTCn4XHIY+V0vwAPuXCC4TCBaOP5v8bTqn8Ua+1S+ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730519; c=relaxed/simple;
	bh=dLVxveumxeenUcUSHn3NT0dRVr6/tZoHTjuD3Vnu6fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1cl+q8S81tafe6HlFzc5Bgq+TBuWNCfuya4eEXo0EFa5AoZRtN56mWwEimmwweie95i59nznNj/JE4B2E8Z1i1ti3Zmq1o+NGheZclU707MIj+8yBxVDRCvo3oZcTWI66Ds0CGiUu6hdML1mijepN1oYKYc1deKLSsG8Iu6apY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O1Xvh48r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1Xvh48r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740730517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eRccp4VYUJ7iVLOPuYyafBpr1ah62bhkdlT4K+RL4I0=;
	b=O1Xvh48rneB4wWEa8CnAxd7E1++LhRfQnpNPukYfewAQMSEBFdz8//Jp7d0Z4KMNkVrdrJ
	USpomGa6vil6//ZkMWR1wOk2rinYSanFYDkXIwyuDagOXiV9AvTtpYvu/Mn+f5m7+BTwar
	IhypT6POfOEg+5DNekQ7QvgcgwjUyFE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-3m0H-eIGPiCjoB2yxgVL2w-1; Fri,
 28 Feb 2025 03:15:11 -0500
X-MC-Unique: 3m0H-eIGPiCjoB2yxgVL2w-1
X-Mimecast-MFC-AGG-ID: 3m0H-eIGPiCjoB2yxgVL2w_1740730510
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A23D180087B;
	Fri, 28 Feb 2025 08:15:09 +0000 (UTC)
Received: from fedora (unknown [10.72.120.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 012F9180098C;
	Fri, 28 Feb 2025 08:15:03 +0000 (UTC)
Date: Fri, 28 Feb 2025 16:14:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, asml.silence@gmail.com, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	csander@purestorage.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv8 5/6] ublk: zc register/unregister bvec
Message-ID: <Z8FwgbNtpu-bDZfR@fedora>
References: <20250227223916.143006-1-kbusch@meta.com>
 <20250227223916.143006-6-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227223916.143006-6-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Feb 27, 2025 at 02:39:15PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide new operations for the user to request mapping an active request
> to an io uring instance's buf_table. The user has to provide the index
> it wants to install the buffer.
> 
> A reference count is taken on the request to ensure it can't be
> completed while it is active in a ring's buf_table.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

