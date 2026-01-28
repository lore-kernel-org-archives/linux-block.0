Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6687A371049
	for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632082; cv=pass; b=p23JU+OUUePGoKqaxnrZZ6YWAtKEEIOtGXYARCK5ZoGCloh7uANxP6GGd6PQogYEmH9PRSpD+/Ma29VUR2VfZFlGjTIwpm26qnGPky8Rzv0z01fKozdiQtazh8oyfp0zEBrsj/FmfDKN/I67N6Kl1rkyohTx3APAhjUqNEw5bhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632082; c=relaxed/simple;
	bh=7xjiBGiTyGf/6QWV4HHTLUNf4ZC6uuGE+DE3EnaE8rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7M/SVyD8URZdjYmPWE68OESLEwuwO/vUFr1XjDJFicHjk8ykWBsleiEbLBsuRPGsntBGQRh015LIrwqmWTOJuc3F5Tf44jQxaHIDnTNdI+EudxV2tovy5AzE3yi984j5FxDhIsk9Q1S2Fr0KxkySJnYExcei96cr/Y8v99hdSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BkdQPE0t; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BkdQPE0t"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64ce9d80429so41795a12.1
        for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 12:28:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769632079; cv=none;
        d=google.com; s=arc-20240605;
        b=VGRUm5M+lKBlhoKU+vkVKKmvqB0W2djYXTVVdyhq0DE3+mWdw2qjc6zuFqSVBY6iln
         lsp+H2o8gwN52NEahKDXW6Bj4QC0jGZ7p18knykDgkSy7Hm+0DI4ie/wVsSnwxlTj9Bu
         STOcNakQINywoY7J4Syy9ZBnukshALdlLykGn0hLtyXLI7aU/mMawFsZozQjNdy1vuBI
         PtALRrGFwwW6SU4WTWsYI6iE8eywgaVtL+r/20I/LOnRPrjc9NP9MqZLpNpX8GDsy+Ix
         oVPihPtYEWXj5tmHzZ7/Mp44yX94ZBgeKCruW+5/a9sbzZG0SJScMeLOqpbWSreYV9TI
         kh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zr+cGAg67KXfHSmr8ufaya1NqKvZdzLngbc+EvjcvNo=;
        fh=7muz7uqK5yjO6Di4DphxTdGLiObWgNhxgYygeY3G4wM=;
        b=PIQVgmRJJ9XMZn/qZ0YEvSwd4CMA6AN3axSpi/REDxx5zJIHyqJe7VbmqbMW9UznH0
         4Pq/vb/RQKTcu8s42f1BOXkv6HgKAg20b1cU58DyXVqtuRZFcsxTugHa4RKgyzgKoPsG
         pYuTR1W0qFVOMFXtZiuqtA/+pWNfqRFdf3Bj3l7Et7dJQa+lrY8gr17Tc31jY07KeGEq
         NIMwi5tR52FSGxVQ7qWUbpV6sFj7XPAuinMntrtcHcI8BqmM5jyjRbVpdCtn5iatVygZ
         TQ+Jk0wEG8PTwNiUAfO6kSattgWFU8xh7FzkVUJyuEJ3DkGh1DTOPTUATiENW8x7O5qZ
         38Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769632079; x=1770236879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zr+cGAg67KXfHSmr8ufaya1NqKvZdzLngbc+EvjcvNo=;
        b=BkdQPE0tAsDGpyvnrd9FiWnEvpN/aLOCKiD7Em7exTVwPJkwomlV26XN1xx0EVWHSN
         iZxGS6p3WJUUuqZ9eEAw36PoY6C6T7fiWwrTaxZo8c1ESXXhFzqrA8rolG4dSMAedZ81
         xcMk/En09JSfL3oPcTOXVoYy6cHneAQVS8+u6TnPEh3POAR4dsq7IftbkN/0f+NyufsM
         mhTOpIRy0N2AbwTZW0nE656s2UKFLl0GxjG4dcqraihrxVBHczXq7A3uB6XmEhURigCg
         rmO7elYDYVEgmcKUh+V9rJRgKVeAZXsJNdXjEosnbXDSuk/PbCPev5lRHZ3dn4wTHOXj
         XWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769632079; x=1770236879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zr+cGAg67KXfHSmr8ufaya1NqKvZdzLngbc+EvjcvNo=;
        b=nk3dzu+1YUZVe9DRFbwSONH9OWThdZ/FhiCBt9fUBKIr4afGNKb4e7XJR8BQ9nxXi0
         9hoJo2jaMDiZ2G2B48V85Pnej5gFcHLJ7snltVT5MWd3ajrmxO7vsfbD3E3vwfi6TaSO
         /OtHMIEJSsxVqFIYjFEyOMnkzS776rUJ2DsXVWldPKN1Z6FoJqaD61YuDSlnK2ujE9MY
         lZExYAh37ZKICqklqJrM0vYWCsWu3vBttR0wEf2rWtJqMrvv3RQ0u6FIe1Ze9BLBK24i
         AWsy0LcMnXZYhC5LK0+eWnn3xQuaiWkkI9YsIzO3/kvmidzmkazKTX0CGV1SK4epgtLD
         RFIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsp/BSXYjxBpltpEANTnO7M8hf9Gq1tltqwc/Ofrl1Hv0emjoCKWkhPNoqu+w5yIexE99daeCLygJZqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyV/YewSoyI56kKR9OaRy3aZY8FG2n+6yIGj1sCN/i5R6Lie+YY
	nVFGikC1JhtJoRjw0EBUP3dp7PMwQxK9rKAo32Jhg7QzmEDyx4NYRFG1u2MTTw5ISdOnWo4gaoR
	8jB3ILe6d6bQx+uaswysMKxtxIMenW+z2bp3YR6uC0A==
X-Gm-Gg: AZuq6aLo8X7Uji6GNTWqg27VBEP8+fv67uZJUrff5S2+r2GNLkHQC3ZcLDWujSrZqCK
	McXi8ZIurFJFzG36hvdslV7wVnfyYtEhaDj5sn6eVtzKqZHFKek26WHLxy3BcNcaRddOGY2TOsZ
	lApuZKWmK6kQxe1PF78GAAstkfc02931r3y35AnqiSs2o463x/6yFYg1piLCvofgCSQ8Aaswc9/
	s1b+7DDaC22rnRWb0cnG3CXpw3sLWPumhjWvtuBBrJV19ymz+S62o1nCELUF2qKxMAZ43XZjBNy
	Z7Z7LNI=
X-Received: by 2002:a05:6402:5107:b0:64d:23ac:6cae with SMTP id
 4fb4d7f45d1cf-658c32e6e7cmr366364a12.6.1769632078710; Wed, 28 Jan 2026
 12:27:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124042716.2314690-1-ming.lei@redhat.com>
In-Reply-To: <20260124042716.2314690-1-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 28 Jan 2026 12:27:46 -0800
X-Gm-Features: AZwV_QhFSLAvU_gnoKpjAaM1YqNCOQWR2dPtHl4Rwpg67qqnsBqFAlpsRdzwLz8
Message-ID: <CADUfDZqLE=w2qsg_yQRbDfD5X0jo3Vt2qJ_eJUgNq0YF=Ecwqw@mail.gmail.com>
Subject: Re: [PATCH V2] ublk: document IO reference counting design
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 8:27=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add comprehensive documentation for ublk's split reference counting
> model (io->ref + io->task_registered_buffers) above ublk_init_req_ref()
> given this model isn't very straightforward.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Thanks for incorporating my suggestions.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
> V2:
>         - clarify `both ref and task_registered_buffers are 0 before disp=
atch`
>           (Caleb Sander Mateos)
>         - ublk_sub_req_ref() is the point for collapsing task_registered_=
buffers
>           into the atomic ref, optimization can only be used before this =
point
>           (Caleb Sander Mateos)
>         - Both ref and task_registered_buffers becomes zero in ublk_check=
_and_reset_active_ref
>           (Caleb Sander Mateos)
>         - add `zero copy with ublk server killed example`
>         - document io->lock is for protecting task_registered_buffers in =
case of batch
>           io
>
>  drivers/block/ublk_drv.c | 89 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 7981decd1cee..8a5a6ba29a1d 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -985,6 +985,95 @@ static inline bool ublk_dev_need_req_ref(const struc=
t ublk_device *ub)
>                ublk_dev_support_auto_buf_reg(ub);
>  }
>
> +/*
> + * ublk IO Reference Counting Design
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + *
> + * For user-copy and zero-copy modes, ublk uses a split reference model =
with
> + * two counters that together track IO lifetime:
> + *
> + *   - io->ref: refcount for off-task buffer registrations and user-copy=
 ops
> + *   - io->task_registered_buffers: count of buffers registered on the I=
O task
> + *
> + * Key Invariant:
> + * --------------
> + * When IO is dispatched to the ublk server (UBLK_IO_FLAG_OWNED_BY_SRV s=
et),
> + * the sum (io->ref + io->task_registered_buffers) must equal UBLK_REFCO=
UNT_INIT
> + * when no active references exist. After IO completion, both counters b=
ecome
> + * zero. For I/Os not currently dispatched to the ublk server, both ref =
and
> + * task_registered_buffers are 0.
> + *
> + * This invariant is checked by ublk_check_and_reset_active_ref() during=
 daemon
> + * exit to determine if all references have been released.
> + *
> + * Why Split Counters:
> + * -------------------
> + * Buffers registered on the IO daemon task can use the lightweight
> + * task_registered_buffers counter (simple increment/decrement) instead =
of
> + * atomic refcount operations. The ublk_io_release() callback checks if
> + * current =3D=3D io->task to decide which counter to update.
> + *
> + * This optimization only applies before IO completion. At completion,
> + * ublk_sub_req_ref() collapses task_registered_buffers into the atomic =
ref.
> + * After that, all subsequent buffer unregistrations must use the atomic=
 ref
> + * since they may be releasing the last reference.
> + *
> + * Reference Lifecycle:
> + * --------------------
> + * 1. ublk_init_req_ref(): Sets io->ref =3D UBLK_REFCOUNT_INIT at IO dis=
patch
> + *
> + * 2. During IO processing:
> + *    - On-task buffer reg: task_registered_buffers++ (no ref change)
> + *    - Off-task buffer reg: ref++ via ublk_get_req_ref()
> + *    - Buffer unregister callback (ublk_io_release):
> + *      * If on-task: task_registered_buffers--
> + *      * If off-task: ref-- via ublk_put_req_ref()
> + *
> + * 3. ublk_sub_req_ref() at IO completion:
> + *    - Computes: sub_refs =3D UBLK_REFCOUNT_INIT - task_registered_buff=
ers
> + *    - Subtracts sub_refs from ref and zeroes task_registered_buffers
> + *    - This effectively collapses task_registered_buffers into the atom=
ic ref,
> + *      accounting for the initial UBLK_REFCOUNT_INIT minus any on-task
> + *      buffers that were already counted
> + *
> + * Example (zero-copy, register on-task, unregister off-task):
> + *   - Dispatch: ref =3D UBLK_REFCOUNT_INIT, task_registered_buffers =3D=
 0
> + *   - Register buffer on-task: task_registered_buffers =3D 1
> + *   - Unregister off-task: ref-- (UBLK_REFCOUNT_INIT - 1), task_registe=
red_buffers stays 1
> + *   - Completion via ublk_sub_req_ref():
> + *     sub_refs =3D UBLK_REFCOUNT_INIT - 1,
> + *     ref =3D (UBLK_REFCOUNT_INIT - 1) - (UBLK_REFCOUNT_INIT - 1) =3D 0
> + *
> + * Example (auto buffer registration):
> + *   Auto buffer registration sets task_registered_buffers =3D 1 at disp=
atch.
> + *
> + *   - Dispatch: ref =3D UBLK_REFCOUNT_INIT, task_registered_buffers =3D=
 1
> + *   - Buffer unregister: task_registered_buffers-- (becomes 0)
> + *   - Completion via ublk_sub_req_ref():
> + *     sub_refs =3D UBLK_REFCOUNT_INIT - 0, ref becomes 0
> + *
> + * Example (zero-copy, ublk server killed):
> + *   When daemon is killed, io_uring cleanup unregisters buffers off-tas=
k.
> + *   ublk_check_and_reset_active_ref() waits for the invariant to hold.
> + *
> + *   - Dispatch: ref =3D UBLK_REFCOUNT_INIT, task_registered_buffers =3D=
 0
> + *   - Register buffer on-task: task_registered_buffers =3D 1
> + *   - Daemon killed, io_uring cleanup unregisters buffer (off-task):
> + *     ref-- (UBLK_REFCOUNT_INIT - 1), task_registered_buffers stays 1
> + *   - Daemon exit check: sum =3D (UBLK_REFCOUNT_INIT - 1) + 1 =3D UBLK_=
REFCOUNT_INIT
> + *   - Sum equals UBLK_REFCOUNT_INIT, then both two counters are zeroed =
by
> + *     ublk_check_and_reset_active_ref(), so ublk_abort_queue() can proc=
eed
> + *     and abort pending requests
> + *
> + * Batch IO Special Case:
> + * ----------------------
> + * In batch IO mode, io->task is NULL. This means ublk_io_release() alwa=
ys
> + * takes the off-task path (ublk_put_req_ref), decrementing io->ref. The
> + * task_registered_buffers counter still tracks registered buffers for t=
he
> + * invariant check, even though the callback doesn't decrement it.
> + *
> + * Note: updating task_registered_buffers is protected by io->lock.
> + */
>  static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
>                 struct ublk_io *io)
>  {
> --
> 2.47.1
>
