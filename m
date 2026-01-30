Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F41487BE
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 02:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769740578; cv=none; b=to9WlrX/NdkM6/clC/lVr+gyTkWZO7DH+Uhwi23qgxYVZqtUS3llY/VQsK2KNBFobxpxjjDYbqiTCJ5oeDO9MX1LPSNo2XtB9VxjlwbWi2XKuEv8FCnXA2kfdCYv9a2+kweaHfUzLfU0UlpBgH2jLnesehfpViIqBYkn7hFUKYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769740578; c=relaxed/simple;
	bh=nin3a//CcTksLO1qYvLJXeA/Seog0sOffg69Y6XWuT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otjP7zRNsBC0Rj2YktbqH88RbCzcTBNdLcp+XgefGw6Cw4PbgQbJ9W4O4xKQgDrJD8lEkUwslssLfu0ekWi3mkx36EijD6Zy+MuDfeJCYrXCvG3YDCf6QWUG2FeTrKiUC7KHZy1shcXrsPq+SSR+1FhzfptR+dTpEvWKIrvTcY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OMHU19Pt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMHU19Pt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769740575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wDLlqogTgAyKGmrWmpBhSlpnvL9Af+bxzY06uc7qz70=;
	b=OMHU19PtSjcGK8YZN97qCnlpZ+vkW6BmbGhZ+VU7XN1XhRHhXGHp8eLUoYR5bl7iDycnzV
	WFzTlJMOD4tqItIkkI0S3MfTEhQmxQWU2SFzr/foTS3lU+RYg+ABZDyq4aYwPn0yHQ5rV3
	3TnUrcdTqlayxaRDY1ZZoiWoGBnDQNU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-491eZz0FPw2Qd94bttmoSw-1; Thu,
 29 Jan 2026 21:36:13 -0500
X-MC-Unique: 491eZz0FPw2Qd94bttmoSw-1
X-Mimecast-MFC-AGG-ID: 491eZz0FPw2Qd94bttmoSw_1769740572
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C5271956050;
	Fri, 30 Jan 2026 02:36:12 +0000 (UTC)
Received: from fedora (unknown [10.72.116.182])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 868B83000218;
	Fri, 30 Jan 2026 02:36:09 +0000 (UTC)
Date: Fri, 30 Jan 2026 10:36:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: restore auto buf unregister refcount optimization
Message-ID: <aXwZFA9FSpoL0t9z@fedora>
References: <20260128205636.4003327-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128205636.4003327-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Jan 28, 2026 at 01:56:34PM -0700, Caleb Sander Mateos wrote:
> Commit 1ceeedb59749 ("ublk: optimize UBLK_IO_UNREGISTER_IO_BUF on daemon
> task") optimized ublk request buffer unregistration to use a non-atomic
> reference count decrement when performed on the ublk_io's daemon task.
> The optimization applied to auto buffer unregistration, which happens as
> part of handling UBLK_IO_COMMIT_AND_FETCH_REQ on the daemon task.
> However, commit b749965edda8 ("ublk: remove ublk_commit_and_fetch()")
> reordered the ublk_sub_req_ref() for the completed request before the
> io_buffer_unregister_bvec() call. As a result, task_registered_buffers
> is already 0 when io_buffer_unregister_bvec() calls ublk_io_release()
> and the non-atomic refcount optimization doesn't apply.
> Move the io_buffer_unregister_bvec() call back to before
> ublk_need_complete_req() to restore the reference counting optimization.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Fixes: b749965edda8 ("ublk: remove ublk_commit_and_fetch()")

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

