Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52AD3BB4D;
	Wed, 15 May 2024 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715777327; cv=none; b=Hyj7jLkdmckdfeq4yZqzWiDdHUE9O6TZ977VcjpfoPXXkikE1f0CMvU12nfqExYqj03dILkcklZo/PyFkMeJ/ICBPZ98y/2QydX6tkr3DM/VfGysY8lNHtVEBSzkrjgQaRR2qodFFzHXAMIvbmb0H7kqq/tj1RS+A3ICaUtfGGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715777327; c=relaxed/simple;
	bh=nprHZDVkoDXa4zAfHxBxTmKTZ9CZ5jcVwcp317JYYaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFiF4JSbSy6Mc9qZHZWllzFNyzPu9KwYWqxEwNPIqfS2c4N6SEsrtXDEj+acyO90eXVvpcxuQgkPlBojyES/HOQaZIOnvsSOz/1ljp3B25YKPD1045nWlcHvAVS7CQdma581EbjGVrQq7vgIATjLfAYPHwrOkxtk/Bih2k2NKr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5a7d28555bso197009766b.1;
        Wed, 15 May 2024 05:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715777324; x=1716382124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy59NphfPqntinjd5ZYesz8gWQ4Cizffpl3PRbnsf+I=;
        b=j9Y3Det3WPw8x8Pn1HFr9920DuM1WTKEmTUhrBSdOS9CF6wiipOXyhcxs41Tss25LK
         vzECFy+SKLBkmCjvszZIIZ4lJklpNgVEHQtYL6ivxZrvYuVLCACdfbo2FYEWMK+8aMre
         rN8qtDZ5BUI4MSo5GiYDxS3oZtLeAugc6NeNOwMuR+3lZSiws/22qQsQ1x0MGFAF08u7
         vnFNnbYgfh2QIrfWinNMsBFNR4uRtDcfcK/xrGuhGEfUmArsP3hyCrJA83lg3HqJWt2l
         AGh3qFLzJOrNOvtbas7YnPnesnDsrzdoxj8SsWQ8XbHLzSW4DIfcW1jcbwbq8556i3Uu
         SSJg==
X-Forwarded-Encrypted: i=1; AJvYcCVJMuQSkA7DFr/5SLZhujveMMdNsiL14dJ8ajGekR5B+VuheoBqHDXY32/DYg9XTWAAhQWQL769yfdGxPdYGk1irfISVlO+nnwl4ELj1zIIduVYJg1mhMgwYmhK9mc8aGBd+7DFKIn2g4I=
X-Gm-Message-State: AOJu0YxoY6EptuCL91FKZqVkGkeIbW0V8evPxneqCsOM4nojlwhKBHxM
	f3Um6FxikPhfvs4PQAv380JnMbv7lZzNjgQiBQyrbAzq45ljtGfa
X-Google-Smtp-Source: AGHT+IEEuMH7TAGn/ROBHLPstBku9tCh67+QAQEw8RRwdl92h1nQdLnKIoN7dEd9dUQ+UJNl9wedQQ==
X-Received: by 2002:a17:906:4150:b0:a59:8fae:f5c8 with SMTP id a640c23a62f3a-a5a2d54c160mr1052783666b.7.1715777324011;
        Wed, 15 May 2024 05:48:44 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01a2esm851686266b.185.2024.05.15.05.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 05:48:43 -0700 (PDT)
Date: Wed, 15 May 2024 05:48:41 -0700
From: Breno Leitao <leitao@debian.org>
To: Marco Elver <elver@google.com>, paulmck@kernel.org
Cc: paulmck@kernel.org, Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Annotate a racy read in blk_do_io_stat()
Message-ID: <ZkSvKbWj1lhGZvLE@gmail.com>
References: <de92101c-f9c4-4af4-95f4-19a6f59b636f@paulmck-laptop>
 <d037f37a-4722-4a1d-a282-63355a97a1a1@acm.org>
 <c83d9c25-b839-4e31-8dd4-85f3cb938653@paulmck-laptop>
 <4d230bac-bdb0-4a01-8006-e95156965aa8@acm.org>
 <447ad732-3ff8-40bf-bd82-f7be66899cee@paulmck-laptop>
 <ca7c2ef0-7e21-4fb3-ac6b-3dae652a7a0e@acm.org>
 <59ec96c2-52ce-4da1-92c3-9fe38053cd3d@paulmck-laptop>
 <CANpmjNMj9r1V6Z63fcJxrFC1v4i2vUCEhm1HT77ikxhx0Rghdw@mail.gmail.com>
 <dd251dba-0a63-4b57-a05b-bfa02615fae5@paulmck-laptop>
 <CANpmjNMqRUNUs1mZEhrOSyK0Hk+PdGOi+VAs22qYD+1zTkwfhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMqRUNUs1mZEhrOSyK0Hk+PdGOi+VAs22qYD+1zTkwfhg@mail.gmail.com>

On Wed, May 15, 2024 at 09:58:35AM +0200, Marco Elver wrote:
> On Wed, 15 May 2024 at 01:47, Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Mon, May 13, 2024 at 10:13:49AM +0200, Marco Elver wrote:
> > +Use of volatile and __data_racy
> > +-------------------------------
> > +
> > +Adding the volatile keyword to the declaration of a variable causes both
> > +the compiler and KCSAN to treat all reads from that variable as if they
> > +were protected by READ_ONCE() and all writes to that variable as if they
> > +were protected by WRITE_ONCE().
 
> "volatile" isn't something we encourage, right? In which case, I think
> to avoid confusion we should not mention volatile. After all we have
> this: Documentation/process/volatile-considered-harmful.rst

Since you mentioned this document, the other day I was reading
volatile-considered-harmful.rst document, and I was surprised that there
is no reference for READ_ONCE() primitive at all (same for WRITE_ONCE).

	# grep -c READ_ONCE Documentation/process/volatile-considered-harmful.rst
	0

From my perspective, READ_ONCE() is another way of doing real memory
read (volatile) when you really need, at the same time keeping the
compiler free to optimize and reuse the value that was read.

Should volatile-considered-harmful.rst be also expanded to cover
READ_ONCE()?

Thanks!

--breno
