Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53AD3815ED
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776445054; cv=none; b=b2dpFWU679iTqupsUf/NtF9h4RSNogObKsytSLDKaFtjKq7s2iBqPCRWyeDt7mX+ZhPhbIXTxu9w0Ka0NiTgZlmdDlo9tg2tZsJQUoIxOkyTHj9ACHphAIJLIffqx2rYZdFkTvEtXjALkiyyzoSe0W/MfUg116tYphvEY18wlFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776445054; c=relaxed/simple;
	bh=vXE5nidksLToHOyLVkyd8RPgu54atDVnT7t9N/s3gsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYw2gK2x0lM8ldqjeFUV1oN89dHSKelgxel0yeI/8dARk4f6v5TOKRQv5CmOszDeK+HWPQk2ho/B7n3dPKtXvdsH1a8319kHCmV7ZKW8JFR/ELVJhBZTu+UnC7CGMYCkOaw+S1P/ygIZ/q4E2QcY5DZvIaqUH3EuIJFrQ3pOHTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AWh4Btrr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWh4Btrr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776445048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uggwtCaVcvROsjHgtNbbX0w2gXo6VNc2FeHwEK+fpGM=;
	b=AWh4Btrr4zvzwcmNLaeefucOhldpnaeSg6X1yzoYAKxMQel21KwVMSUckZW+g9CZ8I8v/A
	slr7AA7rgI8f7xKliAHmlxXz4wdfxTqD5HtVLbVl/BmhNxuXo7H7RaIDX/9xJAbZvBp5S5
	5nlxhbNRHPsoNW+ZcbUgIRZU8cD/d6k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-t342lx2MNom6j8EvNJYTdw-1; Fri,
 17 Apr 2026 12:57:24 -0400
X-MC-Unique: t342lx2MNom6j8EvNJYTdw-1
X-Mimecast-MFC-AGG-ID: t342lx2MNom6j8EvNJYTdw_1776445042
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19B761956065;
	Fri, 17 Apr 2026 16:57:22 +0000 (UTC)
Received: from cleech-thinkpadt14sgen2i.rmtusor.csb (unknown [10.2.16.224])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EB1EB19560B1;
	Fri, 17 Apr 2026 16:57:17 +0000 (UTC)
Date: Fri, 17 Apr 2026 09:57:16 -0700
From: Chris Leech <cleech@redhat.com>
To: alistair23@gmail.com
Cc: hare@suse.de, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	kbusch@kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	yi.zhang@redhat.com, mlombard@arkamax.eu, linux-block@vger.kernel.org, 
	shinichiro.kawasaki@wdc.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 1/2] Revert "nvmet-tcp: Don't free SQ on authentication
 success"
Message-ID: <20260417-a6559d5a9906f8b2da2b9774@redhat.com>
References: <20260417004809.2894745-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417004809.2894745-1-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Apr 17, 2026 at 10:48:08AM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> In an attempt to fix REPLACETLSPSK we stopped freeing the secrets on
> successful connections. This resulted in memory leaks in the kernel, so
> let's revert the commit. A improved fix is being developed to just avoid
> clearing the tls_key variable.
> 
> This reverts commit 2e6eb6b277f593b98f151ea8eff1beb558bbea3b.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  drivers/nvme/target/fabrics-cmd-auth.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Closes: https://lore.kernel.org/linux-nvme/CAHj4cs-u3MWQR4idywptMfjEYi4YwObWFx4KVib35dZ5HMBDdw@mail.gmail.com
Reviewed-by: Chris Leech <cleech@redhat.com>

> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index b9ab80c7a6941..f1e613e7c63e5 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -395,10 +395,9 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
>  		goto complete;
>  	}
>  	/* Final states, clear up variables */
> -	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
> -		nvmet_auth_sq_free(req->sq);
> +	nvmet_auth_sq_free(req->sq);
> +	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2)
>  		nvmet_ctrl_fatal_error(ctrl);
> -	}
>  
>  complete:
>  	nvmet_req_complete(req, status);
> @@ -574,7 +573,9 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
>  	status = nvmet_copy_to_sgl(req, 0, d, al);
>  	kfree(d);
>  done:
> -	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
> +	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2)
> +		nvmet_auth_sq_free(req->sq);
> +	else if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
>  		nvmet_auth_sq_free(req->sq);
>  		nvmet_ctrl_fatal_error(ctrl);
>  	}
> -- 
> 2.53.0

