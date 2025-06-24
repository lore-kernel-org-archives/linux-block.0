Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30DF2D3204
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777378; cv=none; b=AjqU2uzXOE0Dks/CqM4jLUT5CrkfYhkUvk8Sd/L8r3CVOPleLpHni3OGQZHisJD6j5U8A/paw8eDhzxx17F7P7lXg3iqAu5hp3g9EFrvqRBk9CU/no0laZeNRe9OVwcPW7YmMHVK3cTPvFCdWkCZTkxwcMv3kaezz4omloykaw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777378; c=relaxed/simple;
	bh=aZ6d2ww+sAxXhhU8DObEXMjD5Yjx9X+/HeWN0awnxJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9/OpZBRrISwqdGCxqlwDi1vpogdNZRXRH7IxFzVV2iUh77O+p3UhoEz2BBpTPYslVJjuup4uj3FUuCTyNubV7uJ20MQNJpdWB/tkaMAl/ikmtAeJOlVfg1VIKWfCiki5XZtLvv8RvHqo53I5LYIT5otNh1pW45n/xei4mpDjjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4/In0n+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4/In0n+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750777375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26knUQsm6IfAjeqD8XI9QpiX0JprUBMdNcpaBL6aJPw=;
	b=T4/In0n+PAICdSzTOYKgVrFFR+HmjTLt6gz7hisjlTQPuawra1VsL/HDsIEPOvpGG/Ares
	4fZ5f9korUiXA/nvK9XPn829yoLJsUQhKrw16cTT479XWQ1bM/saEQAccyLgHuySbkikgf
	qwwjMcHpWvOCS5wzxMoOjgDknlBBqJY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-4xfrj-j5NPCSzOgQNVPdbw-1; Tue, 24 Jun 2025 11:02:53 -0400
X-MC-Unique: 4xfrj-j5NPCSzOgQNVPdbw-1
X-Mimecast-MFC-AGG-ID: 4xfrj-j5NPCSzOgQNVPdbw_1750777372
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-312df02acf5so4125377a91.1
        for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 08:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750777372; x=1751382172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26knUQsm6IfAjeqD8XI9QpiX0JprUBMdNcpaBL6aJPw=;
        b=QPeJ9FqKY/o5LuVQsRyfA5So8sx4obV1LBsDkOe6CXcF6Pmd2uZ2MhaLfO6BHknxZC
         kR8JEYI9yooJFuMKcOZms0CSwrCMqafvrW8ZAhBwNRMW3k665LpFgfwOvb9dYaLmBiMi
         uy6lWD1mta3LcYVyGvxpeUq69Zr182B3z5GbWtAL1MLYaEzmySSXMD+njtU7KBNFE2EE
         /URuxloSRwY/7SsHoyi++KC/AFa2dkwvUW+oNNN3SQLcKlhWb0DzKHaNqXnePRBpcB5B
         MfL5ep1qrcciS2ojn8fj68D03yFkYgJXdmdgIhRGOjBpeOBOWVYFYf89VFKDYOYBehvN
         643Q==
X-Gm-Message-State: AOJu0Yw2SQeHGRA6Birb3NLLK8zwyXk3ucCZ4d5VEdkMM9Edikxn0RWm
	1TkidvNpWW7AplEYRSzurB8kDC8KzbF7pkWnm4sOaH4oGDUlW6fN79fhvBulEAxecmQQ0FlVd8R
	uFXy4xx51CgIRGQd1tjmy3/JZy3XF7x6sQ+KgPQB5LM+BlC7Z3vF8h6WwUT96iscNSWI129hZvf
	wcs0ybKO9+AE5gp8vGC+6UlE7OtUCwj4K/ecp1zLA=
X-Gm-Gg: ASbGnctJJIyjlB1MRXxjXZh3qo5bVHQPBl7h+lgncz/MkjSgO7yg9IusNvrofja2jey
	asdfjF2dFEP/3tu87PvHanJGmTdX/TUdlVTUwSqJjr3NtwYjoLhV/sMTzk/gN/gPrEUYOckuJxW
	OhklHd
X-Received: by 2002:a17:90b:2e07:b0:30e:3737:7c87 with SMTP id 98e67ed59e1d1-315ccc94eabmr5231072a91.5.1750777371794;
        Tue, 24 Jun 2025 08:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUoxnJOmDWOiFN6+y0j0WjolvSI3k0vnLz5GanKeKUeNgZzu6/9x1t8stmhncEliSTG7rQEkKF9/x2jTX0AqA=
X-Received: by 2002:a17:90b:2e07:b0:30e:3737:7c87 with SMTP id
 98e67ed59e1d1-315ccc94eabmr5230998a91.5.1750777371158; Tue, 24 Jun 2025
 08:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+UFKKb4ydw1+zWX9Bre6vt9TUFt9FY2qOx0LMv+8VaVoA@mail.gmail.com>
 <aFpb3BjH4T8q8KAY@fedora>
In-Reply-To: <aFpb3BjH4T8q8KAY@fedora>
From: Changhui Zhong <czhong@redhat.com>
Date: Tue, 24 Jun 2025 23:02:39 +0800
X-Gm-Features: Ac12FXwnHZkJcRl6FvYU6yXk_BvQss7qEWIOp8lSPnfnln_4oRxx-uvcIcMYZG8
Message-ID: <CAGVVp+VNFCUt68A1-P+Rx85kKJpVioJt7U-=hKyw6ji7_5OzZA@mail.gmail.com>
Subject: Re: [bug report] WARNING: CPU: 3 PID: 175811 at io_uring/io_uring.c:2921
 io_ring_exit_work+0x155/0x288
To: Ming Lei <ming.lei@redhat.com>
Cc: Linux Block Devices <linux-block@vger.kernel.org>, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 4:03=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Tue, Jun 24, 2025 at 01:37:55PM +0800, Changhui Zhong wrote:
> > Hello,
> >
> > the following warnning info was triggered by ubdsrv  generic/004 tests,
> > please help check and let me know if you need any info/test, thanks.
> >
> > repo: https://github.com/torvalds/linux.git
> > branch: master
> > INFO: HEAD of cloned kernel
> > commit 86731a2a651e58953fc949573895f2fa6d456841
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Sun Jun 22 13:30:08 2025 -0700
> >
> >     Linux 6.16-rc3
> >
> >
> > reproducer:
> > # echo 0 > /proc/sys/kernel/io_uring_disabled
> > # modprobe ublk_drv
> > # for i in {0..30};do make test T=3Dgeneric; done
>
> Hi Changhui,
>
> Please try the fix for your yesterday's report:
>
> https://lore.kernel.org/linux-block/20250624022049.825370-1-ming.lei@redh=
at.com/
>
> The same test can survive for hours in my VM with the fix.
>
>
> Thanks,
> Ming
>

Hi=EF=BC=8CMing

I ran the test 'make test T=3Dgeneric' 50 times with your patch V2 and
not hit this issue.

Thanks=EF=BC=8C

