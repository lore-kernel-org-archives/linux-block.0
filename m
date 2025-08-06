Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A925A72639
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754465272; cv=none; b=gPuhlW7sJSq7cmUZns9kzAKrUqDZo3w+xCiXPiZWEucU11qfSGB1rCnDWfsFs/H5+IrrtInlA87YDMph7AobC71LANWL0uGsc7/N62Wd02Xt9hTicacFJDGV/ZTUMnENlcGoTbSDmIwP0VA+Ew/WYFJv4HFkAOECQJzSbRp2qwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754465272; c=relaxed/simple;
	bh=UiOnuiL/rppseg7ENV2O64BXUZM67bL2c/NRSgTjFes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfBCuenUMyXBRDZGaKfytl4zYri7dbvita5jlTpymszHsplPUxXKbAnfi6OB7YMP0/lKD8eEQHoEcXpBZ42jjtj2amxNLbm5Mwxe96AytiuO8WvFErfLfO8/LQUp6y2U/y+BBV5iP1sG/ohFdTlO6iKesLxmHGjO0D9vGSa4CfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVtiL61h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVtiL61h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754465268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WT+iX6g3nfcRlPL0NbEcOpqhsENY00PibScCjEggsh4=;
	b=EVtiL61hUdyHFrbc7rHAuRwA2i6TUcvlZ7N054lr8nr2EiZzTUZWbCAop5BFDTkiRexEvw
	1MeX2/ATQlCTX7RfLSnLuRNSYFWxHmui4rDONjvamsoSas0rDvwh3TKyejkpVyUjyNI0SQ
	Yh0lPw5FHsNx+VTrzmbmXlfeclJlwI8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-zdruGaH_PEyQKGjFlghM3Q-1; Wed,
 06 Aug 2025 03:27:47 -0400
X-MC-Unique: zdruGaH_PEyQKGjFlghM3Q-1
X-Mimecast-MFC-AGG-ID: zdruGaH_PEyQKGjFlghM3Q_1754465265
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B5B41800352;
	Wed,  6 Aug 2025 07:27:45 +0000 (UTC)
Received: from fedora (unknown [10.72.116.154])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50F36180047F;
	Wed,  6 Aug 2025 07:27:39 +0000 (UTC)
Date: Wed, 6 Aug 2025 15:27:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: xu.xin16@zte.com.cn
Cc: tom.leiming@gmail.com, thomas.hellstrom@linux.intel.com,
	linux-block@vger.kernel.org, zhang.anmeng@zte.com.cn,
	yang.tao172@zte.com.cn, axboe@kernel.dk
Subject: Re: =?iso-8859-1?Q?=A0=5BPATCH?= =?iso-8859-1?Q?=5D?= block: mark
 GFP_NOIO around sysfs ->store()
Message-ID: <aJMD5jrvi918AHUk@fedora>
References: <2025080610504934810yy8xTXsec9HpIXS8-2K@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025080610504934810yy8xTXsec9HpIXS8-2K@zte.com.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Aug 06, 2025 at 10:50:49AM +0800, xu.xin16@zte.com.cn wrote:
> > sysfs ->store is called with queue freezed, meantime we have several
> > ->store() callbacks(update_nr_requests, wbt, scheduler) to allocate
> > memory with GFP_KERNEL which may run into direct reclaim code path,
> > then potential deadlock can be caused.
> > 
> > Fix the issue by marking NOIO around sysfs ->store()
> > 
> > Reported-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-sysfs.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Excuse me, does the issue to fix comes from f1be1788a32e ("block: model freeze &
> enter queue as lock for supporting lockdep") ?

The above commit just starts to show the potential deadlock risk, which exists for
long time.

And now it becomes not necessary because blk_mq_freeze_queue() includes
memalloc_noio_save().

 
Thanks,
Ming

