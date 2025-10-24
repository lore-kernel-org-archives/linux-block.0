Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A3626ED29
	for <linux-block@vger.kernel.org>; Fri, 24 Oct 2025 03:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761276472; cv=none; b=S865+LZK8cJ7q+cYfO4xP5L867n1EhyN/G2CaVsuP6GP0Nu8PORkDR9dEE7onSFzi6W2COYFVaKPobp3oVkLB7UOCR164CPrFpyiiZ0l3jZVMIFyvLt5QedE9/fWKn1IUiWWO5EGQDoCw4O4tkNyVoRr8Mnp2uw/6speCTV3VuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761276472; c=relaxed/simple;
	bh=jYlnoA//N3BMbb6A8YOUE+u4Cg0TGYZ4lEykKO7L+04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOAZqfjOyGSaHUneifvz6xzK/zJYyKvOTlnmYPATUCo0sntglkHJnvJEHuOzvbaR1qi0Gee3NzABDY91kx5XZF2H/Vy3TJNocBh9FoboiSJc0lvZEaXell8yOr70q4bmXo0t/KwrwUoltxY58ccW9va+Sjyd18dTpfwHfACUOL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ca+qG8Uk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ca+qG8Uk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761276469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ibXRoeaySX78RFSu+m8DZA78GB7YAHpBsMVeutqEJxM=;
	b=ca+qG8UkI59VAicxVHU+NSRpMMiIodhqQqtUbCiEvuuXFzGdas4k/mxp39gmP+3tWmZxiM
	ZuuVgEWHgHEgqy+uEZ5MzX3QAN75q4et77kWiDApvaFo/sQsbfj/+kQfOkG7d/u0AEJu9f
	tg27g7p7SZ5BtRbwpZCYfX0WGKOqz04=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-8SvPHszkMW-c28UCoYrY1Q-1; Thu,
 23 Oct 2025 23:27:46 -0400
X-MC-Unique: 8SvPHszkMW-c28UCoYrY1Q-1
X-Mimecast-MFC-AGG-ID: 8SvPHszkMW-c28UCoYrY1Q_1761276464
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEC721800245;
	Fri, 24 Oct 2025 03:27:42 +0000 (UTC)
Received: from fedora (unknown [10.72.120.13])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 336F9180044F;
	Fri, 24 Oct 2025 03:27:33 +0000 (UTC)
Date: Fri, 24 Oct 2025 11:27:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] io_uring/uring_cmd: call io_should_terminate_tw()
 when needed
Message-ID: <aPryIDKfN1GB3Ips@fedora>
References: <20251023201830.3109805-1-csander@purestorage.com>
 <20251023201830.3109805-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023201830.3109805-3-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Oct 23, 2025 at 02:18:29PM -0600, Caleb Sander Mateos wrote:
> Most uring_cmd task work callbacks don't check IO_URING_F_TASK_DEAD. But
> it's computed unconditionally in io_uring_cmd_work(). Add a helper
> io_uring_cmd_should_terminate_tw() and call it instead of checking
> IO_URING_F_TASK_DEAD in the one callback, fuse_uring_send_in_task().
> Remove the now unused IO_URING_F_TASK_DEAD.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

