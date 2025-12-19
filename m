Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5A425B662
	for <linux-block@vger.kernel.org>; Fri, 19 Dec 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766153805; cv=none; b=AXhbQBbndXNlcP3KPYbYvDwsszg6kqq3XIOeJ7Ri8BSJFw7C30Hj/cUMOAuRNAgiwoMLeL327rcZBGEXZf24PBeVVDWjQAGddCg5vZSOO8l1uMePNmTheaqq4Hc7mDGWV7npuidk1iBbou+FMmFS3CkZewmFgQivmDeCqqrUmv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766153805; c=relaxed/simple;
	bh=qFdBthuvOaf5gMDGOSU82adg6xi1wuqIG4gH/BzEp80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXWQJipfR1QkIclxvJ0a4MJ98/3MyAqtc+pnvWI0EQchpnnGAJfhrz44N4hMx0BXWYHAkGYVI5ABYV3nK2Wv/oJo8VkPHk81BbRZtKQKWyQBRidoLs09+VW1f0qz8QdYzQRWBV6KXCK8cJ8+XZACJ/PqlwfU9d3X1n58VPjAffk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2lFlDzP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2lFlDzP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766153802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iWXPrzLiJtl4wMOdUVzXHjiRsKB7d+Unwe6U8L+x5pE=;
	b=F2lFlDzPAAsi569A/EBFMTHbLxrMjslKnXFegAqsMgkwrx97s87i4t9sJ77G1ir+cjARlo
	EP3WJjyiYi8lxV38aEtftuhitR7Wc1P3aNEWEvpzuKYdcnguFRWL5WcGC2Xv/f5I8MyNHW
	x30BtNeAryo+58hZcaOmKw7aCZR+fOE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-9u1jT9wROnWuWrlt2bYX1A-1; Fri,
 19 Dec 2025 09:16:39 -0500
X-MC-Unique: 9u1jT9wROnWuWrlt2bYX1A-1
X-Mimecast-MFC-AGG-ID: 9u1jT9wROnWuWrlt2bYX1A_1766153797
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D986195608E;
	Fri, 19 Dec 2025 14:16:37 +0000 (UTC)
Received: from fedora (unknown [10.72.116.41])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3082A180045B;
	Fri, 19 Dec 2025 14:16:25 +0000 (UTC)
Date: Fri, 19 Dec 2025 22:16:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 03/20] blk-integrity: take const pointer in
 blk_integrity_rq()
Message-ID: <aUVeLmewQ0R-Z6ge@fedora>
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-4-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217053455.281509-4-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Dec 16, 2025 at 10:34:37PM -0700, Caleb Sander Mateos wrote:
> blk_integrity_rq() doesn't modify the struct request passed in, so allow
> a const pointer to be passed. Use a matching signature for the
> !CONFIG_BLK_DEV_INTEGRITY version.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

