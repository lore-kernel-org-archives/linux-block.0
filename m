Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC85A29E11D;
	Mon, 27 Apr 2026 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303315; cv=none; b=TpM43c4QlS1qCbxVWhUtUKbIDtDq9FxBLmrxL7M7DPOV+20qEpNJzk9MTJqM6CuLtx69obE6tQfeQt8HPB2LiZH4lL2XG5x7ZnzJpt4i24lFvbcZWh7lza8/yPqDZ+zjELawshbTnmh3PrZFvEgoGhbZMjergND176+18/+utQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303315; c=relaxed/simple;
	bh=WB4zlQm9+FHX+K7g+OB4l8qgcWOrwaIHH/nk762xS9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gU7qI7XavlvSw918h8hOnk9JGWaGKgjkI8z7kGPZr+aqg+AnNdTEw12jYjc4cFK9K3SGeIUbXay2ecRWFphYAqGFAC5Z9Sb+14GXcjcnzXLzo/jVuYvMRYOuSr3+eja8MxuGh/TAbSBtRF6vPCaBRspn9U2Oh6sKhnwt9W2nJHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1Z+QPwl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1Z+QPwl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734FBC19425;
	Mon, 27 Apr 2026 15:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777303315;
	bh=WB4zlQm9+FHX+K7g+OB4l8qgcWOrwaIHH/nk762xS9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B1Z+QPwlSzm9DUFf2VXkMegOGbnMpiWlwRjD7F80talUYpO/pyKyC7SO0jHLe13kM
	 3cmmSFDvWp2MNbCd8jSEl1LLBWs/nGaChpw115gE3SdbtA8gUAtots2MOeFHq4+NP7
	 uHYP6WLhYs7hfrG0buM4N0/lRP9D8ZzjboSUgzxkoagKLLeoOxJLajtuMGTsh3Xs0r
	 JkWKeWJTZS/9Ij5RPTGI7SsYgrMNvFQodBmQf02slmNQLUJQeovo0UgnQ7cZmVZZle
	 qMjrvGXl2FHQle41b1dJu67EKEcX8EB3X6gdLP4+E+9N8ejYYYa/ARbMsIydBvHGwH
	 GNFj1MZW7JTcg==
Received: from johan by theta with local (Exim 4.99.1)
	(envelope-from <johan@kernel.org>)
	id 1wHNmR-000000004uP-410E;
	Mon, 27 Apr 2026 17:21:51 +0200
Date: Mon, 27 Apr 2026 17:21:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>,
	"dongsheng.yang@linux.dev" <dongsheng.yang@linux.dev>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: rbd: switch to dynamic root device
Message-ID: <ae9_DzhmCX87jkQC@hovoldconsulting.com>
References: <20260424103931.2616903-1-johan@kernel.org>
 <ac8ef2a52e42512d17ef3e29cc94353c191c6846.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac8ef2a52e42512d17ef3e29cc94353c191c6846.camel@ibm.com>

On Fri, Apr 24, 2026 at 06:48:32PM +0000, Viacheslav Dubeyko wrote:
> On Fri, 2026-04-24 at 12:39 +0200, Johan Hovold wrote:
> > Driver core expects devices to be dynamically allocated and will, for
> > example, complain loudly when no release function has been provided.
> > 
> > Use root_device_register() to allocate and register the root device
> > instead of open coding using a static device.

> > @@ -5390,7 +5383,7 @@ static struct rbd_device *__rbd_dev_create(struct rbd_spec *spec)
> >  
> >  	rbd_dev->dev.bus = &rbd_bus_type;
> >  	rbd_dev->dev.type = &rbd_device_type;
> > -	rbd_dev->dev.parent = &rbd_root_dev;
> > +	rbd_dev->dev.parent = rbd_root_dev;
> >  	device_initialize(&rbd_dev->dev);
> >  
> >  	return rbd_dev;
> > @@ -7331,15 +7324,13 @@ static int __init rbd_sysfs_init(void)
> >  {
> >  	int ret;
> >  
> > -	ret = device_register(&rbd_root_dev);
> > -	if (ret < 0) {
> > -		put_device(&rbd_root_dev);
> > -		return ret;
> > -	}
> > +	rbd_root_dev = root_device_register("rbd");
> > +	if (IS_ERR(rbd_root_dev))
> > +		return PTR_ERR(rbd_root_dev);
> >  
> >  	ret = bus_register(&rbd_bus_type);
> >  	if (ret < 0)
> > -		device_unregister(&rbd_root_dev);
> > +		root_device_unregister(rbd_root_dev);
> 
> I think we need to assign NULL here:
> 
> rbd_root_dev = NULL;

From what I can tell these devices are only created from the bus sysfs
attribute so this pointer will not be accessed if bus registration
fails and there is no need to clear it (or add a sanity check to
__rbd_dev_create()).

> >  	return ret;
> >  }
> > @@ -7347,7 +7338,7 @@ static int __init rbd_sysfs_init(void)
> >  static void __exit rbd_sysfs_cleanup(void)
> >  {
> >  	bus_unregister(&rbd_bus_type);
> > -	device_unregister(&rbd_root_dev);
> > +	root_device_unregister(rbd_root_dev);
> 
> The same issue here:
> 
> rbd_root_dev = NULL;

So this is not needed either.

Johan
