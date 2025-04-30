Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1598021C9E7
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746022401; cv=none; b=ALO27npEK9jbo5cOm3CsBTro5YxdfvgtYah+xvWyZzw+Dac6xSx2rsJGRcZksnzKkVA636RTMyXTVmXrPWkkFkNA/CZj4dACEcDt92rOjlkaFcxTJ6kU4x/Z9s9XPlPJvWGBQgT0t0HGQ5iDD+Q8eDu0R4PDhoZ3bzOgQeFIQlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746022401; c=relaxed/simple;
	bh=v0xzpPFQsBmcdHkV23fw0EckqVXKdWRNQtSJpTh5fLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAN9h/7KuewDixewYjfW/HCVqe7FsqkY5UghF80l7SIk51t8rGMLEj5mz9QUxHPm+3F7cUqaC38MEwKFXao5Pd6g7CezBpZ7AhKKV8xF6c7vBtC+bzWVs4P+sAlpT622nvgJ+3Rn57mL5reo0SQR8YmSUsESBDFeRw/RbI+wS9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNzwMClj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNzwMClj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746022398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kMwnRPz2CVfAynlC06yjPT5XNTGqMD9YFb/OO2JgfXg=;
	b=QNzwMCljx7J1Zc0Db+rg/35kRSeW8Sc7i8JcOsB8bkcQbFhHIzZ/evdRIIJuvOeHWsWGX5
	0p2QgOIJLnGxPzsLCGumi9Ild73JTP40KRaaF0u7EJFpPGBwQhx6Y4ncgf/GZ7poT3EoYR
	YesdaTiWyQeaAcNw1UC/AMATu+BmkiU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-WzC1ltXlM0ajSE1uWG_hJA-1; Wed,
 30 Apr 2025 10:13:15 -0400
X-MC-Unique: WzC1ltXlM0ajSE1uWG_hJA-1
X-Mimecast-MFC-AGG-ID: WzC1ltXlM0ajSE1uWG_hJA_1746022393
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BC77180098E;
	Wed, 30 Apr 2025 14:13:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.59])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14CF519560A3;
	Wed, 30 Apr 2025 14:13:07 +0000 (UTC)
Date: Wed, 30 Apr 2025 22:13:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH V4 00/24] block: unify elevator changing and fix lockdep
 warning
Message-ID: <aBIv7gigOu9qCucE@fedora>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
 <20250430140837.GA6702@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430140837.GA6702@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Apr 30, 2025 at 04:08:37PM +0200, Christoph Hellwig wrote:
> What tree is this based on?  it fails to apply to all of block-6.15,
> for-6.16/block and Linus' master branch for me.

It is based on the latest for-6.16/block:

53ec1abce79c (block/for-6.16/block) brd: use memcpy_{to,from]_page in brd_rw_bve


Thanks,
Ming

