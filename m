Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3668D4A07
	for <linux-block@vger.kernel.org>; Mon,  8 Dec 2025 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765180793; cv=none; b=LgjYZir6zAAtTSzzo3p8C1Yf1J2nqdYGuw+ve5aYg3GcLSCKX91ij8/oeZLpVBGVcCv1vsJQARdY8B67+Jvk6th4dNg8tE0tWkjYFJCsh35sCgcVP1Xa0FsSewNLNYJEzctkY2Q1OfdnI+8L6Z02Ys47QnUa4ru104zuKnv3PAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765180793; c=relaxed/simple;
	bh=tBfJUTW3NvNbSYEGee4BJk7MP7hvaYS9+XULGReHEuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fz/qSg157vodUstFT50L8f2cY+5mUNUN8/jKWbHRXM7+GTn8ktfRWIBHxeHfJP/xscln6ck2/fRPEcDWn7jq3wrcFNZpjcef2TvMuObfhSfZJ/4yBwofwlgaxldpyJAnRC+cgsc0BN2pHBXckh3kf6Zgy9wqLrk38QAwRJNw8aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IuGyP83X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuGyP83X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765180789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bvbs9g5PUOoEIXxuzBrV0+FVeCXonXlFk3sfGwzwKwM=;
	b=IuGyP83XfLQMhhUy6vytNI2Qq5H3CYyohIwFtqDsgwIqFxwTOK/HjbH69BQzpiRlnH5qIQ
	KJvNirLWkmWndbUL2JC1CikbQfGBlg3xvia0nF0Cw7gTBfloI1Md+NjdJItXZ1upddLcQc
	Ok9/FGOPe+I6Jx2x8hIAaO5uhtJrcDI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-roT6L_myOuyDXeGk6HP5zg-1; Mon,
 08 Dec 2025 02:59:46 -0500
X-MC-Unique: roT6L_myOuyDXeGk6HP5zg-1
X-Mimecast-MFC-AGG-ID: roT6L_myOuyDXeGk6HP5zg_1765180785
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD98519560B2;
	Mon,  8 Dec 2025 07:59:44 +0000 (UTC)
Received: from fedora (unknown [10.72.116.189])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12E23180035A;
	Mon,  8 Dec 2025 07:59:40 +0000 (UTC)
Date: Mon, 8 Dec 2025 15:59:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: allow non-blocking ctrl cmds in
 IO_URING_F_NONBLOCK issue
Message-ID: <aTaFZqtFvlAi5KrR@fedora>
References: <20251201214145.3183381-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201214145.3183381-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Dec 01, 2025 at 02:41:44PM -0700, Caleb Sander Mateos wrote:
> Handling most of the ublksrv_ctrl_cmd opcodes require locking a mutex,
> so ublk_ctrl_uring_cmd() bails out with EAGAIN when called with the
> IO_URING_F_NONBLOCK issue flag. However, several opcodes can be handled
> without blocking:
> - UBLK_CMD_GET_QUEUE_AFFINITY
> - UBLK_CMD_GET_DEV_INFO
> - UBLK_CMD_GET_DEV_INFO2
> - UBLK_U_CMD_GET_FEATURES
> 
> Handle these opcodes synchronously instead of returning EAGAIN so
> io_uring doesn't need to issue the command via the worker thread pool.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

