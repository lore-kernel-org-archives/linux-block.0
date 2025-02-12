Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AB378F4E
	for <linux-block@vger.kernel.org>; Wed, 12 Feb 2025 02:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327391; cv=none; b=RiJlGRt2cNk5ork/+8GTlxV0+DBIi8Q3AzKLW84tgN5m4s6yg1Wv7GBBir0k78+OdLWYIvEx7nIVECRjKjy7TUymuDMjloaydG9CTZOIp95n5jHd3UHOB1Baxrooa77VEVOdC15QVuDaTw4iYxQkenZiaZP90xLF9eGZFcQFVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327391; c=relaxed/simple;
	bh=2IgyZ0g7V2m88LSvM3T3N2W+3GlHleRe3LMJAhSFzg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efaQmcS6QBpfgAkCp2MaymPzD4By4CqB6iau8Ix1n+Cd34bKNtdPIN5COCV5nkV5KK7KUwR9dPv7Cl4/qFPcaLhU54Xduf7vgRJKteZJu/GIJ8zxPn5qt+qTxbWkQwWUdCVY6FOLW9tTpt03PEPu9BVHF7lOHMNDvth9YpWJOkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IcEO0h/2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IcEO0h/2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739327388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X39yARt4BW8kEibKLCcAsrQXU54adKPNw9W/thdQxrY=;
	b=IcEO0h/22csmhYufu3R1Zay/llDGQPy/Op7DgmlqCbsxJdkiLkwuJj0Hf+PT+qlsKWygjX
	fCJr1X7Prh6Oqai8F/xL3/mXvyMvwqyk7d85KAcivgICi/skl0/P4g9cf3EdLpiga6JAYW
	K+75viuKS5MrTQV3K0aJS8VzFIktrW4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-tlW4EdVNOfWTPZgnjJBirA-1; Tue,
 11 Feb 2025 21:29:45 -0500
X-MC-Unique: tlW4EdVNOfWTPZgnjJBirA-1
X-Mimecast-MFC-AGG-ID: tlW4EdVNOfWTPZgnjJBirA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31DFF1800374;
	Wed, 12 Feb 2025 02:29:43 +0000 (UTC)
Received: from fedora (unknown [10.72.116.142])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A046918004A7;
	Wed, 12 Feb 2025 02:29:37 +0000 (UTC)
Date: Wed, 12 Feb 2025 10:29:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: asml.silence@gmail.com, axboe@kernel.dk, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, bernd@bsbernd.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 0/6] ublk zero-copy support
Message-ID: <Z6wHjGFcFCLMnUez@fedora>
References: <20250211005646.222452-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211005646.222452-1-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Feb 10, 2025 at 04:56:40PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Previous version was discussed here:
> 
>   https://lore.kernel.org/linux-block/20250203154517.937623-1-kbusch@meta.com/
> 
> The same ublksrv reference code in that link was used to test the kernel
> side changes.
> 
> Before listing what has changed, I want to mention what is the same: the
> reliance on the ring ctx lock to serialize the register ahead of any
> use. I'm not ignoring the feedback; I just don't have a solid answer
> right now, and want to progress on the other fronts in the meantime.

It is explained in the following links:

https://lore.kernel.org/linux-block/b6211101-3f74-4dea-a880-81bb75575dbd@gmail.com/

- node kbuffer is registered in ublk uring_cmd's ->issue(), but lookup
  in RW_FIXED OP's ->prep(), and ->prep() is always called before calling
  ->issue() when the two are submitted in same io_uring_enter(), so you
  need to move io_rsrc_node_lookup() & buffer importing from RW_FIXED's ->prep()
  to ->issue() first.

- secondly, ->issue() order is only respected by IO_LINK, and io_uring
  can't provide such guarantee without using IO_LINK:

  Pavel explained it in the following link:

  https://lore.kernel.org/linux-block/68256da6-bb13-4498-a0e0-dce88bb32242@gmail.com/

  There are also other examples, such as, register buffer stays in one
  link chain, and the consumer OP isn't in this chain, the consumer OP
  can still be issued before issuing register_buffer.


Thanks, 
Ming

