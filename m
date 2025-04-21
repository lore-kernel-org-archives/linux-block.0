Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0311E489
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745237724; cv=none; b=rC9pIcJ8p2I36uQeRKah6cZ0v9nW1HHSohFsPh64sUXHjmOHzFgQaQa+sz6G///ncwPWdyu3+JR13Cs7njXZGUmE/A67s4zpWeX0YGNlPGWqOhP/U74X/BVaWwGz4+4na5cqPEMVxpTDqorCVmSzf+QDntSax/+ivJZY86j7rWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745237724; c=relaxed/simple;
	bh=896TJi7fq38XxkAFseVjM91gOOFlcMSMLy1VYy9uDk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJ2CWZmvlqi8nBp7y1ecqrqlPEa2DYX7PZ/MsPB6iHEfNVBQXpoIk4CCNazUbm0xMsTqIR6gIXO0p+NLnZNxO2C+wN6HXvg/lVmKmnZ6cjfLX5yYL9e2bmaVckeaX4ZUgMr0yOvNeVW5UiMuRYUjuEUU7VHB8rW4sDtjrWLu2S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHB0J8xa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHB0J8xa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745237720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1n1BO3Wb+x0wf3DBnzO+2/jk25hVoPdUKqmW7AiA3u4=;
	b=NHB0J8xavMskKA9Go2cIg1KCor+P8pnVt7kP4eyGDBeUbQtJbjavMnOTSC5Voh34SzbzEm
	e/F0DOx+KLseRZUevUjiEMv598tInFAA/yJ+o+x9sLdAi0GtMxqwsPlaeiDzTu021jGqh2
	fLLd/WZK/MyfjLU4hCVthwlmwYWNtQg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-EzjPaZh-NW-PCYewTaCngA-1; Mon,
 21 Apr 2025 08:15:17 -0400
X-MC-Unique: EzjPaZh-NW-PCYewTaCngA-1
X-Mimecast-MFC-AGG-ID: EzjPaZh-NW-PCYewTaCngA_1745237716
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03EF51956094;
	Mon, 21 Apr 2025 12:15:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.136])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 155F61956095;
	Mon, 21 Apr 2025 12:15:12 +0000 (UTC)
Date: Mon, 21 Apr 2025 20:15:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jared Holzman <jholzman@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v6] ublk: Add UBLK_U_CMD_UPDATE_SIZE
Message-ID: <aAY2y7-XRAnOcKIi@fedora>
References: <20250421105708.512852-1-jholzman@nvidia.com>
 <2a370ab1-d85b-409d-b762-f9f3f6bdf705@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a370ab1-d85b-409d-b762-f9f3f6bdf705@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, Apr 21, 2025 at 01:59:50PM +0300, Jared Holzman wrote:
> 
> From: Omri Mann <omri@nvidia.com>
> 
> Currently ublk only allows the size of the ublkb block device to be
> set via UBLK_CMD_SET_PARAMS before UBLK_CMD_START_DEV is triggered.
> 
> This does not provide support for extendable user-space block devices
> without having to stop and restart the underlying ublkb block device
> causing IO interruption.
> 
> This patch adds a new ublk command UBLK_U_CMD_UPDATE_SIZE to allow the
> ublk block device to be resized on-the-fly.
> 
> Feature flag UBLK_F_UPDATE_SIZE is also added to indicate support.
> 
> Signed-off-by: Omri Mann <omri@nvidia.com>

Looks good,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

