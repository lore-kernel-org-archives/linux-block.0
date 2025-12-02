Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7A326CE33
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764667254; cv=none; b=PWnjKGyoP2jzePj7UjHfgXQv2jS2LawAiQKb6WfXCoQ1GMPFhBVBds9PnyHV4VzktIHySDJtayOkCKAnv/1jipNxZkEFRmdnyexO8tIUXuFH+GTRFWE8uDwz85eeb5bjXvEuPLcb+88cUSKXTZEM14Uan8OcENPc54/b4I45oGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764667254; c=relaxed/simple;
	bh=vH4vWkh7gbGhbWgaAEhQ1uS1OHOgO3gnXLvxNqqIsZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfAlGNO9lR4nLVVzNKasSqnFA/JaI4lZB6Vu86LsL2O8sBgU7nFYF80IfUAct2R+BG/6cpQVRa0r3xVH3a5hwQfRN8Kv7F87f2WABxBYBX30eD1zYFQvzUvoinJ+0QewiTVdlgop28giOQKbZyih6Ii0RhebyANhoOXBGmc02m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1sfA9sx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1sfA9sx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764667252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fU8QCiuksw8tBhDpNDpp9KqQoaz5so+HUSNROIQdK5o=;
	b=G1sfA9sxMJAYk89aBMWw9fShO2JlaTjqQPUDLC2Eoaiy7wxqdlh1Zrsa3IRvjI+R2r1K87
	MBxQe0oy5cPJ8WtQKoeSslQU+kAVUMgXJmL4bxt176WCux1LxYZ4hQD+MqT0aP5MXPL5B6
	9eEYEt52WucuGdye3Jwip8pNjIjd/iI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-VSlh5EwTOjGhsljq3MbErw-1; Tue,
 02 Dec 2025 04:20:49 -0500
X-MC-Unique: VSlh5EwTOjGhsljq3MbErw-1
X-Mimecast-MFC-AGG-ID: VSlh5EwTOjGhsljq3MbErw_1764667248
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD7B71800250;
	Tue,  2 Dec 2025 09:20:47 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E98A130001A4;
	Tue,  2 Dec 2025 09:20:42 +0000 (UTC)
Date: Tue, 2 Dec 2025 17:20:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Cong Zhang <cong.zhang@oss.qualcomm.com>
Cc: Jens Axboe <axboe@kernel.dk>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-arm-msm@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	pavan.kondeti@oss.qualcomm.com
Subject: Re: [PATCH] blk-mq: Abort suspend when wakeup events are pending
Message-ID: <aS6vYCg2Gks2BGHn@fedora>
References: <20251202-blkmq_skip_waiting-v1-1-f73d8a977ce0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202-blkmq_skip_waiting-v1-1-f73d8a977ce0@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Dec 02, 2025 at 11:56:12AM +0800, Cong Zhang wrote:
> During system suspend, wakeup capable IRQs for block device can be
> delayed, which can cause blk_mq_hctx_notify_offline() to hang
> indefinitely while waiting for pending request to complete.
> Skip the request waiting loop and abort suspend when wakeup events are
> pending to prevent the deadlock.
> 
> Fixes: bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are offline")
> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> ---
> The issue was found during system suspend with a no_soft_reset
> virtio-blk device. Here is the detailed analysis:
> - When system suspend starts and no_soft_reset is enabled, virtio-blk
>   does not call its suspend callback.
> - Some requests are dispatched and queued. After sending the virtqueue
>   notifier, the kernel waits for an IRQ to complete the request.
> - The virtio-blk IRQ is wakeup-capable. When the IRQ is triggered, it
>   remains pending because the device is in the suspend process.

Can you explain a bit for above point? Why does the IRQ remains pending
and not get handled?


Thanks, 
Ming

