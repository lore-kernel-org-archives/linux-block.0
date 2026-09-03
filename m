Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335242F6F6
	for <linux-block@vger.kernel.org>; Thu,  3 Sep 2026 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425393; cv=pass; b=ltSNzfcc6403Xu29yA41PTYgQC97Pif3a+vrtCkUPY6PQT6wPBGsXo+5ULjISJ53fC7h6C9kC0VWicbywIUu8bKZqL47TlPQ/K6yxqEPrz7q88p2PCtqDsiJKmOLynljlAbVbeDHi7h33yt8DO0umZKUsQhTqyEnh1whca8ckBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425393; c=relaxed/simple;
	bh=4NJgnCo+urE8+5KYbq4/pOyPzobTS71FJ1h76WNYwuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GejDY8TJkI7CmHNw/cfJSN2UlO1umcFxssiXYc4L85i5OP1NF1DH18ewZPkLQ9dvQmiuAbGXoQjAHb80mvsJlp6G7SttqhcsskY/AEVUsGd/63WRkxKuW9/q8EyT1SUZzcja3SMnno7RZwjer9lRmNXLvgCergSLS7iAGNqxTaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws0dnqWc; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws0dnqWc"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-910316a2fc9so13021576d6.2
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2026 01:49:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788425386; cv=none;
        d=google.com; s=arc-20260327;
        b=EUIhp08NyJ1zArLGRoYXjy9wlvO63VSPMqHZ2xT1eTqrmQvEpeQ9wyyuO8JEBIPSwz
         90TjKg+jzsRDvr2An1OUsuChCSTaIrfVz6ENGc4NNnaUh9T33vyfyGVoXrwU1vYj9zLJ
         VFmuEx95C6y1Rpbz9sHOKtJZ5Dxagv1BkorobKgbLjIy26B4LtJGF8PPj6g/EqRzzu48
         JNVN3m3jpw2MjngJc3PedBGZaA3NZZHPu4kdCXEM3WJqdHcVmmSoyllI8BB08fV/AHo/
         6QORYMaM5uLjWaq9FUoZnJY9qclG5H/MjqaY4QmoI+4XaSjwqitmKp9rLiNO9Trxo+Pv
         EecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4NJgnCo+urE8+5KYbq4/pOyPzobTS71FJ1h76WNYwuU=;
        fh=HPC/1UNpUusS9qMX64btgz5+TEXnXr/Lu57OaS3hnT8=;
        b=dAyYeqRrhZpCwIco44vPeIW3UH4Nd+Sd4RsEApj5OdIg2uG7kQsFlknzMtMOUzsnsX
         cIp9oVjRMzEWx/aNlqVYhLWcmmDRc48ZABU7NeUqV8kittHtcGgShYzSgZut2fcNpuL4
         VhuUBen060B9a0dhRpw29ciBAyWMngN4TtziV6zoRSjEbm/a2yqU1+Ner5Fmp24Ls25E
         PROn3flQrvL7FrDOsQK4hsL/qHEJTXALwhC9K2FGSLj/JKjXOpexrtsBihDKl6yWiD3b
         6Rg5iL4nXIsNK/23BJwAOho71qkELY1lO5MhMnm5pN30Y08RtKGb64fCPBWza/3yagVN
         Otxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788425386; x=1789030186; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4NJgnCo+urE8+5KYbq4/pOyPzobTS71FJ1h76WNYwuU=;
        b=Ws0dnqWcVJ+nHcOnXdEZoWGtUsJxmgh0WCvVF78gkGt12KfG2zEnExJTXY+MA975Cx
         WJhpXhkQOWxDQn6O77yA+H9u8ypbtm54S4A5+8jkkYu9Ql9lnBoZTIDmUTeSINGzQtuz
         XXTbMsk0OeI9IfmZdr4oI0rEU+H4NgOdQTQwAwYffwcfp6aPOAikcCKE0SQsgFEuSNR/
         WpgYz1toSo4QvZjHYPjQq0sfaIWq+vwmh2zu9NSVfsPOVv9Pm+yoSunwxLGvZgbnPeh1
         IUE2fzxhFlbWwJjY6PU26v83qXyMFnbDFFhfxlkpjbPMH31WUNUIT49moqoz6/jCamak
         NcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788425386; x=1789030186;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4NJgnCo+urE8+5KYbq4/pOyPzobTS71FJ1h76WNYwuU=;
        b=J3XFTw0Ew7K4NVXn1cihyxMsGDuTPRiUcpKDMYEDdOnjGunk7gwv2ivPQ+MZ1Wm+2l
         kyjp4VXszmE5pU9dCk7ONxDCElC1dq8wEDcln26D+aBaPbratYOj0HKsU3zFI45+JGoS
         zMhDwhsMWPlINYugH6Mg2xUwOXme3jU8pu+UCiM0t8m1uxnzVXx/70fvPQPdUkLxed6R
         xldV5kmKrI6orzeb8U69ywmbqhbSFHqTaX0myfri0Bo9cHqCXvDhiUwrwpjbSZ0wtcCF
         7ZhuCKkpnJQBfKHJFr7wEAAi93GV5hGJMZ6rd6mHSHBHIlLdTYKjnwucIsIaVeN8lem7
         8s+w==
X-Gm-Message-State: AFuF++lCB08fS1W87zeUGw06KYUXRQr7y6LjNsyXakkiXUdfRFLW4xnF
	el6RIRRXR0OYP6FvTSjmt61WDH99xT/AO1Rr6LIIXGZABGjnpajnK7zragMBhM7iRMY9P2Z1FfF
	5HhG4phfGUEpaZHiFRdr3VH3ORikn+4vMEFYd
X-Gm-Gg: AYBFou0NWN29/as2+mJbEFVnOkdnUJUqQndyol5k2qdir/wRkrnebV1fEw6N6/SNR/4
	6W6JBJ3WZPNpEuZfhGqPWdL4QjQGpYCl+oN8io5UJ/knKk4tQm/6xPohYr7WjbVBo7oAPc458FH
	Tvty165E9pOGDidAC3qMi3T8iQh0LqD7yPfIMsYK1iXs3TKGW0ct0rU+894vZ0/yGrN9k4hCav4
	DPe2oYthhxHmp5jnSvL8KoBLv9CRr5Zii3vF+rga2bo+9hgcGbxyEulsI8RpjeV9Kz6X5O/yBV6
	UfWRkSCSp+5s0AWnAox/EivBUElx3tf0RqNTgvaGxnVDHhKT81H8Wf2Hr9XJppqz+bIg4qtE
X-Received: by 2002:a0c:e650:0:b0:910:3451:b180 with SMTP id
 6a1803df08f44-9103451b5a4mr50935556d6.33.1788425386135; Thu, 03 Sep 2026
 01:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821105335.794406-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20260821105335.794406-1-shinichiro.kawasaki@wdc.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Thu, 3 Sep 2026 17:49:34 +0900
X-Gm-Features: AcwNN1VmwIKOXaFSDbMYVou9EqCKgnVvNET9224cD2gCE_BUa1mMLIojH2ifqQc
Message-ID: <CAC5umyji1aiitHgy-7Totx0pCsUftf_WvRPqyFCX1nMCtNys2A@mail.gmail.com>
Subject: Re: [PATCH blktests] block/{029,030,031}: relicense from GPL-2.0 to GPL-3.0+
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>, 
	Christoph Hellwig <hch@lst.de>, Li Zhijian <lizhijian@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B48=E6=9C=8821=E6=97=A5(=E9=87=91) 19:53 Shin'ichiro Kawasaki <s=
hinichiro.kawasaki@wdc.com>:
>
> Most blktests code, including check and common/rc, is licensed under
> GPL-3.0+. However, tests/block/029, 030 and 031 are licensed under
> GPL-2.0 only. These test scripts source GPL-3.0+ shell code, but
> GPL-2.0-only code is incompatible with GPL-3.0 code [1].
>
> Relicense these test scripts under GPL-3.0 or later to resolve this
> incompatibility.

Acked-by: Akinobu Mita <akinobu.mita@gmail.com>
