Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73346263C9F
	for <linux-block@vger.kernel.org>; Fri, 19 Sep 2025 03:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758254020; cv=none; b=IMpj9cYFozjEuHQhAN3S1IsqX7crc+MlnUvIbCal1eINLVejJaK5nRL4McoauCLmBXTZCbfsijLxMeoAJqSeTXHJ13fRQTxu3uKMKJE0B78EGPBwcIspMPeH3u2tjI8cQdh+ul9+tBX2M9rdwLnMrNtcbisXpIzpOtnXe6GBbiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758254020; c=relaxed/simple;
	bh=r7u+fIYunh1tQjSKJ4gx+/XeyyhWsam1c6dx2oNcQVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBIWhRAWzixWmrCayzakx9EDrsrr1bkd5t1GZnRvHj+Jhr3bjsECuW5CPOFgGd6W4WqEuL4kEe77yPmwpmdykvZUwEinnTpxjF6nnATOOz/JT4IG1kRr5GW9bSM0tTp2gW6vf5AHweqpoN5XWa9S10aiyakPoQcqNTJKgwqrnYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijgrXA4n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijgrXA4n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758254017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eQrwM23HsGfKWdvsFTuBJVXHncfoNOQVfb470fO9tiU=;
	b=ijgrXA4nBv/iJ26DRq3xvAiR+ErT5oFn7mhuexr8tXvCAGnr64ClThAfLZ81N7gdWrfoP3
	BLrbp7D2w5uZkOkyjwtsykmWXJaVl5OQXVZJaCSPy6gCVKxc6VADSppD2E1ypUnO3zFWB7
	JSFotHBurF5wcb9cRpBPZNMO671NZZE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-nEh6cxuiPwyutF-Z5CILuQ-1; Thu,
 18 Sep 2025 23:53:31 -0400
X-MC-Unique: nEh6cxuiPwyutF-Z5CILuQ-1
X-Mimecast-MFC-AGG-ID: nEh6cxuiPwyutF-Z5CILuQ_1758254010
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 239FE180035C;
	Fri, 19 Sep 2025 03:53:30 +0000 (UTC)
Received: from fedora (unknown [10.72.120.15])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ADD818004A3;
	Fri, 19 Sep 2025 03:53:22 +0000 (UTC)
Date: Fri, 19 Sep 2025 11:53:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] ublk: remove ubq check in ublk_check_and_get_req()
Message-ID: <aMzTrazYYfN0eTfM@fedora>
References: <20250918014953.297897-1-csander@purestorage.com>
 <20250918014953.297897-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918014953.297897-2-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Sep 17, 2025 at 07:49:37PM -0600, Caleb Sander Mateos wrote:
> ublk_get_queue() never returns a NULL pointer, so there's no need to
> check its return value in ublk_check_and_get_req(). Drop the check.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

