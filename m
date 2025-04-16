Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5D51E9B06
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744830779; cv=none; b=ko9KSpm8cFlXrlhAxeUUWZrd5MPohHER+byz11xqAVMnyXBSZzfJ8ag0z5gf9CL3p2QNwQxOI87yv8VKMSCdDLRHd45t+2jojZhuzMl3Yrwj9h8RBzapxYv6C1JWcS9YwM3KI2urU6hmrUGpGdLCWPMjGaMsxeqzaPqofxi3QoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744830779; c=relaxed/simple;
	bh=YAJyde0rKlA3/Jqp4w4fxsQdvAfJUtcgdJrAhXCwwWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvvVotnputqPooMYoPW42NuqLm56/sGgYVmorbWp1e9yVDxmVyrgGOE3WVB03z/AZWjk8J93/zYTguDYHPKiBoUtGd0EEpSln1zcwFVc7JzR53nhXPrNTcI8K0KqF6KKERODyankoeKrd325zTI85j2yekU1h00PBZW9rCYo7L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dNubGrkb; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dNubGrkb"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b03bc41695eso943968a12.3
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744830777; x=1745435577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAJyde0rKlA3/Jqp4w4fxsQdvAfJUtcgdJrAhXCwwWk=;
        b=dNubGrkbCdiSRJ7SVPJ2fmimk4f7lxRhnPd8I6lRJGrHsfLy96c33eE1vZf5IDN3dn
         GmD0et2ca+ZYf9mfDO/hxcka6zOLDOf4c46jEGH2bT0VwxzPH7enhGkzNCNsydofISMm
         FUFn3of5G1nNhQtk9HS1QQUcVqZxCtXFhR10iGnbmJQTkn9+e9anSUix8+9YDXzLwjXQ
         WpzMxfEBTv64CE8a+rhWWhNhOE5+4mkico+y+RIpzFZblHYUbIw5A8QT0xxKWkMQ/A8u
         4VLLVC5IHLifkgPSYGrTmYSebbHxcKCN2xuoVGnh7PSbt4Yky6NDE5DBCahaY0XW3DzN
         SASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744830777; x=1745435577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAJyde0rKlA3/Jqp4w4fxsQdvAfJUtcgdJrAhXCwwWk=;
        b=EcTvfHF5uDFz9FK51uoRaiMeZ2yCwFa870uSXRMM5JtfO99r9bm4rWuTO67scY/+Bc
         5pTv/3U9bCJoGaa5IoKUonBxAx27wnZBHfl3N6w4AvIlALg6C1WPi3m6ezjz9TlvVk2e
         OiXPyv5QVci37FPJlrM6rNn1VH3Qc9PAkhFD2G9fkzv1M1WyKPMKTS8jd3g6C0qVnoUq
         GneOyxxT2nVOt0aRpuisJEdTJ4adKZHSZXqf1InagIh4ss9WzcQ+GNkzZQUv2FCGUvdg
         pWGnBpodaWv2jIUarHK/6ALSWFFJWqApr9ifoza8fZAMRuXLUJIoJIM/Gqcmax1hs8Hh
         9v7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX474brnNYsT7pRD3wY0jCQUz7aj3nJHAmKfM0KzrdNuprFBAm1By3tnsTGOvRY+szLUU+U2Sfh4u4FeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLnoKdd/fN6i9x0Rcphgomh9vwaD78xQMXAj0chjKNanEWol3T
	tCIDWTOo/paTFjbQClNLj1oROnFQbahmUgT0QTaQXrbT22WRO2vAO5IUpPOU8KgzDH8ZZcZbXcE
	dj09hcxBWaPpf/nb7CwwyvrH2r7PbQIacLmHb8X3lhGvEKtMGaps=
X-Gm-Gg: ASbGncvam6cc8alZ9sCKX53SeDbYGtSmhyJGj7AQ3oqYArkwrRt6MLtEHqk+bBQpURR
	pA5P56wUB8dqS152ecq1etYyjLanIy9hcnw7Ghi6bGfcO9DO3jWjqF0hh7VI7yx85MvPvgW/ZD4
	l8FzraZDEiktKN7Fe+7/mjbH9X
X-Google-Smtp-Source: AGHT+IEEcaK/kf+hnH7WpJIPAbQ8YV9bexKkzYpKirQXm53d9m61Se6AU0kOe6wu5D9y8Gg8iAntt2FdlcQVnKoaH4I=
X-Received: by 2002:a17:90b:1c8b:b0:2fe:b879:b68c with SMTP id
 98e67ed59e1d1-3086d45aa33mr512422a91.6.1744830777267; Wed, 16 Apr 2025
 12:12:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415-ublk_task_per_io-v4-0-54210b91a46f@purestorage.com> <20250415-ublk_task_per_io-v4-3-54210b91a46f@purestorage.com>
In-Reply-To: <20250415-ublk_task_per_io-v4-3-54210b91a46f@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 16 Apr 2025 12:12:46 -0700
X-Gm-Features: ATxdqUHTDCU2rQJ_X2Nhw10mB39sRHdrBHSFxas462wTw_XpTmSoKQxHVE6ODV4
Message-ID: <CADUfDZofzZk4vE4E=aKcTTDwm7KxT1F-3_xMTrw796nL_tH=YA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] ublk: mark ublk_queue as const for ublk_register_io_buf
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 6:00=E2=80=AFPM Uday Shankar <ushankar@purestorage.=
com> wrote:
>
> We now allow multiple tasks to operate on I/Os belonging to the same
> queue concurrently. This means that any writes to ublk_queue in the I/O
> path are potential sources of data races. Try to prevent these by
> marking ublk_queue pointers as const in ublk_register_io_buf.
>
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
