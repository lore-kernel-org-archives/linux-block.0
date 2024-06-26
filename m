Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AAD1922D6;
	Wed, 26 Jun 2024 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431790; cv=none; b=ZdOsU5RS7H42wiYNrWZwFlN7Z3jbASCqBq5VagnmfF4mnWUpdH8btX6SlU0ZUhGXc7K8w3HD4YD1arL7czpMINKrSLykueSx7FUGBfP+ff3eF9JCpmAA3WrBzGCQeIopZTRez8NGSX5thPpYDoa8j6mizGfWQDu22yzNuuSXYLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431790; c=relaxed/simple;
	bh=xF9UeWfTzHz8HNy3TSbvPPUPUomDd/NHcJaptNVaIZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ffps5CWYthv9yoml7YOTeaI2mGf8rsMGC4bsrffUoX9LuJYNCOwWTOB7oxuiOcewt2HNROvkLvrIkRTPGaGnnYyIK65ySvUhiH0ifM497hiWGeD9TIWSt/4whE8T+hCLRl/VdoDpP4uzIu6geCdhCn2A82torroj+2aY8tTSXB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sMYkF-000000001ji-0ybD;
	Wed, 26 Jun 2024 19:55:55 +0000
Date: Wed, 26 Jun 2024 20:55:46 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Hauke Mehrtens <hauke@hauke-m.de>, Felix Fietkau <nbd@nbd.name>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	Min Li <min15.li@samsung.com>, Avri Altman <avri.altman@wdc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Hannes Reinecke <hare@suse.de>,
	Mikko Rapeli <mikko.rapeli@linaro.org>, Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Li Zhijian <lizhijian@fujitsu.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v3 3/4] block: add support for notifications
Message-ID: <ZnxyQgYyM31Xq2xV@makrotopia.org>
References: <cover.1719368448.git.daniel@makrotopia.org>
 <609f654800583feb016d96d9c3fc2f029f0f460a.1719368448.git.daniel@makrotopia.org>
 <58cc9e3a-bb69-4205-9f11-d262f811ea9a@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cc9e3a-bb69-4205-9f11-d262f811ea9a@kernel.dk>

Hi Jens,

thanks a lot for the review!

On Wed, Jun 26, 2024 at 01:46:50PM -0600, Jens Axboe wrote:
> On 6/25/24 8:51 PM, Daniel Golle wrote:
> > +static int blk_call_notifier_add(struct device *dev)
> > +{
> > +	struct blk_device_list *new_blkdev;
> > +
> > +	new_blkdev = kmalloc(sizeof(*new_blkdev), GFP_KERNEL);
> > +	if (!new_blkdev)
> > +		return -ENOMEM;
> > +
> > +	new_blkdev->dev = dev;
> > +	mutex_lock(&blk_notifier_lock);
> > +	list_add_tail(&new_blkdev->list, &blk_devices);
> > +	raw_notifier_call_chain(&blk_notifier_list, BLK_DEVICE_ADD, dev);
> > +	mutex_unlock(&blk_notifier_lock);
> > +
> > +	return 0;
> > +}
> 
> Nit: redundant newline.

I'll remove the newline before the 'return' statement then, right?

> 
> > +device_initcall(blk_notifications_init);
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index b2f1362c4681..8d22ba03e3e1 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -1687,4 +1687,12 @@ static inline bool bdev_can_atomic_write(struct block_device *bdev)
> >  
> >  #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
> >  
> > +
> > +#ifdef CONFIG_BLOCK_NOTIFIERS
> 
> #if defined(CONFIG_BLOCK_NOTIFIERS)
> 
> > +#define BLK_DEVICE_ADD		1
> > +#define BLK_DEVICE_REMOVE	2
> > +void blk_register_notify(struct notifier_block *nb);
> > +void blk_unregister_notify(struct notifier_block *nb);
> > +#endif
> 
> Surely these helpers should have a !CONFIG_BLOCK_NOTIFIERS failure case
> definition? Either that, or dummies. As it stands, any caller would need
> to check if it's enabled or not.

Makes sense. I'll add dummies to the header and always define
the macros for notification types.

Note that what I'm planning to do is to have the block nvmem provider
select CONFIG_BLOCK_NOTIFIERS in Kconfig, as without that it simply
won't work at all.


Cheers


Daniel
