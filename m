Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAF629405
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783558236; cv=pass; b=n5BCHM9E5ARaZf4IvuMLzT5YiE6RyobIbYmfsVPaghMx5XVwNHfWNZsCNXDXtcjDrWgEEaYEHmY41j9b6xcObNLMOHuWKcFIFCxZlCYVJjscVCgFZR6I7S1fblJn0eEkUJbrNm4wFzmxx5XuvpfwxLfgLYtBdEdcfmMqvXoGRW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783558236; c=relaxed/simple;
	bh=2NWaXAy80IS4mQNgSpAis+R77UTVZ9Ca0JrBHDRaTFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtAgGY/A9NNWPYhpoFMYVPsr6JYXFus3QGDqdM9aTsXvgiENeTvZohDe2tTXnZQ8eOECy7XceBwlEUoToup6TiQFOj/MNROjIXpBGmMuFrJinS1Safw5klYvwNAHIAfsYZXTXyTsdyQoyT/7mkYZ1GbuuTJvJFPSnkC7efuukgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNX8dpz3; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNX8dpz3"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8eefd0c5f59so9346206d6.3
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2026 17:50:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783558234; cv=none;
        d=google.com; s=arc-20260327;
        b=FJTKy53/DLw27j56G2bXDiHm3r1MSYtUqr4b8+zEDAAeTUwV1KS9gWCwcdUap0hcRi
         qFm47r4vKZ8h0nyx7kO8JhF7CFecMcyEkdd4q4BpuBG8Ews6nJf8Q+r/ETR6QbGtYdKC
         zKd35VQqkiOnQmolYJThWR28KFVpQYCy7ruTjRPbtpjp8NJMcoWVNa4bRNGzmFrBR+mt
         gJ145Odknz17VS9Xml22I2bsLCoNbanFWSkVreyHxzIckoU9AfeWhOhUl0MY0NWt4zpZ
         ww/4AWEIc6yQKmvJIabj/H7IEn0FWSr3nDxQyKGI3niDYMHLzBBEhYRXWvysL0OVKS8a
         mX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kkofK5lB9wXpWMbMSe+NkS3murI5ZbIBP3R8HNBHkiI=;
        fh=7MAkkEgk8CY2LC+hfeNR7KKwHIkch1Kf0Xh+MaH6gio=;
        b=F3EJZyyNgHLzYfk8bGnQnwxfStf1j/Ke94vIJXjYc9vCMfJTkK2NO7wWpXgDUduVRF
         gnmFWndXVlu73L/izVpootNvW3hlDPdIZequ5Z2lSUCybIaHT32mSLhyXHCSSwX4F9zf
         2XLetln3AQEv8XOl1eDXpRPpba8WzJw02U00DtyKsBXluOMTtuihlwxnicJbZW6c5fcj
         fd9YzOVdXwIeaCrEpWen6rIIvxjhnq6IuOZ0rRs48eIh0njXomTHLNmdHpBQJai/MeDa
         A6XcHt4/AEWZ3ZdRsWl7Sw3ftgELfPNpmSjII3y3OnIgBe0LL47ftHyXAmwbd6CNI8De
         6MDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783558234; x=1784163034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kkofK5lB9wXpWMbMSe+NkS3murI5ZbIBP3R8HNBHkiI=;
        b=WNX8dpz31/6eyvEaBh2OEw+W+65eF68vYRA6Ol8xInXKOejKBxHlwkm7hYGpphGL3F
         gnnqI/lKEhqVtyJCL/uzazJOnfydsFPjPhgwaiN7M7F8RgVTOeeDtjWexaPo89khadHG
         r1Xn4B7XBoFDbHsA+CIsBQkhE29Wf2lYgCSfHaNtCEUkPQtbhh6UzwMuQhvJ6C2PXOxH
         NhKXPBq8CPYLG4FD4HgoUrC+RerXKz0UDyVDW/2ED59+EJ0dHPdRWuaMKxPvITY2vzPe
         zu8kerJs4uAO6g+ZaiS2m5rrIJkCWI8lWxqk2tTMqm8qmc2mkvXUODGJBgh5QOQI1b5n
         CxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783558234; x=1784163034;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kkofK5lB9wXpWMbMSe+NkS3murI5ZbIBP3R8HNBHkiI=;
        b=FhnDf7H9w0vLVDYsYutoEbA2ATQOqb4D/YnxhX0WS7r0T0pjcoNyfx0WFUe907ohj3
         MphoKaPIOzNk0PG1l6zHOB+0kAnP3HMnjKLahvF1uDnkH+N6Chjf33eoHOaIY8ztkTeM
         2NLNfjI1j66cLpROW4X4SJzWo2QztLVsOXrUwfRXhRiW825zo4ow6h3IkdRXS3M9GCX0
         TsjJ0gZRIPwxLrSqk1FeJ8DtqAE8dAaRn1EjspYKA5okJlXYCdPPqoMtVkZ3RG9t3Am8
         Poof0s/NyKCvIGnI0yO379PaLWHbHdTA0mn7od+g6CvoSWpq9WDbOV6tSUGjI++l3iWK
         O5eQ==
X-Gm-Message-State: AOJu0YwQyeEujdDJNd0RKmKOCjSmW/ctpd6XYniNCqC/9MPt5nLpeJE/
	y8Al4iI4yZDF6gjciPkArb3bMsxXTJm8LwTQGkbT8zqjOjJBiKos33IgQHKasLKAzWzur7siUi9
	BnC8nGrTSIU/enfzT9n2kkKkZOvAYRyE=
X-Gm-Gg: AfdE7cnDUycfn44GeHgeiRV2SjdWNDaM2cGD9DCWNvAJ8DP0FijRU85/u8sqSTGRwZa
	XAerW6eqCitrflYzRbIi8W50iSpm7zcDYX8H4u9M+rRYWfLp10PAK0Z+Q73NQKC2t0mX84AfGfK
	UIXYHYLxGS4GX8X8PnrMtf+6WNXQL+VdwviSxIy7HinFc4YR6GsyJIi9ZZcZWkTluZHCdAxgXed
	uNm9GS0D6bXoARHx58k04RHVYs0pQhBjyvRjzUGkVX62I1GuwMn5BaO9g/lES+j/tZX+s/9Lez6
	WC8pRCGb+bMXiMTICYHluVMy
X-Received: by 2002:a05:6214:4345:b0:8f2:5a3e:c619 with SMTP id
 6a1803df08f44-8fec02ed4ecmr60837156d6.4.1783558234570; Wed, 08 Jul 2026
 17:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <akyeX0hlcrnOC0nT@shinmob>
In-Reply-To: <akyeX0hlcrnOC0nT@shinmob>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Thu, 9 Jul 2026 09:50:23 +0900
X-Gm-Features: AUfX_mzTNYWtmH0qEDhoC1KIIBB_O8XrDJqsM-x2iVUSDXAQ5FDjsdUIP6BDd44
Message-ID: <CAC5umyg17Y5BcC6r46yzWyEVYUsaW5pprPB2WYFGPz-uHAU-wQ@mail.gmail.com>
Subject: Re: blktests: call for agreement to relicense GPL-2.0 files
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>, 
	Ming Lei <ming.lei@redhat.com>, Ming Lei <tom.leiming@gmail.com>, 
	Keith Busch <kbusch@kernel.org>, Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	Li Zhijian <lizhijian@fujitsu.com>, John Pittman <jpittman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B47=E6=9C=887=E6=97=A5(=E7=81=AB) 15:39 Shin'ichiro Kawasaki <sh=
inichiro.kawasaki@wdc.com>:
> 2) block/030
>     Author: Bart Van Assche <bvanassche@acm.org>
>     Contributors: Christoph Hellwig <hch@lst.de>
>                   Li Zhijian <lizhijian@fujitsu.com>
>                   Akinobu Mita <akinobu.mita@gmail.com>

I agree to the license change.
Thank you for your work.
