Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1471CEAD6
	for <linux-block@vger.kernel.org>; Fri, 15 Nov 2024 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688201; cv=none; b=FXbf5X2VNo4V9yyByq9bhWyi9ETfQMAdK+YCNiwNSSxH4P6d0fFf7LKpwX1G3jC+lr9hx+G5PhgrdljbcfEKSmESdN2iSQ0eUbM1fjyRMo68EWE/YHZcZ7JsIq6hdr+Kp8S9LTT12EGUbr38zpV+JZ1QDjain8PP34Iy2ImjoFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688201; c=relaxed/simple;
	bh=xTqB4718tXms6bvog7y3vdT7t7xnRL17SdaAX4LnHDM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHtqbg86tJoUTxjnWVCt22K/CFH1FFT1Qa/Um0nfIsceYp4ei9QPQVuANExR9Aghi/SBELazWiBRJ8vEtvE4f04y57ILXPt0LIpciSKgBgAxCFTxJdO7e9vryLHwQEbs/wZgeO9VrWxgz/5KLH7uOZjDKGBHMqzEQCYfEluQ2OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SlD2eU62; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlD2eU62"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731688198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+UaaEkmiUYycOEKE6OMcE3A96SgVAOVks2yku9Hxaec=;
	b=SlD2eU623OPbAXBM7y5PWgy8O5RspSwQgb/Pe5SSeIxyODtrJgr78pWqHIJS8c89jB5WFu
	k3I6mNZgsp5M9QniwPi1mElW8z6XzH2KNpy3g90dlr6b2Gj+PMXG5bJiMagEsen+nvnqPn
	6Hbfbnimk/aZ3lqpOcO/Vs1qiECqdtE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-JnW2sMTzMGe04DncpICcow-1; Fri,
 15 Nov 2024 11:29:54 -0500
X-MC-Unique: JnW2sMTzMGe04DncpICcow-1
X-Mimecast-MFC-AGG-ID: JnW2sMTzMGe04DncpICcow
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA56F19560AA;
	Fri, 15 Nov 2024 16:29:53 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 711C419560A3;
	Fri, 15 Nov 2024 16:29:51 +0000 (UTC)
Date: Fri, 15 Nov 2024 10:29:48 -0600
From: Eric Blake <eblake@redhat.com>
To: linux-block@vger.kernel.org, nbd@other.debian.org, 
	Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: question on NBD idempotency
Message-ID: <zhoxmjoys5ikhg4uqelexincgyx5ehgowg3fretnlpquhzdevo@6rwmb7y5zvtz>
References: <2i75j4d6tt6aben6au4a3s63burx3kvtywhb3ecbh3w2eoallm@ye34afaah6ih>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2i75j4d6tt6aben6au4a3s63burx3kvtywhb3ecbh3w2eoallm@ye34afaah6ih>
User-Agent: NeoMutt/20241002
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Nov 15, 2024 at 09:43:29AM -0600, Eric Blake wrote:
> 
> But if there are no such ioctls (and no desire to accept a patch to
> add them), then it looks like I _have_ to use /dev/nbd$N as the tag
> that I map back to server details, and just be extremely careful in my
> bookkeeping that I'm not racing in such a way that creates leaked
> devices or which closes unintended devices, regardless of whether
> there are secondary failures in trying to do the k8s bookkeeping to
> track the mappings.  Ideas on how I can make this more robust would be
> appreciated (for example, maybe it is more reliable to use symlinks in
> the filesystem as my data store of mapped tags, than to try and
> directly rely on k8s CR updates to synchronize).

I wonder if xattr might be what I want for associating a user-space
tag with the device.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org

