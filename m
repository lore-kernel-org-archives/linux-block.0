Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AA128C2B9;
	Wed,  6 Aug 2025 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493463; cv=none; b=SgJJ/HH6/es2qILMKcGNyjib31MynoA66hAchIHdZySO0x8BV2X9cfNXz9zfUiyXxkX8R730K/c6S85+A6sR9Xr38GNCfy5r9YflmjCWtaDbdhMmvK9pmYC+AVgMwOGQzhnLVWJVg2M9GvBlx7u/7FMetxodJ3XIKKYKuknNmPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493463; c=relaxed/simple;
	bh=hWQuqMlYGqSysFZY0WYGkixYRNv5nyQF+2TTKw6FCds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pImXmTXxEmVW81wAUW/m1hJtRYbMI6wawJHVwMqbnxaZuBUp7AupGgy3lzyquIhnVnxZSGSvFD6lTWCuC49ss2fOQo7aDYvmAk2q7XkHrbeFJKxchY44C1GVeE6DUB4e6GSMbTmLi6nuh2LxnHqVm8rIUreQkxiBHIf/siKFZCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNHdk5Xb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNHdk5Xb"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so1511196466b.3;
        Wed, 06 Aug 2025 08:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754493460; x=1755098260; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hWQuqMlYGqSysFZY0WYGkixYRNv5nyQF+2TTKw6FCds=;
        b=KNHdk5XbPf2T+kbR9JVjfhRaHFrVUA4/O75nq2MZMCoHv7IalnGJJoZHUxnWQqtwIg
         uCmKmOIZORlhaz7/7MGkWo7BWyuhSAAP2/nC9sm10BSLqFbfTDJnyQOlTlTEEhj8jKEt
         c81MHOk1JsNLL701WP/i47UH+6y25nsPerQjlslxTq6+21F2uYNN8tiQqDXdX2WQHLRj
         yfVEh6LIOT5TYPvGWOuHdWx3YPyMWpgm9LACZQsu7FrwBmvYx2luGC6VjjOJFAgRi3xb
         cREdNXU8JPd1i2vpkOmfd2XnkX36tLHZk7TbSK/Ls7fPX8sh+RWP9RkYNZMY7UGicFK7
         Fj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754493460; x=1755098260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWQuqMlYGqSysFZY0WYGkixYRNv5nyQF+2TTKw6FCds=;
        b=pD1qYBhRZy/aW16o/lcYhfC7VX+vnjXXXUwQEaeNV090Nk7nG54tjX3+G7aA3I0/yh
         Ze68/tUzomPsDXofuOGKyKQbJfdJ3rN4126yv7AfdF1Txf76m+zW4UMJ4ndfGnXXR6ZL
         ARcXc93x9TZqGIP5Zxpo7/u/iRvUMGpZBMD03MfJDc/V8z6KOic4xtISMsjg0N9yQvzG
         8NOd1Ms//M1RNoXFwBCzBOoD9OYkiaJj/rMVAfjfVUN9soYuOo/8sERujxK7Lnh6wNBr
         excmFMHsdiqRQQeG+ZjkPBwX2ZpdbfxlMVOJvxTfYrbfZWrZua+9LgX6LnRV1blGcEyd
         xknA==
X-Forwarded-Encrypted: i=1; AJvYcCWHSPGVU/f1VWfPH7/MrZX0HNp6W1A+m+yxOrQA1uBn7Nr7ShuZaRTMDS/49/fWr6RpjdkAzupuUMqb6Q==@vger.kernel.org, AJvYcCXb4ggUiNn2m5OXd7lkqbDHuCxLJK22JlC1VbNQ/4BstQPd1TDxmv1+iEsmWsauzF5+C68PMMQPEST2QcVG@vger.kernel.org
X-Gm-Message-State: AOJu0YyOKzpKTv9RI0RJqhy93RUFS+VjAitARFVyhhMkllKLFzTUh2u9
	kPMdySVpZYyz2lfEIRXxaqL2jrNLXO8TdkzhKSOzmd/xTs/e3UBg4T0Xa94rNSbFoFw/cVgF8cf
	Nd1AbhWpwj25ZDeUDV5cC/eDXczK7WHnXFgfXVw==
X-Gm-Gg: ASbGncsEk/XSB5aDe+ViC69vAClHosXLjx0Pya5S2kPeLnviNznxFQg7Sy4pu1teUSx
	Tg4j5BH7kk6WmaQHAmpELJ+f1qbJfNcur8Vxh2yX8FTqDQ/9cl6DKS9rmdjKNDcXFPlfQIX7jCq
	geZLuYhq8ldQ9Ue+RJsf5XtntBExZ9iqnM6JQ/MhX118pcelIfOUuqA5lcy0xLs49+wNXxVN9/P
	foFO0Tf
X-Google-Smtp-Source: AGHT+IHqAZrOzsfGjlwFpHagjFXpijWrYwxgeDkU7dDh9FKQf6tOGtsnsjNT25i0oWnRYKJzAVqswF/fG0a3uP8w/J4=
X-Received: by 2002:a17:907:3d4c:b0:af9:610e:343e with SMTP id
 a640c23a62f3a-af990116764mr322240666b.11.1754493459873; Wed, 06 Aug 2025
 08:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250803134114.2707-1-ujwal.kundur@gmail.com> <20250805120001.3990-1-hdanton@sina.com>
 <8f1183d0-dfee-9448-446e-2a8846987319@huaweicloud.com>
In-Reply-To: <8f1183d0-dfee-9448-446e-2a8846987319@huaweicloud.com>
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Wed, 6 Aug 2025 20:47:27 +0530
X-Gm-Features: Ac12FXx0T4QSbWP1S2EdAexmxgi9MXwdQeH2eVEwt9jN8SSZrh0zgBiK5AfCsY0
Message-ID: <CALkFLLLTBfLxtq0Euz6tYb0gwgDs37P8_TmfNQ8qaPZ5D9SuMA@mail.gmail.com>
Subject: Re: [PATCH] block: prevent deadlock in del_gendisk()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Hillf Danton <hdanton@sina.com>, axboe@kernel.dk, ming.lei@redhat.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"

> This problem is already fixed inside nbd by:
> 8b428f42f3ed ("nbd: fix lockdep deadlock warning")

Thanks for letting me know.

Would this patch still make sense as it narrows the scope of the
read-critical section? It reduces the chances of holding other locks
while trying to update the number of hw queues (and thus avoids more
lockdep warnings for this particular lock in the future).

Thanks,
Ujwal
