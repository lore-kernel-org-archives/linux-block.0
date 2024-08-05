Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B91D15B0E0
	for <linux-block@vger.kernel.org>; Mon,  5 Aug 2024 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862376; cv=none; b=SsIAjx3h2Qxo2nMOp4+n/oIma1Tdi3BHRE3yIZmmWq2V7xSlVl0/WZzi+w6bynWBtiLSr6ErVqdzSZvZ9J+k+uGJzpLZNYov69ZA9xJK/1yB4G3OLN4jTSbdKVQ9HOKYh9HtuAO2vkQAt++ePWovrFGqHIUlNJ3zsClZcFaYl74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862376; c=relaxed/simple;
	bh=rJS+qElkhy5+j66Bcy+bEPtu7bAV5J+oGQhJjrLaFq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Elfkp+iajCC8efO4i6jN4l+mjnjnqRAl2K1lwKEw1sNT//EF8IPJL15y/l3hUG7vJB7goESLScpRgVPqLEh4jRe9hTxU5sM6o0Z/KMn3m/mvD9MrqBRHPFFHCoVfYgrszfzXduGofXEQZyyi/LSupCkgSe53zkPgUZNOsSvYSq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=StaDBLV5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StaDBLV5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722862373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wg5uEtaKzzmeOJAOD80NwwJkOITcZMlBczYm/4JZgkM=;
	b=StaDBLV5rPmtUyOhQzG9+EJ8OUXPtnSYvOEkC5MnC2ewIeQcsKabDprlo4eF9rRyFzVdbm
	NJJHDUSRlxZ1wJ47ngvJVxYOZQBK0LEaI6uXAfO7kPik47PH3Fc1iqYvI6YJ5FzFpo7YjH
	sg8qEHhTARKT+RpzGDMEd6w+dfTOBaY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-KaKSC-31OV-NDoQoT0NnNg-1; Mon,
 05 Aug 2024 08:52:49 -0400
X-MC-Unique: KaKSC-31OV-NDoQoT0NnNg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2AD11955D4C;
	Mon,  5 Aug 2024 12:52:47 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28F3219560AE;
	Mon,  5 Aug 2024 12:52:44 +0000 (UTC)
Date: Mon, 5 Aug 2024 07:52:42 -0500
From: Eric Blake <eblake@redhat.com>
To: Wouter Verhelst <w@uter.be>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nbd: implement the WRITE_ZEROES command
Message-ID: <f2kaityrjmmstzvqq7xu755ikstida2hcnnng634oeo6fxjfbj@zrgbeik6fwz6>
References: <20240803130432.5952-1-w@uter.be>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803130432.5952-1-w@uter.be>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sat, Aug 03, 2024 at 03:04:30PM GMT, Wouter Verhelst wrote:
> The NBD protocol defines a message for zeroing out a region of an export
> 
> Add support to the kernel driver for that message.
> 
> Signed-off-by: Wouter Verhelst <w@uter.be>
> ---
>  drivers/block/nbd.c      | 8 ++++++++
>  include/uapi/linux/nbd.h | 5 ++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 5b1811b1ba5f..215e7ea9a3c3 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -352,6 +352,8 @@ static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
>  	}
>  	if (nbd->config->flags & NBD_FLAG_ROTATIONAL)
>  		lim.features |= BLK_FEAT_ROTATIONAL;
> +	if (nbd->config->flags & NBD_FLAG_SEND_WRITE_ZEROES)
> +		lim.max_write_zeroes_sectors = UINT_MAX;

Is that number accurate, when the kernel has not yet been taught to
use 64-bit transactions and can therefore only request a 32-bit byte
length on any one transaction?  Would a better limit be
UINT_MAX/blksize?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org

