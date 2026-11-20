Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795203851;
	b=sq5G09LVzSiFjKdHvZAgD/LBCzMiOXBjuc0oZiTgOW9WYCysYjWxSphuY2otVYHLTzkq
	 w2QIJx2C46Ft4KuZTvoW9ZE9oY/MdWFS/B/AnLwgUeiz7uo2h70K0GHBGblLoh45/ujvD
	 mKXSnoGiivgf5geM+wPEI7OF1qKHl9qmmj049fyPRDvlYt0Qb6/ZrilZwLVKJ2XX+j2G9
	 TE+PNej67rz0M1QUAlAPL0edFT5sPHCXxjqjvAdeg1Y4lEWq2oeUTIij4+Xiph9xA4HFe
	 s7lDkYtDyKdLLEK5CJKIozjS54vZfQMdM4jVZ6KivKDPHjuoo2jrk1atcY2Kd87Cb2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203851;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=wqj7eho1qsScUX7Rstv/jSo5ybS3FSLuhvGplwRCAqU=;
	b=1P6yXf3LSZQEzHxCuwR/kog1z3Po0pwFAtY7xR9cdSZYJ/ClYO2oFOoojEaf3CPPXaRv
	 g0V/2EBmAPZFWl5qa1dqO+4LrnFZDlXk3VyQWk5MyXiE78ZXaIZfDQSPDP92GWveHB/wy
	 zqSKrFzYPd3gEpmnFgblHWxXj9DcC4gfvo/EC077xEhP6QxFz9YJQxcuhE0G03WaIl2Tk
	 2Ia+6iTJ+pgYZA//McoZ6dejWtY5l8iZ8CqXkwQFFGpj3aBYRYMlzlCRC5t78Y0WLRwHc
	 cfOSB3YNJpgXt2BcVFvV6wU+2Md8iUpk176jUl/1kb4LzajQuLkh4uG+bWgSqQDYCxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E5nJ6FkK;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B752606A6C5
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 19:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B752606A6C5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E5nJ6FkK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795203849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wqj7eho1qsScUX7Rstv/jSo5ybS3FSLuhvGplwRCAqU=;
	b=E5nJ6FkKdlJvx7kQKcNZEC/PpF+7p7wbV6+VTVYDltEgJrep/koHY+Roy3ex4tOl59xgZI
	DS6AKcP8cebPxvDXJ9Z7I/s6QLOueCa5upZWwZ8coVXnpPVAeTyeNq5WGO1jOnEOW93L4F
	tFBHkqP6AeMEFIQKzWhQJxitiviGFZQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-N45WE1kOOaaqJwZtFKTBdA-1; Fri,
 20 Nov 2026 19:44:03 +0000
X-MC-Unique: N45WE1kOOaaqJwZtFKTBdA-1
X-Mimecast-MFC-AGG-ID: N45WE1kOOaaqJwZtFKTBdA_1795203842
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C88E71801337;
	Fri, 20 Nov 2026 19:44:01 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A8661956041;
	Fri, 20 Nov 2026 19:44:01 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 6AKJi0pB1530875
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 14:44:00 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 6AKJhxUp1530867;
	Fri, 20 Nov 2026 14:43:59 -0500
Date: Fri, 20 Nov 2026 14:43:59 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>,
        "Martin K . Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: stack max_user_discard_sectors
Message-ID: <awCi_9_Xykc_Mmk-@redhat.com>
References: <20261109193927.595104-1-bmarzins@redhat.com>
 <20261120154040.GB28611@lst.de>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120154040.GB28611@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Nov 20, 2026 at 04:40:40PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 09, 2026 at 02:39:27PM -0500, Benjamin Marzinski wrote:
> >  		t->max_discard_sectors = min_not_zero(t->max_discard_sectors,
> >  						      b->max_discard_sectors);
> > +		t->max_user_discard_sectors = min_not_zero(t->max_user_discard_sectors,
> > +							   b->max_user_discard_sectors);
> 
> I don't think we should take the underlying max_user_discard_sectors
> into account here, just max_discard_sectors.

Is that to handle devices that call blk_queue_disable_discard()? I
didn't think about that. Makes sense.

> But otherwise yes, this
> should be stacked.
> 
> Please avoid the overly long lines, though.

Sure.

-Ben

