Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF48258CF8
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557760; cv=none; b=SsGqASpMtxzFJJTJolfEL6nXU6YD9GWPc8x/BmY3WSr2bQGOrnQM3imWLQwpIkoRcFW6VqrNa4/9up5SQlS0Zhet/WBiErqgWA19Mn8b+BAX9gGGbFYstks0o+yzLrXvW3the1dpjCYqnnKwK9mG7BG1I+fBhSGZJhT6TvZ+L10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557760; c=relaxed/simple;
	bh=nALpxznmBhzULFmfDkpB8aWVcJCEE83NjjXYdSRCF6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCTZ5P0OYRRzYQEDNGZLCuL6umFSmrz8DffRB7b/n/sPLXsCLkJ6TRJnm7U/i5wAyekvP+tI09cSyo6Y+Fdw4ep6siJK+R0TyX4dPOJhnlwq6WQFNH9FWZQk+EdOQK+YmcdTiLvo1YcrwZS0YE1p1yMxKfi9Ec4EZlU5mMaraMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZaBbh77O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaBbh77O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740557758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IkUcDBu8Qo7NTXBR3iH6KjBpPvAxntcf8hHlhE3zaYc=;
	b=ZaBbh77OEK8DqzSsEes3o/yhEALST8vc0aDTxd9sOGDCUnkHtgt4yB53BzSe2zU9vBncIm
	v4y8FyKu/r0PBB1muS5xUCbWBDALmzrERHPSTxvblS03czPMtL58b6QsmG6YlwwfMeNHyb
	2EstFZvtWMGghpq7vApUKUp+FEFS5ss=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-lMLmeSYlPcSKOrHiRuniNw-1; Wed,
 26 Feb 2025 03:15:53 -0500
X-MC-Unique: lMLmeSYlPcSKOrHiRuniNw-1
X-Mimecast-MFC-AGG-ID: lMLmeSYlPcSKOrHiRuniNw_1740557752
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7455219039C2;
	Wed, 26 Feb 2025 08:15:52 +0000 (UTC)
Received: from fedora (unknown [10.72.120.27])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F7FA1800359;
	Wed, 26 Feb 2025 08:15:45 +0000 (UTC)
Date: Wed, 26 Feb 2025 16:15:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: asml.silence@gmail.com, axboe@kernel.dk, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, bernd@bsbernd.com,
	csander@purestorage.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 09/11] ublk: zc register/unregister bvec
Message-ID: <Z77Nq_5ZGxUjxkau@fedora>
References: <20250224213116.3509093-1-kbusch@meta.com>
 <20250224213116.3509093-10-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224213116.3509093-10-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Feb 24, 2025 at 01:31:14PM -0800, Keith Busch wrote:
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
> ---

Looks IO_LINK doesn't work, and UNREG_BUF cqe can be received from userspace.

It is triggered reliably in the ublk selftests(test_loop_03.sh) I just post out:

https://lore.kernel.org/linux-block/20250226081136.2410001-4-ming.lei@redhat.com/T/#m3adfecbfa33de9f9f728ccb4ab1185091be34797


Thanks,
Ming

