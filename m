Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57981F5EA
	for <linux-block@vger.kernel.org>; Sat, 24 Jan 2026 01:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769218733; cv=pass; b=B33fdjCyDo+hkukUter9fovo7b25ZThBomTzVCEauZwVqDjscOr1HZhCgvdigb16mXQQSPW2VWx/0TVJx/cIHzE1xmMTLMK8E3iq+6i1t6wcNWb+wTggGMcmrCTGdfv9h1CxMPI83oMjUygyCCaQ7oAXVUxr556/lrZNHxe8j4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769218733; c=relaxed/simple;
	bh=hbB1PawQWPZIpMyHvqf4g+2XYeMtOot3j9Rxarolx20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGPZ9tHse8O9eGJ+46h/qf/avMIxWDI/hWytqP3fT7Ziqko/ZszrOUoBGfBcZeslf+MYsvNNr7F6OlFCRROrsaGvaCq+ll0WiaS3IDvny6uWNi+/GxwnWrbZRO5n4a1erkzY0eEzwqmkVXWKcPKhC3Ai8iEU56xf+CfIycwokEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GttMKBLx; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GttMKBLx"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b6a868ad45so342467eec.0
        for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 17:38:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769218730; cv=none;
        d=google.com; s=arc-20240605;
        b=i/LmZAVGOmPXwZtcM7VqTOS2si8vWeRBfMhqCiWN2r0RtfQmqQsJ4V/C2qEFmokDv6
         XqVrDHQSjWlXkeNcCw4i5aon2BVrpgjoNEolyyWiyWTF6R1nUb2CyvdZ3JOHXF57OX1u
         earrPwBTZ4Z3+iLAR5l2D22Ii9tL38JHpTevJk7QnpzPwleLWJNYvretVtftf92icBj8
         Ta/mD5m0FNjLNHmYMZuEvXNFRieCsOQTkPZ9PzmMuqX8HLZUeDQgtzHZcmbhagzLvczY
         gntFwi+Y4RW3KaplVlisfjDgEzobx31Pmm5U6JLgJ8x8pw3xCLoUPeLDbh0PLRdgPAvn
         AWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q+lwynGmtS4WN3bg0tIUPjdz3p4NuDB0OdpbdMx9Q8k=;
        fh=zwqV47YcHPAOp63LopULiW2TM60PMiJgbUwHO2rmLuY=;
        b=CZpMy/T6ruq/AuUE/t3Dw2JQBK+w3vuvsKotmJYi38/xSd/Kc6pMxPhwvqV/9AHQe1
         G0UQ4PYjNdlaPEZBrYilorpaKPny1mEvpRQ2bFqSVPbdCFcunf/k9GZffHB+o9LU/uPH
         KPLOiwENiY+Ch9rqQvERxqHC3IX0gQO+crzDo2rUbt7Q0j+HzslSKa38FeZJGIsO8XFi
         STmgqULcFQCYhKBGAASEYG2I17mtab3pV+44odlNHlshweovkqtdZopCuHya1QZ1dDfe
         U/qkW6OxElImzeYIz27DxuGz2OQ1lfvU4p9c7bp5tmtblEQWuRTQwbAXnaGn64wQWkO8
         PmHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769218730; x=1769823530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+lwynGmtS4WN3bg0tIUPjdz3p4NuDB0OdpbdMx9Q8k=;
        b=GttMKBLx8j/BGoYlCalMIO/2zO4fQZaEafpEnw1i9JVGzQ5+AAZPJ6kXqnXJ6RdI1D
         POnhxhSZiXmmb1OTgkrRDcnMFdzKjU522G6F8cAyLKTisj9fRC4yZwnK05YksYKLF+az
         aZ9PAhmPdGwgBUU2WAyNqzKKpOkKDrqMisAyNzDXjUr8ZiFMVtGELZS1RcV+DoRWpKOe
         n99EjiaCwyEWnWE5tj/OI6c0MQrWil7iU8OnKfNCAOZ49+d0cX6Jh8193JLmxzNTqWei
         ubFHZvPfQg2vzbDhkXvlacNjgBswRq2w4LjCL/19P467usQX5Gfrnkep5mbgPYOSEHvv
         NCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769218730; x=1769823530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q+lwynGmtS4WN3bg0tIUPjdz3p4NuDB0OdpbdMx9Q8k=;
        b=udikUn5NsDY8ZJRs2dJfYDAoGI8jIi9NsHCpAbnl96NlDM87ge2O8aGrcNEJCJPYyf
         l4rTs2dvaovBqiZzyC6NoT5vgLreqnQWjnkenEYnSRe4PO1vDuWTVYS0zhA4pUKLHfXX
         ll0oREebfFpNeYeHveK+nfRjEw0YiX43AO3olRSIjSAWb4mmwreFFcpq6KmH6kUFm/AB
         V3eASmdKwfwkHEX3Z4k88+fEhveK2FHYeAKz3cGrcp7pMK3ajEwPq70D6rXJYlhT8Gts
         6t4fD6DYVe6fpCiscpSa2vS3ZgSQRpz5IVz8+v5dmVJel50L6c9hFWfx666ZjF6XQ6bx
         MMwg==
X-Forwarded-Encrypted: i=1; AJvYcCXa7/YEIUSQY0HBV6BUE5NxY7aCa+rMBw9grgyxKjsPtcqtXQYZ+/LPg6dJJskVdNGfZOgLaVr8PhnB+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNzFpKgwTsladXSSayuYgcgEx+waKxKctmRMZVx/nHUapvfgGH
	UTiH+p6InBaY+Us2dWdcRK66R7fugQYOqs4tHF7oby/TKP2ir8IH2By21M0t07CK7/9aeyzZxr2
	SfRQLZgRI0H5UaKFxc52Qyfa35xcbQozy3oe2sezzHIkJXqyLb+hsnQA=
X-Gm-Gg: AZuq6aLD/7w8SITm4Qu6C9jQTRukKwgWM0ITC4K1g3+XZZfrrUSejCSfQ8CgxNP/Z7u
	SUpaE1Npx9CxulmBTxkG+dsJmdUWzTfNWgwM0wps2OfYnzas3g+rxYBjXsJbUu9cduy6+3yu6E0
	Dg8qCkQmoGHtfr0O4Ahu1oooiDqltHdK278kXhZ758liGnUafVa6o80VM6/2EA0NAB1JjZXA+7g
	+W/pt4JUBJU/LxR66H91/jt/KAqKqPwuDn9WZJRwkgrW29D/CZ1U1TZAuNRJDEtZ3nqogwL
X-Received: by 2002:a05:7300:c99:b0:2ae:5b8c:324a with SMTP id
 5a478bee46e88-2b74e8d0951mr417254eec.4.1769218729459; Fri, 23 Jan 2026
 17:38:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123135205.2202474-1-ming.lei@redhat.com> <20260123135205.2202474-3-ming.lei@redhat.com>
 <CADUfDZog7YhUz0RXfyR=guO3-aKo_FnSF6cSVY1uVv0=m-xB1A@mail.gmail.com> <aXQgtDq2ffpAwnUW@fedora>
In-Reply-To: <aXQgtDq2ffpAwnUW@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 23 Jan 2026 17:38:37 -0800
X-Gm-Features: AZwV_QiIZtuf3JaTtLxj-gt0ybkVuqaHUZGpgiKlTTXWZm-OcuYHd5oTlfhyMuo
Message-ID: <CADUfDZrCCGY90oNo6qdtBrZ=xtZgZDTKndrAwqUjnA0Ou-jr=Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] ublk: document IO reference counting design
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 5:30=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Fri, Jan 23, 2026 at 12:37:07PM -0800, Caleb Sander Mateos wrote:
> > On Fri, Jan 23, 2026 at 5:53=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Add comprehensive documentation for ublk's split reference counting
> > > model (io->ref + io->task_registered_buffers) above ublk_init_req_ref=
()
> > > given this model isn't very straightforward.
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c | 64 ++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 64 insertions(+)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 7981decd1cee..91218b78e711 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -985,6 +985,70 @@ static inline bool ublk_dev_need_req_ref(const s=
truct ublk_device *ub)
> > >                ublk_dev_support_auto_buf_reg(ub);
> > >  }
> > >
> > > +/*
> > > + * ublk IO Reference Counting Design
> > > + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > + *
> > > + * For user-copy and zero-copy modes, ublk uses a split reference mo=
del with
> > > + * two counters that together track IO lifetime:
> > > + *
> > > + *   - io->ref: refcount for off-task buffer registrations and user-=
copy ops
> > > + *   - io->task_registered_buffers: count of buffers registered on t=
he IO task
> > > + *
> > > + * Key Invariant:
> > > + * --------------
> > > + * The sum (io->ref + io->task_registered_buffers) must equal UBLK_R=
EFCOUNT_INIT
> >
> > This is only true when UBLK_IO_FLAG_OWNED_BY_SRV is set. If the
> > ublk_io isn't currently dispatched to the ublk server, ref and
> > task_registered_buffers would both be 0.
>
> Yeah, it also means the reference counter is initialized, which is implie=
d
> in the whole doc.

Would you mind mentioning explicitly that both reference counts are 0
for I/Os not currently dispatched to the ublk server?

>
> >
> > > + * when no active references exist. This invariant is checked by
> > > + * ublk_check_and_reset_active_ref() during daemon exit to determine=
 if all
> > > + * references have been released.
> > > + *
> > > + * Why Split Counters:
> > > + * -------------------
> > > + * Buffers registered on the IO daemon task can use the lightweight
> > > + * task_registered_buffers counter (simple increment/decrement) inst=
ead of
> > > + * atomic refcount operations. The ublk_io_release() callback checks=
 if
> > > + * current =3D=3D io->task to decide which counter to update.
> >
> > However, this optimization can only be used before the I/O is
> > completed, since task_registered_buffers is collapsed into the atomic
> > ref at that point. All subsequent buffer unregistrations need to use
> > the atomic ref since they may be releasing the last reference.
>
> The point is ublk_need_complete_req()/ublk_sub_req_ref(), we can make it
> explicit.
>
> >
> > > + *
> > > + * Reference Lifecycle:
> > > + * --------------------
> > > + * 1. ublk_init_req_ref(): Sets io->ref =3D UBLK_REFCOUNT_INIT at IO=
 dispatch
> > > + *
> > > + * 2. During IO processing:
> > > + *    - On-task buffer reg: task_registered_buffers++ (no ref change=
)
> > > + *    - Off-task buffer reg: ref++ via ublk_get_req_ref()
> > > + *    - Buffer unregister callback (ublk_io_release):
> > > + *      * If on-task: task_registered_buffers--
> > > + *      * If off-task: ref-- via ublk_put_req_ref()
> > > + *
> > > + * 3. ublk_sub_req_ref() at IO completion:
> > > + *    - Computes: sub_refs =3D UBLK_REFCOUNT_INIT - task_registered_=
buffers
> > > + *    - Subtracts sub_refs from ref
> > > + *    - This accounts for the initial UBLK_REFCOUNT_INIT minus any o=
n-task
> > > + *      buffers that were already counted in task_registered_buffers
> >
> > I would note that task_registered_buffers is also zeroed during
> > ublk_sub_req_ref(). Effectively, it's transferring/collapsing
> > task_registered_buffers into the atomic ref.
>
> OK.
>
> >
> > > + *
> > > + * Example (zero-copy, register on-task, unregister off-task):
> > > + *   - Dispatch: ref =3D UBLK_REFCOUNT_INIT, task_registered_buffers=
 =3D 0
> > > + *   - Register buffer on-task: task_registered_buffers =3D 1
> > > + *   - Unregister off-task: ref-- (UBLK_REFCOUNT_INIT - 1), task_reg=
istered_buffers stays 1
> > > + *   - Completion via ublk_sub_req_ref():
> > > + *     sub_refs =3D UBLK_REFCOUNT_INIT - 1, ref =3D (UBLK_REFCOUNT_I=
NIT - 1) - (UBLK_REFCOUNT_INIT - 1) =3D 0
> > > + *
> > > + * Example (auto buffer registration):
> > > + *   Auto buffer registration sets task_registered_buffers =3D 1 at =
dispatch.
> > > + *
> > > + *   - Dispatch: ref =3D UBLK_REFCOUNT_INIT, task_registered_buffers=
 =3D 1
> > > + *   - Buffer unregister: task_registered_buffers-- (becomes 0)
> > > + *   - Completion via ublk_sub_req_ref(): sub_refs =3D UBLK_REFCOUNT=
_INIT - 0, ref becomes 0
> >
> > I think the order here was actually reversed in commit b749965edda8
> > "ublk: remove ublk_commit_and_fetch()". ublk_need_complete_req() will
> > call ublk_sub_req_ref(), and io_buffer_unregister_bvec() is called
> > *afterwards*, which results in a call to ublk_io_release(). So the
>
> Right.

Should I send out a patch to restore the original order to recover the
non-atomic refcount optimization?

>
> > buffer unregister will end up performing an atomic decrement of ref.
> >
> > > + *   - Daemon exit check: sum =3D ref + task_registered_buffers =3D =
UBLK_REFCOUNT_INIT
> >
> > Both ref  and task_registered_buffers are 0 at this point, no?
>
> It can be UBLK_REFCOUNT_INIT or zero, please see ublk_check_and_reset_act=
ive_ref(),
> the doc mentions `Daemon exit check`. But yes, both reset finally when we=
 confirm
> that the io hasn't active references.

I mainly found it confusing that "Daemon exit check" is listed under
"Example (auto buffer registration)". That makes it sounds like it's a
continuation of the steps above, in which case ref and
task_registered_buffers should be 0 at this point. Consider separating
the part about the daemon exit check into its own section?

Best,
Caleb
