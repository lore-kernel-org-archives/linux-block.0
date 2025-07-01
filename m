Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D479FFC0A
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 02:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751335375; cv=none; b=MbPycEcoVlIMrSXgM5SJjf1LOQYNRJRzQdcYJBnlhSLguHmNo846XF1I/APwrVw98rIHCtPXwP8Tez5fw4Ijie/KmTgoH1HUzltxTxM6QQGNJ463PaUihbfhqMhBlUERYM0rd125vnDianYRmBIHTtcP2odmjjBK49DgnDWzoBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751335375; c=relaxed/simple;
	bh=yECXbIEKM5wPqwt5vRAk7HwTeYECNySDnRkDg0+K+AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIUszhoY5zVQG7RtGlLG4R9I7ZHIabcssjtoMTUvUBzoBJ6KDNMiZII0/tFm1znpLx4Hh/qaan98ieQVCq0GoMGfEwrlj9PNpIKlVk2B/jIyGYl+3RcVn7Lo/ZTX3A+4oA0ifbVSW0IkqLeDZa/Q1/Zu0WOSkAVerSrMwVlLe+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dA/WU0ZW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dA/WU0ZW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751335372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=exM8bqcWMXopB7Yy/E61grHqcEI7VkMvKXE+dreKHuI=;
	b=dA/WU0ZW3EE1P20mwJs0jnknnSgqr+669E/0Msvhy6UZ3xXvTw4bckGXUxmPooiESgo1K7
	anrLqjl3JVvzSMsQBFcWCKyeRYFy9DdbKBkWssNpgdw4DmcvQuLzLNomwh7fYr3HwprMIy
	HWdI5PKI/P1Cn02schjC0xvuQ9dY9zg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-PhC34KVeNEK3YiEn6jx6eQ-1; Mon,
 30 Jun 2025 22:02:46 -0400
X-MC-Unique: PhC34KVeNEK3YiEn6jx6eQ-1
X-Mimecast-MFC-AGG-ID: PhC34KVeNEK3YiEn6jx6eQ_1751335365
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 279C71956086;
	Tue,  1 Jul 2025 02:02:45 +0000 (UTC)
Received: from fedora (unknown [10.72.116.88])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41FCB19560AB;
	Tue,  1 Jul 2025 02:02:40 +0000 (UTC)
Date: Tue, 1 Jul 2025 10:02:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: 6.17 block tree rebased
Message-ID: <aGNBu1jngH4r-SZ4@fedora>
References: <dd82e081-a508-4b55-9ba6-36bbb54a2c2a@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd82e081-a508-4b55-9ba6-36bbb54a2c2a@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Jens,

On Mon, Jun 30, 2025 at 04:08:29PM -0600, Jens Axboe wrote:
> Hi,
> 
> As per discussion last week for ublk, I've rebased the block branch
> for-6.17/block to be based on v6.16-rc4 to avoid a bunch of issues on
> the ublk side.
> 
> For ublk, could you folks please check the end results?

Thanks for the rebase.

We have merged commit 4c8a951787ff ("ublk: setup ublk_io correctly in case of
ublk_get_data() failure") to -rc4, commit c5adc2714c2c ("ublk: move ublk_prep_cancel()
to case UBLK_IO_COMMIT_AND_FETCH_REQ") becomes not correct any more, can you drop it
from for-6.17/block?

Otherwise, the ublk rebase is good.

Thanks,
Ming

