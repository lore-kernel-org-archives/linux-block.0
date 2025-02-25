Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846811C8607
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472664; cv=none; b=DGMrKBL6UiycoCU8BXWYt/oL5pKaGptRCSavZMthF8xIzwxmu3QjhtqexYeuRvmYjcx23FUGXRHK3JXFt+OTnYvcFhTtfJdkiL8frapciTN451UADD8VSthHlnXIIFnxl/2Qefp6vlgc04W8OjJS13wDKh92oIk2qm7ThjXJNOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472664; c=relaxed/simple;
	bh=6F4YYXLZUwyXNPnGHw+FF3dVGBHe52pY87rmvu1Bm6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEuJhPFebWipbymTNwU01azXL9aGlJ+2ycZk4L5e1KihTCoMEmRPGQBlCVYOdAbNkBzlK5PJcusG0C7hvCiOA6xwJygokH9QjiSzyASZbkSOmTmmwUSPW6oYutyg8T7vDCqndfavOBSKZTBCDujX1QG36rIjuh0tevxfxajNmLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pp+8akOp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pp+8akOp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740472660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FdUebZZOtGzmcl1QLylvNFIYhCCJhFPOqqpv7jR86pI=;
	b=Pp+8akOpA3mgtoHmkjsrPfRRl/0g+mib5rVPNrdyfUEAWA7m8sa+CB+V6QZciAC/bS2k9N
	CL8HyDl5xAM1XRlFoFW0uguShIUEczEC2tJcweK4ake2d/K2ARUhfHqaMpNf+6tpZ1DLGc
	2UaPl5eGIFBHsKtBAFiUG2f4q6kj8GE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-Cm5ctpPLMC2H4Yt1-0Pciw-1; Tue,
 25 Feb 2025 03:37:34 -0500
X-MC-Unique: Cm5ctpPLMC2H4Yt1-0Pciw-1
X-Mimecast-MFC-AGG-ID: Cm5ctpPLMC2H4Yt1-0Pciw_1740472653
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9CBB18EB2C6;
	Tue, 25 Feb 2025 08:37:32 +0000 (UTC)
Received: from fedora (unknown [10.72.120.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BFD5C1955BD4;
	Tue, 25 Feb 2025 08:37:26 +0000 (UTC)
Date: Tue, 25 Feb 2025 16:37:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: asml.silence@gmail.com, axboe@kernel.dk, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, bernd@bsbernd.com,
	csander@purestorage.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 01/11] io_uring/rsrc: remove redundant check for valid
 imu
Message-ID: <Z72BQOvQKmuw1eLg@fedora>
References: <20250224213116.3509093-1-kbusch@meta.com>
 <20250224213116.3509093-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224213116.3509093-2-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Feb 24, 2025 at 01:31:06PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The only caller to io_buffer_unmap already checks if the node's buf is
> not null, so no need to check again.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

