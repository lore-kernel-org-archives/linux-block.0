Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJl6fOKU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC52A1AD
	for <linux-block@vger.kernel.org>; Thu,  7 Dec 2023 18:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702000851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JJ2EPKnJQm+fAlvkL+74UAK/7dPrJSHeWEZnkUKYj2w=;
	b=JJl6fOKUtPa+BEVQBIAoe4DrScWqVxJ29CNABz3oDmhW8ODg+19VtR7/Cq0JHoK5ZWtLEN
	tEbaLoExAUW+h/+hkIUrQ6MMLvBfMQcpOWG01+eb/DLQdfVVmAvi5OJcyhvUWNVjXrJTLM
	fqlUbMTnzIWbLalHceyoAyn3U2wYhbU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-Fz9at8PFNQ-bnMhti6X8PQ-1; Thu,
 07 Dec 2023 21:00:48 -0500
X-MC-Unique: Fz9at8PFNQ-bnMhti6X8PQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6E0C3C10153;
	Fri,  8 Dec 2023 02:00:47 +0000 (UTC)
Received: from fedora (unknown [10.72.120.10])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 991062026D66;
	Fri,  8 Dec 2023 02:00:41 +0000 (UTC)
Date: Fri, 8 Dec 2023 10:00:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
Message-ID: <ZXJ4xNawrSRem2qe@fedora>
References: <20231207043118.118158-1-fengli@smartx.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207043118.118158-1-fengli@smartx.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Thu, Dec 07, 2023 at 12:31:05PM +0800, Li Feng wrote:
> virtio-blk is generally used in cloud computing scenarios, where the
> performance of virtual disks is very important. The mq-deadline scheduler
> has a big performance drop compared to none with single queue. In my tests,
> mq-deadline 4k readread iops were 270k compared to 450k for none. So here
> the default scheduler of virtio-blk is set to "none".

The test result shows you may not test HDD. backing of virtio-blk.

none can lose IO merge capability more or less, so probably sequential IO perf
drops in case of HDD backing.

Thanks,
Ming

