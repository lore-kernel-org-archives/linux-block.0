Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B2B198E84
	for <linux-block@vger.kernel.org>; Thu,  5 Sep 2024 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725541449; cv=none; b=RRvbXEMU5WTckv14aA7UboOqnUKauTGd8UxWEdFW0TekxEfJGMpAXNzIZEvYnysblwtbwUXtQz/NIOC0s8Mol/mg7vaESx7ijZBIRsWGikX4mnLsaq8fXLrZChhEomzABO+18UI1TkKrgDmMuWOJ3S8T+j076gcoSYwOzgE/OAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725541449; c=relaxed/simple;
	bh=qGpAZM5XpCkcODjFq2vl0Dk+mcSV913HY+tOzfnyCCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgXv+OCdT4KmWaexElK9M2mK8SosDpVdEgdPZGc/XvcOvIWS04kW2VQ8cgt0xV4U/ZoQbF1Wq+S8q6CUWFu/pqpyo8JODmXKg0ljlvOrgHcuzjQoYbR96yDCb5e8FMFNcj5FY7rdCLLDZhy6aDWzp6gW/gWY7sCKHjBnDvHVSVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T8Rjt9p+; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T8Rjt9p+"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53653ee23adso629181e87.3
        for <linux-block@vger.kernel.org>; Thu, 05 Sep 2024 06:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725541446; x=1726146246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ky0s5zG/xdQQDayQ/39OCSHzsYjaPzBB5sy+e9ElL/4=;
        b=T8Rjt9p+J7dSzXx6/ENycGd1hF3dIDKzg2CdwgiwheiVHSBqDVgDTAawKLjJ9Oju7O
         afDeZFkXNejacaKF+9rsPB3PenO0D6Mv+R3txmkQYwWU582jY5jiicaJf832B19KrcjB
         V9wGUMWo+NvL0Va3rC69ptdlpDmguUFZacQyedxTQAkXIytGn0SEDCNxtmK/O2G+tEsg
         +ZQsl+av2jnCtPQEn1CHh2yqRB7SIho3VKKpA3UQsumLX9pTbfTfFEhvq8MfxhC0anIa
         0U695X8jlswQYligHZls/KPr5DmIGnfrs+DIzNWUtMVqW99i1GS/Q5qxv2UrXk39r9TO
         aIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725541446; x=1726146246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ky0s5zG/xdQQDayQ/39OCSHzsYjaPzBB5sy+e9ElL/4=;
        b=SQQ71Z7U+IVYtHyT+A0+XuG4H4UY71sUR0uW6+wnqFu9ogMTzGTz9QtzUSpDkCyN+7
         XtndYkDPaBxoQs9FC2xDFWcFbiMVbVysOCZVfQbJaUG3X2PHzG436Oa7QV7P4GjYpHMb
         mqjiEWeRG/XrxDjjgdggjDD4maHkE7Y/MeREmMkj3jPm/kuozEF+4twFDEWzliyHaGkQ
         dA8CPIWYZPPmSsm953C/AcOnYa7KTUEZYdNDwOTatrqTn/jlOUa+r3gOQUaWbr48hmdd
         8g2dLTlvloy6Dj7iq7pGmmfN11X1mREb1llTuaYMjccr5EbwCbUN2ge1si4V94E91n3Q
         uBBA==
X-Forwarded-Encrypted: i=1; AJvYcCX/ivlcqytjrjv7bGBnI0qYzCYr/awljlwiVfat1XukkVueXV7ePg3pysh6kXSkegBgNwQ3ibB+h/M5mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw70A2hlhFZk4H8EexpL1TFf74XZp/4lLEjMDplCWXv+mbFajHm
	adAa2z4m+aIAYI57JQ30jUSxgFCKo+/HBFbGCCqh1QYC8X3j81n4x0pIF4p2DiPY7NT526uqFmX
	bfM3BdT6ALNhevHXR5nEboF4bVwFIelDybRVdXA==
X-Google-Smtp-Source: AGHT+IF1xRVrxiqcSfRbnA/wlyf5y0fwiuV30n/DQC1bJrYoxm8ZmC9aCfASdVjP9zzKKqsoEW5lCLmUQka1HXCWrVo=
X-Received: by 2002:a05:6512:3c9c:b0:52c:d6a1:5734 with SMTP id
 2adb3069b0e04-53546b24e1cmr15368266e87.14.1725541445224; Thu, 05 Sep 2024
 06:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6fe53222-876c-4deb-b4e1-453eb689a9f3@kernel.dk>
 <CAPDyKFoo1m5VXd529cGbAHY24w8hXpA6C9zYh-WU2m2RYXjyYw@mail.gmail.com>
 <d8d1758d-b653-41e3-9d98-d3e6619a85e9@kernel.dk> <CAPDyKFp4aPXF6xuuQf6EhGgndv_=91wsT33DgCDZzG6tyqG9ow@mail.gmail.com>
 <dea642a2-85f8-445b-ab84-a07d41acf2e2@kernel.dk>
In-Reply-To: <dea642a2-85f8-445b-ab84-a07d41acf2e2@kernel.dk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Sep 2024 15:03:53 +0200
Message-ID: <CACRpkdZnc_6T6tQtCDZvWh_QMFqm6OJm+7Dk5A5W8UC5hV95rA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: move the BFQ io scheduler to orphan state
To: Jens Axboe <axboe@kernel.dk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Paolo Valente <paolo.valente@unimore.it>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:07=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
> On 9/4/24 7:59 AM, Ulf Hansson wrote:

>>  Surely BFQ is being
> > used out there, so it would really be a pity if nobody takes good care
> > of it.
>
> Probably not a whole lot I think, at least on the prod side experiences
> with BFQ haven't been good.

Which production? For singlequeue devices it is pretty widespread.

It is used in Fedora, RedHat and SuSE as default scheduler for any
/dev/sdN, /dev/srN and /dev/mmcblkN (i.e. anything singlequeue).

Example from my main development machine with Fedora 40:
$ cat /sys/block/sda/queue/scheduler
none mq-deadline kyber [bfq]
Laptop with MMC card reader:
$ cat /sys/block/mmcblk0/queue/scheduler
none mq-deadline kyber [bfq]

Maybe we should propose these rules to the main udev repository
so that they also go into Debian and we get even wider use?

It is also used by default in all Chromebooks using eMMC as storage.
I think even all Android devices using eMMC is using it but that is
hard to check.

Yours,
Linus Walleij
