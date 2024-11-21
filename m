Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB367156875
	for <linux-block@vger.kernel.org>; Thu, 21 Nov 2024 03:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732158868; cv=none; b=g81x5aivAz/oaw14QRFx77VAw7GUqSIKQZcnhXsQ/jusaCoSuG+UWXF4kW8HUat5dypI7o8jlKqHXB/hcecKakgjxXHvQHxYe9E32oE1UYfHBgFrR/tglV/Nbz2OZQF8tDYEt3o8QGwn1LhxO4P7CXWGhdo8/i17xlP4kAxq8HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732158868; c=relaxed/simple;
	bh=oW2wKrx2gGk+Bb6oIpzo/A+eWeVBcBeNoa46TyWd5bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOnTOag8Ncqrunxjp0ZvBxPMkun7zCjbsuQizD1IBEqAJak48Ik6uHOVfhtGAXlPfthkYcjUV9JU1eQx/axjPOxqc+RtLq796ygHNHtbDIy8MymYQZEePRTcJQ8qAlutC7fhRds91fpFk+pOcLTSyociACLVz/BFOgxEB/CBhb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bREJIAnG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bREJIAnG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732158865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D4oKZkh0sz5FdqSHIoW2az+kTH4U1zOxQ3OJWWsyrf4=;
	b=bREJIAnGcX/ILjwLV9vbQHQRsrIAuSZoyLtVmYAHI7pOLt9eKmg0j/4DS3x9TtZG9MFw2e
	x1Eye9mA88AR4tqRKk/1DtC7uThBOQv6lhoG58awg9zH/ky8ZwFIYnEAeuUwcpj4hc5UeR
	cIJ2gMe1/XAsGDIKyHvL9uJ/zuIw/Tk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-YrEWYJ_ROAGUuM5QpoVxVg-1; Wed,
 20 Nov 2024 22:14:22 -0500
X-MC-Unique: YrEWYJ_ROAGUuM5QpoVxVg-1
X-Mimecast-MFC-AGG-ID: YrEWYJ_ROAGUuM5QpoVxVg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A5BA1955F57;
	Thu, 21 Nov 2024 03:14:18 +0000 (UTC)
Received: from fedora (unknown [10.72.116.87])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B63E01955F3D;
	Thu, 21 Nov 2024 03:14:03 +0000 (UTC)
Date: Thu, 21 Nov 2024 11:13:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Garry <john.g.garry@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 5/8] scsi: replace blk_mq_pci_map_queues with
 blk_mq_map_hw_queues
Message-ID: <Zz6ldgmd3tGOvQTl@fedora>
References: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
 <20241115-refactor-blk-affinity-helpers-v5-5-c472afd84d9f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-refactor-blk-affinity-helpers-v5-5-c472afd84d9f@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Nov 15, 2024 at 05:37:49PM +0100, Daniel Wagner wrote:
> Replace all users of blk_mq_pci_map_queues with the more generic
> blk_mq_map_hw_queues. This in preparation to retire
> blk_mq_pci_map_queues.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

