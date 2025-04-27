Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F651524F
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745759009; cv=none; b=CqQ+F0ZlSDCBtiG1jC83XNYOYeTIP0bUkq/74xw865G+Wp/KXGAY/B9QRswG0RNYKkHQ/w6jfuzsB2WrTn6iSOZmFN8AyZ0TXVcw2q4dD7sLVJAlJ6t/6MB3ZgXMgGlUMWILuEaqRVrk4KteKccVgrTL1Rcv6uNvj0jcuyoyntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745759009; c=relaxed/simple;
	bh=EnhTCkCCjstjTOS3cvLSPx8ihzWmuy58ZAqB/nLmNFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hobOxaBOFocndYYtJMRgamWrPFmRRvILjmA7JjRRdKHRfxDTimgYJvzp1qA36iS8T50lMONlivXJLh9ov7NTCxcwvn+mZ6wOQTnO6n8/U8RRpL9O4eCjXdLF2tOGLc1kamLKkS73iFAU5+nXV0qt813A4rx7NHU1DQ4NRSrzzYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxyiAZRm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxyiAZRm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745759005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rk061VGy61aNDeoFW5R8PsdQHZHCvwhvyL/4EM79Bhw=;
	b=SxyiAZRmUraSoKuBJdrzIF4p6NU5j5pFiqJz4eZUXgHl2CmbMp9w6fhyMxNDOWZtWAbgKQ
	GYyAXePSPHjsL2YOqTQn6WakMeMvqUooyS4QGkTnsjxKDE7WT3QvagsFz6pkz4UXe4fUAv
	87m7pSi8UlV8xZ5590lDcpMPmh4Iwfg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-wd9cMJCaOkyJ9I5SUMDUjQ-1; Sun,
 27 Apr 2025 09:03:21 -0400
X-MC-Unique: wd9cMJCaOkyJ9I5SUMDUjQ-1
X-Mimecast-MFC-AGG-ID: wd9cMJCaOkyJ9I5SUMDUjQ_1745759000
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B76521956086;
	Sun, 27 Apr 2025 13:03:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.119])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F9A31956095;
	Sun, 27 Apr 2025 13:03:16 +0000 (UTC)
Date: Sun, 27 Apr 2025 21:03:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] ublk: don't log uring_cmd cmd_op in
 ublk_dispatch_req()
Message-ID: <aA4rD7sy1e1WDI1U@fedora>
References: <20250427045803.772972-1-csander@purestorage.com>
 <20250427045803.772972-5-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427045803.772972-5-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sat, Apr 26, 2025 at 10:57:59PM -0600, Caleb Sander Mateos wrote:
> cmd_op is either UBLK_U_IO_FETCH_REQ, UBLK_U_IO_COMMIT_AND_FETCH_REQ,
> or UBLK_U_IO_NEED_GET_DATA. Which one isn't particularly interesting
> is already recorded by the log line in __ublk_ch_uring_cmd().
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

