Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692B1E89C
	for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412492; cv=none; b=qReeW2EGaM74Zzq4nWxs/QOBKlfXYCjIPEsR4PanMi4Dxzuge4SBJbkmfo7iTLrH/VzVk2hbzWp3dpamJYxnB8zav3bqpFicw8Rnto0vWFkyQ2YEluVoph+csasqYY2zP7Sy/ufRSE+TB9mlryiQnGbMXRr5OLvFdu3WW1rhYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412492; c=relaxed/simple;
	bh=RTgzRhZtU+wcaZTou1TRxADaE5pYyb3Uy1nUiDeeZfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ+YMjGrA3W6SZu94OM2zOYrFkWGP1BCyFhQs97mFX8hxMkZ1F91GmOz62j8/sVS6Kv0iKXIuwE6nV3zhfY0ZVqQPUV3/jgwekhAnIh4X+o22b1gO2IXNfc7SUXKIY2lCUh0N1MVrXTeFcMz+btFy+n4M57jRKRML+ZYLciBfhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VniGk/GK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VniGk/GK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724412490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1F7ViutPWXeFjixbg8VdDHwcNyNdv8vvkZwxymZ+ANE=;
	b=VniGk/GKeLzrbhJaxXFmDsYcOCc0tfRV30jJU0N3PP4yoM2Ub8ic/727grNUboRFZCaNfk
	ZyYQhDV9k9XP8B0U+lTnWG6euyevAj9iqEi/DvZ69z5itPirTW3YdcYVxeFfwTSKy9n9Qj
	z0A5jOO62irkge03o4XDpI3rNUv1SZM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-w7efIv0ePhCHkx4Z8prKQg-1; Fri,
 23 Aug 2024 07:28:08 -0400
X-MC-Unique: w7efIv0ePhCHkx4Z8prKQg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 936771955F43;
	Fri, 23 Aug 2024 11:28:07 +0000 (UTC)
Received: from fedora (unknown [10.72.116.9])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DEFC319560A3;
	Fri, 23 Aug 2024 11:28:02 +0000 (UTC)
Date: Fri, 23 Aug 2024 19:27:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 4/4] block: fix fix ordering between checking
 QUEUE_FLAG_QUIESCED and adding requests to hctx->dispatch
Message-ID: <ZshyPVEc9w4sqXJy@fedora>
References: <20240811101921.4031-1-songmuchun@bytedance.com>
 <20240811101921.4031-5-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811101921.4031-5-songmuchun@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sun, Aug 11, 2024 at 06:19:21PM +0800, Muchun Song wrote:
> Supposing the following scenario.
> 
> CPU0                                                                CPU1
> 
> blk_mq_request_issue_directly()                                     blk_mq_unquiesce_queue()
>     if (blk_queue_quiesced())                                           blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)   3) store
>         blk_mq_insert_request()                                         blk_mq_run_hw_queues()
>             /*                                                              blk_mq_run_hw_queue()
>              * Add request to dispatch list or set bitmap of                    if (!blk_mq_hctx_has_pending())     4) load
>              * software queue.                  1) store                            return
>              */
>         blk_mq_run_hw_queue()
>             if (blk_queue_quiesced())           2) load
>                 return
>             blk_mq_sched_dispatch_requests()
> 
> The full memory barrier should be inserted between 1) and 2), as well as
> between 3) and 4) to make sure that either CPU0 sees QUEUE_FLAG_QUIESCED is
> cleared or CPU1 sees dispatch list or setting of bitmap of software queue.
> Otherwise, either CPU will not re-run the hardware queue causing starvation.

Memory barrier shouldn't serve as bug fix for two slow code paths.

One simple fix is to add helper of blk_queue_quiesced_lock(), and
call the following check on CPU0:

	if (blk_queue_quiesced_lock())
         blk_mq_run_hw_queue();


thanks,
Ming

