Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2082EBBBF
	for <linux-block@vger.kernel.org>; Thu,  9 Oct 2025 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021961; cv=none; b=iT75hYg+jSwmf2JUT5T4h6FNxg9j7dV3MR8QgFFt4JYpaQUUftw0EKZ0N0i8JC280fwffQgU9aX+CrNDMZ8fcb61U8V4GZJV+4Wil6jBUsNv9/KI7iui3O1PvRxNqxihAfD1U5pWW5nwdind6LVDEwHqocd8gG82DI6Ez1yHDAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021961; c=relaxed/simple;
	bh=s4LtQsa5EVllx+birty57NnxElV7bKafGqgU2aZZh0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5COKDzoOxkrxh1cafVKc8LE1SvwuW86r3ndim2PbIAKcXW8kW5D7wi6W1qbj4k51jXJna2FcFTnEJ1r71VYXC04as10fcBXxgPO6UG1j+8LwTcYpMBnWX9rbIZQPza2aqTRcfvEjMO7l9QSCT1qczjGp+vP8GNSsTdkmD7zllQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WRY3vYTQ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WRY3vYTQ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3307de086d8so1079953a91.2
        for <linux-block@vger.kernel.org>; Thu, 09 Oct 2025 07:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760021958; x=1760626758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahjgOspVOdMfoAz+ojX32xnetLiqRNtvEWbGqK6jlpg=;
        b=WRY3vYTQIEl0w6vrzb0TkeHNaUJv5kMqlWWqHHmvKaGQfWYjI0NkzV1rrHVL7FNWbi
         zvgAhjMWPn0EoqHf6jfOUmAymYTgGCZzxfOS81KRpGZLgt5jKlnnGcdk7EzIGAQxaF16
         D0keH+n0tlcsdr3xFnO/GuZniqyGRgWLpy17zejdJyw5GnjjZvEEolI+BOIFSvPkQ4MT
         dH9ihR643KJV7UujWzJSnXiK5tIabYDxJkmXXa3p4Fz1hBq+wqbH9bbugBGflT6NIvip
         q6VKSzyvHc6oWM00Qu/HwqiwElMcsDn82z3E1cBBDF0dmf/qkHjHnni6qmOGRl3GDKWk
         eqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760021958; x=1760626758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahjgOspVOdMfoAz+ojX32xnetLiqRNtvEWbGqK6jlpg=;
        b=CGdVvgTZOFbiA+KqzsbYNo5sR7gPcX1zn6hl+bPsxq1O9rvmCkyY2ni4KpwsXdXY0V
         sAGcJhU8oa+2NC/MS9K8jIpPyYpuR97xSmIsfBXLnHcPYG9EAGosk4BCjvGqiitg+pa+
         JXKJSHvO13/vkmkjoY3kuSXa6DAIiYf59REfrnXg+N2IZ2xqLOk7vqYvv9gz1x81J90K
         51Io7DsVvsAFYALQRDX6TOwrv1i6bK8ug5c9Xx5dygcFECiLv8ip00ZrOU4HzJnjWhrL
         0WpEp2TMzbUSzztNKpMRT8hCXFlXGG2SgoVI//KQMsBR9+0ypehSbd2g+s0JUVx/CO54
         fwkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlgbq8OWAry47n226s6gdsd0Q7c3DBGqPuV6Ck2i4kBeWQlEEh5+mdB9/HVzR+LnqgWIhxtKzTW1gyxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlfEQ5UXL3GpYwfQdFul+k9w+IqdPEMiIO7KFrr8LMAyrT4Vmc
	4jIPdFzrMRSoYEeWCf6feEO/j37b/s3V1alGL5cZetm8GNhbwAXUoTcpedEgCoUcJn/CKDs+dCF
	wZ799c1x5XA50dcP/QJSdKj2u2Cu6ViIdTkrW0667
X-Gm-Gg: ASbGncu/z27E4MhGJymRd8YqnuVidQSU8vCBVMBX3jmvhUcscbQK2+ZSSv4wfcqn6/4
	OJBAZbvje68JWLOufiFNQ92xqFPj5z5mYG70np0V/Ks4qtwUno7WKAKrouc88d09xJ/2uBYABAt
	4e6TVGMzRpKGTbWyw8UO7V7yOiX1eyX/YFizf8TtZc14qP7FnXUCgDe6s3EqZvdwbNii8Y6nId/
	BK+greRbDxUpsA6wB/weLXTbzs6LzE=
X-Google-Smtp-Source: AGHT+IFf2eEZ8Y3dwPHYfsVPR85J/bW2SFKaZNq78idaJg/NJwVTub7Z+ubYcdUX+OzcCgA2pvccKjX4/bJU8TSe2e4=
X-Received: by 2002:a17:90b:3810:b0:339:bf9e:62a6 with SMTP id
 98e67ed59e1d1-33b51129786mr11695081a91.11.1760021957340; Thu, 09 Oct 2025
 07:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009134542.1529148-1-omosnace@redhat.com> <CAEjxPJ5FVGt0KR=wNmU=e_R5cD6T4K1VRabaZmDAWMd0ZNnPNA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5FVGt0KR=wNmU=e_R5cD6T4K1VRabaZmDAWMd0ZNnPNA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 9 Oct 2025 10:59:05 -0400
X-Gm-Features: AS18NWCQ7y7YKQUxDIqDE5v5atyeT9gE-uS-Jx9EA3wAYJDjv0gABnAz5t8dd9E
Message-ID: <CAHC9VhTCa_SgkOrJVtf1dz0bYt+cyWAUwDWx16MxL9mMRSogDw@mail.gmail.com>
Subject: Re: [PATCH] nbd: override creds to kernel when calling sock_{send,recv}msg()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, nbd@other.debian.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 10:34=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Oct 9, 2025 at 9:45=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> >
> > sock_{send,recv}msg() internally calls security_socket_{send,recv}msg()=
,
> > which does security checks (e.g. SELinux) for socket access against the
> > current task. However, _sock_xmit() in drivers/block/nbd.c may be calle=
d
> > indirectly from a userspace syscall, where the NBD socket access would
> > be incorrectly checked against the calling userspace task (which simply
> > tries to read/write a file that happens to reside on an NBD device).
> >
> > To fix this, temporarily override creds to kernel ones before calling
> > the sock_*() functions. This allows the security modules to recognize
> > this as internal access by the kernel, which will normally be allowed.

...

> > @@ -2706,6 +2720,8 @@ static void __exit nbd_cleanup(void)
> >
> >         nbd_dbg_close();
> >
> > +       put_cred(nbd_cred);
> > +
>
> Should this be done at the end, after the workqueue is destroyed?

I didn't trace the send side, but it does look like the receive side
could end up calling into __sock_xmit() while the workqueue is still
alive.

> >         mutex_lock(&nbd_index_mutex);
> >         idr_for_each(&nbd_index_idr, &nbd_exit_cb, &del_list);
> >         mutex_unlock(&nbd_index_mutex);
> > --
> > 2.51.0

--=20
paul-moore.com
