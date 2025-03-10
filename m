Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922522DFAE
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624766; cv=none; b=XfLbOVT1poQariq1ISUDxScjN2G5068YdLJ3wF6nFAjkl9p3ftgSuY7/8rdTTorhmAeXrTizpPzcN0m0tvHE3cI7Jdmr6nmlU3ziaSvj4pgZf338wbcuSREiO/COxM5apQyb0JapuwZq5ViRhVEgEdheahwjESlz7u4ArFOkd+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624766; c=relaxed/simple;
	bh=cpyV4JgH1AWo+do8fcQTYy2kPWL9ktMAlboZe779qEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpOgFEcHc/0lYgzYWUA52tN288mdnTVuy5+dxq0Zelk5dfauhXhL14Dxv6eiyw07iE8eDNpUVtBjbLisCHxpie9kIv4v0VNl+PtUT3Bxqbbl7sKzqZLaipjBq1HSTOlqvDYVxO82jsKRRzm7KqQg6Lwa3UjPbRYIXiuSlZ4WHqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=idE4RDHW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idE4RDHW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741624763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WRQ5j56SYpEQ4INQoex+HolFgwnUbJQFdN2MGNRw2E8=;
	b=idE4RDHWoRTy3c1xNBSjDv4ehcoLgfZOdGtDPy0AMHhxApX1jY6KpxA5ueJKxghf5fsnpU
	lLeGtAfINNzU8i9ID0iwgcXBfZM0bYIK32vW/sxbHyD5965EENf+hQTWZHsuVAQ8XfO8u3
	c3yylKwJCTGLmGooGpNEC/U+2ZTPBBU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-SkjFCRVBODm0jTA8TYeAlQ-1; Mon,
 10 Mar 2025 12:39:20 -0400
X-MC-Unique: SkjFCRVBODm0jTA8TYeAlQ-1
X-Mimecast-MFC-AGG-ID: SkjFCRVBODm0jTA8TYeAlQ_1741624759
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 858241955D66;
	Mon, 10 Mar 2025 16:39:18 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BECB1800944;
	Mon, 10 Mar 2025 16:39:17 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 52AGdGWn478738
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 12:39:16 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 52AGdGxV478737;
	Mon, 10 Mar 2025 12:39:16 -0400
Date: Mon, 10 Mar 2025 12:39:16 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/7] dm: don't change md if dm_table_set_restrictions()
 fails
Message-ID: <Z88VtC6BLVWTbOM-@redhat.com>
References: <20250309222904.449803-1-bmarzins@redhat.com>
 <20250309222904.449803-2-bmarzins@redhat.com>
 <671584b2-89ca-42f0-b7d5-a16bc77c3dab@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <671584b2-89ca-42f0-b7d5-a16bc77c3dab@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Mar 10, 2025 at 08:18:31AM +0900, Damien Le Moal wrote:
> On 3/10/25 07:28, Benjamin Marzinski wrote:
> > __bind was changing the disk capacity, geometry and mempools of the
> > mapped device before calling dm_table_set_restrictions() which could
> > fail, forcing dm to drop the new table. Failing here would leave the
> > device using the old table but with the wrong capacity and mempools.
> > 
> > Move dm_table_set_restrictions() earlier in __bind(). Since it needs the
> > capacity to be set, save the old version and restore it on failure.
> > 
> > Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
> 
> Does this need a "Fixes" tag maybe ?

Yeah. I can go through and add the appropriate Fixes tags.

-Ben

> 
> Otherwise looks good to me.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
> -- 
> Damien Le Moal
> Western Digital Research

