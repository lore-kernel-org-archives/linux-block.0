Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAFC1DFFD
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 02:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302936; cv=none; b=N6V0YNCQxAA86/jYcBWpuUt4GS2V90i9c4pj8WTApgvusdLwuSvVJVDtq5iZOuvaUdPNL4geBm/i2v+LOjwznod4pbJJSMuf/HW8lhT+E0zaTD0EUZM+VsM+yjE6yxlzmKLs2gu54gqTZZdlK2ycPG7HRYgh/gGAfe3KPcoMZsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302936; c=relaxed/simple;
	bh=EXRrD5zZ3BO53qhfNw9BukEZkzxSGaRPGtQEG7bh/kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdVzsUM++cZuLQepolC86I+wkTiR4NgpvmAXGM4kdNTu9M5rWlC55EHUiB2igO/RMSiDT7nVON/G0wnF5BVTzS4iEVEzNY7qCVNatzHTKbcgS1o/i2lM42uEFSFzP/80kM6YUo0W/Df/IqY3BY8E5lcPtW24MofZcBZCZUgxQ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I3BR51AM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3BR51AM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736302932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BUmFn0QdcbnrP+kAJCEAifsFmvKuEgoz5SMuFeJiqRM=;
	b=I3BR51AMiRBWDqx65nOjDIlwqp50x5rWfhL/XW1XMNZHXsxOrLOBG4dLUxRX+Td5Ly3cxD
	rztELj9Z2YYXKOQV826vvYAk1CYK7b/r7n5cfC4SmluTHje56v08VYS5SU6WtKafazwMQo
	w03iLSneMRV0TULxyLrJu0k0Z4TFUO4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-rFxU6K-JNFO5J-Hw5JdVVw-1; Tue,
 07 Jan 2025 21:22:07 -0500
X-MC-Unique: rFxU6K-JNFO5J-Hw5JdVVw-1
X-Mimecast-MFC-AGG-ID: rFxU6K-JNFO5J-Hw5JdVVw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D476919560BE;
	Wed,  8 Jan 2025 02:22:04 +0000 (UTC)
Received: from fedora (unknown [10.72.116.126])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E153D3000197;
	Wed,  8 Jan 2025 02:21:58 +0000 (UTC)
Date: Wed, 8 Jan 2025 10:21:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: fix queue freeze and limit locking order
Message-ID: <Z33hQfkbolsku7yr@fedora>
References: <20250107063120.1011593-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107063120.1011593-1-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Jan 07, 2025 at 07:30:32AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this is my version of Damien's "Fix queue freeze and limit locking order".
> A lot looks very similar, but it was done independently based on the
> previous discussion.
> 
> Changes since RFC:
>  - fix a bizzare virtio_blk bisection snafu
>  - set BLK_FEAT_POLL a little less eagerly for blk-mq
>  - drop the loop patch just adding a comment
>  - improve various commit logs and coments
> 

loop_set_block_size() needs same change, can you cover it to this series?

Thanks,
Ming

