Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B113AF2
	for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525709; cv=pass; b=c8lLgHl4Cok9jSTDXID1E9jnZr9OPxf6AdupegSCwerLW8Ir6rtnOGIRHb2Pty3dPk6nqgt7yEoBX5XDT+Rphr+xU6tWWSPQ/ZbKfgrk+QtZGRxs7q4fjzqjjk0X821r6scmi25ncaXBbBIqhXswdhd2Z4/3CyL8c9+WCMideeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525709; c=relaxed/simple;
	bh=t2ybBJsNWtFjQaIkqKJiX+bUT4FayuvonReDdoNdNG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Igp762FS/8FOZTJpUuQefj8HndcQPRfzzgVMRIgsqjEihbPqdXnGvZnw6sh3C7Fedp/BD7nf6H9xfFLxXn+AObSH0c46uyReIxz3fyq/mAgJQdumaufkYLIY66du0sI+7OUKsv0ZUuF9hYfz4mPeaxZAOoQgXrIqOENtLH7Wftw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvFulGeI; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvFulGeI"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b87003e998bso1170014066b.1
        for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 06:55:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769525706; cv=none;
        d=google.com; s=arc-20240605;
        b=Lx4uKit/r5pEAx23/VZ1fVmBWw/N7pWcIgKVdjvPbxDz93UjZj+fbnSW1tzJ4+n8Y+
         7DdAnvemK+H8XeVwznI4/89MjzgXgVRHkQF3zWXgeADTSHvPk9GkMUKfr4C/FdjUjpic
         AVDXg4Hd6lExfTY+4jMyzk40j6UdMt+kfJ6uHGSgGQuomGnjx4/gNcmsKw2oXPUlYbXC
         /o1fh8n152QynlQ4oCoYYc/+LMYklHkFzcPrPQDw9wtG/XsELFxuXbqOuANzmb1Dfz9n
         A9e/0E9qBxQIf76PI6eOcj8rzQp4LH1lpJcm6T5Mc2h53f4cS+lnzj3vWfqSVZvxvPta
         Pbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lCtQBBTytpHyzGbCjZPP22G47ZoJNaJiWCn03phHKmg=;
        fh=cER5kyZ+s05CE50poFRexqWk50t2S1d2sMb2Xk/Pm4g=;
        b=QS4Hyp6eNRtxU5pwKuecgQ/EnPwni5ug6Ktqq0p9R6Ynfw745jvhx7lq2kZ16RX2U2
         Ira/QyNVpHTTwT6J+2gVYl9qdnv3/adHQ/K5QjerKH0gAgUcGnnJpiVf7fkjQzCwbYk+
         qqmJzyq9QnQZ9KsP0pmZDm/PHgPZboYsIkhc3JcnFgD8E6ARkChOCmExkp5Q7oQwtMX2
         U4//sO3WjYvU1s3IuKpXJb7UYPs9InNdrb3MF8uaXfZLdgXBX4jEa/3bvD+x8q744/nP
         HwkSy3tXpieX434vdZYN2MEvU9wYshzZ7Y1NA+rV/qRrJjr7f3JskDg0EA6So+EdTq5C
         /h+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769525706; x=1770130506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lCtQBBTytpHyzGbCjZPP22G47ZoJNaJiWCn03phHKmg=;
        b=GvFulGeIrpJtBdSxwyjbfkhzgapKKMMVosbvI57UYBPI3aBbqCPmlDshU2BQeOeaH5
         nfKtfsgJqvSAr0xHpI+/qEtslAyIdDVwAJ8uMAL8caUYV7kCfHHx4iAthN9KunwhReyY
         PyZ9/BXHWpcqzo6bjfGxCyG+3DzRX+wtkVK+x0pz8VhEZwc4TUtpP3r9d8HJ19YJYDso
         +6utxDOUnhtIxerovJgQaRIE9joS5rywwPEeu0d+tbdGCH6OBFMiB9yw9Trq6dwJgnw6
         31xYd1sw5pCk+mkro2/D++5IYVlmCceH24urBYAVJBxqFwlS8/7GjoiiM6bDdVts6OrD
         YTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769525706; x=1770130506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCtQBBTytpHyzGbCjZPP22G47ZoJNaJiWCn03phHKmg=;
        b=gsN3cW9+LhRF3ko5HUkXg5okRTaSxI8FvdHLMjEENq7CEw6dMQBoLnYDngQ6Zj4d+/
         tgfJS3bbB5pEtxrur7ihtucSgJq1S0KS5KJH95WwsGt+i+ZvQkiLUaTSyByIMGczd0y/
         dJAQswoHXztNxvOsIirOiSkoNyh8c2EnB/He3fk6BUVlcnzcKbUoi6e7TPGCLT28bcOS
         kI+fpU7Dd4xgJ03nH54XGAKeecbAw1zCbri+E/m7BtqFgROXumstb2FJnQjHEtUDa8Vl
         XMc63ZZB9ekVo84AQ1lNflXugU/tzj9q9mZqGcVNTeaNMElcxY2r+R209xd7RiTWHADh
         nfEg==
X-Forwarded-Encrypted: i=1; AJvYcCVuYR0XUDb43HlrMJekDQpMHHaIPVsUzF1f2jIJxVgrBg9DFkrUJPC2aa7r3xkE42dGtmard/aKXGkleg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0tJI0/EC9I+3JH7StfQgWyvwGw5cSn4Ni/OM93ICZm1YX4rc
	tizWIj07tjtZM5O2rju3kYRGBRlY/IvxhmVmC2+YsUY8NeXBv+h967ShCglLOnr/kDNOp/NLoWy
	blb0YPGyIK4KdsPSeS7niQyoejEwI9wfOrUw=
X-Gm-Gg: AZuq6aIbbtfGKALsJWVvnyR6PxIpTfGZ4ZshcNKNKIRIIkFYitoUQzb0RyJmiXEjP6b
	QwmT2foAa1ogkl4ojkL+EAMU4m6ykR3uOKbS2nIO3Dr61j4BzZcJBXIQaA9gJiz2QI88Pk8yexZ
	KYb+MQus31rz5W2zrWDFO/WBDswzdXwazmpnKGJOeoEB9O+gQELbUdAyOgfs3qJr6bx54Rk7CwQ
	yF9IOmI5ng9Ep9H25Kn3dTp1CsQin5CB9i7QiKtOIbCv+hooUEJwuPxetzGi1iT8p1+k2H87n2J
	kPvm8uuzFIiRieZcnrmP8L1YElfdh+sUtEujOoZpdg4NBZ2jTjSDUIFYnw==
X-Received: by 2002:a17:907:2d08:b0:b76:d8cc:dfd9 with SMTP id
 a640c23a62f3a-b8daca2128fmr161653366b.18.1769525705537; Tue, 27 Jan 2026
 06:55:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121064339.206019-1-hch@lst.de>
In-Reply-To: <20260121064339.206019-1-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 27 Jan 2026 20:24:28 +0530
X-Gm-Features: AZwV_QgrOpVy11EguRWdouecQbjVaZ_wK6fgRNHqWm4H5Y0Gztccb7HBO3aIMrA
Message-ID: <CACzX3AuDkwEw3v0bNmYLk8updk1ghVJa-T9o=EHXor9FA7badw@mail.gmail.com>
Subject: Re: support file system generated / verified integrity information
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Christoph,

Here are the QD1 latency numbers (in usec)

Intel Optane:

Sequential read
  | size | xfs-bounce |  xfs-pi   |
  +------+------------+-----------+
  |   4k |    13.62   |    7.2    |
  |  64K |    99.66   |    34.16  |
  |   1M |    258.88  |    306.23 |
  +------+-------------------------+


Samsung PM1733

Sequential read
  | size | xfs-bounce |  xfs-pi   |
  +------+------------+-----------+
  |   4k |    118.92  |    91.6   |
  |  64K |    176.15  |    134.55 |
  |   1M |    612.67  |    584.84 |
  +------+-------------------------+


For sequential writes, I did not observe any noticeable difference,
which is expected.
The Optane numbers at bs=1M look a bit odd (xfs-pi slightly worse than
xfs-bounce), but they are reproducible across multiple runs.
Overall, the series shows a clear improvement in read performance,
which aligns well with the goal of making PI processing more efficient.

Feel free to add:
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
