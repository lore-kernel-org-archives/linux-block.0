Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF7F4CB36
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617063; cv=none; b=hnA+t3xa8jD6sEK7NLA1dP+jNez2j4EPfuAV458mQJGXMX051Dcov1y9n5ADtNNSzkO4wTA/HJZitsrjPd8MVEiuADK/XbhTwJ1tPCGesmv73TYdBt3KSrx65j7maHfRJTsGqF10AyifiQN5Dr4xiRMCa6f6cPiWevDbno6E/MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617063; c=relaxed/simple;
	bh=vdDPgOETrlIUEHKIjDm7sqX4QOdjEmevinvwmI0xP0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bp6zMFmCpjCZCZdwz3G0JbmG1H0DAAuZJzTTG8ZP9iXGWLM6KWY9HdXU1qqAGawW8aeWIphlchi6rspsu25UkgO6dN6SPHbIko6YAFk5F9b0zPR0GSKjziymqMKu+twr7h/kN3KUSGGsANCcyaEA2hS3tMLuIdoiKjJ6idFckQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S/0/K2Vy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/0/K2Vy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717617060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vdDPgOETrlIUEHKIjDm7sqX4QOdjEmevinvwmI0xP0U=;
	b=S/0/K2Vyj+UgeOT6RdLYwGdkfpVYg1d3v5LCGdKyAYsaS2GmUIF5EJMxisXcoj+Wi922xm
	dSn/OGWAuFlRA9OgU60cEBL6mBRhjxpQaJu+TOcUMfnrG/9y+MCD0G96u6KMZBRW0u+TsX
	MfzaNmc0gj8jsZuHEcfKDOKGDfd37xw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-U1cu7pIlNPKX-2lwW12HzQ-1; Wed,
 05 Jun 2024 15:50:59 -0400
X-MC-Unique: U1cu7pIlNPKX-2lwW12HzQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98AA91953966;
	Wed,  5 Jun 2024 19:50:57 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0E81300060C;
	Wed,  5 Jun 2024 19:50:56 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.1) with ESMTPS id 455JotT0617827
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 5 Jun 2024 15:50:55 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.2/Submit) id 455JotIY617826;
	Wed, 5 Jun 2024 15:50:55 -0400
Date: Wed, 5 Jun 2024 15:50:55 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 3/3] dm: Remove unused macro DM_ZONE_INVALID_WP_OFST
Message-ID: <ZmDBn_YCyxNauhe4@redhat.com>
References: <20240605075144.153141-1-dlemoal@kernel.org>
 <20240605075144.153141-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605075144.153141-4-dlemoal@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Reviewed-by: Benjamin Marzinski <bmarzins@redhat.com>

