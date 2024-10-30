Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51061E2600
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281832; cv=none; b=EWGRSeVGqhaawAcd4araArRg9PjTniawq4TljaN+TWbt8cIV851GmvJQQgWvpJ0ylCOKMxDqtq279WBf7dj7vGwez207K/5fwGYlZYgtvLE5/kf5nr8rhDJiW24/abJ7rtsn7qgL0zFTzFoPrJFjJlddAIIlvq+2nMGOwHKJwQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281832; c=relaxed/simple;
	bh=yw+qgrswFYZZEPGEhoCezC7p6EMLBW9w0hRwCKfLPyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7m1PSwjkrIsBjWAoW4IO2bQ0U4kLfb4m6wwVXQrUtu759KrDWfc0SVtZ3Qhqp62fIswLvDgw7QSrt72/3d4uFpML81hdutEKQJaoP72k3BnSp33s/cvER3GvMORRNUCmH6QlR3ZHn/eLvE+IYmy42znHyk/D1OY647j2OQf3RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O92fBRwJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O92fBRwJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730281829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yw+qgrswFYZZEPGEhoCezC7p6EMLBW9w0hRwCKfLPyY=;
	b=O92fBRwJRzT7q4+Locw0UBuKbhYJuG1v/V6d9l/Q3c7uhhmdM8ce5LKAlhqLYM05z8+o6/
	Bamlm/8QgNwKdH5qeUFJ2UtSGkX9oaINcdlI1iqlcbjxhV6tbNQj8AtH8knpZxBi4uBzOd
	h48WlhjQffH/M1ymUk6WcGft4x6ImnI=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-vStNLY8BPYmzq8HmIeROVg-1; Wed, 30 Oct 2024 05:50:27 -0400
X-MC-Unique: vStNLY8BPYmzq8HmIeROVg-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4a481940bb0so2039157137.0
        for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 02:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730281827; x=1730886627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yw+qgrswFYZZEPGEhoCezC7p6EMLBW9w0hRwCKfLPyY=;
        b=Jqdj5yq5htfEz/Ak/+4cNrWaNdAhlplVJLamZSc5y6CM9XDVqZ7XbVQhMYMKcxiOig
         Bt87IXD0Si8e91pXb/hR1cCCZ9p26O0e7m1E3/i2tQEb9ulpxPlfx+wBo6tqlGv3G7Tb
         HHfRfGdC2s27D5Phaz0Doldso33MSrtJztHEUasReUNr4rT15NxuMtFk1JToK4EEPK+n
         +w/ZZHcUW5pLxDG0z3TBIcxxn8/lHa8y2wbq0X3DZ/D1vhaBLxfhOpFWy/6vCxtqf1I8
         84OclXKA0pBttz0H0WKg2TbDX/3NkDLN7WE1W8WVroL4woWHYPQcAJyirJJ3cvVgOLnJ
         JOjA==
X-Forwarded-Encrypted: i=1; AJvYcCV7sgTXcaxofb5qOQ98Y3F3CezgEiAgbjTfWjegXVwcyHA4AN7b5dtNPhhcfRe3Nu5dt7z1uDiB+Iw/0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ5mw3R34DXkOWb45k3tWknHPJARdzrt+P3wXTIKCerYjAuaHj
	u24jK/rqfbIgLMJQsOO18JIa0rRz3mJdjiv8lJQfeXASagTIHPYUCk6+JAs/KXgNt3QlZBmNfy2
	uBrPw2lFKEiQMqvXuwguN+Q+gfBpolDf9rrzoRd6bd0naQ1yxBxKE8DeZ1MBYKsBS+9SxEeyu+4
	vguajeyhpgIQB2JBYiFhqKsB5+wgLVqUbIPAc=
X-Received: by 2002:a05:6102:b12:b0:4a5:b7fc:7a40 with SMTP id ada2fe7eead31-4a8cfd4de6emr12961423137.19.1730281826763;
        Wed, 30 Oct 2024 02:50:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeJJ1xQxqX4HN4aM/wTAl2EKCwNKfmwOih4Ww8Rq4eXGBxq6k2he5HPduCvc1UrN8NKknkLV3oaMtdiixtCHE=
X-Received: by 2002:a05:6102:b12:b0:4a5:b7fc:7a40 with SMTP id
 ada2fe7eead31-4a8cfd4de6emr12961404137.19.1730281826407; Wed, 30 Oct 2024
 02:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025003722.3630252-1-ming.lei@redhat.com> <20241025003722.3630252-4-ming.lei@redhat.com>
 <ZyHV7xTccCwN8j7b@ly-workstation> <ZyHchfaUe2cEzFMm@fedora> <ZyHzb8ExdDG4b8lo@ly-workstation>
In-Reply-To: <ZyHzb8ExdDG4b8lo@ly-workstation>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 30 Oct 2024 17:50:15 +0800
Message-ID: <CAFj5m9+bL23T7mMwR7g_8umTzkNJa14n8AhR3_g6QjB2YCcc5A@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] block: model freeze & enter queue as lock for
 supporting lockdep
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>, yi1.lai@intel.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:51=E2=80=AFPM Lai, Yi <yi1.lai@linux.intel.com> w=
rote:
>
> On Wed, Oct 30, 2024 at 03:13:09PM +0800, Ming Lei wrote:
> > On Wed, Oct 30, 2024 at 02:45:03PM +0800, Lai, Yi wrote:
...
> >
> > It should be addressed by the following patch:
> >
> > https://lore.kernel.org/linux-block/ZyEGLdg744U_xBjp@fedora/
> >
>
> I have applied proposed fix patch on top of next-20241029. Issue can
> still be reproduced.
>
> It seems the dependency chain is different from Marek's log and mine.

Can you post the new log since q->q_usage_counter(io)->fs_reclaim from
blk_mq_init_sched is cut down by the patch?

Thanks,
Ming

