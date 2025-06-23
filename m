Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF7135971
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672193; cv=none; b=ViM9fhNYe4GYNJOmm1X8xKzIPvVYKSJw1Ew8TostkJtqIH0knvu1Bz1pqo3rHwFI4C22/c+cp2JY2BOH3CQxTrgTn2lTzTRdNXRRaTO8JdkxA16WNTlyVwMPHT5Em4keDBUALYCkKPqGNWgkWeJIgGTPJGLniKvuZNspP2dTw6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672193; c=relaxed/simple;
	bh=+H0dRhnp8Q64tlwjF7CJT9uEF1qylsO88zcPvwXYqtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7cgnBhH+z77YGbU8HQ+DagrlKJ57OHrgqVcWAgvlTFYwFhPXDfJPh6KYrK2zcT9Z8C5zpgqIEDXPLsCgb+cOTpoQMRdP+/VOUSI5I9iZVh5848r9TfwafXkJCPFfaoFeW2LK0rdhCKpWA35TftMn0rde1PODGcuPqI/zJ1eqjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YDC735s/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDC735s/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750672190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s6vOPDAaaJfJPHfTtcv9wcz82LhLntSeSCi44vr4yZ8=;
	b=YDC735s/QMw98/eFerc6jpkfOrPlGBR6LTqfFJGcV+wQ0P6bmRCD8I546KUSp+/FinQuf0
	Mmn4rlmXR8o6raq0P3yBPTWg1wWLhGjA3IOvAeGACZJncxSvvQtVT7pwxq9m0DPvTL7pHy
	sgZ/FRukffuFnJu6jvqOOtdd/PkDcl8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-V8JXfqoCMTKUEl-PDUVI_g-1; Mon,
 23 Jun 2025 05:49:43 -0400
X-MC-Unique: V8JXfqoCMTKUEl-PDUVI_g-1
X-Mimecast-MFC-AGG-ID: V8JXfqoCMTKUEl-PDUVI_g_1750672182
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 335C81956048;
	Mon, 23 Jun 2025 09:49:42 +0000 (UTC)
Received: from fedora (unknown [10.72.116.65])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B9F0195608D;
	Mon, 23 Jun 2025 09:49:39 +0000 (UTC)
Date: Mon, 23 Jun 2025 17:49:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 14/14] ublk: cache-align struct ublk_io
Message-ID: <aFkjLuMmq6rxDcDU@fedora>
References: <20250620151008.3976463-1-csander@purestorage.com>
 <20250620151008.3976463-15-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620151008.3976463-15-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Jun 20, 2025 at 09:10:08AM -0600, Caleb Sander Mateos wrote:
> struct ublk_io is already 56 bytes on 64-bit architectures, so round it
> up to a full cache line (typically 64 bytes). This ensures a single
> ublk_io doesn't span multiple cache lines and prevents false sharing if
> consecutive ublk_io's are accessed by different daemon tasks.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index ebc56681eb68..740141c63a93 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -186,11 +186,11 @@ struct ublk_io {
>  	unsigned task_registered_buffers;
>  
>  	/* auto-registered buffer, valid if UBLK_IO_FLAG_AUTO_BUF_REG is set */
>  	u16 buf_index;
>  	void *buf_ctx_handle;
> -};
> +} ____cacheline_aligned_in_smp;

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks, 
Ming

