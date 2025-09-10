Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8011230274
	for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 02:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757470147; cv=none; b=ce18jmdeuk8FH41zbFL7jsIUBQmIdefoYxjYqM8ba+QeBAut5MHw+dbBcm/ZzoQc3exzu17AvfJZuSMX/pXQIZMKjmBTMP3H3lHtc7A8/7TcRpnDq0E7LdaTVESeVhyj1t/i3POHZJc+AJRkP+Uxy+s3u/zlCtoYX0frheXhbWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757470147; c=relaxed/simple;
	bh=jkOvdJzLstBIaetzPcUgj4AetdRvNHrGMjoqK0fz9IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfUvlHTHWs3Xipc1ZsjIaVcfPj7smoXYX7WI93/5uwlILtOMI+RSabghmCV9YResnepx28Qbk9cbTAaCe2xz/2aRL/5yPAK66cZDTshRXqMv2rWAriPTRNbl12R+B1gV8jQ0ou+cLlGdQXpoyquTWSezGINQ/D0FuTcSzqBH1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X8LCgXXw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8LCgXXw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757470144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ww3IgOKSoDpyO/4jsNx5DIMEDAXFT9EIpiaSt7ZtuRU=;
	b=X8LCgXXwaua4OM+wDpwJ7f0AVNiuey7TvbLKVWp2Vkhw9oN3v/D9CHjFHPr0AGAJPYUgwG
	imDFUd+uL2OB22MJhvR5pEZbadMFMN354XXux7s8QLoQWh9ZJAj1vbxbEkJJFG6t9zdivs
	djkR/Bd/xALtLACRY7zQBCF7LWECedY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-1H3jjdClNsemjLb9BsLu2g-1; Tue,
 09 Sep 2025 22:09:01 -0400
X-MC-Unique: 1H3jjdClNsemjLb9BsLu2g-1
X-Mimecast-MFC-AGG-ID: 1H3jjdClNsemjLb9BsLu2g_1757470140
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BD0A180048E;
	Wed, 10 Sep 2025 02:09:00 +0000 (UTC)
Received: from fedora (unknown [10.72.120.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5699B300018D;
	Wed, 10 Sep 2025 02:08:55 +0000 (UTC)
Date: Wed, 10 Sep 2025 10:08:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: consolidate nr_io_ready and nr_queues_ready
Message-ID: <aMDdsp0dYjVitaE6@fedora>
References: <20250908184542.472230-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908184542.472230-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Sep 08, 2025 at 12:45:41PM -0600, Caleb Sander Mateos wrote:
> ublk_mark_io_ready() tracks whether all the ublk_device's I/Os have been
> fetched by incrementing ublk_queue's nr_io_ready count and incrementing
> ublk_device's nr_queues_ready count if the whole queue is ready.
> Simplify the logic by just tracking the total number of fetched I/Os on
> each ublk_device. When this count reaches nr_hw_queues * queue_depth,
> the ublk_device is ready to receive I/O.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

