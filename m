Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5651819EEC7;
	Tue,  1 Oct 2024 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727774791; cv=none; b=HBtcf1f5MwWMwbyNoH/oPCojKMPeo5nRzDdeGYFzzZjPcv2q5i9jvZinNrw3x/USUq57qirFEaBF7vvAt/ewJSbk6K0FzeiS4KVHxthL0icd78Qqnq/4leRCfc/kUV8fQAjmy2L1lmNHETYK4pVWJqgjqd+O3qWEXl2lJcisxpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727774791; c=relaxed/simple;
	bh=kiLNEv8PYjxTKEEFtqR9FMXfuJo2JfE3v840lMfZqIw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBjNVkZ6TAGeq5dV2K+LWOaX9I8ohmJS0u7qFbeooIbE7Ho9cHWAVnT2pN24u3sRWUlqGjpuZi6aTtfD0bSb1faDB3jPv3EAcaJTgvqZUV0SacUgwcyBgD35vM9h3QU/OJ5qo1yvrqH98CH0mANR4zsWl/UUt7/uHjjs3gtry+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmP6O+AK; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmP6O+AK"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5398e53ca28so2783519e87.3;
        Tue, 01 Oct 2024 02:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727774787; x=1728379587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OKOpu8OvR9MCdCVBtzoqXKWA0SUu6W2UxiEcZRsyq48=;
        b=hmP6O+AKx1CEUu5cRjPqh4fF0HwlWxMpup/Z37s4td0Gt9h7pffOO6teHFjQbfiMyX
         v8Sh27SGIDnSYM2xwrmuRsSvdpcMDehqcOkA67KSWlc/nzQZyFUJevxt/oJ1BgdvX7nP
         rDmpmOIwXMT7OR00BEEAAYDUYSJMZXOdkcoTn2TXnGieaSK54C3KfEOFrWyHIusJFPG2
         5LQwxWf675q0W0HPmO7bUTxIcphSnORxHvtBtqu5kgIRIFashMsOYyRoZcEIjxynsqGo
         KZikduDlx3hLVlzjDaJBU2C8IpQNUZYlHBv3mP4PvNF9Jteyv1jnRA3+8HYqBrN9xTZL
         gpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727774787; x=1728379587;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKOpu8OvR9MCdCVBtzoqXKWA0SUu6W2UxiEcZRsyq48=;
        b=JhQmz11D4hkzCu1rj+o98je+CgbxkoLIs2TutKdaHVxPMLBNsXgRXjOUkgrtADb28+
         1kSTMqARh1Qn1PNIMv8FjUrJ0dD+DAq7TE4XcjvyC8l7oFRF/TztabcJIYBFr6rwc0zE
         ZBd3CD/JJ9rUJVhrNTTF49+ZcM95r+j6RMBCpFPId/ebKRXkbTpJoW3sptkRGvDTeTj8
         a8L8QFVaT4zSNxVN7QrPuBTcAmyb3eZe35a9XDmZ6mr6S1koBlacss5lbfRo+EVD5dNG
         g47DLpYPX6NardHaFegg4mago3AuxGh/VlwBC1w2pP+TsK82/GQPqhRVLO3FyQrpTP4T
         jHuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFVXir9lnxtI4vdeb0clb2YJ750WnFjukuLOGsWA+UCpr3w7be94mITKCMvOf+IilA1y4K2OmLYOMD0Cc=@vger.kernel.org, AJvYcCUKck7EvveoyqTbtSZTjGqlx0MMZivgqz4tZ0RLkGum2U8Tn8yOHw1qdPVUNrn1lEDQyqSyw+ZzIRMw@vger.kernel.org, AJvYcCVLWA+xCSxwbKqZ0+x1DOO+8R0AsXmL8YxvF+pWcSETAAE0+M3TKlqCSjHFgYVTcfGMcj8WTlBmngZn@vger.kernel.org, AJvYcCVwomWiwFgw0MiLUNKzZcuAjGW5uLpwmPffV4Pv/qiU0AGt11QDRwwyu36AZbRqLDDrJ0vWdjdSZRFM@vger.kernel.org, AJvYcCX8PuJNNldBqD+NWD7zPyZhVUbnAx1zvpBUKqCecCgrjmPOZ6e9Vqm53zhInRYXIUCRSbw3LnS/qIS42Et+@vger.kernel.org
X-Gm-Message-State: AOJu0YwURssJCPvZnw6IGiCgAD6W8Qp6yqP3bJgiva/FaaYfLboB/IT2
	Yec5mVSIDayrLYBKjhBzJtvAbO+Dyqp3k5bv5QD2WNhLGMKW819/
X-Google-Smtp-Source: AGHT+IEBBnzS/FO50TPUnWbkTUuN3w869DwW/d3QRY5TeM6swS5Re+a5N/eh4RpM6YoSiU0Djf7oxQ==
X-Received: by 2002:a05:6512:280e:b0:530:ad7d:8957 with SMTP id 2adb3069b0e04-5389fc7faf8mr7778280e87.49.1727774786946;
        Tue, 01 Oct 2024 02:26:26 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a54fdesm176188105e9.41.2024.10.01.02.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 02:26:26 -0700 (PDT)
Message-ID: <66fbc042.050a0220.3523ed.a6f9@mx.google.com>
X-Google-Original-Message-ID: <ZvvAPjRAhmUXWCWa@Ansuel-XPS.>
Date: Tue, 1 Oct 2024 11:26:22 +0200
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
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvu0sRreId59-lpH@infradead.org>

On Tue, Oct 01, 2024 at 01:37:05AM -0700, Christoph Hellwig wrote:
> On Tue, Sep 24, 2024 at 12:17:36PM +0200, Christian Marangi wrote:
> > On Mon, Sep 23, 2024 at 11:34:53PM -0700, Christoph Hellwig wrote:
> > > On Mon, Sep 23, 2024 at 12:59:32PM +0200, Christian Marangi wrote:
> > > > +#define BOOT0_STR	"boot0"
> > > > +#define BOOT1_STR	"boot1"
> > > > +
> > > 
> > > This boot0/1 stuff looks like black magic, so it should probably be
> > > documented at very least.
> > >
> > 
> > It is but from what I have read in the spec for flash in general (this
> > is not limited to eMMC but also apply to UFS) these are hardware
> > partition. If the version is high enough these are always present and
> > have boot0 and boot1 name hardcoded by the driver.
> 
> How does this belong into generic block layer code?
>

(just as an info, we are at v4 where I added more info about this)

The cmdline partition parser supports this already, just not clearly
stated in the code but described in the Documentation example and info.

> > > > +	partitions_np = get_partitions_node(disk_np,
> > > > +					    state->disk->disk_name);
> > > 
> > > disk->disk_name is not a stable identifier and can change from boot to
> > > boot due to async probing.  You'll need to check a uuid or label instead.
> > 
> > This is really for the 2 special partition up to check the suffix, we
> > don't really care about the name. I guess it's acceptable to use
> > unstable identifier?
> 
> No.  ->disk_name is in no way reliable, we can't hardcode that into
> a partition parser.
> 

Then any hint on this or alternative way?
Again this is how it's done with cmdline partition so I'm just following
how it's already done.

Also I feel it's not clear enough that we really don't care about the
identifier, eMMC driver hardcode and always append to disk_name boot0, boot1,
the fact that one disk or another might have a different identifier and
they change on different boot is not important for the task needed here.

I can drop this thing entirely and make the implementation very simple
but there are already request and happy dev that would benefits for the
additional hardware partition supported by this.

-- 
	Ansuel
