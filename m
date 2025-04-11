Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6850528F939
	for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357902; cv=none; b=hmnAVJI2NgOVccRabqpvtT1ZOqGJxRSb4BsMidjCVZn4VFeYtFlPzUOpmGGHJvzZlf9p/EM5xs8OiV77euyrD9iJM3svIEhUyEkj0sJe2zhA6n9KJgLllpWzYEUEja1hvt+eDtC+a9sfUMvya0/EEmAydXN82grvNOoEyqG+3ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357902; c=relaxed/simple;
	bh=RoaRnEuDGYNZNBysc6IoCuCalvE8roZQ3otz4VDUpFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzSEN8eVNXrbpV+dEgX5SbLbo/sv1RhEzawdTINsR3qxVnc/MAnzXur0UJM0yqUq2yOHzqe/JLPJTltQGY2vINvzCJ+XPiN3ArtCNWwb2WN17Q6upvUVP7MYurdAQ7JeFsTThhlfm8rk/JHYxT9XFxcUwbgtzq/jXXtVdgMTfeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LeYK3sjX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LeYK3sjX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744357899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/nq9vWKH5vK+LG8V0e3I7yV8cZfspJSlkpTU7meTlsU=;
	b=LeYK3sjXGqkExKng36z705FohTE2DLGpXtaAtw7+Tj52Y0Z2jfG22m1jia9TOmNEOIDG6z
	DDW7rQBZFLpssp74tabUMkdDKyIgjeCBcgFwSY9Y4I8CKD1OnZNF6oDVHg47JPTLIhmBUT
	xo38Cw6TG+P8TsEgzfd6SWfcVA6GYJM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-4MRAc9WOPCav8HDlsRdL7Q-1; Fri,
 11 Apr 2025 03:51:36 -0400
X-MC-Unique: 4MRAc9WOPCav8HDlsRdL7Q-1
X-Mimecast-MFC-AGG-ID: 4MRAc9WOPCav8HDlsRdL7Q_1744357894
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75B701955BC1;
	Fri, 11 Apr 2025 07:51:34 +0000 (UTC)
Received: from fedora (unknown [10.72.120.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49E021828A9E;
	Fri, 11 Apr 2025 07:51:29 +0000 (UTC)
Date: Fri, 11 Apr 2025 15:51:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: pass ublksrv_ctrl_cmd * instead of io_uring_cmd *
Message-ID: <Z_jJ_EU28D3C5P6F@fedora>
References: <20250409012928.3527198-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409012928.3527198-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Apr 08, 2025 at 07:29:26PM -0600, Caleb Sander Mateos wrote:
> The ublk_ctrl_*() handlers all take struct io_uring_cmd *cmd but only
> use it to get struct ublksrv_ctrl_cmd *header from the io_uring SQE.
> Since the caller ublk_ctrl_uring_cmd() has already computed header, pass
> it instead of cmd.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

