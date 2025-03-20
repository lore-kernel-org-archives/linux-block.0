Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98DA1DF985
	for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481436; cv=none; b=bCIRFwxSnx7fOY/Y27LSARfgaGs3/vGZ9psEcwrb79URqZ2WBQSf/fH1lAdKzCP1AyBUgwmFh6pxTCI+uv5UuYXNHhMamigEhQCKbmOMrjPDiUCkQuTWqQuJUf0UM9a9DFELE4x2LOFgTORsWL6MvwwLqQwSbftEVfZp8hgQPog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481436; c=relaxed/simple;
	bh=dKWHt6FujybyOyL5cedYtqrafz17Hc5CfWsQ5YrnuQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWzXIoLTbgLarKeHeFskCcq/j5YoN+jFD707Hik/Sr1IuoFbCAP48Yx1YVBFigCHiBPcI6e8r1HLtJo6jmWhxqpYyP8Q1AWCOILzDQZq/+7XZASjXf6yDJG/YW3h3hJU9fsVhAlW/hOvyORbNQnwgeIv7Zs8RCEU9AU2SyBPJck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVzqQcNF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVzqQcNF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742481433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OhfkO0nOeFh31dBWlpIBHPp/23oMIm4/ZzrV7nDHXfs=;
	b=LVzqQcNF5lFnNgzkRLDogBItBVTSgR3acHVWsqaBBBvy0NPqsrbCc0UhJkDvq94vWcFaPZ
	4d7m7H9Zs+Fr5cVTV5lwjqqxpevX2jQMx+qkpz92rVgOVrsazJ7UzcWwHRe8gte/2Q7rnx
	FIhbRRmgrmKUZ5WLAv8WcKC5gIF+Ft4=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-zpZ2P0haMhCfjQkdfMlInQ-1; Thu, 20 Mar 2025 10:37:12 -0400
X-MC-Unique: zpZ2P0haMhCfjQkdfMlInQ-1
X-Mimecast-MFC-AGG-ID: zpZ2P0haMhCfjQkdfMlInQ_1742481432
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-523efd77006so299204e0c.1
        for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 07:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481432; x=1743086232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhfkO0nOeFh31dBWlpIBHPp/23oMIm4/ZzrV7nDHXfs=;
        b=kS24RdZoGOYE1GcJ05Nd3bHjVtExOC43tCFbQezNtBXIA7C6FOU87q0s1NpsBgy40/
         B68b4Dkpp6EiTSHLt5e3FLyrRsP/ggwvJEpHTe/mXUv8upz8CSL0QkxwzetDksAd8Cdc
         TTByp/MbNvfkguJ/XNBMKbqr1txG74qmDOBohzzJTyqjr2o1R7A3By/TLDSakdr+I2jZ
         oDzpa9QcSbhB44I8gLXmd6ple9SmY2cmhKA4SJ67DqdhBSjBr9YsdjcKYKEkr5wDJCK4
         X74zqsdfFnYzRiI61n91TRMKDFJJUSaZaNXjVtN2mIo+ouNEDX9QhgrXNDsElBv+PBgD
         SJPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSQPLfTskn4YtgcB5XQxQIDdgKR5hT49pXjefhrEmqEdU3Z5K0nL+9XUtYuKKcVc+jKMIiPr688xYZHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq7/rYNPIqY1sqO3votXSAnIGd+nsZGi1c21trzia+qXRyQMNA
	9TYrYcO1sIBPEYgbDLFM3mRtqK3vduKU1sXv9tmVkE9Y0oI6y9po7/gD8aHKjmeAnezPnDoVPaP
	QQGmQhrvzCIDJM8CxnoLzL2IL/xfw0kICWxoq1Fj8xM7JBFv4TsZo4N5bwvKVBu2NoqlcoLJhu5
	ioQbB7qWBldLzktrNXJTS9M7V6dOsbO00k/aU=
X-Gm-Gg: ASbGncuyZrQNYLZ95KERvMmerasjx/jdD4eFTwZEEB74uuMVO8FOZ/zuAiYVvxH5pME
	UVZTTGYqVgqBVn1tJJIX8p2QiooXU+9FCK4m2ebS13E/guFfSRMq4Pjk3k0W97yJhcN9iRAyv2w
	==
X-Received: by 2002:a05:6122:608b:b0:520:60c2:3fb with SMTP id 71dfb90a1353d-525960812c0mr3062141e0c.0.1742481431791;
        Thu, 20 Mar 2025 07:37:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZzOib+M1uSgBNdPU9As6RS1qawt2FeKNo41kWJkJdCE9L3Fh8fjGANZNClbTw9gJ8Xn1+es3nosLVtfd7E60=
X-Received: by 2002:a05:6122:608b:b0:520:60c2:3fb with SMTP id
 71dfb90a1353d-525960812c0mr3062090e0c.0.1742481431364; Thu, 20 Mar 2025
 07:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z8-ReyFRoTN4G7UU@dread.disaster.area> <Z9ATyhq6PzOh7onx@fedora>
 <Z9DymjGRW3mTPJTt@dread.disaster.area> <Z9FFTiuMC8WD6qMH@fedora>
 <7b8b8a24-f36b-d213-cca1-d8857b6aca02@redhat.com> <Z9j2RJBark15LQQ1@dread.disaster.area>
 <Z9knXQixQhs90j5F@infradead.org> <Z9k-JE8FmWKe0fm0@fedora>
 <Z9u-489C_PVu8Se1@infradead.org> <Z9vGxrPzJ6oswWrS@fedora> <Z9wko1GfrScgv4Ev@infradead.org>
In-Reply-To: <Z9wko1GfrScgv4Ev@infradead.org>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 20 Mar 2025 22:36:59 +0800
X-Gm-Features: AQ5f1Jr8FjeQhNt7BbY6PJzfG3RS9LN-fvPsePmLRNjHLbVpaQVZTtsZ8BaAdPI
Message-ID: <CAFj5m9J1BGiqG+P+7kidH4V0hR9f-BmUar=0ADDR9wpGbnWSZw@mail.gmail.com>
Subject: Re: [PATCH] the dm-loop target
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, Mikulas Patocka <mpatocka@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Heinz Mauelshagen <heinzm@redhat.com>, zkabelac@redhat.com, 
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 10:22=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Thu, Mar 20, 2025 at 03:41:58PM +0800, Ming Lei wrote:
> > > That does not match my observations in say nvmet.  But if you have
> > > numbers please share them.
> >
> > Please see the result I posted:
> >
> > https://lore.kernel.org/linux-block/Z9FFTiuMC8WD6qMH@fedora/
>
> That shows it improves numbers and not that it doens't.

Fine, then please look at the result in the following reply:

https://lore.kernel.org/linux-block/Z9I2lm31KOQ784nb@fedora/

Thanks,

