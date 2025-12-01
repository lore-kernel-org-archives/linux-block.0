Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3EA1EFF9B
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 05:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764568703; cv=none; b=M5qyefys+hnbiItdHDPxPcre2Gyc/B8bqgpJUfsmw+bhBwOsghu4ez3//9+TwgcjgMttEq5NOwaWJLCKAyGvUfGuFidWVnwfGNKLTAkzdcdlGR8IzEq5ndNXyiyF/xIAqykwhI7zmT+YO8ERJSzSQy515bsbpBpvGohUTInYv4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764568703; c=relaxed/simple;
	bh=aImZKz6ZAeMtXOu12x1GpTS3RXvMiBtnNRdUGUH/wNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkwqwS1TmPA4mtNYLZiQ+PBLf3iO/CL8TlCZkTJgq9cBqwKXNEAmXR4WFX+d+D6nT6zxqjeKUbWjxWElVSdYuqs8fpt12fhWMiNX9kNozlWWhcWmSkxD2IYl2MHX5CEKyqduAFFNxYvK6g//+oGjxRWXLIRMjhOECO9ONID64jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Oe0uAtqo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Oe0uAtqo"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29806bd4776so6642175ad.0
        for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 21:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764568701; x=1765173501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynFk6sjjY/clNnonF5CdKjbMTq2F6Or6gkxvJspqSRU=;
        b=Oe0uAtqoLa6DmZy9ndUVuvyRK4wpSdmliqX8RSbeKUJlvN7Rd268iXHb395O3mpyt2
         zbSvoFknnpVBg0I7xVpUPNtPsE9JY3k+zgOvW/OhBn6+W8X4kByVmPLK0KJY6UrQXosg
         Vm3UV7zqk1Ep7hfQvUxWvO4+00cQp0Up4mkUwLvkdDhprn2U0gazt2ntljgjjjn/LPk/
         THiv31zCoX7t8K00N7ePi0g0S1eDBCJ5QiQockpPFNSuHLEdiRI2e4uUxEn/rIrvTQfG
         KJ9JdhTPnI7/dA2Q7P+GrhYhXU+0uAvlOSen+GOrEX2tX1h8oDlu0VS4J89Kkr4RR5dW
         i3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764568701; x=1765173501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ynFk6sjjY/clNnonF5CdKjbMTq2F6Or6gkxvJspqSRU=;
        b=A67J+wZGjdBaWgL5dzZndQWsBXXLcjckBbmhLl5jt+wYh9mt9NcQ6kqpfJYE0KbmMV
         UPBPxAIvQSAE6BYk2BycFg1GdUMxFoxG5404HZzj8GP7oK8YMSjrXpJrqmj4m+K4Lse7
         u1ze1OoRKOOWCPDHE5iUvIkbv28P/r1uH018Xvc5lnZ1S4EHcaAGu+Gp4GMv6yvoed1+
         7lW8AYwOBvqIZ14uResq0kkC5x3py2pM3J2FewHcnE4mUaHfoeQb59joPHnxOGlBSpBe
         1dUpvjzj4WDAGUoDLwK2QQhYwfNXm5hSOgbJbOy5KfkKRFoVyMsnq6THwYtM7klqE1QY
         NRyw==
X-Forwarded-Encrypted: i=1; AJvYcCVffoPnFBOX6VMqvRiXHnNxT85KcK7e2+fjzt8Dpzh9Vq4LyP7W0PdYAZC/VxGaZrBzHuVkJ8PfulT2XA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZIeqjFJ6a+auSjnhW7bYpg9eqccePsuJwA5aZTkA+wu1B2S1F
	tuZp25gdApBntQzXW3Erg4INLl0mE0MRBO6PZziSh4WL9EgwWc/y0tFczdCaa5cI7/W6S9+Adv2
	9uwiynNzbkzj3iyJr0lSRRtDoIDFmODsFer/J4ittiw==
X-Gm-Gg: ASbGncu7I/MU9hC6VLGFZ5iekvr/ynzrek6OvoEQ0E2au+LG9a8g6FkiJW3T/jQlXmk
	4IYcnxphan3fppDda1m5bRK/oX9WHhBqPcyIwqdnYnlg1iV26Nn+X+r766EODk4aMh4nOkUsWkA
	jn7IMmbZFBi+rfsG9jiHW8DBRnQPySomPDlvmXuZEPFTNbmGi4Ms8baWb7Xei7Wmz67voykcBP4
	v/ENwStLv4SFxa/b/Hredls7bgqjJiJEFwcs4YGbEmAp+P1ZOe9z0sFusiImOFozbb4qSJE
X-Google-Smtp-Source: AGHT+IE4J3mB1vmb+l2kleEK/k0qPOX5WcsiH5cESjNzC8LWsclbyPhXJ4BFyz7GF0V7JPAZjnc8nJOg/8doVROIOZs=
X-Received: by 2002:a05:7022:24a7:b0:119:e55a:95a3 with SMTP id
 a92af1059eb24-11c9d87d64dmr20444793c88.5.1764568700651; Sun, 30 Nov 2025
 21:58:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <20251121015851.3672073-2-ming.lei@redhat.com>
 <CADUfDZramMrqZ1=ZH2xXcT=n-p-QsdQ2nOpAeWGzxEpjc-9-Rg@mail.gmail.com> <aSzzdFRAVAGpBMpr@fedora>
In-Reply-To: <aSzzdFRAVAGpBMpr@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sun, 30 Nov 2025 21:58:07 -0800
X-Gm-Features: AWmQ_bnrOeqUi3OvYYFoBPMWMhSAE1kVUIHaZFswZDOYqBXZrcB13LzK13GdDNA
Message-ID: <CADUfDZr0GqyWj=Zyq4WQ2T3wULrC_L4ZX_LB_CRbRj7TS=pmSg@mail.gmail.com>
Subject: Re: [PATCH V4 01/27] kfifo: add kfifo_alloc_node() helper for NUMA awareness
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 5:46=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Sat, Nov 29, 2025 at 11:12:43AM -0800, Caleb Sander Mateos wrote:
> > On Thu, Nov 20, 2025 at 5:59=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Add __kfifo_alloc_node() by refactoring and reusing __kfifo_alloc(),
> > > and define kfifo_alloc_node() macro to support NUMA-aware memory
> > > allocation.
> > >
> > > The new __kfifo_alloc_node() function accepts a NUMA node parameter
> > > and uses kmalloc_array_node() instead of kmalloc_array() for
> > > node-specific allocation. The existing __kfifo_alloc() now calls
> > > __kfifo_alloc_node() with NUMA_NO_NODE to maintain backward
> > > compatibility.
> > >
> > > This enables users to allocate kfifo buffers on specific NUMA nodes,
> > > which is important for performance in NUMA systems where the kfifo
> > > will be primarily accessed by threads running on specific nodes.
> > >
> > > Cc: Stefani Seibold <stefani@seibold.net>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  include/linux/kfifo.h | 34 ++++++++++++++++++++++++++++++++--
> > >  lib/kfifo.c           |  8 ++++----
> > >  2 files changed, 36 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
> > > index fd743d4c4b4b..8b81ac74829c 100644
> > > --- a/include/linux/kfifo.h
> > > +++ b/include/linux/kfifo.h
> > > @@ -369,6 +369,30 @@ __kfifo_int_must_check_helper( \
> > >  }) \
> > >  )
> > >
> > > +/**
> > > + * kfifo_alloc_node - dynamically allocates a new fifo buffer on a N=
UMA node
> > > + * @fifo: pointer to the fifo
> > > + * @size: the number of elements in the fifo, this must be a power o=
f 2
> > > + * @gfp_mask: get_free_pages mask, passed to kmalloc()
> > > + * @node: NUMA node to allocate memory on
> > > + *
> > > + * This macro dynamically allocates a new fifo buffer with NUMA node=
 awareness.
> > > + *
> > > + * The number of elements will be rounded-up to a power of 2.
> > > + * The fifo will be release with kfifo_free().
> > > + * Return 0 if no error, otherwise an error code.
> > > + */
> > > +#define kfifo_alloc_node(fifo, size, gfp_mask, node) \
> > > +__kfifo_int_must_check_helper( \
> > > +({ \
> > > +       typeof((fifo) + 1) __tmp =3D (fifo); \
> > > +       struct __kfifo *__kfifo =3D &__tmp->kfifo; \
> > > +       __is_kfifo_ptr(__tmp) ? \
> > > +       __kfifo_alloc_node(__kfifo, size, sizeof(*__tmp->type), gfp_m=
ask, node) : \
> > > +       -EINVAL; \
> > > +}) \
> > > +)
> >
> > Looks like we could avoid some code duplication by defining
> > kfifo_alloc(fifo, size, gfp_mask) as kfifo_alloc_node(fifo, size,
> > gfp_mask, NUMA_NO_NODE). Otherwise, this looks good to me.
>
> It is just a single-line inline, and shouldn't introduce any code
> duplication. Switching to kfifo_alloc_node() doesn't change result of
> `size vmlinux` actually.

Right, I know they expand to the same thing. I'm just saying we can
avoid repeating the nearly identical implementations by writing
kfifo_alloc() in terms of kfifo_alloc_node().

Best,
Caleb
