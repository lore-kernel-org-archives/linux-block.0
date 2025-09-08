Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0873C38
	for <linux-block@vger.kernel.org>; Mon,  8 Sep 2025 00:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757291343; cv=none; b=Fj4FV5JaMb/NJxb3ZTq7dtuajdJOVS6d88lchxiRf4L1/OT/t694PFi4wtEo1oeb7imCGeWd5wt1rqmT6sIzxqQTmnHtYvTWQXwf/+O6EMaS4byt3RYCJLtQkrQ02PUaEJyIKWNtEMekavmmGgv6OW3Eg7HyIkuGSLyo1Z/7VZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757291343; c=relaxed/simple;
	bh=36z0+y8OTF2avqCw2FFABT9x4zD+kKxQwdoCXsY/FwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtNouQ/rnrSSBxq79i9c2QXnurq74PD8q/SHlAsp0eUWAV7xg6XR/p0uB8vYjF2EpwA72SCi6LmEqvCtwQ5m/RpgwTSNfpc1SCTw8w4bmqDhSY4vi5ncc+CcUxDXFlAPKJdLh0BDlHCQlLjC4uCGk1qOjckfRhUjMqbZdiNNwhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sr9SDbXj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sr9SDbXj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757291339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xKTt01T7Rh9dDqG0nLx7f4bh3eGgvtcoXM5/mgLYFak=;
	b=Sr9SDbXjKuAYk5VNof8HI+w7IGcyLWvmsPt3G2eBg5k6XJW4ulX9vvChRg59EuxpV4JoFM
	4WKDNzuhiXWY6nGgYwb+0ttBc2Yybv8V/d7I02vJ4L6jC9O3kncPm9TbZF8SyoQS4BZhfO
	T7+Iyjx9janFxUMQ82RYoHqHqcbou1E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-fOdpvSj7PlW36UgVcuK-kQ-1; Sun,
 07 Sep 2025 20:28:58 -0400
X-MC-Unique: fOdpvSj7PlW36UgVcuK-kQ-1
X-Mimecast-MFC-AGG-ID: fOdpvSj7PlW36UgVcuK-kQ_1757291337
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 291A0180034A;
	Mon,  8 Sep 2025 00:28:57 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 861C9180044F;
	Mon,  8 Sep 2025 00:28:53 +0000 (UTC)
Date: Mon, 8 Sep 2025 08:28:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Heorhi Valakhanovich <code@mail.geov.name>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [blk-mq] Kernel OOPS after usb drive surprise remove (bisected)
Message-ID: <aL4jQG-_CeHxGPsU@fedora>
References: <LmKwxMZhQ0h6bHWk_m7EMu4jDpbdcL0Z4gix3USIvS2sJpGZP1b_858GvxaDL6zwoGxrPIs-dT10NLxersJpxExsOOpJmyDh_fTOp97ZBYE=@mail.geov.name>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LmKwxMZhQ0h6bHWk_m7EMu4jDpbdcL0Z4gix3USIvS2sJpGZP1b_858GvxaDL6zwoGxrPIs-dT10NLxersJpxExsOOpJmyDh_fTOp97ZBYE=@mail.geov.name>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sun, Sep 07, 2025 at 02:48:27PM +0000, Heorhi Valakhanovich wrote:
> Kernel version 6.16.4 and later.
> 
> Usb3 thumb drive surprise removal triggers an oops in blk_mq_free_map_and_rqs.
> Block IO is limping afterwards and often system is unusable.
> 
> 
> Bisected to:
> 
> commit f9a9098ca82612006b9c71ce03b8fe189a437370 (HEAD)
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Fri Aug 15 21:17:37 2025 +0800
> 
>     blk-mq: fix lockdep warning in __blk_mq_update_nr_hw_queues
> 
>     [ Upstream commit 2d82f3bd8910eb65e30bb2a3c9b945bfb3b6d661 ]

No, that is not true, because scsi/usb does not call into
blk_mq_update_nr_hw_queues().

> 
> 
> relevant kernel log:
> 
> Sep 07 17:19:26: BUG: kernel NULL pointer dereference, address: 0000000000000020
> Sep 07 17:19:26: #PF: supervisor read access in kernel mode
> Sep 07 17:19:26: #PF: error_code(0x0000) - not-present page
> Sep 07 17:19:26: PGD 0 P4D 0 

Please try the following fix:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-6.18/block&id=ba28afbd9eff2a6370f23ef4e6a036ab0cfda409

Thanks,
Ming

