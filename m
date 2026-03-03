Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0821149C7B
	for <linux-block@vger.kernel.org>; Tue,  3 Mar 2026 05:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772516422; cv=none; b=XMBX/E3M8178Iag/acsuQkYmtwzHV9G7G7FyV9doj4ew/AFGzzFNQuRqsCZq8GKGW5c7wlv155ux5J8U4aKCCfE/3SiXXtB8/lTphOkqjth3TP36/Z9RAhQZlKQocEvM09IrYpQMsppBx7Vd2ipie3i7e89b7ypQRa+obPfwQa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772516422; c=relaxed/simple;
	bh=Efrv2cy+F/yE2YkjAE1qPqG9zYUCEuW6ZG9zHXhbxxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOIf4yN74zbgsqr+6a75giB6AUZZyFrv4yaMp1amxvxjPpnG55k3+W5QtA+xAUfUUzCiuMdKkceR417hlmKKRUTLlBAF5qGHmUrUpoOGnf03gwD6dr6HO+H2lMBK/ltx5r4eDbMcQb6AxLFqMHAZARKJ/D39IgrlgmmX5gzEWTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dz49Vj5d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dz49Vj5d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772516417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wGDXpiZUgPV8wjM7a62PXYfnySDj7E1W1FYiXgU7gPk=;
	b=dz49Vj5d3nQly81fYOZZcYe78fLfzIX2vI/tor8O4reAv+szdvLHrS1jdJrWd3oNxo2r7o
	ywIXHtONVAg6fmqpLuCRrIawUKa5IbukyEi5pMK5hrGZZJCeH6kyjK7Jn7ncFllwQx0Hv3
	OGSCCaFd8tPTmJODynuuDZV3BfGxCpY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-hkpAaKNIMXqbxBv1z2Y9jA-1; Tue,
 03 Mar 2026 00:40:08 -0500
X-MC-Unique: hkpAaKNIMXqbxBv1z2Y9jA-1
X-Mimecast-MFC-AGG-ID: hkpAaKNIMXqbxBv1z2Y9jA_1772516396
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A15D919560B2;
	Tue,  3 Mar 2026 05:39:55 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBF8319560A2;
	Tue,  3 Mar 2026 05:39:54 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 6235dr2b1875431
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 3 Mar 2026 00:39:53 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 6235drsg1875430;
	Tue, 3 Mar 2026 00:39:53 -0500
Date: Tue, 3 Mar 2026 00:39:53 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com, jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/24] scsi-multipath: introduce basic SCSI device support
Message-ID: <aaZ0Kf9n79QF4gbR@redhat.com>
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-3-john.g.garry@oracle.com>
 <aaT0Taxs6WgX6m-j@redhat.com>
 <784abca8-9dc1-4fca-b72f-62d55b4cc3f1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <784abca8-9dc1-4fca-b72f-62d55b4cc3f1@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Mar 02, 2026 at 11:39:28AM +0000, John Garry wrote:
> On 02/03/2026 02:22, Benjamin Marzinski wrote:
> > > diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> > > index 19d0884479a24..cfab7ad1e3c2c 100644
> > > --- a/drivers/scsi/Kconfig
> > > +++ b/drivers/scsi/Kconfig
> > > @@ -76,6 +76,16 @@ config SCSI_LIB_KUNIT_TEST
> > >   	  If unsure say N.
> > > +config SCSI_MULTIPATH
> > > +	bool "SCSI multipath support"
> > At least until this supports ALUA, it should probably be marked
> > EXPERIMENTAL, just so people trying it out aren't surprised if it
> > doesn't multipath their device in the way they expect.
> 
> I think that ALUA support will be mainline acceptance criteria, and I am
> looking to add it now.
> 
> BTW, Hannes suggested to not use the DH ALUA support, so that means to
> separate out the core ALUA support from the DH stuff. So you have any
> opinion on that approach?

I would (perhaps naively) have thought that the device handlers would be
a useful abstraction for dealing with ALUA devices. But, Hannes knows
this code much better than me. like I said before, I'm no scsi expert.

-Ben

> 
> Thanks!

