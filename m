Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E951C2DC3
	for <linux-block@vger.kernel.org>; Thu, 12 Sep 2024 23:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183325; cv=none; b=en9urTeTCiz72s4jPNVCwJGHMqJJB6gKEjeko9FAskG9TCjLaZBnMJpY5GvwTaoVDZ9xpPmCnO1VP0Ke4EGN2XVJD17xw1ZUCAsFGH6pvfwy2srSWiJXxeUom1sw+fWeSW9ykg9Ig9M0AZYbMhZFAujo+PYjMburC8y1vmUCQBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183325; c=relaxed/simple;
	bh=Yw+fkYTS7VaRTVUGVzNupGrRm42IY3OFFAGbr1Uqve4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCk8VrrsXEuQlT/2/aKBBvMUDnGRkKadqAKITpBe7Pbl0T1B6qSB77IltyAtTacpqZuWr+81ZrVuPeBwtqxSfGvzvNaU3kFSIojr/NjX4J2twOO9V0VgiFzoyvlyyOBJOjimLKCAwGAdb/ENS3OKzdS0pUuBopCmObH6dFhqHeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P3qYUNCi; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P3qYUNCi"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f761cfa5e6so5048931fa.0
        for <linux-block@vger.kernel.org>; Thu, 12 Sep 2024 16:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726183321; x=1726788121; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9ryhHeA6Hvuga7ZSfyREbRFDb02t7ikBMNarZ2W/nEs=;
        b=P3qYUNCizSxB6YOHnQXVba15qf3DtKwiHv/SFa0OdzdQOJdy2jyDvP+z6FcjhjnJFj
         L1x/G/57TxJz3FJRp6smuqgbWLWxEsxeDvIWKrDzg35qt71PCgwGFoPhlWW/ZopqfHhz
         ohka4dqWBfvhlKjBS8AWUbYnsNhZMXUsnH938=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183321; x=1726788121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ryhHeA6Hvuga7ZSfyREbRFDb02t7ikBMNarZ2W/nEs=;
        b=tz+H8/D7E62HnEP/rvSLSyHi5tj3J6IZ47H0Yk27Q36jR8pksvbgWEyqAHgxkjU6Bz
         GWcF840ZCvOUJA3AAF5q85JZ9hn4pdmTFjvofnmJgksYzJY0mfOrKej+m/YiuPhTkcWE
         oTTjquJTDENaKfjw/aUwcFTBLm/9BI8g0OEFmniplcsmIosDN8Z3CHgWdgeJjW1WTNWc
         yN9ZzRfMOHAfbvA5Pzllj7YVpOlt51l5pCbjfq8u6wFlV6biCQNM56lJCEK4yGVrfPSf
         Kc8LUsuJJwnb1KrLLv8IbX7T8ZydnDlvG74z71BtMEDWyNMq00ClOwtSoTtWPbWmJzmb
         1Fqg==
X-Gm-Message-State: AOJu0YxK0kbUX6AixAylRji+jZ7k0sGsjr0WbHZtR1zpgsK5DIKmt9gh
	oTXpRCLhRPeXV475dyqHJN+8Nr0OcTGzFPoILAP+LeM0b+IfDAz7q1MVnISiEDEdCZdd0EjM9g8
	ALSM=
X-Google-Smtp-Source: AGHT+IGnMnMBdZul+SJ1uGbwDKBVGEMXqC3GsRU1GglemeTQzjvt844tRQKzdufa6px6zS76pCXvhQ==
X-Received: by 2002:a05:6512:1051:b0:536:5413:2d56 with SMTP id 2adb3069b0e04-5367ff32328mr454617e87.51.1726183320718;
        Thu, 12 Sep 2024 16:22:00 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8cdbbsm7025760a12.81.2024.09.12.16.22.00
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 16:22:00 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5becfd14353so349960a12.1
        for <linux-block@vger.kernel.org>; Thu, 12 Sep 2024 16:22:00 -0700 (PDT)
X-Received: by 2002:a05:6402:50c8:b0:5bf:afe:6294 with SMTP id
 4fb4d7f45d1cf-5c41e195d48mr521482a12.17.1726183319842; Thu, 12 Sep 2024
 16:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c8f3fba4-9cc1-4e7c-baf3-afb10ab7605d@kernel.dk>
In-Reply-To: <c8f3fba4-9cc1-4e7c-baf3-afb10ab7605d@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Sep 2024 16:21:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdjRgB0WRULyWU3S2LG+z7fQULAq5_44Kx7TrakAasYQ@mail.gmail.com>
Message-ID: <CAHk-=wgdjRgB0WRULyWU3S2LG+z7fQULAq5_44Kx7TrakAasYQ@mail.gmail.com>
Subject: Re: [GIT PULL] Block fix for 6.11-final
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 15:44, Jens Axboe <axboe@kernel.dk> wrote:
>
> Just a single fix for a deadlock issue that can happen if someone
> attempts to change the root disk IO scheduler with a module that
> requires loading from disk. Changing the scheduler freezes the queue
> while that operation is happening, hence causing a deadlock.

Side note: I do think that doing the blk_mq_freeze_queue() outside the
sysfs_lock mutex is also a mistake, and will deadlock if anybody then
needs to do any IO (like a user space access) inside the sysfs_lock
mutex somewhere else.

It wasn't what caused Jesper's problems, and maybe nothing actually
does that, but it still looks rather questionable in
queue_attr_store().

I mean, imagine holding q->sysfs_lock, and doing something as simple
as just a memory allocation that wants to do swapping, but somebody
else did that queue_attr_store(), which freezed the queues and is now
waiting for the lock and won't unfreeze them until it gets it...

Yeah, yeah, very very unlikely to hit in real life, but still. Seems very wrong.

             Linus
