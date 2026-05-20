Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CE734A3C4
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306856; cv=pass; b=gmvhfiAJpukVTYDWrD8+OEX52z36nPwM32V+kaepGpe8+f07K7+NvwWvq5C5+2Up1uYl3CqUsX3J2HHD+sABT9CCNU3G06k/bC2125Xcomdh/fHeaEXSSxipCAAh3saee2+W1fYcZhC4CJTa4Cxq8Qpzu1jj9Qmu6hkSEYct/OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306856; c=relaxed/simple;
	bh=Idq3g52uIiBvH2yixrvLS7jLQ3Jl6Es6K5syhNvywDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHSJBUJbyFykN9OEAnRBmyI9OPDzxJrH11Q3iqRMPWCC6Jlu1+4BjsPEadbkkfwtJL0croy/eImOAEz+QBVRrJyqdHQajVqtROr5/xT0bRKCdBf9Lgcp8dIR2TsVIym2nBeMsa2GGdNFY5UhmXUa041gArlytY/9dLMBGbz2swg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gc4kFj0V; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc4kFj0V"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bda62f13d90so285896066b.2
        for <linux-block@vger.kernel.org>; Wed, 20 May 2026 12:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779306854; cv=none;
        d=google.com; s=arc-20240605;
        b=doMq48fGP0VaY4HQzo6yeUijDQkYB7KA1vv5lw798sSqJzaPk6iD5+2KrXjlufBuoY
         dEICCDN+yEyDtNT7rN8y6KhGRdzOMcSLNlEQNQ2m0aOZY6ZSPcmJcr7nWTK6maTQwNtE
         74nnC0I9EEY2mF+Kx7MYL/DoFbDtIUXolUtfsXHrvWxngFK3vHrWOBFHrBMUq+C+zEgN
         E0JsCY+ygpofRf+NLRlBhHz5iqYihSMy2acS8pavAajQOFoaIKV4eYuBV+zsSBjhaG+6
         8vnUzPO8/QbooZ1Aoi4ATLi5km6EHh2QbAgJ3acnhPrlRZBHoJO5yBsoTyqeFsijdi9U
         DDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Idq3g52uIiBvH2yixrvLS7jLQ3Jl6Es6K5syhNvywDE=;
        fh=MDVQpaLermnHI1YmHcrML2XOYd1VY3VFDh+XOoB9SIE=;
        b=acImPxPLHbs5PunpY1CbfEaBh9GW796FBfvjRHorcge6RHt0grcG+MY3wweEz057j0
         lps9+JzDcknUdbz23FP2EclL8dB0ibucAqAOEDpbodH3fV9+BzpcmAmJbgJZPZv6VYXI
         j71TDn/1px8MJQwdRH7MBCD79BSHHhEg9zNHtrwVA/zJ4hydaaQIbUUnNXtf4l2HDioa
         8dApGSRV2NL6wKZE1HsdEk+4QFtDJ3WGFKYcLhfBHBdVfO/UUMGx73eeuYL4qVDqa1QO
         oe7Zny1BK9exDhD8d4u/ONLtNO5KJksSl9kfQNRdRNU0BsW0U3HiPCjH4YnEufcc06Bs
         fGrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779306854; x=1779911654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Idq3g52uIiBvH2yixrvLS7jLQ3Jl6Es6K5syhNvywDE=;
        b=Gc4kFj0VbYTQLq/WZFpFpM8NFMsYWzHmdgWYczp14ai4ubMD236KxFORnB6B/xMn/v
         9L7Hn81nMwN+Y43RRds3Cm3oXHub6jp9mzP7GYnOW/NRS3uLy2eaUKBZfz602/TLj2jd
         hoGo8A5D+Ks8/2KrjyqLRu48g/Cx5E8zs8Lropka9XWQFX4i1bW+NE06x412lORDZJ9c
         czNp0kDxGgQ1PSxXH/xoLKdILbHqCMWV07bgBWoBo07w1Hgwl6Ke9GerZBVtqteyF+MZ
         noYh1TC35yaDInWPHWYI50aEJ07ndUqvYgCYQnPRL4UgM83ylYVyvJYRRDm7ct9yQNrZ
         XgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779306854; x=1779911654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Idq3g52uIiBvH2yixrvLS7jLQ3Jl6Es6K5syhNvywDE=;
        b=qzfKcc/ImcsIPNrF/SSQEBS/YSyhdioHW5mhH6BpJa1niEOGc+9A+ZMGqIaOOSue/L
         SUyIEh4DmMLWlaDrij3OEQAENG6XLT9ErgW0X2dgb0tCSXjhv2XqLdgQ7CO6GlpuVPtk
         a3B7F4bzK33LRlRyEPf7Q7Nb8jUMcoujh25ji05OE1LKikpXnJegOJxkfJHKykg+d7Kw
         JD7R0rfyZtLcrD8tYbunQweJ70WfZHNFUXiFVvuCfGjLe8/yEW6M03ouA/+xHqhCIbrw
         J4ebBpzNrNz3KVO60+B9C+xXVR2EJds4DM/Lu3wdKQ1V9ex4bq43DfGnNQ9CQtHXFiY3
         EyBA==
X-Forwarded-Encrypted: i=1; AFNElJ+YwoQGj4GZNarSk47tJSpVOWONhXfTF4aGtzUUj9wV29tZA/s4jgzk5oofUpKfNIMe3LR0cYR5d+I0xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YykugdkEx+nnzQFSZOlZhLK3AvUAghWgd3lq4VwKOhpXm8mcJka
	TWtfycsyeHaUxHY7d713QYFoxhjdEsndk3Dms091vWgv1TxG0W2i6a9t/TwJSEm+/LrOCnMcHi+
	6OIJdipeHNpN9euFHosZ1VygSLFXa+C0=
X-Gm-Gg: Acq92OF+XFGDGdJXwE2vyeoZD8V6bDb/HrWHh8pDVC9dP8d6HzpE3A3BgAgVn7Q2osL
	r12gskQ1CI/uahvrDWF5JKAZPOfwjXt0JE2QbzptjedTO28mAF7d7NFsqmkxL0W+kSZ0WCQVG9k
	w7Vw+R4o1p8bZdBfJmxVv+75STgwkn/5yfVxSe7mLzpI3bTmqedPv4z61EG/B60RNsAzLYD1f1P
	3QvjZYAqSowor94GOLg+SeE+pHHZBnEfOryxuYtH0JqyGWByJabQbY5gLE/laxEcHG/tK28/viv
	nz7gZy8=
X-Received: by 2002:a17:907:3ea5:b0:bd4:c64c:5a9a with SMTP id
 a640c23a62f3a-bd517aa757bmr1498301266b.36.1779306853243; Wed, 20 May 2026
 12:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519172326.3462354-1-kbusch@meta.com> <20260519172326.3462354-2-kbusch@meta.com>
 <20260520072250.GA14937@lst.de>
In-Reply-To: <20260520072250.GA14937@lst.de>
From: Chao S <coshi036@gmail.com>
Date: Wed, 20 May 2026 15:54:02 -0400
X-Gm-Features: AVHnY4LUfvb8kQcg0Gdncx9V5QaE6U9ARHtMSYBUfU3zjF8mOxyspQdwZP7NJH8
Message-ID: <CACd_6n0Mhn9tLj4H7EojOfaF5uKj0Zu6iZDDxf+tJPUgEABBng@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] blk-mq: fix status for unaligned bio
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, axboe@kernel.dk, tom.leiming@gmail.com, 
	Igor.Achkinazi@dell.com, dlemoal@kernel.org, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good to me.
I also appreciate your consideration of my report.
Need a little more time to go through other patches.

Reviewed-by: Chao Shi <coshi036@gmail.com>

On Wed, May 20, 2026 at 3:22=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
