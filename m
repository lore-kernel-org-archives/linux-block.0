Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16A53803E5
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241359; cv=none; b=lNHD/CzjEUJgGNh07cpRYdabv/a121VPcLAt+5A6xz2FAcPISlxNjJvZqfPOc059yNAckwOn/m7HyhwLkPYRYEaq+tRVykaimWr8RNlyGrJR5i3HlT25/+11gpxSGVfuK80BTlJmzuSXzRs6NQnWqQj/4q3nUv2GGpnejJctnSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241359; c=relaxed/simple;
	bh=zVgDjt6fjdf4BBH0+K2VyUEBTjG8SYQlzr7dYZjePmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KamGT4nwuUb7VrZHAfxNt03HAdwOGY77fz6Hhw1cOHpBtOsJg7G4MU2K+GtmxaeyL8H3H7iQmVg5LsEAGExPJ8jXqwtxb/nllPqrFx4z+nwBq39f3sQfejmgl+6f0+xj8WeZDSeS9ILThAuGHAuJXhpD1cb/sIOd0kz+JJZaiVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FaKyZzo7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FaKyZzo7"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b802d5e9f06so972168066b.1
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 10:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1768241356; x=1768846156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gh7LLYNrjRjP3D+25YLQ7uFtmarzJZFabcCNONp6hIA=;
        b=FaKyZzo7HR03WvprOPAorkV8hDjOlMZBE2uACu5kJkbo/UJ51ZjosYDZlrQeTwLZbh
         7d8f/3A+eK/C5JAsV1e+oGdJ4XJqM88CdG0I50By1YLCYpw0y2SqZhaSRRCUZMvq7mZz
         TTrKJDDcjJ/KaSxqNk7b9JusbKjn8nnFr2EhNq0DF8dS/7mj3QVxnMas7JDF4WRMYbre
         /OHuN55vZFmMh1IIT/R6ZFfOaou/TiYWOKUFcMTlTyBess83gZrvDM/YRd9A06YMeYIp
         C2MrR6y/oBdXdOUbtbRYn8a0rG3mwL0dEqLVTpsjmB2k824/fBzLz4ipdFinXHQpDhFa
         2s4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768241356; x=1768846156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gh7LLYNrjRjP3D+25YLQ7uFtmarzJZFabcCNONp6hIA=;
        b=IHC/jsZimN3l6sWZeWAk2pJgBUFten1p5NPLsh9zO5puTcvnRtA/w+bLXpIzMi8dIU
         wx9xoGeLvOgIM4PGwUX+Dw8NxgEv5C5s3K8bPC3egv/TkyLspiuzYs5Np6Zvm/GDrzwf
         xTCT6syP7t+6Z2+u/N7jWNk4yduNSBNyua3TGT/Hf4UhwHeUFTJf5x3JxweZtgLgoc/V
         YVNb3NOhkb10UuudVSc+Nvz36lBTX/Anv5T5Ay3IfyHgcz37iINKKk9ZjG96Oy1jwkB6
         o2p6ywKmodQZgEVDpBtz1G8SS2LtnceImSAbT8GvEq+DTqPH/5fvXn8Odgv6kyJ5l8mG
         FEvA==
X-Forwarded-Encrypted: i=1; AJvYcCUr4uVxDQRrBrvrxGopGpJHa2G41gkkYxMctl7M7etZiGwt+AiUMRAv3FMDeXAMSmfTFDFSea6EOy/dOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcIZe/hBtWBZ2/UWeSg4UVHRd9Wr6nmXt/Y+Q89FZGsc/OztoZ
	lz0JIrZOtjHUVpqHXzzV8xZ1IIGTHhC0H4Z6vf1kFIZEFcZyDpX4+ITWtTCKYv3NvNeZItqsDJ4
	2n14YdnIqmBPwtcYNlzN035puu2d3w+3rjeIBQ/G6UuUdxY2oyFyn
X-Gm-Gg: AY/fxX6cJ0B/2QVmOpx53J0msM7vpGZpFmjDBSfEniZZK4J83MQxCU44MrcT5xBqYhB
	Glv1nDz6Hl9tBFnNy8FKt5k7ElrW3pFey76I+/MUS59Y8S2N3nayh7YSBUHxM/QN96r24AUahSg
	qoHJziQxXJSyhz/zcPnlTlouhlC2pRL2WbPnuIQwwGtt41DCdlONrpEPntAX8covWn4aUaOx7Xd
	JExIeOfLhymZkS5oOGholwZRPhxXGQ1dBQjazcL0AMm2LRochlnm9j1BU4tcpQxEMMwUSOqkWMd
	vzvF/w==
X-Google-Smtp-Source: AGHT+IEYm6JmZ6oxVEG3sghkMbFby4352xUDa/QghGdKg6QzWrgPW5eiKR07M1PCnZmMpNOPMHgZmF9fd+u0Fl3r/lQ=
X-Received: by 2002:a17:907:9723:b0:b87:fc5:40ba with SMTP id
 a640c23a62f3a-b870fc61ea2mr481798866b.20.1768241356080; Mon, 12 Jan 2026
 10:09:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB5MrP5YbxdUe0378VfKBMb_n9=6G-C=TPixYoMaV48trgtWBg@mail.gmail.com>
 <aWSJRAEbC3SUuRk-@fedora>
In-Reply-To: <aWSJRAEbC3SUuRk-@fedora>
From: Seamus Connor <sconnor@purestorage.com>
Date: Mon, 12 Jan 2026 10:09:04 -0800
X-Gm-Features: AZwV_QiXATLjlde29NI6GjNCFmTeW-I4i6Tsfut-UMedDBzTGyIMyurHYb9RAvI
Message-ID: <CAB5MrP4ZAe3Zw677eHBaMRsv9TugpEGpmMC_1v+Dm2GMo7CiNA@mail.gmail.com>
Subject: Re: [PATCH] ublk: fix ublksrv pid handling for pid namespaces
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Caleb Sander <csander@purestorage.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Can we fix it in the following way?
>
> +       struct pid *pid = find_vpid(ublksrv_pid);
> +
> +       if (!pid || pid_nr(pid) != ub->ublksrv_tgid)
> +               return -EINVAL;

Sure that makes sense. Let me try that out.

> Also your patch has patch style issue, please check it before posting out
> by `./scripts/checkpatch.pl`. Or you may have to use `git send-email` to
> send patch file.

Sorry about that.
