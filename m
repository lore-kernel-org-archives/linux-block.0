Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA7AAD2C
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 04:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762143176; cv=none; b=SYBeZ0O5No5/rTVTNgFEsmIqyX0q2to+WrhG8W9PHmv6HGVddqb8FMWCdedvGo8FgKmjWJ0taN0L3M4RbTCYsNMkKYBB4IHHQHtAuwcLK8r5XhTTBuJJk4S7BHc0JhtkJ9Lcvc3cwRvjnrfyPwSbT5jdcDxvkBOGgRQCiFIpA8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762143176; c=relaxed/simple;
	bh=KN+TO5EXEG6rXknFXdUGFg3Ct0/f03Jh7oOqpXz1gqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHunK68ztBRV6jC/Zxtdb90oeC3MEIZKpM5j6qsO8NNseFp5b8ED3T0YqDOqymFDyaTwD4irzZV3HgsJdlBNnDbYQ+3O36/7pWOKCHf2HV9oLaiv+6xZHX3pPoQeS6EjXq+V4cD+7Y7w0ONPIwUjq6bktihgQba3mt4PsGik0uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JS2jkXwv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2RDpdia; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JS2jkXwv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2RDpdia"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762143174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KN+TO5EXEG6rXknFXdUGFg3Ct0/f03Jh7oOqpXz1gqU=;
	b=JS2jkXwvJ3z6/SJUD1/N7n1HqNNQtVTp/sbh7KQxayNyYhjfWMsRBP49dF+qetFUTMXCt4
	K4XWhC3McmdZ2mGJaKjmHEdjLdpcIio5W2W4n0GF6hz/Wr35S/aKUykNGarFo/B0IlsDvr
	AHRztMhHBqzwuy1kVtxx62LgMFHtIyE=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-45z5He5pM8uB4mp2YK9lQw-1; Sun, 02 Nov 2025 23:12:53 -0500
X-MC-Unique: 45z5He5pM8uB4mp2YK9lQw-1
X-Mimecast-MFC-AGG-ID: 45z5He5pM8uB4mp2YK9lQw_1762143172
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-935138fdb74so5154989241.3
        for <linux-block@vger.kernel.org>; Sun, 02 Nov 2025 20:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762143172; x=1762747972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KN+TO5EXEG6rXknFXdUGFg3Ct0/f03Jh7oOqpXz1gqU=;
        b=F2RDpdiak5iN4njG9RROSMPuLbS6vEE8O2W2hDJOXhO7qrG8OyKp/HxrHeeS9tccPv
         /MU7zLUsd+3h9fGevpumDUIibOiRiQ17p5MfQDsFvf3oib4QzbMXTjrlhmecF6PVKkOS
         Zax3p//P2yOUA5CgbkCcbTHujzpNEAhot70cU44z6WNPTB6JRE+Rj+oyrmK/5K29wlkw
         pV+HgtEvZjnDekWW/nyA0WjrANQmqqUNoALytXq8x6cVmqajEXaNiYWIdtaKK0klFpEG
         TmJlCrZJb9htPXZ27I1Q60WnilLOfEfB7Vd9Y9nFAnV2aGZzloBrCzhlCXnTCooUnhff
         veHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762143172; x=1762747972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KN+TO5EXEG6rXknFXdUGFg3Ct0/f03Jh7oOqpXz1gqU=;
        b=hgXeCOG2Sx26bHIEsmvS8dDUzfOJhi7Ld7s+wg7rDIO9GTnutegO+qwnM/B8I6Swa5
         9BmSpynbzUFXtBg9rEQNry6V0BD2UJEmMKPpAf9fIwf6zAPghpltxXmobd6294zyF+Lo
         fkB+raAeV2YVCBmmA+40aqIY0fcjYuT8d+LKIlF60cItaYVpzFaJxfLcz9JXTv6vo0Dh
         DeF03wQwYWAXB2uQCr35SLa5aJi0jJaRlo6u8dcs6chMHxt7gV6rAH3q0jYkwkhXIyC8
         iSAXa+mdPD3WHlw85+GoJHU49IuY5kciJpwEUc+t6L5Cb3A+1ms3/K/hIgQ+XIR9mWKl
         4Buw==
X-Forwarded-Encrypted: i=1; AJvYcCW1lCB07DfPgMKzIDnuuB64WvOBe3sh5bY04KvLvj/swyws2wsQ5hpuPVKEJekKl8igqcjTEsJiIC8j4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4vfICPLmGQwF281i74DPrfhiXT4qMCJPun2UgzablTvf3BiQV
	sczX4azcXmLIqNJecO9uoElv7EDevArOK02yj698y10E9LJrX+/ysi7xTqxaQbt4bHrJ4zY5d8k
	Aq2K4ceKXYUJ9hxswgBsgkDQnPO/PHOs5uuQHUCVBW3enx+zDrgWfhkfXf3kWhGE7pmdz5lByk8
	G1T3BeZchlpyNov/rY1uhaURXoTnaQRb9qj2ntOwg=
X-Gm-Gg: ASbGncu5w7hHy76oHJ3cPSRj9xGN4aUW3GdMU8mRy1gs5p/rvWSVpnOtGJzjGtAMkow
	0lxp6eh6ASlB7GTsfBjGm6QDItqZXgT9wwaVmW4usBe6cpG5PoamXuW+/H6uLbB76A7UrxofHwO
	0YVaGXFak08mV6xtUwmZzkXGxIP1b7GTr+L2g4SN1kbUMx+6J/AvybMlV/
X-Received: by 2002:a05:6102:c8a:b0:5db:ceaa:1dbe with SMTP id ada2fe7eead31-5dbceaa21e1mr1492747137.29.1762143172502;
        Sun, 02 Nov 2025 20:12:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwDkt+ubg64eT5kGK1eDIVI/O9sWszvBtfRlJSK167ZaNYK6Kshtfh+QKTZn7iqj5TgGrCmpoV04GNq8YCLfQ=
X-Received: by 2002:a05:6102:c8a:b0:5db:ceaa:1dbe with SMTP id
 ada2fe7eead31-5dbceaa21e1mr1492742137.29.1762143172194; Sun, 02 Nov 2025
 20:12:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030172417.660949-1-bvanassche@acm.org> <befb4493-44fe-41e7-b5ec-fb2744fd752c@linux.ibm.com>
In-Reply-To: <befb4493-44fe-41e7-b5ec-fb2744fd752c@linux.ibm.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 3 Nov 2025 12:12:40 +0800
X-Gm-Features: AWmQ_bl0Zz4CsOHgn8YBsWzj1ge39bPHWAEOup3xt7h3Y5s2M8CAljrLL0JnfE0
Message-ID: <CAFj5m9+-13UHPTKToWyskQ5XGiEFEEBFjgQzkkuDa=VBKvF7zQ@mail.gmail.com>
Subject: Re: [PATCH v3] block: Remove queue freezing from several sysfs store callbacks
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Martin Wilck <mwilck@suse.com>, Benjamin Marzinski <bmarzins@redhat.com>, 
	stable@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 8:40=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
>
>
> On 10/30/25 10:54 PM, Bart Van Assche wrote:
> > Fix this by removing the blk_mq_freeze_queue() / blk_mq_unfreeze_queue(=
)
> > calls from the store callbacks that do not strictly need these callback=
s.
> > This patch may cause a small delay in applying the new settings.
> >
> > This patch affects the following sysfs attributes:
> > * io_poll_delay
> > * io_timeout
> > * nomerges
> > * read_ahead_kb
> > * rq_affinity
>
> I see that io_timeout, nomerges and rq_affinity are all accessed
> during I/O hotpath. So IMO for these attributes we still need to
> freeze the queue before updating those parameters. The io_timeout
> and nomerges are accessed during I/O submission and rq_affinity
> is accessed during I/O completion.

Does freeze make any difference? Intermediate value isn't possible, and
either the old or new value should be just fine to take.

Thanks,

