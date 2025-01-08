Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A57C134AB
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 02:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736304492; cv=none; b=Kt/Ev/OMW1PGR+X0OyTyDjAp7TzX4WhKwmEkaZvbz5QMEwn4XvdeSjF0kbnS/Y9r7IGgaxlI2i0roj5vBzL0cOTMJaVbw9Tbze1F5PFHxX9znBuua1tOEyFKmM0anyNBRdAUg/MnDZwqIuF6DHLyqsWe+mLTB7tVxM5gJLoj6jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736304492; c=relaxed/simple;
	bh=RQ0hRjTXSEY3yArnxPsBSSe0VuxOjyU5JYyFe8pGgQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3MowaRttum6G2q1sST4mvbCfU2rHWyUGy7nvI0IhA7QkvsSlxtzYH8rmH6lCWPrbrzhPTH5O/JcSxeJ92WjvdFkzRvceb2fDVEPV4PfnVQhe0zALG1kqfm7Ru3DMw0TzirASxbm6eVRRPqx7nkTILWiFm0cgqVQvNU9BOW6qUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DtoGj+c4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtoGj+c4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736304489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o4TxO98MT4J/jabWL3YD4BH9smaAQJAmU9iZv/EUBUc=;
	b=DtoGj+c4BWzZGN7/+Xlkj/WmeatcWSmwQuiO1uprs9ZSWlUkH+2bDm7zJfs9PFSJXBTbQE
	fKdwlQxNtJJW8A7IqMfUpNKJCN5sN0z8yn5cXtbzLvlkkMoswZAf+Gl2cXsP70NicT3sSP
	bdWBsRZca6XnWNYXruGUcQcjPrI2DDE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-pqUHfpy5PkmLC8GRlLP7Fg-1; Tue,
 07 Jan 2025 21:48:07 -0500
X-MC-Unique: pqUHfpy5PkmLC8GRlLP7Fg-1
X-Mimecast-MFC-AGG-ID: pqUHfpy5PkmLC8GRlLP7Fg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5298C195608C;
	Wed,  8 Jan 2025 02:48:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.126])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC22A1955F43;
	Wed,  8 Jan 2025 02:48:02 +0000 (UTC)
Date: Wed, 8 Jan 2025 10:47:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] New zoned loop block device driver
Message-ID: <Z33nXTkBueJ4uju7@fedora>
References: <20250106142439.216598-1-dlemoal@kernel.org>
 <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
 <20250106152118.GB27324@lst.de>
 <98be988f-5f6a-489d-b0e1-2f783c5b8a32@kernel.dk>
 <20250106153252.GA27739@lst.de>
 <0f2eea00-e5e9-4cd1-8fe6-89ed0c2b262b@kernel.dk>
 <20250106154433.GA28074@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106154433.GA28074@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jan 06, 2025 at 04:44:33PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 06, 2025 at 08:38:26AM -0700, Jens Axboe wrote:
> > On 1/6/25 8:32 AM, Christoph Hellwig wrote:
> > > On Mon, Jan 06, 2025 at 08:24:06AM -0700, Jens Axboe wrote:
> > >> A lot more code where?
> > > 
> > > Very good and relevant question.  Some random new repo that no one knows
> > > about?  Not very helpful.  xfstests itself?  Maybe, but that would just
> > > means other users have to fork it.
> > 
> > Why would they have to fork it? Just put it in xfstests itself. These
> > are very weak reasons, imho.
> 
> Because that way other users can't use it.  Damien has already mentioned
> some.

- cargo install rublk
- rublk add zoned

Then you can setup xfstests over the ublk/zoned disk, also Fedora 42
starts to ship rublk.


Thanks,
Ming

