Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FA73D6B
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733472955; cv=none; b=D2zr7jRmcYYBd6/3ahGcxB98NuLgGy7YasMWN6Z6lOjnKNyDGoxwvouY2fNXRyYPZ2Dg0neYbydpv89wqjbEES94ObBNZ4kEMdlm1p4ayjjjghAIu8JxNf35vEXLMG1uHPzlTFTgYC/oRbCgYuAKNcpXiuCY40XHZElhDqYCgZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733472955; c=relaxed/simple;
	bh=6r59LDTJLjI1H7TJxbsRQn3U+Xq0QFXnqpAM32BaPOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/5ihdLaXKrh9W+NwfZ0MeZ6/rPF0ZGLTzQZDIH/VcJ8Adl5VWk7ZoNt02KM2ZwrFwQK0fPAlrscl87gIEWHpGxmSnjMWaL8UGz4JFS8pZKPRWnF9JAyQ50PLe5yyJ2OVHTaB72E+ZhBN0dfO5p97erXuFudWrzj0wE8/U7GIvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ib6kuJ+O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ib6kuJ+O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733472951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6r59LDTJLjI1H7TJxbsRQn3U+Xq0QFXnqpAM32BaPOU=;
	b=Ib6kuJ+OkK25XRZ6q0bpj7dJFNU6+vAjQZh1ji3Mu4p7A5c8m7cZL++GZjxIA7ZHmA/BoT
	4UQv2DacM7yyyWdwgz4dtuV5WcCyic57HtEz/kRnhXGsH1r11RbOJvYuXhsJxZ2eS0DgFP
	ZsMZkmQNT500dw9JO1xFa/cb1Zdo/KU=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-avdJs_BcORaEJ0-9EZ0oBA-1; Fri, 06 Dec 2024 03:15:50 -0500
X-MC-Unique: avdJs_BcORaEJ0-9EZ0oBA-1
X-Mimecast-MFC-AGG-ID: avdJs_BcORaEJ0-9EZ0oBA
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4afcbe904ebso196308137.1
        for <linux-block@vger.kernel.org>; Fri, 06 Dec 2024 00:15:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733472950; x=1734077750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6r59LDTJLjI1H7TJxbsRQn3U+Xq0QFXnqpAM32BaPOU=;
        b=hVLKaqql5tBTjqzjrlKYIxVoDeuQhEnrOrIQebWCzjixCACs8OJr0+cu1AgXLl6bV+
         c+764c5+i9+s7IgXSAeE/ug1FMY+V85v+U//7nkZHS3orrcFFZ2g5T5fG8I/CxJyGiSC
         VMsx8cMbtF7vLUvErXhNKQllk6BPhYJS4Oy54DV7sRHmf29H4yM+z5/pN6LOEuRyaBIo
         gyQt+yTY+NuFl6f+KxcPSKzzd/Fq90KqAn3LgyE+adTki8rILe/XXvpmv3QVJB18gSWB
         NQYUB6/JzyXO7kom1oH3yYbETgfj0gKw15wDWOAYvKTBhlGxWVV1j2N5ztEX7NFKyNEN
         FOYg==
X-Forwarded-Encrypted: i=1; AJvYcCUK6Os1J7eacZvJpZsFrb/0weOYwpMyrse33FTrRjz/Kcrk8SPa7F1r3fukemxfHiG5YKIoUx3cjKIkRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzN6k3b088TlDxWiwesHDKnrWRqYs87fuI5DmB40pStpkylNsAF
	RgFqSyV0biMkx6zTceYpVx+KQo6fq2U66KbRyAo/nIpbIbZZ9krrevdb/3x7vo1D7OtdafSCjWw
	DbO4ovRw5uKuDABE3uEu2WLywoZJkTPCvNEXi35AxOiqjyMjhA2E9UUsLOt4FYUq0hklOdszC6d
	8U10sAmzP63QtHYv7LRvys1MFBLAE4ACFW9pw=
X-Gm-Gg: ASbGncsMuIrUAKCyvxbIrwLhcue3dZJNU1xAG1ty6iCVKcmphJEfW3MNEBRBjo2bTjO
	Wt/T7NiR6GPsDvmglzf1y9L+4hvN9UalV
X-Received: by 2002:a05:6102:41a7:b0:4af:4cb0:a310 with SMTP id ada2fe7eead31-4afcaa1c523mr2530467137.11.1733472950144;
        Fri, 06 Dec 2024 00:15:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEV7s4mOjRGOhrGQrI7fbcqfx4w/47H1g7o019knjjY5uzImyccP8q/qbis3mryy+2kn+RXulhE8UAuaiK/2lQ=
X-Received: by 2002:a05:6102:41a7:b0:4af:4cb0:a310 with SMTP id
 ada2fe7eead31-4afcaa1c523mr2530458137.11.1733472949908; Fri, 06 Dec 2024
 00:15:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206080622.942110-1-ming.lei@redhat.com>
In-Reply-To: <20241206080622.942110-1-ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 6 Dec 2024 16:15:39 +0800
Message-ID: <CAFj5m9JPB0WCDC3AqXiMJD61LOvJEvEDivFZAhLyQHGiiEyO3Q@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: move cpuhp callback registering out of q->sysfs_lock
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Peter Newman <peternewman@google.com>, Babu Moger <babu.moger@amd.com>, 
	Luck Tony <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 4:06=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Registering and unregistering cpuhp requires global cpu hotplug lock,
> which is used everywhere. Meantime q->sysfs_lock is used in block layer
> almost everywhere.
>
> It is easy to trigger lockdep warning[1] by connecting the two locks.
>
> Fix the warning by moving blk-mq's cpuhp callback registering out of
> q->sysfs_lock. Add one dedicated global lock for covering registering &
> unregistering hctx's cpuhp, and it is safe to do so because hctx is
> guaranteed to be live if our request_queue is live.
>
> [1] https://lore.kernel.org/lkml/Z04pz3AlvI4o0Mr8@agluck-desk3/
>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Peter Newman <peternewman@google.com>
> Cc: Babu Moger <babu.moger@amd.com>
> Reported-by: Luck Tony <tony.luck@intel.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Please ignore this one which depends on another patch, and will
resend V2, and sorry for the noise.

