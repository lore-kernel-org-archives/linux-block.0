Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6A14A0B7
	for <linux-block@vger.kernel.org>; Fri,  5 Jul 2024 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720185771; cv=none; b=TmvKJZSVtxlRtVnY8rZDNET0+6U6ilbYoz76vMVOfvHPEij6QZRK+SvYZyAsU5qYaSAI9YzCvRgGclcxHMSfjST4TvKfCsv/tu1pn8qVCXsb1yGdCocrBJsAhNfV2pca2QfBYGA9zdEi+CWNkeix+m1ONkltECY9lwpZxWRG2CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720185771; c=relaxed/simple;
	bh=5ZI1opG3x0dgqXkVUaoIxovNwoAeuTlTuiZ/kdAimoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJaCglXog37/Fp31WhSu5HOOxca1pGrLLn+MRPviY2UnkoJ6aP4k0cM/40POpj7UmnQK6KF9W3pP6iwOsv+mgv8FPBsJ+VukVdokD4ZWBkZVWIzPflS6O8qmUBfLDMePS6t4Pvog9p/Od0qYw3qoSyXSPKHz+AB9dNYbsMHOeT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVaTQnwI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVaTQnwI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720185768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZI1opG3x0dgqXkVUaoIxovNwoAeuTlTuiZ/kdAimoU=;
	b=CVaTQnwI2E0RPa6s9DaNd9gkOhi1k/E8bkFmdnkI6gNoCVG0BDk2h23IEv7IGp2sJhXyGw
	cXIW3G95m/AQJ4gdPxFPoRDRD746sXu3a5EEZAyGNQeqmP1TRZqWeHz4RAXTnigqNzdjbw
	XfuiNfrOSk6XUFOwvAxBuob1fHVvTTU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-0iIhh97YPhupfvhKkoRsIw-1; Fri,
 05 Jul 2024 09:22:47 -0400
X-MC-Unique: 0iIhh97YPhupfvhKkoRsIw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 828F81954B35;
	Fri,  5 Jul 2024 13:22:45 +0000 (UTC)
Received: from fedora (unknown [10.72.112.111])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4542E3000184;
	Fri,  5 Jul 2024 13:22:40 +0000 (UTC)
Date: Fri, 5 Jul 2024 21:22:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH 1/2] block: also check bio alignment for bio based drivers
Message-ID: <Zofzm6TRrOFb5iy9@fedora>
References: <20240705125700.2174367-1-hch@lst.de>
 <20240705125700.2174367-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705125700.2174367-2-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Jul 05, 2024 at 02:56:50PM +0200, Christoph Hellwig wrote:
> Extend the checks added in 0676c434a99b ("block: check bio alignment
> in blk_mq_submit_bio") for blk-mq drivers to bio based drivers as
> all the same reasons apply for them as well.

Do we have bio based driver which may re-configure logical block size?

If yes, is it enough to do so? Cause queue usage counter is only held
during bio submission, and it won't cover the whole bio lifetime.


Thanks,
Ming

