Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9391527A4
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717616878; cv=none; b=BeackOWUGscV7p7E4EBJUOnUs/Q6dooJ4vr/GlVw+gH/ivFzbFz96VIs32QZjA2ncebjuVEaF1T2zSaErftJHJyGC/SQB2WKnfUbIz3XJVR2RXO6dD72+312Pq1MUnyzwV9wBuHdqyQXJQIVUk2ntqOw3LC4oEjNHTcmllO55tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717616878; c=relaxed/simple;
	bh=9OKgBsV7RBSeayqdw0/fkMkvMxBwGmMeJOI2kkvm3JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBekkqu0MnAbzB/uTDM42YNYmvhVWVgT927bvcugheBBH+xlcV2hA1uue1wGjNtk4xDomRtsR2se+UDO+B39PEub4dGX8lRi2KbBXMuG6kTfQ5Y25EHEqtvjDM1+4JDThfI48gyZJtRyoCYq8ekKeey9FiE1u3B9Hi9F7dXEhc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NRKlTsNz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRKlTsNz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717616875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IR6BXJd96FArYmP+akXbQdmnrU/B47deB/gC19fhAT4=;
	b=NRKlTsNz+osKWDH7eTAKoAX3R2m53L/BF9bRKMmHGZeD2p9jvgOVRFzI0/dkv+2W0Hzabi
	NUmzQiHAG4lt+NPBk86g2Lp4/m4aAdpQbx6CJPw2DhalnKcN3Uizs1xB1zfJ17O9UrMDx2
	CX5ldOA1UUhTq4z0ojddTnOKe/UTeuc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-NRS0oFk-NXC2t2CmnUv1aA-1; Wed,
 05 Jun 2024 15:47:51 -0400
X-MC-Unique: NRS0oFk-NXC2t2CmnUv1aA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 077D43C025B2;
	Wed,  5 Jun 2024 19:47:51 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B58F72023299;
	Wed,  5 Jun 2024 19:47:50 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.1) with ESMTPS id 455JloDl617712
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 5 Jun 2024 15:47:50 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.2/Submit) id 455JlnpU617710;
	Wed, 5 Jun 2024 15:47:49 -0400
Date: Wed, 5 Jun 2024 15:47:49 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 2/3] dm: Improve zone resource limits handling
Message-ID: <ZmDA5fmZMNGM1oFl@redhat.com>
References: <20240605075144.153141-1-dlemoal@kernel.org>
 <20240605075144.153141-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605075144.153141-3-dlemoal@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Wed, Jun 05, 2024 at 04:51:43PM +0900, Damien Le Moal wrote:
> +static int dm_device_count_zones(struct dm_dev *dev,
> +				 struct dm_device_zone_count *zc)
> +{
> +	int ret;
> +
> +	ret = blkdev_report_zones(dev->bdev, 0, UINT_MAX,
> +				  dm_device_count_zones_cb, zc);

Other than the nitpick that BLK_ALL_ZONES looks better than UINT_MAX
here, looks good.

-Ben

