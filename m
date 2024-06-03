Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504A546AF
	for <linux-block@vger.kernel.org>; Mon,  3 Jun 2024 02:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717382652; cv=none; b=OPYaNyWT52Fm9XfKi3IsxdPyGvUKz6t2Tdgd3HL5T8hdQCuFZJ+33jqtBW8Vz4rSW1kvzq8Hr+86H/fYVbk3lU1xtm66oXF0hVDxKobqeKMN+eBiywaM7bWvZPHk3zmlmZYjCKhL8wXmut/V7LupE+tNtH9KCaEp8QRcxpZ63PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717382652; c=relaxed/simple;
	bh=YmffdCZX+QfHi+DHuaDWTe2NbDgd175ZCCdBejQe9hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7jB6tHX9YVvqmIza50YQf8hReLc5xsxJhfzebqyVvhZ7eLqyB6zAjd2U0Frsy3zJbzlFfOE8R1ACudYtO8IOQzlPEQJvhzVz/CZEi6jhbMoJpJU1K41ij5bnq9pSgRvqWU0ZpHblsid9nKUEAfF1DMLAGBkSifwHivg+Ha5ymI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iHkjOS+W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHkjOS+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717382650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYh7TnCnCAANHzNAKdvfvxpMmsmyucOVTxxcqwn5OJs=;
	b=iHkjOS+WpVm+gxojaPmKBcbHJLAfhIYnuJJPTPqsltRpsLtyvneGc3cbGX46bwRBscf54O
	35OA+tVe6uwzfORAc8Au8EQrmyHv7nPSMWUP8ftYOp0/18HBtoEhrRfRq5W9oBwDqRyayD
	0D7mMWtdqnwd50y3CRcdGYGuxX0HAdU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-uzmAEO9QNG-PqZAfkg0tTg-1; Sun,
 02 Jun 2024 22:44:05 -0400
X-MC-Unique: uzmAEO9QNG-PqZAfkg0tTg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EF601C05129;
	Mon,  3 Jun 2024 02:44:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A3FA2200BFC7;
	Mon,  3 Jun 2024 02:43:59 +0000 (UTC)
Date: Mon, 3 Jun 2024 10:43:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Li Nan <linan666@huaweicloud.com>
Cc: axboe@kernel.dk, ZiyangZhang@linux.alibaba.com, czhong@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH] ublk_drv: fix NULL pointer dereference in
 ublk_ctrl_start_recovery()
Message-ID: <Zl0t68TNz2alGvM+@fedora>
References: <20240529095313.2568595-1-linan666@huaweicloud.com>
 <Zl0QpCbYVHIkKa/H@fedora>
 <225f4c8e-0e2c-8f4b-f87d-69f4677af572@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <225f4c8e-0e2c-8f4b-f87d-69f4677af572@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Mon, Jun 03, 2024 at 10:19:50AM +0800, Li Nan wrote:
> 
> 
> 在 2024/6/3 8:39, Ming Lei 写道:
> 
> [...]
> 
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 4e159948c912..99b621b2d40f 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -2630,7 +2630,8 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
> > >   {
> > >   	int i;
> > > -	WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
> > > +	if (WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq))))
> > > +		return;
> > 
> > Yeah, it is one bug. However, it could be addressed by adding the check in
> > ublk_ctrl_start_recovery() and return immediately in case of NULL ubq->ubq_daemon,
> > what do you think about this way?
> > 
> 
> Check ub->nr_queues_ready seems better. How about:
> 
> @@ -2662,6 +2662,8 @@ static int ublk_ctrl_start_recovery(struct ublk_device
> *ub,
>         mutex_lock(&ub->mutex);
>         if (!ublk_can_use_recovery(ub))
>                 goto out_unlock;
> +       if (!ub->nr_queues_ready)
> +               goto out_unlock;

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

