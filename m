Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DE562814
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097606; cv=none; b=ZJfia9k/Z/8oUBDrrtELfwJf46qDkEbY3xEXX/vbct2EKk9UYG7KIkGA4sHPHPeHEOIcxcvtAPggLaWWqRuijiHtG78EW0kCrP543LitxyqZ+jU5xPicfP4fPXHbDfvFVjmSX0Qd3yZ2pF59rqi1TDWHlJ0r7X4Z7WAQxqyLGa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097606; c=relaxed/simple;
	bh=s+U/I1kbGvtdSDHN3vLuy14cJeTvPNTBLK9/RJFkaYY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qF27ANNbKkjkYPrflCrAW6GJeb9V8zN4z3Y3lNrHqKWaMN3LJ5AxTfmPLq3qsOt1GhcBhutmF3rTQ0Xs2c89sH4sBfwNgJUvSt0fBzT0NlDdypXSglXf0UnR2o2r/jV8/uDAMOBy7K6YxTfWSU6riPE9rjpqoe9PXx2bRcNYHVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xc8F8ANW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xc8F8ANW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706097602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=EOJO21mMWm9Ve37XvF5zAOvUvne3pqlm8zmlzW92C/4=;
	b=Xc8F8ANWvoBmVba94ZKc9w7c8oJhixzB+803VQ53T7X8sOxdP3a9umYYuSCjLlRvK45SJf
	5e5IcOeqMSN0oBOrkBSIfoQ4WhTSzzcAvvzFheEkMUIemRl/43KXptoddoLH8tynOR5SHw
	hNQXZWQ7nyGJvnBMyE6CJQvf+GnjabU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-hTHzp1ECNrKOB1WIMu4y9w-1; Wed,
 24 Jan 2024 07:00:01 -0500
X-MC-Unique: hTHzp1ECNrKOB1WIMu4y9w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C43F73C0F1A9;
	Wed, 24 Jan 2024 12:00:00 +0000 (UTC)
Received: from fedora (unknown [10.72.116.11])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EA262166B32;
	Wed, 24 Jan 2024 11:59:57 +0000 (UTC)
Date: Wed, 24 Jan 2024 19:59:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org
Cc: ming.lei@redhat.com
Subject: [Report] requests are submitted to hardware in reverse order from
 nvme/virtio-blk queue_rqs()
Message-ID: <ZbD7ups50ryrlJ/G@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Hello,

Requests are added to plug list in reverse order, and both virtio-blk
and nvme retrieves request from plug list in order, so finally requests
are submitted to hardware in reverse order via nvme_queue_rqs() or
virtio_queue_rqs, see:

	io_uring       submit_bio  vdb      6302096     4096
	io_uring       submit_bio  vdb     12235072     4096
	io_uring       submit_bio  vdb      7682280     4096
	io_uring       submit_bio  vdb     11912464     4096
	io_uring virtio_queue_rqs  vdb     11912464     4096
	io_uring virtio_queue_rqs  vdb      7682280     4096
	io_uring virtio_queue_rqs  vdb     12235072     4096
	io_uring virtio_queue_rqs  vdb      6302096     4096


May this reorder be one problem for virtio-blk and nvme-pci?


Thanks,
Ming

