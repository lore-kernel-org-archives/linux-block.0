Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4464218C325;
	Tue, 24 Sep 2024 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727173064; cv=none; b=ku3MAo/HSPeG69CMJlcnJOtLzKOXrr8FXMYICAFIfRpWrtTwiqvEbWRlfvmnsKs/QPkD8IMgHv+2KVn65sZ6+di7LBVN1Fb3NnaBCB6KkukH4GSXTQKc1CnTFIRhjO25tlfGKxz3xIIprfi2Y+mjsHK7Tk7ms1nJAmQysf2X6iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727173064; c=relaxed/simple;
	bh=MOrv/PO4+p/q2gx2H/jXlnLEDH+f3OEGh0lgTFRI7QQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCmewtgXF0Sfi9Dz194/EUoMXXDnPF4/MWnhMWGd5ILy++e3UqwdrmeqDlRhcsdDmw0cNEXq8qkbvH7WfuzQRhPvKpO8xt1PM61wJEm2OTP58Lm0CdeS1Y4fcU8bb/eK2HJF28Ab+LcX0pYXoxAeGD6uLmaPJVlTMwvt24uC/jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z38oR2E1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z38oR2E1"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so53307635e9.3;
        Tue, 24 Sep 2024 03:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727173061; x=1727777861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6yq/DwFQfx4tBwrb6K58nwBTecQ5jjhs54hsQLsb9E=;
        b=Z38oR2E1dsCG6CNYo51evLlunqZ20cOYS4Ppt1yoZVdkMgZrKv9J02i7f5MIJIy3pz
         lkMSfpTAA+vi4j8rfgTcRDMV+pyNivEHEFEYEqdquoD3s8nsx/y5A+aAAjWzaMBHac4t
         E/5hCXTtnNjJzomGLqD4TxFpbifNJn8rSyb7+K38wTOIEW46cHHxZZ2NKG06dh0f8Em5
         8Rd9iAdTJTUz8BeDl7k/zz2K8LNPkScGNJOCVnr9Q8TmsEIp/pOqTVg+6f7NKQXGNcbq
         uJHAtmOB1kddFNtYL3xiRil60W2owfkiSgiuo0LSZquyrcget57b+cYAhhaDz41yfVKH
         aoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727173061; x=1727777861;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6yq/DwFQfx4tBwrb6K58nwBTecQ5jjhs54hsQLsb9E=;
        b=p0e9xjdoPsHRZPsvLGPtoL7c+9HW0mIRFQ0DfQp7DsGV2QHIwIC+OfWqKlCj09uFCq
         S53SaAHP/GA40dSSx09SjuQ9ewmcpSwQcvDnfTWKl6i+d/J85kUIUKuo0x/L3LVarJk1
         T79DBzMRdfLfP4Gvc/RNJF6Tl3cVHuPIkBEii7MWqTDQRsUTR99MpBcbvzUgdeYIqUT2
         INwiq1IvSasrxkREH/v2cExy393TRXrVL42VvotAhKPzbLLuNHBa3nupUzmVD/ZI7xOz
         ko5VhnIwLADCBbfpNcXV1v0tQyX5EoUWnH+6vXXpzDpKxr/Ee+g7G6RM3mgSvNH+wso8
         F92A==
X-Forwarded-Encrypted: i=1; AJvYcCUa5DXOhQ05b3n85NeKxyw8XLhlYJxl1eC3Wxft4BM8JzWajpiS4jB3BJTZ1IcBgzoFguOgkATuuOOp@vger.kernel.org, AJvYcCUqk/Ob0M8x0mpUd7P/rRkUcpbceFVHAvz0O9e8Fgvptzhn0T2QSGO14lw8W69JnOhx91cvlvWIFXcMrbg=@vger.kernel.org, AJvYcCXLURe4W8R/yDkprd9Riobm0dbO62aJaGr5xjDChiLLOcCiPc/r+5iEmV2kGdUUE39xiPfBOveSxXnddbRT@vger.kernel.org, AJvYcCXNIb06qukqmiqIWrPdgxOXYO3sivBKaTUPf4WnTfPODG6d4f00N3CmMMsLvu8BmdIPcrmy3yEmkV5X@vger.kernel.org, AJvYcCXq5PWCz4UTjuTyBHUUT6/nR76i3EONd3Tm6KQeMODH9JRzt7i0FeRon9nb4ryv7wBmYUYNkbSJ6ra+@vger.kernel.org
X-Gm-Message-State: AOJu0YyS0dClzAe7bRGqyUWI6NAWJjOaBxkHuYJq+jW0fXInORs1tMP1
	18a0C0YVGdkDuzSs1e8OlPytss/7XUNjUuCoib/1/8Ugb9jwNyy+
X-Google-Smtp-Source: AGHT+IE83mnLUuf+4WZRfrPw50LD+lxqX8rWtjINgvgK2vW5eLA5p3k20e4sMLnXxjQweQjgZ91oYA==
X-Received: by 2002:a5d:4488:0:b0:377:9867:9028 with SMTP id ffacd0b85a97d-37a431ad4dbmr7918215f8f.44.1727173061365;
        Tue, 24 Sep 2024 03:17:41 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2c1ef1sm1188238f8f.35.2024.09.24.03.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 03:17:41 -0700 (PDT)
Message-ID: <66f291c5.5d0a0220.328e5a.2c9e@mx.google.com>
X-Google-Original-Message-ID: <ZvKRwI3zrXURbYKS@Ansuel-XPS.>
Date: Tue, 24 Sep 2024 12:17:36 +0200
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
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvJdjRpFaPUuFhIO@infradead.org>

On Mon, Sep 23, 2024 at 11:34:53PM -0700, Christoph Hellwig wrote:
> On Mon, Sep 23, 2024 at 12:59:32PM +0200, Christian Marangi wrote:
> > +#define BOOT0_STR	"boot0"
> > +#define BOOT1_STR	"boot1"
> > +
> 
> This boot0/1 stuff looks like black magic, so it should probably be
> documented at very least.
>

It is but from what I have read in the spec for flash in general (this
is not limited to eMMC but also apply to UFS) these are hardware
partition. If the version is high enough these are always present and
have boot0 and boot1 name hardcoded by the driver.

> > +	partitions_np = get_partitions_node(disk_np,
> > +					    state->disk->disk_name);
> 
> disk->disk_name is not a stable identifier and can change from boot to
> boot due to async probing.  You'll need to check a uuid or label instead.

This is really for the 2 special partition up to check the suffix, we
don't really care about the name. I guess it's acceptable to use
unstable identifier?

Thanks a lot for the review!

-- 
	Ansuel
