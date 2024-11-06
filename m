Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF83D1E517
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 00:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730852678; cv=none; b=eCFhXaPDYjNcJZIwDoKecevi1zXSq4MjcPrsW+bU0UrwJjveYc+OAT+zIpUTFBYlfa7W7w9Kqf5+XM3ee8hvDknP3ONLvC7FFIi0yjvsM2tOVDYwclrbxh+lxG1HeyNhM/wEWcsoY+jmSCu0+qf7lkBjIOIoi2xQPv1VTCglNc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730852678; c=relaxed/simple;
	bh=vKFQmVXxaVUgu/rOoGYm15BV13iXOcJ0Rk+dGPGBMVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=id1kwihhIsmFNnugvv1R9vs0lm2me4/JHzdvALAgUNJj7OBRTw2HKYspeUWR6KMX9xYtWM2MjM0H3R3MxD6k6MUAwDviy5uo8IIpGc6NL87eSvbgZQxUSZH0cTIR6YT/NWEBTlmk9P3rKoJ6EV/uGJomNrxuYVRH7td1/9Nn8BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5ismSFR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5ismSFR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730852674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9vYyhJYPtOgmRXcFyWBmXail1BSOKMF8d9N5hqjPCqU=;
	b=P5ismSFRWUrvfUjQTyZs53sqUbfAplQjJR31raACjdC7hdc7QwJW2REQfav5wXNMIZBBsf
	0+AxkonbO0dRDdrwhDckadeFSYIuGfe2lsFWeEezmL2/XZCpl+49RGxWF+JuX39hZ6vhog
	IOEZjf9HW0qrxoYBpnRnq7RKzQBlz4Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-C0DSgyPQPxqRALxQ93QKLQ-1; Tue,
 05 Nov 2024 19:24:33 -0500
X-MC-Unique: C0DSgyPQPxqRALxQ93QKLQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3EC81955F3B;
	Wed,  6 Nov 2024 00:24:31 +0000 (UTC)
Received: from fedora (unknown [10.72.116.25])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2E7530001A6;
	Wed,  6 Nov 2024 00:24:28 +0000 (UTC)
Date: Wed, 6 Nov 2024 08:24:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 0/4] block: freeze/unfreeze lockdep fixes
Message-ID: <Zyq3N8VrrUcxoxrR@fedora>
References: <20241031133723.303835-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031133723.303835-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Oct 31, 2024 at 09:37:16PM +0800, Ming Lei wrote:
> Hello,
> 
> The 1st patch removes blk_freeze_queue().
> 
> The 2nd patch fixes freeze uses in rbd.
> 
> The 3rd patches fixes potential unfreeze lock verification on non-owner
> context.
> 
> The 4th patch doesn't verify io lock in elevator_init_mq() for fixing
> false lockdep warning.
> 
> V2:
> 	- drop patch 1 and fix rbd by adding unfreeze (Christoph)
> 	- add reviewed-by

Hi Jens,

This patchset fixes several lockdep false positive warnings, can you
merge them if you are fine?

https://lore.kernel.org/linux-block/Zym_h_EYRVX18dSw@fedora/



thanks,
Ming

