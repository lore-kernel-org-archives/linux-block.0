Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888D7F4FA
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750667394; cv=none; b=c3WloAVkwb22FztlO2nh5HCMBAVrdOYBST+YgrTFt2Vmf5YAtuCfGfagp00ljVsSNZQdwse1ghQ3gLJE9Tj/DaeLzn2mMCXJSwj0SifXoX4pTmFKItZGs3LHZuBj3vhIgwuk+Y0KpPTRTjMIYH9mDQYho1S3MXLjOuBWTO1Idmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750667394; c=relaxed/simple;
	bh=rLgh0h+5fqC7ithE0zX54h/+cCXSejpJq2xEKouZ+jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkfnZ1+WljfCkmA78g9Scse7bIwFbmzj8rjbQMAW/+W5AKPDP/vJ9oio+2lUUS1y5Yrk5p2+u3oQc4Sq9qiSXH6lpjAJ6CrBxjFPJCttJ9CT0w9i8ro6Qogs42YTI9VnWplHOq5+ZuIDAoqXfyMNvuqrtSRO0Y0HMcCcyyrQpIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e7s1uqP4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7s1uqP4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750667391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YTPBsehA0CF+x3bw/1ZgF0i6Cq7WJ4W5k0SWtWRsAJk=;
	b=e7s1uqP47MCOoc+jTcpQE/TlyLfzYuUkfxO+tVWXkD7WkjB5TNko7z5rVs3+DidAT7Y5Pc
	53F5ogBCOmt8uMtJVmPKTrYlpQUlIzGQhveEZAhn6r7jirpUjamXIN1g9YzpaY50bQqZ2F
	vrLARKIRZD1VRhGHWlc/wb7aREzZPzE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-uLSv4TIiPQ6_8cIiXIB1bg-1; Mon,
 23 Jun 2025 04:29:47 -0400
X-MC-Unique: uLSv4TIiPQ6_8cIiXIB1bg-1
X-Mimecast-MFC-AGG-ID: uLSv4TIiPQ6_8cIiXIB1bg_1750667386
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2BF519560B2;
	Mon, 23 Jun 2025 08:29:46 +0000 (UTC)
Received: from fedora (unknown [10.72.116.65])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AE2C19560A3;
	Mon, 23 Jun 2025 08:29:42 +0000 (UTC)
Date: Mon, 23 Jun 2025 16:29:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 08/14] ublk: don't take ublk_queue in
 ublk_unregister_io_buf()
Message-ID: <aFkQcSl0yC9tfp8G@fedora>
References: <20250620151008.3976463-1-csander@purestorage.com>
 <20250620151008.3976463-9-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620151008.3976463-9-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Jun 20, 2025 at 09:10:02AM -0600, Caleb Sander Mateos wrote:
> UBLK_IO_UNREGISTER_IO_BUF currently requires a valid q_id and tag to be
> passed in the ublksrv_io_cmd. However, only the addr (registered buffer
> index) is actually used to unregister the buffer. There is no check that
> the q_id and tag are for the ublk request whose buffer is registered at
> the given index. To prepare to allow userspace to omit the q_id and tag,
> check the UBLK_F_SUPPORT_ZERO_COPY flag on the ublk_device instead of
> the ublk_queue.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

