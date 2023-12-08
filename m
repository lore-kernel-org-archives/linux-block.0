Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlUYyFtY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6710D1706
	for <linux-block@vger.kernel.org>; Thu,  7 Dec 2023 19:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702007660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMjgdK/2S1PdVSZgnJj0b95Jv4yCNX3anEehreiP6o4=;
	b=PlUYyFtYFjnLvOGYxniGB8YKWnxODPXXIyiqk5M8sVjJrL2+GULp0ifHeyh9i7MJBPtZQo
	uznRjLiqU0yIEj5+u3mroivt4Yd4mLxNT7KpVP/MhJJlhlUvJYiuWCRbS94t7pXNO7JZ+B
	7zsmkuKNE62is4MZR2gmHdsZ56C4kIU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-v257SBM9Ou6VY-NkZGlbJw-1; Thu, 07 Dec 2023 22:54:14 -0500
X-MC-Unique: v257SBM9Ou6VY-NkZGlbJw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F0128057FD;
	Fri,  8 Dec 2023 03:54:14 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 05A5C2166B35;
	Fri,  8 Dec 2023 03:54:07 +0000 (UTC)
Date: Fri, 8 Dec 2023 11:54:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Li Feng <fengli@smartx.com>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
Message-ID: <ZXKTW7z3UH1kPvod@fedora>
References: <20231207043118.118158-1-fengli@smartx.com>
 <ZXJ4xNawrSRem2qe@fedora>
 <ZXKDFdzXN4xQAuBm@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXKDFdzXN4xQAuBm@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Thu, Dec 07, 2023 at 07:44:37PM -0700, Keith Busch wrote:
> On Fri, Dec 08, 2023 at 10:00:36AM +0800, Ming Lei wrote:
> > On Thu, Dec 07, 2023 at 12:31:05PM +0800, Li Feng wrote:
> > > virtio-blk is generally used in cloud computing scenarios, where the
> > > performance of virtual disks is very important. The mq-deadline scheduler
> > > has a big performance drop compared to none with single queue. In my tests,
> > > mq-deadline 4k readread iops were 270k compared to 450k for none. So here
> > > the default scheduler of virtio-blk is set to "none".
> > 
> > The test result shows you may not test HDD. backing of virtio-blk.
> > 
> > none can lose IO merge capability more or less, so probably sequential IO perf
> > drops in case of HDD backing.
> 
> More of a curiosity, as I don't immediately even have an HDD to test
> with! Isn't it more useful for the host providing the backing HDD use an
> appropriate IO scheduler? virtio-blk has similiarities with a stacking
> block driver, and we usually don't need to stack IO schedulers.

dm-rq actually uses IO scheduler at high layer, and early merge has some
benefits:

1) virtio-blk inflight requests are reduced, so less chance to throttle
inside VM, meantime less IOs(bigger size) are handled by QEMU, and submitted
to host side queue.

2) early merge in VM is cheap than host side, since there can be more block
IOs originated from different virtio-blk/scsi devices at the same time and
all images can be stored in single disk, then these IOs become interleaved in
host side queue, so sequential IO may become random or hard to merge.

As Jens mentioned, it needs actual test.


Thanks,
Ming

