Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D794F8BF0
	for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160663; cv=none; b=rgGQGhBoGY/syucJUhiBOb5RqoSTX0yhJ89qaMelra2cG0JAn8UFUOgx+r68wyRgY4V5QyQklMOprzyMX0O/9A0TRPpA12EJtIEf/bJUCX9HnXKepPq9/sb7R8ebwcoS9cm23BjcASLaqozuYOJ/yp3wo+3aG+KeJhccR6GHJ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160663; c=relaxed/simple;
	bh=LpsqiJvMgPeFGUk+BZZEvqNyd7oNQvz6Lh1UHfN/Jdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMFaX6XqwDZrrg3FQCxYsCt4QXgFQZp1THEZNXdEtn8Dn/QTf/rHQi3DG8mG1brDg7j+t1eaLw0iol53ZdSZGKy4kQgL/BAMPd8i1BHdaEcgnengH0cJ5bpV8u5GZ7j/uIWCtukZDTgqEl21dM9LuNk4wrqZJkqTZiZXF566RvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UdrwcHEb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UdrwcHEb"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2054e22ce3fso51160765ad.2
        for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 23:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727160661; x=1727765461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/4TVrZGAPYYZ9jgK0SoUaboMFGCpBKiH3t0JiBxkdE=;
        b=UdrwcHEbdf618KJiMNMrIGqYphlbDhR9+dV3iUpzKuq+OdtdTXARO577wptxGjIXEa
         2PgX30ITBo6mU52q0nKCYEO7FjXCurWnadY0QoRN69jMhBblbilGLk0ebz23qXwjkU5R
         d4pxHnwcfptku4iRn2bbaQ0a5ylT/1yhGwp6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727160661; x=1727765461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/4TVrZGAPYYZ9jgK0SoUaboMFGCpBKiH3t0JiBxkdE=;
        b=DpfzIfNfrMPqj0owfkrfGwAXVl0W60uJkZVW4dQ0VIztB4rOgEmDt457Pr/1owDmtB
         TuFFanXaAi/pRFvMK6IB89OoYN6exJ+3N8QqErdSaGXwwyL3Frj+DyG/KoJMOgM4+4SK
         9wp0xlrIPhtqchSUhR1a+TiJVEkXDngqvoceh845ETcQ/JjrOuzSDk0v9k736fkTYIkP
         1YoWPfsu8UxBMjLSehyMISbtwhlR0ozUwjltKnPtWQ2cdYaHbSw8mIfWqCASTdUzx16i
         FydvYioXmDeGqF8tcq+FOKjulosLOc+oQNYdGscaCsaxXfn/bY2ChhiAQ8bzaTMZP4VC
         K6UA==
X-Forwarded-Encrypted: i=1; AJvYcCVwiqLkzr5t5Ltz9qM21pdoPYbN3zjk496mq3LngpHBexqkgusafCwNfkJFFGGkUt5M4rQlY6DqqNt3Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf5UHBelWpoNA/3/9KQsl1QfPQq3/1UOCrq36ykDDDTWEtRmpv
	BDdRckSZwklqjcdUHczb+nZ8F0s/DZn1guLVK1wM471hO26tPtprS6acvxcAug==
X-Google-Smtp-Source: AGHT+IHL8eRo0RSvvbNDTCkEkAe7y/UEEpovG0ZqtEloktAHurr+zf+J8pOugx0pBfpmpOm/9jfvfA==
X-Received: by 2002:a17:903:41c9:b0:201:f1eb:bf98 with SMTP id d9443c01a7336-208d840ace4mr182071705ad.54.1727160661152;
        Mon, 23 Sep 2024 23:51:01 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:93d1:1107:fd24:adf0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1818a88sm4874115ad.210.2024.09.23.23.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:51:00 -0700 (PDT)
Date: Tue, 24 Sep 2024 15:50:56 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v3] zram: don't free statically defined names
Message-ID: <20240924065056.GP38742@google.com>
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <c8a4e62e-6c24-4b06-ac86-64cc4697bc2f@wanadoo.fr>
 <ZvHurCYlCoi1ZTCX@skv.local>
 <8294e492-5811-44de-8ee2-5f460a065f54@wanadoo.fr>
 <20240924054951.GM38742@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924054951.GM38742@google.com>

On (24/09/24 14:49), Sergey Senozhatsky wrote:
> On (24/09/24 07:21), Christophe JAILLET wrote:
> [..]
> > > kfree_const() will not work if zram is built as a module. It works
> > > only for .rodata for kernel image. [1]
> > > 
> > > 1. https://elixir.bootlin.com/linux/v6.11/source/include/asm-generic/sections.h#L177
> > > 
> > 
> > If so, then it is likely that it is not correctly used elsewhere.
> > 
> > https://elixir.bootlin.com/linux/v6.11/source/drivers/dax/kmem.c#L289
> > https://elixir.bootlin.com/linux/v6.11/source/drivers/firmware/arm_scmi/bus.c#L341
> > https://elixir.bootlin.com/linux/v6.11/source/drivers/input/touchscreen/chipone_icn8505.c#L379

OK there are too many users of kfree_const() in drivers/ so
un-exporting it is not an option, that was a silly idea.  We
probably need to walk through them and make sure that they
don't kfree_const() modules' .rodata
