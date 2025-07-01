Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E237526B755
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379263; cv=none; b=Ej7+V215EQwZqQgBl4912u0LM2GcyA9LWwkWun/EMxY2aEtte2dcxiUrv9L6x9BUu/UUcenuCC4GDsZeH8PgsFKZTwO0hEJRuiQG0bQ71h3N3rFjD22YsqUc4kuXIuQyrXpb1ZzA8jFQ/bO0C51ItLtflWrrENtQXQg/CMwd3M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379263; c=relaxed/simple;
	bh=5OuLPJkS7/FW06Kbx8KtlQhZFZ40qlvkY0aEbvH701c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JylDdH0VbMjBlx+QVzwPii+iZWu/c4vUgkXuJduGAsy98T/nkNFKTk5vEOClnD6VBHzOJQ2RJslWq2HBRrp5iERkvScA2EUuNrAl6ZDtLRWJdzr50D2QfnbsnkzSKe749GqyXumV3bc/tLq2X17KCSzpOTFGguenEFiv+Ys1F58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OzhsDA3C; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OzhsDA3C"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3dddc17e4e4so10862575ab.0
        for <linux-block@vger.kernel.org>; Tue, 01 Jul 2025 07:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751379260; x=1751984060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmzCkliGIgc/w9CprIKleCb6nmEfP7kYHQXw+v1QCyA=;
        b=OzhsDA3CRP9ZuwaW//WaVIxPQZDj+5RgvrGHpwMDmdUHIIjZgl9x2CmUfQfHyg2jHp
         MVajJFbbNa31aSf1zolxcR8T7zUnso3B59vWdYlygpnieVyAP5j4oas/F2fmcZpnb6cH
         xdG4VaCz1y0fsYonpuzyqaewkg7dypI0iXjlpy1046uhC6TyfplXvBrv8VzfrI5saTj4
         saj/WyPRxKDKbRix0vmYMmIkNnP+33XWZGsoMFNDuq2wMo/xxBKNVJFlbg88kePkHpFS
         oRkKss9SMir+kWdCvddwMG0ic0po4nuGhPXgZvOqtmCh9TQaakgo52D1gU/M7Gzk/tzd
         i5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751379260; x=1751984060;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmzCkliGIgc/w9CprIKleCb6nmEfP7kYHQXw+v1QCyA=;
        b=dog2/nur2TbJJdlUC9fQqefA/PBV4zKVDuhhoCRGnJJ7sJK75my2yR89tB2kgpTa1G
         GRSHf5/AMidzX/+Rknd8fntYkdPagFSuB7xZWI69J+v3bQW8Hv+WRJGlZe6LNfF/JVup
         1eogwIPSG8utyk9HCK0VAtAHkhfFoUvPEpCSSqCqCraNVwl/EshsQwfH7WfF9oldA5Zv
         ndc3EjQQ6+mJf1XzhtTM0l2cUilL1b4KxoFBan7ZO8ek0unwcjmCl9i8I3fmHExvbABT
         697aef7++/k4FmscbiNKvYaKd+0gnQBd5BJf8NcYFmg2ovIXTQqmVueEOQjBcTzKIjjL
         J5zg==
X-Forwarded-Encrypted: i=1; AJvYcCXRqAJJBvdqVy6tvujhIF107KCSZB6PMQQ9m9cw/vr2l/NN+cDK8fie7dwdhtNGjTCrWFaM70fBjIsHvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzevbRyUpt5XOdbKepBb4PhJ513ZbzgoTnZIyS3Ii0FQ1NpFBPZ
	wRxjRfRDdihYIFqiv6uhCWQ9yXEfHiqVh/Xijo0MsP/aJPWp1R5qn4Cgj3NsTOIJdYc=
X-Gm-Gg: ASbGncsB4L18FcT5pIFPT0jMc/LIBkvW5Vp59vcfme6/M/KARhPawwmSF1dgApl+ACd
	Re9+RDGaLQrSptyoQF2Su6r+p/erlDTo492qw1I5Sx61n2woC6dZdjW2sIwZM39YjGyliL84Egf
	tFiPyX38mIglJrM6Dny2IUp2gFOP8YWRaoqibTFHVN/tHZyoI22OShlYGr83Cm47wufYPrvoDXE
	pchj3lJyioxm4rzluMas9wj/ARWt3kibQMOSUeU+HrJ1+YfqOtp3AH+zKsvs32wSgrOYx0Gs4EZ
	JgrisyVmR1wkHzWho2eKy1wFgf5KyA/16U0ybJuYbeCwIWFif0/4nUHgRQB2QI81
X-Google-Smtp-Source: AGHT+IHB54piwldk5JvCGymkNdiDgT55hx3SHr7B9jacyIo19MjXnu+NW0AhuMQH0JmTjiSmrjmDSw==
X-Received: by 2002:a05:6e02:19cf:b0:3df:3afa:28d6 with SMTP id e9e14a558f8ab-3df4ab56adfmr188248595ab.2.1751379257608;
        Tue, 01 Jul 2025 07:14:17 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-502048c49b1sm2489377173.49.2025.07.01.07.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:14:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, yukuai3@huawei.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: penguin-kernel@I-love.SAKURA.ne.jp, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
 johnny.chenyi@huawei.com
In-Reply-To: <20250630112828.421219-1-yukuai1@huaweicloud.com>
References: <20250630112828.421219-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2] brd: fix sleeping function called from invalid
 context in brd_insert_page()
Message-Id: <175137925672.318770.9783780559206172712.b4-ty@kernel.dk>
Date: Tue, 01 Jul 2025 08:14:16 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Mon, 30 Jun 2025 19:28:28 +0800, Yu Kuai wrote:
> __xa_cmpxchg() is called with rcu_read_lock(), and it will allocate
> memory if necessary.
> 
> Fix the problem by moving rcu_read_lock() after __xa_cmpxchg(), meanwhile,
> it still should be held before xa_unlock(), prevent returned page to be
> freed by concurrent discard.
> 
> [...]

Applied, thanks!

[1/1] brd: fix sleeping function called from invalid context in brd_insert_page()
      commit: 0d519bb0de3bf0ac9e6f401d4910fc119062d7be

Best regards,
-- 
Jens Axboe



