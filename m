Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF2D82866
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353268; cv=none; b=rmEpWpHT0h+9avQ0sYETKPCSHRgeLgwMU+JGIQwmW6bo30tyR8llYoUl2gnmQIT+3W4iYf35xrXIbIxEWB/FXMQbAHh4pZqb5ToZ6MfFiSFxDD0ghhxW+fitjaBpmdKZJg+5oFp7QskA+aHmCRxoc8ckJJjUIn/kX5QTaLy3Z1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353268; c=relaxed/simple;
	bh=7O8461+KKSNV4SQKExQrXmF3Zec1VEEVyAMe0lkB4oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoOtGs++Vz/Pq2b7K3aIt70cEH2Vlhb/x2yDn3TqX5OY0plRPoE1ofRNhQSCfSRQbDDex+sI4NRG0MhEWk/czl3BZHVgyXiAbAV5UDLw2asE8hElu8m/v0ETmu9bMd/uAUNOY8pUqR1MeMy7rdss2q+O9iU9jzatqbl9tf73U1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fM2fzwTU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fM2fzwTU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776353265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vFY8emkWvh+CcCvc2Sq9jqOrMYd8LQx+4a873ps+EKA=;
	b=fM2fzwTUQHOBH3WlbbzAS2gvv8rGRidB4VefAZ4w1QzzX4aX00H1uEOoNo7m4WxmSbTiHI
	4EpqnZJgRZGDJ9uytsU7cuYiXJrIT5iRBFnW8rbUIhzC2voYtpb3KebkBeoAgvE6m4xYJl
	nOxrnlWY8hZYxjAZSm3avYRWOyeq/+E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-RD7OP0XxOxWsppgXoN-JIw-1; Thu,
 16 Apr 2026 11:27:42 -0400
X-MC-Unique: RD7OP0XxOxWsppgXoN-JIw-1
X-Mimecast-MFC-AGG-ID: RD7OP0XxOxWsppgXoN-JIw_1776353260
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F2E11955F07;
	Thu, 16 Apr 2026 15:27:40 +0000 (UTC)
Received: from rhel-developer-toolbox-latest (unknown [10.2.16.224])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 46A7530001A4;
	Thu, 16 Apr 2026 15:27:36 +0000 (UTC)
Date: Thu, 16 Apr 2026 08:27:35 -0700
From: Chris Leech <cleech@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: alistair23@gmail.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	kbusch@kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	yi.zhang@redhat.com, mlombard@arkamax.eu, linux-block@vger.kernel.org, 
	shinichiro.kawasaki@wdc.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] nvmet-tcp: Ensure old keys are freed before replacing
 new ones
Message-ID: <20260416-landlord-encounter-c93f2733de5f@redhat.com>
References: <20260415230250.2783414-1-alistair.francis@wdc.com>
 <959f800d-b92e-406e-a174-680fb09c884e@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <959f800d-b92e-406e-a174-680fb09c884e@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Apr 16, 2026 at 08:16:14AM +0200, Hannes Reinecke wrote:
> On 4/16/26 01:02, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> > 
> > Previously after the host sends a REPLACETLSPSK we freed the TLS keys as
> > part of calling nvmet_auth_sq_free() on success. A recent change ensured
> > we don't free the keys, allowing REPLACETLSPSK to work.
> > 
> > But that fix results in a kernel memory leak when running
> > 
> > ```
> > nvme_trtype=loop ./check nvme/041 nvme/042 nvme/043 nvme/044 nvme/045 nvme/051 nvme/052
> > echo scan > /sys/kernel/debug/kmemleak
> > cat /sys/kernel/debug/kmemleak
> > ```
> > 
> > We can't free the keys on a successful DHCHAP operation, otherwise the
> > next REPLACETLSPSK will fail, so instead let's free them before we
> > replace them as part of nvmet_auth_challenge().
> > 
> > This ensures that REPLACETLSPSK works, while also avoiding any memory
> > leaks.
> > 
> > Fixes: 2e6eb6b277f59 ("nvmet-tcp: Don't free SQ on authentication success")
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   drivers/nvme/target/fabrics-cmd-auth.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> > index b9ab80c7a6941..58185184478a4 100644
> > --- a/drivers/nvme/target/fabrics-cmd-auth.c
> > +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> > @@ -412,6 +412,13 @@ static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
> >   	int hash_len = nvme_auth_hmac_hash_len(ctrl->shash_id);
> >   	int data_size = sizeof(*d) + hash_len;
> > +	/*
> > +	 * If replacing the keys then we have previous successful keys
> > +	 * that might be leaked, so we need to free them here.
> > +	 */
> > +	if (req->sq->dhchap_c1)
> > +		nvmet_auth_sq_free(req->sq);
> > +
> >   	if (ctrl->dh_tfm)
> >   		data_size += ctrl->dh_keysize;
> >   	if (al < data_size) {
> I am not sure.
> The authentication variables should be freed as soon as the authentication
> completes; the session key is ephemeral and
> should not be stored longer than necessary and will _never_
> be used again once authentication completes.
> The TLS key, OTOH, is used throughout the session and needs
> to be present while the session is active
> As such, both sets have vastly different lifetimes, and
> I would argue that this
> 
> void nvmet_auth_sq_free(struct nvmet_sq *sq)
> {
> 	cancel_delayed_work(&sq->auth_expired_work);
> #ifdef CONFIG_NVME_TARGET_TCP_TLS
> 	sq->tls_key = NULL;
> #endif
> 	kfree(sq->dhchap_c1);
> 	sq->dhchap_c1 = NULL;
> 
> is actually wrong as we should not modify 'tls_key' here.

I agree with Hannes, and was just about to respond with the same
feedback.  I think the freeing of the auth temporaries needs to be
returned to fix the memleak, and the real problem is the setting of
tls_key to NULL.  That doesn't seem like the right lifetime for tls_key,
and it looks to be a reference count leak as well.

Is the presence of sq->tls_key the best check to see if the socket is
currently in a kTLS mode?  (it might be, I'm not as up on the target
code)

- Chris

