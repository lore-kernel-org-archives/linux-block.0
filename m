Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FE41581E5
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 07:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734419163; cv=none; b=mgCQccZ8hupvWBhRjHlh3PoHWo3HZtfipNyNSQyzyt6oQBY56H6tapaRk04G6BiAn1jAaKb5glBAH29w5kSNqM/ukhf2oP2MVSu0zf/xlYwYoCdq5yPjLYEb3hqePVSvhBXfZoKdEPXJVhh9z3zrCu1zEevqH3mFwaJJGfAJxg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734419163; c=relaxed/simple;
	bh=Gf4tUZlP98C1x/Wd800InNzbnXPQ/d5jObpLtOOxGz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoDnSN1Y/Owjvytv0iCtsXGnJ488iSd9eOjdPjGkfBK7tfIRKYd+IphIAibC757JKu6Vj7/rAoMAjhOnJogxDSYNdoBN3hw7IXftKXW5YW9hOq/LlIHF1lvwx0nF66tiAbddDZrirDZ+dXVLh+yXfSuUIOsuo517jN4vRUoor74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GGYJ4GoM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGYJ4GoM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734419160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ucmUcDhtIH/+Z6csGc1l4MAcPGn8Q/OWsh+/nxSEwvA=;
	b=GGYJ4GoMKfaCJsdLGCyDliZdnKztoZrJy9Bw7VdF1Qm5Ya/48UIek9fcW2HWYEqIFTtj5D
	KVH/7Nx0uI4cNcJ6HTiUWZZaq6aTrH1eZAcGzqr7tNnIjjngcS/eMAsMiZWiG5RjCAsjxZ
	wsuCs1pNHFYRsPe/Ot6B0Q8+UavfBIs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-X4sL_C1XOFektkG8QEv3tQ-1; Tue,
 17 Dec 2024 02:05:58 -0500
X-MC-Unique: X4sL_C1XOFektkG8QEv3tQ-1
X-Mimecast-MFC-AGG-ID: X4sL_C1XOFektkG8QEv3tQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AD62195608C;
	Tue, 17 Dec 2024 07:05:57 +0000 (UTC)
Received: from fedora (unknown [10.72.116.165])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC8C319560AD;
	Tue, 17 Dec 2024 07:05:53 +0000 (UTC)
Date: Tue, 17 Dec 2024 15:05:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: avoid to hold q->limits_lock across APIs for
 atomic update queue limits
Message-ID: <Z2EizLh58zjrGUOw@fedora>
References: <20241216080206.2850773-1-ming.lei@redhat.com>
 <20241216080206.2850773-2-ming.lei@redhat.com>
 <20241216154901.GA23786@lst.de>
 <Z2DZc1cVzonHfMIe@fedora>
 <20241217044056.GA15764@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217044056.GA15764@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Dec 17, 2024 at 05:40:56AM +0100, Christoph Hellwig wrote:
> On Tue, Dec 17, 2024 at 09:52:51AM +0800, Ming Lei wrote:
> > The local copy can be updated in any way with any data, so does another
> > concurrent update on q->limits really matter?
> 
> Yes, because that means one of the updates get lost even if it is
> for entirely separate fields.

Right, but the limits are still valid anytime.

Any suggestion for fixing this deadlock?

One idea is to add queue_limits_start_try_update() and apply it in
sysfs ->store(), in which update failure could be tolerable.


Thanks,
Ming

