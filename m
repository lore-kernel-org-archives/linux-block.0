Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB51145A1B;
	Wed,  2 Oct 2024 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858816; cv=none; b=jaJ/6Lu9RKkB/ogT2Jspq1b1JeGxNe5va3gbbCh8OAkvmul5PSbMfVGSCQqkTI9AF2o9KGW+oWugOjtHb2uKTNXtgd4D1Zhbcpwz5BMxBPgOTastu4WHSjckYrNNHOdbFXq3zczsWPVDDn+XZMH4exs+3rk09kzIoUVJO5BE1WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858816; c=relaxed/simple;
	bh=iy/BIYyK40dg9ebV9WMEldlWCF4rO/8jVQpEtKDVYPU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndt8gcT1jAg0gr0xNpjmZKJv1PT7GeaclcI1S6Kjd7WbPBO/n3aPV/k3TS3/lAVUchB7qfHBv4T0K45Y3VYGtGVR2aECpoAOIiLigotWbQHOGw0o8brgIK+FpJuRuPKpkAQwTmYU8nBvlHJPTAQj26nCQ1SS3OEUB5pDtnwcuvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJXKfF/c; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJXKfF/c"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42e82f7f36aso52090695e9.0;
        Wed, 02 Oct 2024 01:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727858813; x=1728463613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GhBvyE8q6EBFVXj/rB9bzTm3iod+t/31icDfvrestuM=;
        b=BJXKfF/cfYW4024HIvky/sGVrRO1Q6jKyO/GsKyT5k/76GxngPMOkDC9dD24BWjG1t
         uv+2+fQVdLYxpbHVRk4GwS5Z1TCoz1JsFxIA2eIW/elUdoGD7Ok9Y5PnxCRl7NRIsOiL
         aD6KqW1AacXuJWHfF8z1HBH4IsgSLYekVYSSoBIeTK7PSdOVVFGgvDAGJMaXGixRDjGQ
         ilTk8DPeWs5Z3RgqK4EckQtPoUHuG7MOuVYZpwG9Y3Y4irVsz0+r1GaLipaXtCGSy62X
         RKnujQku1tzXe/blGR2TiHSnbFnTPtDv99mJuJBxENrVAEU6oPfwnMW6+xORl4NsdO9Y
         UBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727858813; x=1728463613;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhBvyE8q6EBFVXj/rB9bzTm3iod+t/31icDfvrestuM=;
        b=fzSYZdGDqPvHtXBLHaqShPfvpLGjdnuUHwLqutB859O8cCth+2bi6Pg1Ln6c5OsqGB
         6hUGQ/cXWtfqXi0MR2ZN3CG8B/Cm764GGDQvlKmU9uG8HupiN0ic5bxFESK5772WwIui
         2vZaxebdZGty/xuJ350fQJBWu2HBa9vz2wBkF2jb/lXOqB+1g0Pi4ArmZe3IQTge2ij4
         vp8cslGTmM3yu5z+g989mpynaYUlgZAOR+ueIvQsG6sBd9KDGnSM6Kr01e3ddvFiVn6J
         ik+v4pcTOUfUGNPnHPWQl9TQU2ZHhvpUaNl7b5MIdSo4X/ugiqTXyJ3+FpVyF5bV3YkU
         rcEg==
X-Forwarded-Encrypted: i=1; AJvYcCUJEquh7liWEY/eWl5dRCQsC3BwaFAX0e1qK/+45BNJ+a4sifZpKIDc94gLSbW+1qRJc8bJtp4xOo1Y@vger.kernel.org, AJvYcCUVXgig7aHSj7KB7RfMpQ9gquCQmBv/CplvdhG+THzMD1TFQbYgRDV+dhj4BRB/q155GpFQX2WWRI4NQoSA@vger.kernel.org, AJvYcCVKa4lDPvDgHpHd8YVgPoTtk4OWDAecgkK+DeYEOrhaZ6QWJcD6P6N+zGxyOXO7QEjFIERGiVcsovokgT4=@vger.kernel.org, AJvYcCVOF2qSC9bPpEI9oGJNV+cN23FJEQHLZBbGXVU2KqbosHeUvtlst5q3b6Yk3ysJjOzj37kCiallt5h6@vger.kernel.org, AJvYcCVWXy0xIrIJdewHAFZkRsV9a3t7FAP1C/NLWGNJfD/RpP01jlKfDoP8M++wbQj3pd3n8bXDpKeRwSw/@vger.kernel.org
X-Gm-Message-State: AOJu0YzCTUZ84Va+OY4aN9I9xGYkXxhOId5ax7cUz3iWMB14cgB07j/N
	WEWCGXbwRRfxeyUVzJ0re0uU6IDz6+ap5PGma0oK96Dljr4oKun1
X-Google-Smtp-Source: AGHT+IHKwnQNXxJiHx0BQX5FTBdr/zPkLpqkMi6DWboxhbduPp1AM0cC9yPMwcN92vQUajlnTWArOg==
X-Received: by 2002:a05:600c:5494:b0:42c:baf9:beed with SMTP id 5b1f17b1804b1-42f778ef558mr14465905e9.27.1727858812582;
        Wed, 02 Oct 2024 01:46:52 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7a01f694sm12389635e9.35.2024.10.02.01.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 01:46:52 -0700 (PDT)
Message-ID: <66fd087c.050a0220.3b87ae.3666@mx.google.com>
X-Google-Original-Message-ID: <Zv0IdjQemuWZfZf5@Ansuel-XPS.>
Date: Wed, 2 Oct 2024 10:46:46 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Ming Lei <ming.lei@redhat.com>,
	Jan Kara <jack@suse.cz>, Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	Avri Altman <avri.altman@wdc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	Jorge Ramirez-Ortiz <jorge@foundries.io>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Li Zhijian <lizhijian@fujitsu.com>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>, upstream@airoha.com
Subject: Re: [PATCH v5 3/6] block: introduce device_add_of_disk()
References: <20241001221931.9309-1-ansuelsmth@gmail.com>
 <20241001221931.9309-4-ansuelsmth@gmail.com>
 <Zv0HGh0IjPCt3pYt@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv0HGh0IjPCt3pYt@infradead.org>

On Wed, Oct 02, 2024 at 01:40:58AM -0700, Christoph Hellwig wrote:
> Thanks,
> 
> this looks much better.  A few minor nitpicks, though:
>

Very happy you like it, yes I wasn't sure what was the correct way to
introduce the helper. If you notice in the blkdev.h we have also add_disk()
that is a static inline wrapper for device_add_disk().

Wonder if device_add_disk() should have the same treatement? No idea if
it would cause problem with symbol with external modules, that is why I
used the wrapper.

> > -int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
> > -				 const struct attribute_group **groups)
> > +static int __device_add_disk(struct device *parent, struct gendisk *disk,
> > +			     const struct attribute_group **groups,
> > +			     struct fwnode_handle *fwnode)
> 
> I don't think we need a separate helper if device_add_disk simply
> wraps the OF version by passing a NULL fwnode.
> 
> > +int __must_check device_add_of_disk(struct device *parent, struct gendisk *disk,
> > +				    const struct attribute_group **groups,
> > +				    struct fwnode_handle *fwnode)
> > +{
> > +	return __device_add_disk(parent, disk, groups, fwnode);
> > +}
> 
> I'd name this as add_disk_fwnode as the of in device_add_of_disk
> reads as in add the device of the disk, and the fwnode is what gets
> passed.  The device_ is a bit redundant and just there for historic
> reasons as the original add_disk predates the device model.
> 
> Can you also add a kerneldoc comment for the new helper?
> 

sure! I will wait the usual 24h to respin this.

> > +EXPORT_SYMBOL(device_add_of_disk);
> 
> EXPORT_SYMBO_GPL, please.
> 

ack.

-- 
	Ansuel
