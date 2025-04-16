Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266151547C0
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 19:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744833328; cv=none; b=el4vYw5cvkITBcxqjusFFBqub9xUHr9hPTgGDTcT3bTi+T4x+HlBGPUKYX1+W1+lPtzwhv0bro5XNUe4v4PnVNiSCsJBlvFkTMwoeBDHXFhbnI/O3vRejUoOcSeE8UTqY4drXREqEM614Ydu330D8jTdgaQ11+Q7/morr3g/ePs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744833328; c=relaxed/simple;
	bh=1HUg6vRplYnyCVWiBYojljLFNc1IiwTnkSohA4vTdkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noP2L+7tcyPNgAtWRgdVJ+1VgshW/sXeJHIJSzuzEorVvR6A2M00AyXQJAiep0KIUHyBHblssNfWsf3aqMSj1nGXIrbCrXMzMFuIp8KGfDOCe3szZOK1Nxhr1V9PEUR3HMCyf+SJAcMcx2tteXUD1Ogt6gq4AZ9tBLJ1udbEb2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BttANV3m; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BttANV3m"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b01d8d976faso546a12.0
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 12:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744833326; x=1745438126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HUg6vRplYnyCVWiBYojljLFNc1IiwTnkSohA4vTdkM=;
        b=BttANV3mwvcyQwuziqUN7MbQfIuxxmpc5mJ334ngqS/qMDf2pmhi8oQWh7Bk6SR/oY
         +rpLChmW8Lju3Wp49gcKHlnUMEEYa1ztzvaL64NbrDGIktFNp4zKKT//LzWB8CCR5OSO
         /2ogF56ymHDTk21fV5KzmEc7PMZK5KfohJWXTG7TsnAZskfq5kBoQMjbv2cutSp3j0/j
         0gzIHy71jpkhFt81MUgdQmlwvn35ipYa58AkDioyGZEtKcaRiQOMakOObVP7+vugAbkH
         6f3ZIMXF+iuy8uUw1MCfT0EjITi52/Tm7jD9g/bAAsf1ssfuvJJmZ0bBKgMvnSnIpAnw
         2uKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744833326; x=1745438126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HUg6vRplYnyCVWiBYojljLFNc1IiwTnkSohA4vTdkM=;
        b=OBy0V2cJ1yAaStB5eJQ4gJ0oRDQR1cUSthCjTG5QbYJhYiIdhwqZUQINDMdDloyR4l
         geifK8SM/ZYwI+tmd0T5c0yoji1tFXemKfVXGzd7t88eNVec38YWqJqa/X6nXqzQ6SBx
         nAxgBkAInztj8iD4DYeyNxp9KMgmOPK5FHcVmhDFnsQFSCDunICK4MdI0vlFE4pZH29t
         VY9R4CaUnJYKa3rLAPKcQ7UX5w9WTHLiq/zxQOKBFgs9ik2CBzQA/kqut1ZLYmK71qy1
         XmSe5zF49wULtpOimDm3s02kZg3OCM2+O4bHTJ45VYdpP2gPHzLlHh4EF7bAEjYzhR0w
         W6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBJ5sW7xWvNcIrNRQ8i1S/nyLiepqpfh9K7YqlNouCONGRA1pag9FXXF27Y8mF/hftyM0+jxyYWtVu4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1BQNWU+cgbZPQU7X78WdHqrqglcvO8k6PwhfdjG44F9oqUIj6
	gVBxusHMm+X81/o28c8ZLD26IuMeqpV+Ie18MT7lB2KOT4uBtb+D7XyjyS8QI3o4vsmD0gjRArZ
	uiAKsEPjuI0nEQ9YgU3+73JBMS8Px9zbgd5oeTA==
X-Gm-Gg: ASbGncsTFCGh71jcFkW5YVtnsW20zIXy4ElodVQ+5gEGzEWPW/SZZuf12hJ9GFlERAT
	7bRUkNgmgtPcoeGMTXEydCuNXpPc+PwSYFTVM2FfAULH+w/sr/BU6NXB/yXgaZoYUmCBU5tzaz+
	kKwnEbQzXRo0C3/RIRCRWLLwm0
X-Google-Smtp-Source: AGHT+IGqDMF/ALxgIEpB98flitK9xgvxPgd44G7WeU/Xt83/u6oRlv7JHAEZnJWkR5Q0ZDEgWiYoqEe8L6aCLUjE4bg=
X-Received: by 2002:a17:902:d2cb:b0:22c:336f:cb5c with SMTP id
 d9443c01a7336-22c41200358mr2529885ad.6.1744833326409; Wed, 16 Apr 2025
 12:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416-ublk_task_per_io-v5-0-9261ad7bff20@purestorage.com> <20250416-ublk_task_per_io-v5-4-9261ad7bff20@purestorage.com>
In-Reply-To: <20250416-ublk_task_per_io-v5-4-9261ad7bff20@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 16 Apr 2025 12:55:15 -0700
X-Gm-Features: ATxdqUFwp4qvZeRJfWY7VwLd0YPT411Yqwdu1i1gJfqMCA8jsnrpr2zoR65e_0k
Message-ID: <CADUfDZqNh1G8VDOw__y96ZBtYa=Y2ZhoX4emutMqxki85YABCQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] ublk: mark ublk_queue as const for ublk_handle_need_get_data
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 12:46=E2=80=AFPM Uday Shankar <ushankar@purestorage=
.com> wrote:
>
> We now allow multiple tasks to operate on I/Os belonging to the same
> queue concurrently. This means that any writes to ublk_queue in the I/O
> path are potential sources of data races. Try to prevent these by
> marking ublk_queue pointers as const in ublk_handle_need_get_data. Also
> move a bit more of the NEED_GET_DATA-specific logic into
> ublk_handle_need_get_data, to make the pattern in __ublk_ch_uring_cmd
> more uniform.
>
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
