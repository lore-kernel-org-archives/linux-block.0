Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF38A2629D
	for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729341154; cv=none; b=UicylFY07Jss/5zsbB5k5FGAowXTbQnCsBDXL35Yv9mfAPQGcNRue2A/O9XDjtm19qgisJepcjV51jJbB7RYeCdSRhdVRuG49S6mV8gutYUy4wcFO3Zgm2qcMWHYuTwBuaq26Qj7znJqIzCFSCLUp4R9ZEwz4lATo+DIHRD3EgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729341154; c=relaxed/simple;
	bh=FabYbONdUGI87idSVOcM/fVvdjJfuyQohQgua/rCtq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cq6nssgPZF9FtwxhV/tohNqe2iebRp9SAfxl6dWoIJF27ugUG0Loswns+ewtlskZzlUxGM2BB2l6i+dD9u7MCCCjkIM3SWRlqp0qUPj2aYyp2GSgm1WZIHQDJvhritfLYcQCPiIXrPO94GN7kY5qoVDm1mFF1H5uEpLEoaM7IYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KOh8oyDi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOh8oyDi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729341150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kML6LTH2wTxGgnYaDJ+WyXDJPgN2924x6ZmEYSXiUHY=;
	b=KOh8oyDiC0BFB6fTYHcJsb8CO38zqve9fKVPic0dkuSyemA+xPtLEPFmJYFTFf6EbGMi4X
	YyuIiI1hq6oTczyoNrVz26HtPsM73uvWCLCkbpnV1XPN74CD9E79B3TWk2JEVPUo9WDDzI
	+dZoL7uatzD9PNycijhJEYctXEe50/I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-fmLqIlcaO9O-s-Fh1iHJuw-1; Sat,
 19 Oct 2024 08:32:27 -0400
X-MC-Unique: fmLqIlcaO9O-s-Fh1iHJuw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3ED21956088;
	Sat, 19 Oct 2024 12:32:24 +0000 (UTC)
Received: from fedora (unknown [10.72.116.23])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8485C19560A3;
	Sat, 19 Oct 2024 12:32:19 +0000 (UTC)
Date: Sat, 19 Oct 2024 20:32:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Message-ID: <ZxOmzVLWj0X10_3G@fedora>
References: <20241009113831.557606-1-hch@lst.de>
 <20241009113831.557606-2-hch@lst.de>
 <Zw_BBgrVAJrxrfpe@fedora>
 <20241019012541.GD1279924@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019012541.GD1279924@google.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sat, Oct 19, 2024 at 10:25:41AM +0900, Sergey Senozhatsky wrote:
> On (24/10/16 21:35), Ming Lei wrote:
> > On Wed, Oct 09, 2024 at 01:38:20PM +0200, Christoph Hellwig wrote:
> > > When del_gendisk shuts down access to a gendisk, it could lead to a
> > > deadlock with sd or, which try to submit passthrough SCSI commands from
> > > their ->release method under open_mutex.  The submission can be blocked
> > > in blk_enter_queue while del_gendisk can't get to actually telling them
> > > top stop and wake them up.
> > 
> > When ->release() waits in blk_enter_queue(), the following code block
> > 
> > 	mutex_lock(&disk->open_mutex);
> > 	__blk_mark_disk_dead(disk);
> > 	xa_for_each_start(&disk->part_tbl, idx, part, 1)
> > 	        drop_partition(part);
> > 	mutex_unlock(&disk->open_mutex);
> 
> blk_enter_queue()->schedule() holds ->open_mutex, so that block
> of code sleeps on ->open_mutex. We can't drain under ->open_mutex.

We don't start to drain yet, then why does blk_enter_queue() sleeps and
it waits for what?



Thanks,
Ming

