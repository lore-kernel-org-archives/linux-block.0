Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7011B3920
	for <linux-block@vger.kernel.org>; Thu,  5 Dec 2024 07:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384404; cv=none; b=VmaIprPsh7WZPF2G6j/jjFONlB/vTi0s0n/sANtwtZIryUpQQwH+K/YiXiSYTsilTUZft/ngxfgCKRU2Ce0UawBRLnknfoIUpe7XjDDy2ZTivTGLgMcc3wZe+5JTtC0ma9XV3LeToXfn/m7hxY5kZJL1j//XrGpfbxLvqK65gJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384404; c=relaxed/simple;
	bh=9ff4/8AXvGXoT23jC6UqbSxxhnB+zrWd5tFzzASQgZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcNM+Ff6MdPtBtvQVl3XRsXX9NPhHm3bW+AYFyHfUoQCMdbJdAS679bUo+7+xzr4gjHHwsqosmjzPrkvdKMXo9viqgg47nuPNcWqKcEg8xMlLQW5pAo/F8EX9SRFT5IIFAnzcLbhHkcMS7bOuJAlMVbMNs9jXgXkay418MGeeRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cRWPYo0f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRWPYo0f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733384401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0qiRMFEZU2kLfdKFqOu/0E5iByZVNjbT0mmKXmaW40=;
	b=cRWPYo0fMlWUk23hIcDUohGfKRmDxJh3drXkJXIh5g7UZmeTt9KUYk7NckqGSfYYZTTW/B
	uHRXHBU5b5o8Tzvpv+2+90wCPTygxiZQEfftQlQmwd+aots6k59OfeuOpuIuh0tmJWhbRl
	C+IQ/OSW5rZJeGrUJsUDbB0H05qrptk=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-p5ylruGdMW-pd6BdYTlxIQ-1; Thu, 05 Dec 2024 02:40:00 -0500
X-MC-Unique: p5ylruGdMW-pd6BdYTlxIQ-1
X-Mimecast-MFC-AGG-ID: p5ylruGdMW-pd6BdYTlxIQ
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-85bb5c397d4so91464241.3
        for <linux-block@vger.kernel.org>; Wed, 04 Dec 2024 23:40:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733384399; x=1733989199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0qiRMFEZU2kLfdKFqOu/0E5iByZVNjbT0mmKXmaW40=;
        b=ZwXVKGltkRyboF/Xs/MFiAreb1HfOqnNL6OKYY53+UCQLc5IbaQfyIVksKTlk1hLVr
         E8HZZiJPTp4SjhDiJtAOhDPUUChG0qiQ0SriItr2mV477Vd1SsyutjZvIaxgHxNy15sc
         LksfrVY1ApAFTxS05W/hmzAyLs55HINBIX4TGy27ViDoPF7K8c4EwUYluEMU1plHoVI1
         iLJK1ok9bTwHC2U8KfgeBdn/mR1L5vtyfuLl8RAJpJIRIUCAw/T8xc4SgehBETgZbSlf
         mzOf1RuhdtvfwAIgD/6xgfQHXPPdWb7yoIWcNlQGb0cto7B1NtcpRWpuAy9PdHr2rY42
         jkzA==
X-Forwarded-Encrypted: i=1; AJvYcCXUPF+K2Wl65UtHPpqWkXmzEr43/ZH05Lk+xx1JgvnyMra9BzbUC53qoS8SS/CiIuKdpaYBjvTnkvZBOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzaRyWwD9FlUW9Hjyy7jvxi2AJMQ9IIZnc209lUvrWwRMsVJJ2
	g9Umqo+ykyowEikmrYGDFXRhQyqdy6LNQRMiiVx9cUyOjSoQMHS9oz1M+3kT7Cyr47VKRR90POH
	UukVQpKF4QRaDgbUdF7bGiIqHe0GCO+13vNX/WELzjGzfAdf0OgI28IKEoMz58Wm58VteMS1oYN
	sLXyJFSErS8f2GRAxUd+Q9muCPfNlsqaOHBjORjD3BYwzT/zBh
X-Gm-Gg: ASbGncs9rbKAcTO0Ll7ZpoHQbO9ag26gQUgJV/he9GpWOL2nDQ8f2QLyJ5p4TxgkG4e
	CcwUJYxOzrVA/DDqaKaZMkHsyrQGN28gk
X-Received: by 2002:a05:6102:54a9:b0:4af:b475:93fb with SMTP id ada2fe7eead31-4afb47596c2mr3839652137.4.1733384399655;
        Wed, 04 Dec 2024 23:39:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnjMDu7v0rmT7ufZdMNbJ5xJYSmwpb364Y5/Kb84+67HxNVOUBICLz8M1awN4jvDGO4eME4i7nJvuorXyAJTg=
X-Received: by 2002:a05:6102:54a9:b0:4af:b475:93fb with SMTP id
 ada2fe7eead31-4afb47596c2mr3839648137.4.1733384399460; Wed, 04 Dec 2024
 23:39:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1225307.1733323625@warthog.procyon.org.uk> <CAFj5m9KusEo=jQbt1AC=EQoOM-0EXmjjc_9WtSBCq+eMOSN8pw@mail.gmail.com>
 <1695261.1733381740@warthog.procyon.org.uk>
In-Reply-To: <1695261.1733381740@warthog.procyon.org.uk>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 5 Dec 2024 15:39:48 +0800
Message-ID: <CAFj5m9Lsgt+iGE6JQV6OgUTNeGb1iiOsXz-eYqGC5Vg85JXL-w@mail.gmail.com>
Subject: Re: Possible locking bug in the block layer [was syzbot: Re: [syzbot]
 [netfs?] kernel BUG in iov_iter_revert (2)]
To: David Howells <dhowells@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 2:55=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
>
> Ming Lei <ming.lei@redhat.com> wrote:
>
> > #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-=
block.git
> > for-6.14/block
>
> syzbot isn't on the To: or cc: lines.  I can forward the request if you w=
ant?

Sure, please forward because I may not do it without syzbot report context.

Thanks,

