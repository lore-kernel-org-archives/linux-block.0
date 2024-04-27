Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01AD145325
	for <linux-block@vger.kernel.org>; Sat, 27 Apr 2024 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714254044; cv=none; b=GJsi2/9GfjKlYsWTzSfcz+D1of5ayzXmaTioqQpREHWPVOk4RH+t8uZ+y2jWUcuLA0wOcwKo7LTnI7b43cn6z/r7sqweobr1zxrl/uZTWXvaNMj/v09jr8mH3ehtGK59+eJcLqbMB1g1vj8+s5l8vbUtjwfpizeLl8v9xd1R9y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714254044; c=relaxed/simple;
	bh=IIGshDaph8veGUjCfHMCr5hhSRQX7mrwk6r+2BogNic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s29OF2DD7kr9iJUpuE37qFhPqDTwLDWsGJ+wj8qEl3eGzcft4q7GIe6aqjwPpOoB5IZGBqwM7pSUqcSUY9OJplInmVYqdlr5JyQpiTz/sLhDpI+nBtal9JeUrEw6AtmMTOD27JXDPKM+mR6aMfRcc1KL4hh8fvtSSkOdHHgikks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RIkdIDI+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RIkdIDI+"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34665dd7610so1385566f8f.3
        for <linux-block@vger.kernel.org>; Sat, 27 Apr 2024 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714254041; x=1714858841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mA6ESoMU41euVvMMgdzVMUo8Y0YkwHfh7I4CxBNPhNU=;
        b=RIkdIDI+2V8I0wlOlHmqLljoMUNIciP6A7khKduRcYnE9V4tnDUNvaZi/MKweP8W/B
         idkH6sVzdjp5kc3lCfMLhnyIq5VnxVtydmjeo2jcbtUird1FgWb8lak3l+VfLrOS0rcu
         3pK2tAQgSS0XYMLqZaXgk7xtqFlmNrdPRBqwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714254041; x=1714858841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mA6ESoMU41euVvMMgdzVMUo8Y0YkwHfh7I4CxBNPhNU=;
        b=XtNycQNkBwGN4QslhygHRrjArj8uaYXMbJ6Za213LjSNliFmikFnQjVfQeUh/rQflf
         eRbHqUvVev1Kho+WV8ub/rh+AqeR4+GpNFLcG0URoSv9V6BffD/pWU4qv0U1ljlgb8CY
         nMjhdBtICHgxgEuPIFXXbbUBqGVVfPfBMCyqe7A3It4jc2/QoXQHF4l39SadrAqsxFTu
         UblwBGdcAwvTvdUF5qBejJro9AYy1rozXhWXzEPCaRcAA2h1sljSdPw4n+je3XeSrLBU
         pX3VyFIpydzPp1EOFLKlJipc6mxzMURvn6yBFu442pztn0CSv6ZUaSu3YfDEqrg9Mxcl
         JNBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3RtaxAZqUI5iepDxoMyIrEGUQjM8vdrhyOScWJsK0bfM2KtaXf3ZJ+L8wwU3slV+3qySDM00nw8+HP5GEVUL+UpVgU9efnMblWsM=
X-Gm-Message-State: AOJu0YwC8AsHJVsUIqcZYHbyLQE3t/hsHepfrQkBQiFWPS0j1nvH8wsz
	FuYHS9fGh5pJo9dOmr0r9ulaDGcMLwUihe4BMRQTpIR985VrbgInR8LQ4euvQHE/3YgeEObs0hS
	HjZM=
X-Google-Smtp-Source: AGHT+IEWVZQe6XZUK1GIyckJtO0sNaaxJ3gs8srFaQbCeLQRoGC9cba5uDpofYgUjawcxd/86c9zkA==
X-Received: by 2002:a05:600c:358e:b0:41a:446b:10df with SMTP id p14-20020a05600c358e00b0041a446b10dfmr5573218wmq.12.1714254040717;
        Sat, 27 Apr 2024 14:40:40 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id k4-20020a50cb84000000b005705bb48307sm11392954edi.42.2024.04.27.14.40.39
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Apr 2024 14:40:39 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a58f1f36427so32125866b.3
        for <linux-block@vger.kernel.org>; Sat, 27 Apr 2024 14:40:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8nlm5YZxDnvYRQ/yQszEwuGG4WQ8nQYBuABxW7zGqGZFRJN3WnO2KydWBbxp0b2vmzKVzISJ+mcCf+WFujPcRO0B+NxCAcakC9kQ=
X-Received: by 2002:a17:906:22ce:b0:a55:b99d:74a7 with SMTP id
 q14-20020a17090622ce00b00a55b99d74a7mr3773528eja.11.1714254039321; Sat, 27
 Apr 2024 14:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427210920.GR2118490@ZenIV> <20240427211128.GD1495312@ZenIV>
In-Reply-To: <20240427211128.GD1495312@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 Apr 2024 14:40:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiag-Dn=7v0tX2UazhMTBzG7P42FkgLSsVc=rfN8_NC2A@mail.gmail.com>
Message-ID: <CAHk-=wiag-Dn=7v0tX2UazhMTBzG7P42FkgLSsVc=rfN8_NC2A@mail.gmail.com>
Subject: Re: [PATCH 4/7] swapon(2): open swap with O_EXCL
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	linux-btrfs@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Apr 2024 at 14:11, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> ... eliminating the need to reopen block devices so they could be
> exclusively held.

This looks like a good change, but it raises the question of why we
did it this odd way to begin with?

Is it just because O_EXCL without O_CREAT is kind of odd, and only has
meaning for block devices?

Or is it just that before we used fiel pointers for block devices, the
old model made more sense?

Anyway, I like it, it just makes me go "why didn't we do it that way
originally?"

                Linus
