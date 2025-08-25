Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0C31F418D
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 01:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756086674; cv=none; b=WvUJHCiAlYRr6yh4CCHW6TDzGVfQGCtYENF3xHVZpBY6MuyjOg9mmy1ETSqXut0ZArVJw6kO6/UYkbkCcYAZ5gQin6HInMbuyh9nHPL0Ott5NRw8LHlDgGDAYDdLKN8DjY421Klu7iwnQ2EPQvDYC4ltU05RAksN5GDtWNwH0cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756086674; c=relaxed/simple;
	bh=Rp1cVCftBz23Fa+VORXeNRa2txptyXNKS3pufTJ/PXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZuJteVYMiE7HWUhNYeaiIcloZUCMDe5ntdOi6c7N3OH873vJ7iERDIXVKcdkQM8t3kHWEhtoDMQU5nYehhKbDdHj/gpiRr167f2W5dFBaTX6P2NKcM6oUW/ppTifDGwkrqPPwpr7lc9TKRxbszBJOpeoybv7ExP3bbOKzcqjxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ia3lIwJ1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ia3lIwJ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756086671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rp1cVCftBz23Fa+VORXeNRa2txptyXNKS3pufTJ/PXU=;
	b=Ia3lIwJ17sLA+T6g+pfneGx7PUJVT6459PWLj62zv8gibbHq48VC8ysx2Ws37PsaaQZjF8
	RX+O5Ze8OfGHmsDLfC935YVBDlA8Xtzf2EqbaW6Kn7bkOtEj0UzKTjEEN+zuUjF3OwUoCM
	o5nQ+VBSnHZNtB8piWX4Jw6ciKLS2zw=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-MxAE3zAJMjuc2zfN51XjcQ-1; Sun, 24 Aug 2025 21:51:10 -0400
X-MC-Unique: MxAE3zAJMjuc2zfN51XjcQ-1
X-Mimecast-MFC-AGG-ID: MxAE3zAJMjuc2zfN51XjcQ_1756086669
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5221dd7ec20so782057137.3
        for <linux-block@vger.kernel.org>; Sun, 24 Aug 2025 18:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756086669; x=1756691469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rp1cVCftBz23Fa+VORXeNRa2txptyXNKS3pufTJ/PXU=;
        b=SOPyOtv42uQPyfCkYFsRQXmjhKLj2bAG/ZB7vHLfSNtCoMReF77zH8U1PKH7WsAjc2
         cYXLG7yTtTcZdTHJPMrOfnLAxO8DI66sQhivYDVzF8aAf/qA8BeW2ZbOAqIWNHsFFWJ3
         19VC8uv5i0naNPkWsZQiUjaQJn2hK5z+k0E0qLclrMwYB8Z6yzTgOh6u1odTdFTZjE98
         e2c2rOVJ5NibmuThX9vkYjmdYcOisyRw412brLB3Q0p3J3E8NAdG4bjwz4oq2gX3VsP2
         U163OEGPfVu9ggVz9VX/KH2CSoEebgCc+5zNNuBdQM0+X4t4I2e8bIVqyWyiw+C9/JqN
         r0pw==
X-Forwarded-Encrypted: i=1; AJvYcCWDN5ihp0mSBfZvQJPzkiOZJqy1zjxnJmscXRgRd2NT8tgcEsH+hq6A9zm+HAa6xeCOkFBJCB4IQumb+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+8hsJ+XDtrS9mrWhQg9XSltxxQ21PL0zMuKdMMyRtCrHwwLNe
	/maXsJPjLW/g0OUJIpMm3WVs+2qAXm03au/NHD3aDpzZvnK9968hsjIBe04JAP3kvlwqRmBvwuY
	yqutxnsj5NJXklrpIFdE0MkbGjFj8CpG4Q3k1286187j3mbzuO0nBnbkwEATgHsBqftfULVl4LD
	FaEDMeNqPnGg8/F8Att8TCaXaJAUa3cIOB4YKm5Qo=
X-Gm-Gg: ASbGncuXFbg6iKkLprifoaSJSHYM74Gspe8gnrDw3LBu7M9c+UK0+0GwGRoLv06CDLV
	tc88lmKs0JAv1kD/kj63hlfjXcoDuU0GAtKpcq5/YCSbpIhu34/dO+Aeb9GybZ4WF3rU1V6b18R
	U75oT8vud/YCuqda+a3VRbjA==
X-Received: by 2002:a05:6102:c02:b0:4e9:963f:2d09 with SMTP id ada2fe7eead31-51d0ceff3dfmr3343105137.10.1756086669481;
        Sun, 24 Aug 2025 18:51:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpV3OsnfsviLzxRZzowyoLGU7Mreux18ZgJ0TDnpJfNT5ZkNcCfzx585W0QjCd7rSpnNuv5UH1iIZvXAWtMic=
X-Received: by 2002:a05:6102:c02:b0:4e9:963f:2d09 with SMTP id
 ada2fe7eead31-51d0ceff3dfmr3343099137.10.1756086669214; Sun, 24 Aug 2025
 18:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823025443.2064668-1-ming.lei@redhat.com>
In-Reply-To: <20250823025443.2064668-1-ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 25 Aug 2025 09:50:58 +0800
X-Gm-Features: Ac12FXxEjY3o2RMA1BrwoKLpNXI8Tb0XMnfB_BJBWXUPgHMPo2-JC6LVWVyrfok
Message-ID: <CAFj5m9K7FepEmqg=26jZK6UtJkjpK+ehijxgj-JSdg1wk0h7XQ@mail.gmail.com>
Subject: Re: [PATCH] ublk: avoid ublk_io_release() called after ublk char dev
 is closed
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>, 
	Caleb Sander Mateos <csander@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 10:55=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> When running test_stress_04.sh, the following warning is triggered:
>
> WARNING: CPU: 1 PID: 135 at drivers/block/ublk_drv.c:1933 ublk_ch_release=
+0x423/0x4b0 [ublk_drv]
>
> This happens when the daemon is abruptly killed:
>
> - some references may still be held, because registering IO buffer
> doesn't grab ublk char device reference
>
> OR
>
> - io->task_registered_buffers won't be cleared because io buffer is
> released from non-daemon context
>
> For zero-copy and auto buffer register modes, I/O reference crosses
> syscalls, so IO reference may not be dropped naturally when ublk server i=
s
> killed abruptly. However, when releasing io_uring context, it is guarante=
ed
> that the reference is dropped finally, see io_sqe_buffers_unregister() fr=
om
> io_ring_ctx_free().
>
> Fix this by adding ublk_drain_io_references() that:
> - Waits for active I/O references dropped
> - Reinitializes io->ref and io->task_registered_buffers to clean state
>
> This way won't hang because releasing ublk char device doesn't depend on
> unregistering sqe buffers in do_exit().

Actually io_uring file close may rely on ublk char dev close, so still has =
hang
risk, will send V2 for addressing it.

Thanks,

