Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A511FE476
	for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730444; cv=none; b=o4p35NHRZnPHNg2RIpleKWETBdBG8OBvnfzsz4Z/d4BRCNMVXePetBamL6d5ktdEJkk1an+qT21z+4qUGfIETp7BZnKyhtaDUiF/iXBxPaVikMN6XnSPkGHje0QpLkXkB3u9v9BNi2NsIyyvvyp/5Ziom0I4OzgbVwu/He7vnSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730444; c=relaxed/simple;
	bh=0Xddv6iXUCTDL7nf1j/zQ7/QpvA0KDeU4cLWQndSS0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJ6mo9ugG0MMMCeh+5T4PFW4Y+DNr/M/y/LaxWQZ6dyY+dy1dVslNI48yIEEw8GUwjlyMet/rE6bObhdBOdSLi3EEZsfBO3mHidWINM5tPLt8DfDHYT5YZ3o78bbZEpgwZpnzuH5cv/Kp83xHa5CRBPboqy3Etb1h5dA6q2cY5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLVk5ciF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLVk5ciF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740730442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/RW2S6X5ptZrapMdWo1yqIKyOazSb405vqeZrfbMITc=;
	b=RLVk5ciFn4fkDlvRmGSlXjewIdx7fiqV4GFY4xzoqCCCG2GGqT6hsy96zORAB+mXlqKHd5
	7ohCjpfBC3ZAJkYUpF/fc3nlU9Gbr9Bx88r28i1rjkSpMktQa/AUE2CC0Z3awcpCw8exwR
	2J6phSwK8OYmbRc3pL4B+g9gzEuIkCo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-Tq3jjiP9Pxm14G1fBQDICA-1; Fri,
 28 Feb 2025 03:13:57 -0500
X-MC-Unique: Tq3jjiP9Pxm14G1fBQDICA-1
X-Mimecast-MFC-AGG-ID: Tq3jjiP9Pxm14G1fBQDICA_1740730436
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1020E1954126;
	Fri, 28 Feb 2025 08:13:56 +0000 (UTC)
Received: from fedora (unknown [10.72.120.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1BBF1800359;
	Fri, 28 Feb 2025 08:13:49 +0000 (UTC)
Date: Fri, 28 Feb 2025 16:13:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, asml.silence@gmail.com, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	csander@purestorage.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv8 4/6] io_uring: add support for kernel registered bvecs
Message-ID: <Z8FwNxRdeRFBEXGL@fedora>
References: <20250227223916.143006-1-kbusch@meta.com>
 <20250227223916.143006-5-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227223916.143006-5-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Feb 27, 2025 at 02:39:14PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide an interface for the kernel to leverage the existing
> pre-registered buffers that io_uring provides. User space can reference
> these later to achieve zero-copy IO.
> 
> User space must register an empty fixed buffer table with io_uring in
> order for the kernel to make use of it.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

