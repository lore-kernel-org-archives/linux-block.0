Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009651946B8;
	Wed,  2 Oct 2024 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727857356; cv=none; b=tmKv98cY6BhAIprdtblqY3+h9JsUvlgz/cXos2G1/QWD/DirOpcxFGIE6EP7HRXQ1rvSaNQlk0MKWfQAIXjs/J5gcVhRjIg6ujNFiDy1t94M1noN5yXtL03AMoqa2ySLU/kAMndMGTvTWri2a+2eg5dKknQlwMh6p67yPyvh3N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727857356; c=relaxed/simple;
	bh=4GNWQzdmMCrDARd68xFjaPRtZKjsriOwHawo+hPlevw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rd0wVj9t80T2cSdvqmVrzzRIzWcYkMxVA2S/X4hPJlBa3H2trzFQs5ObzxZk3pbnzzG1nGd3XTyy3GcULjlciFrNewf+a6wr/QFBJOIT7U9JwWx2bBgvL3bOZmk6h9/E1L8z7aXl9KArGLKJKUMC6Wvd2EgEfCe+ioAwMna+b3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cL43Chs/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cL43Chs/"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37ccf0c0376so3736691f8f.3;
        Wed, 02 Oct 2024 01:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727857353; x=1728462153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3Hb3k3EKf/EoWRFs2OpRBiWSn+ODx1WX52yygI1Im4=;
        b=cL43Chs/5v5QuDP/9mhIg7AedbMFAumDCbUajDkYLF1OAzkcxYqmAGRt8k357bN+Bh
         8xK53FegUGWgew6idZpK9Y7pXGeBW0Q7WTAsDXk3NyZBqo17N5Llk7fTmJdARB23N6UP
         pbl8Pt5+5HhFK3MNK/Gax4czTaMk+GQjf3ualoP4YvOPAlbLlIXBgElXOQ4HWDMv/tR2
         zCO7Iz3QiZud34XQSbwKVajp+TrAY/YtJ7gXmh8e3+99p4nsAM0ohJ4MzW7IN3LngBz1
         lqTh9+5jEkdGQ2GF35s2wAncHKVDBW6XE0jzUQou53C8sICxx7FKAnlnXHI4pJvhZA8I
         dMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727857353; x=1728462153;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3Hb3k3EKf/EoWRFs2OpRBiWSn+ODx1WX52yygI1Im4=;
        b=mr73ETyk7xIUfNMjNGf+9CR/OLA98EyoOk9vqNDLOAC/CTXdZxHKztzs68fGSgI4Me
         f8j6UCtpyzUZpavLhNb9lPAFY32Ss7SASV39twu47mOIo/MIox0o6F6tPd/Yb75JGMI6
         NU3AkdEjW/OLZX1MSrSrOEUFY/FyyGAh4UpWgNrYsP8jukLJo9sFFU0tAnv+gvzQ6hMN
         lJ43niOI3mFZ0B5nUTHl/C3nwBmUCkSDg31oYCvqJtKtfHACDqlnY2BvTkl5+sf8FBc9
         wqe+3Sc/iGOjUEJFWKqGwTgqQclOqj1z2FC7gY9d2uaiEQtiMi94cSzrvzd+YDFaIj9V
         2wLg==
X-Forwarded-Encrypted: i=1; AJvYcCUTBulACD7+VVHCceXpyNJRb+QptAeefMozPTR4xJ6bgGJ9FzAp7r6ifRs+/kk2P+mGkt+mrK2nHKvv@vger.kernel.org, AJvYcCVycPePuD0UCotxYc5hXDSYDZ1MUNyx/Li+mzRAY4t0rbv6Jc+MENrJUMnM4rS3fN07iyy1rNroIccvE2c=@vger.kernel.org, AJvYcCWCEYKM2Ap36/52im35gsYupyYBddTrLciuPETFZwUq5sQeihNE7m4y/Y1+27BRPaSEEW8DiGBx5ZRs@vger.kernel.org, AJvYcCWkZE3EgbcRQGjdg3h9kFqBC/Y1T0Kaxlj5j/jxiK7DLs8nM8AC9BmN1lv4Mf8aeu9PbraomQR2ycyQ8HkU@vger.kernel.org, AJvYcCXhtCK1VW+nIF3UYQ9U8M6eO66qqoWphYqeL44VSBuTiJeCBeeNbnwPh+21eTopn96R7hHlTJdt9t4B@vger.kernel.org
X-Gm-Message-State: AOJu0YzJhPf2lX8EJaJPWpqYgALNS7GbgxMGR/qvwwO70XZJ0a7MhSo4
	wuNc/ChstiJ2VuvDW+ijxd49/BSTtK9A47A0zrXFRoIe6HLrCR+5
X-Google-Smtp-Source: AGHT+IE8UWf7hexFP3MZr4siAQZDY9GW8rIP/zhC2ugK34rKeX/R6x+wyxcjCBk0DgE6Q2BfTkH/1A==
X-Received: by 2002:a05:6000:1186:b0:37c:d227:d193 with SMTP id ffacd0b85a97d-37cfb8a30b6mr1228838f8f.10.1727857352944;
        Wed, 02 Oct 2024 01:22:32 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd572fbebsm13428241f8f.72.2024.10.02.01.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 01:22:32 -0700 (PDT)
Message-ID: <66fd02c8.5d0a0220.796f6.d2df@mx.google.com>
X-Google-Original-Message-ID: <Zv0CxHUwiTSgLVO8@Ansuel-XPS.>
Date: Wed, 2 Oct 2024 10:22:28 +0200
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
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [RFC PATCH 3/4] block: add support for partition table defined
 in OF
References: <20240923105937.4374-1-ansuelsmth@gmail.com>
 <20240923105937.4374-4-ansuelsmth@gmail.com>
 <ZvJdjRpFaPUuFhIO@infradead.org>
 <66f291c5.5d0a0220.328e5a.2c9e@mx.google.com>
 <Zvu0sRreId59-lpH@infradead.org>
 <66fbc042.050a0220.3523ed.a6f9@mx.google.com>
 <Zvz6ITaMKmo0U3c3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvz6ITaMKmo0U3c3@infradead.org>

On Wed, Oct 02, 2024 at 12:45:37AM -0700, Christoph Hellwig wrote:
> On Tue, Oct 01, 2024 at 11:26:22AM +0200, Christian Marangi wrote:
> > > No.  ->disk_name is in no way reliable, we can't hardcode that into
> > > a partition parser.
> > > 
> > 
> > Then any hint on this or alternative way?
> 
> The normal way would be to use eui/ngui/uuid provided by the storage
> device.  We have a interface for that in the block layer support by
> scsi and nvme, but I don't know how to wire that up for eMMC which
> I suspect is what you care about.
> 

I think I have found a better way to handle it, please check v5, did you
receive the series?

The new series just make the driver pass the partition node and the OF
code just take it and use it.

This way we don't have to parse the disk name at all and it's driver
specific work to select the "partitions" node if multiple are present.

I feel your hint produced a much better implementation without having to
pollute the block code with specific case.

-- 
	Ansuel
