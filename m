Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C45822DFB5
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669661; cv=none; b=jkOTOSWxqEUUgjnNsk7k9jRDNR3KY4bKN1GX3FauGoZTvt92xWuVLWA5x3O2kZ9GWzSMZUs55eUDL/4WVKKsXt9HRR1/E+ZFsmZjcqBnwUBOTQfPoyGUnC+/nUS84IDCU+IEV6RqFWV17l4Jc0zsdDq2WWUDJAWWyG2GS2O1Pxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669661; c=relaxed/simple;
	bh=rRX+RnuzOnRKOpY0on/TuFOGe0GI+7Qi72agLmxyQig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7avaA5dI6+7budnDtn9AtxeMexlVcSpeKXyZEvOdNZvBzIeFzD4QU9e7p3hGPk+HffdeEA6RBmM5fCtWlbnIqxVeK9QPgu2dawy2UEMLz4mrIw2/tXk+twzyF4JG74s2QGNDmW+XAObYIVbl80VpfdCDRV5aGBhdJpM8an3ahQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pc29xYR7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pc29xYR7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750669658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3tsGCpIu03s5GvpnXBeZBoJtrh3BiqOyhIjJPpF2U8=;
	b=Pc29xYR7v76diniO7eXgnORCFxj0C6+cUPx+WUnGpZeMlFO1gTeOVF/farMlWLW4a2/0G9
	36yCQ6Hc9yQl/01IhE4xTHoaBz0vBID4Sn9bOgMfPo7iKRSAFvsjOoilJ7DjeJ3RthH+Ip
	K1XQZuom5Fb5CT5ffFgg/mzfNYdzXrI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-Sx78bgyZMdG6iI4TVjpZ_A-1; Mon,
 23 Jun 2025 05:07:36 -0400
X-MC-Unique: Sx78bgyZMdG6iI4TVjpZ_A-1
X-Mimecast-MFC-AGG-ID: Sx78bgyZMdG6iI4TVjpZ_A_1750669655
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8798180028D;
	Mon, 23 Jun 2025 09:07:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.65])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27DDA19560A3;
	Mon, 23 Jun 2025 09:07:31 +0000 (UTC)
Date: Mon, 23 Jun 2025 17:07:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 09/14] ublk: allow UBLK_IO_(UN)REGISTER_IO_BUF on any
 task
Message-ID: <aFkZT1dAPfolVieu@fedora>
References: <20250620151008.3976463-1-csander@purestorage.com>
 <20250620151008.3976463-10-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620151008.3976463-10-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Jun 20, 2025 at 09:10:03AM -0600, Caleb Sander Mateos wrote:
> Currently, UBLK_IO_REGISTER_IO_BUF and UBLK_IO_UNREGISTER_IO_BUF are
> only permitted on the ublk_io's daemon task. But this restriction is
> unnecessary. ublk_register_io_buf() calls __ublk_check_and_get_req() to
> look up the request from the tagset and atomically take a reference on
> the request without accessing the ublk_io. ublk_unregister_io_buf()
> doesn't use the q_id or tag at all.
> 
> So allow these opcodes even on tasks other than io->task.
> 
> Handle UBLK_IO_UNREGISTER_IO_BUF before obtaining the ubq and io since
> the buffer index being unregistered is not necessarily related to the
> specified q_id and tag.
> 
> Add a feature flag UBLK_F_BUF_REG_OFF_DAEMON that userspace can use to
> determine whether the kernel supports off-daemon buffer registration.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

