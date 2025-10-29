Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A824B2F6169
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 23:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761780850; cv=none; b=D6JnLz7ojDPUEzg1LU6+KkF9cUdwxZZm75Mo8aMjuohE6BgNMhoK2QX8K8nsn1+rkPV6Ft0jsdt5nfRAOK3RoVNegKNz1ztEXgqLVYrYIb64Jyj3BzkaPgypALQONbxF7W9CPZkDXDjpnkxjAfRIauqKt/S12PoXyFCosTe6718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761780850; c=relaxed/simple;
	bh=20QrfhsP7BTxdY1uWOqrP2JATqYCaNwlQeZEXNk6GsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4CURrWcB8ZwvqyOpoPXFt48B2LSS43y/noH/2KK/7LTcvcuwhK6wfSJxATIZlXDX+h2HpEi0ug6TiEyjaZSQCUC8qd2V3YWZmGewNAzHNXI6kL0MPy/sV5CO3xZkovqMTsw+GBTwdmFNiVkgdaoFtCX70hUKXdsJeM35OBPLxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZzmxZc+6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzmxZc+6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761780846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ev4MgcEU/YMM004s+ooaPWltT7gsDwUNX82Pw1HrpeM=;
	b=ZzmxZc+6VF8OrKVCx4izSBh1UK/jSwl6W+/y97gUQ+2QCrNIM40ZqtZCeOYo1duFU2KF4b
	Zp2pjqRaDGW+s7YV9lKtYTfVFNDXZ1e0iiLD5FkbF/XBFH3GRl5IPDFohxk5lh664DbzjQ
	u2d+leARCJrrrl5r1xzaDNqnSurHCIc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-p1peaPsTPyennamT6acj3A-1; Wed,
 29 Oct 2025 19:34:05 -0400
X-MC-Unique: p1peaPsTPyennamT6acj3A-1
X-Mimecast-MFC-AGG-ID: p1peaPsTPyennamT6acj3A_1761780843
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58D581800D8F;
	Wed, 29 Oct 2025 23:34:03 +0000 (UTC)
Received: from fedora (unknown [10.72.120.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03278180057C;
	Wed, 29 Oct 2025 23:33:57 +0000 (UTC)
Date: Thu, 30 Oct 2025 07:33:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Casey Chen <cachen@purestorage.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"yzhong@purestorage.com" <yzhong@purestorage.com>,
	"sconnor@purestorage.com" <sconnor@purestorage.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"mkhalfella@purestorage.com" <mkhalfella@purestorage.com>
Subject: Re: [PATCH 1/1] nvme: fix use-after-free of admin queue via stale
 pointer
Message-ID: <aQKkYCdao3eyDdB7@fedora>
References: <20251029210853.20768-1-cachen@purestorage.com>
 <20251029210853.20768-2-cachen@purestorage.com>
 <65062542-e87c-4026-a58a-d5a29d03b8c9@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65062542-e87c-4026-a58a-d5a29d03b8c9@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Oct 29, 2025 at 11:00:29PM +0000, Chaitanya Kulkarni wrote:
> On 10/29/25 2:08 PM, Casey Chen wrote:
> > From: Yuanyuan Zhong <yzhong@purestorage.com>
> >
> > When a controller is deleted (e.g., via sysfs delete_controller), the
> > admin queue is freed while userspace may still have open fd to the
> > namespace block device. Userspace can issue IOCTLs on the open fd
> > that access the freed admin queue through the stale ns->ctrl->admin_q
> > pointer, causing a use-after-free.
> >
> > Fix this by taking an additional reference on the admin queue during
> > namespace allocation and releasing it during namespace cleanup.
> >
> > Signed-off-by: Casey Chen <cachen@purestorage.com>
> > Signed-off-by: Seamus Connor <sconnor@purestorage.com>
> > ---
> >   drivers/nvme/host/core.c | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 8d8af58e79d1..184a6096a2be 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -687,6 +687,7 @@ static void nvme_free_ns(struct kref *kref)
> >   {
> >   	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
> >   
> > +	blk_put_queue(ns->ctrl->admin_q);
> >   	put_disk(ns->disk);
> >   	nvme_put_ns_head(ns->head);
> >   	nvme_put_ctrl(ns->ctrl);
> > @@ -3903,9 +3904,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
> >   	struct gendisk *disk;
> >   	int node = ctrl->numa_node;
> >   
> 
> would be a good idea to add a comment at both places to explain why we 
> are taking this additional reference ? since this is specifically needed 
> for userspace.

Yes, it needs documentation, I believe it is because the reference of
`struct nvme_ctrl` doesn't cover ctrl->admin_queue & ctrl->admin_tagset.

Thanks,
Ming

